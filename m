Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718BF15A85A;
	Sat, 11 Apr 2026 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775925233; cv=none; b=hoDNd642O/3K6gaaGkR0Og64A42fiQfo0CoFaR4jPV41UN0cxp8zSJTM3L4VQEYgopv8/KFo3gUT6ZFJ1+8OCe8YlpyZ7jodsvL9NfPiz+uksrHutBle50hkh+bUJuAbZ4CUDHbP0NcOppddGRePCoCwrbWRtdiCnoW9VudnqvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775925233; c=relaxed/simple;
	bh=EpJ7cnZvULwnwdpRqje5W/TcK0J3y3KDLXRPTpMJC+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bM+JK6qip9/lfXIZqEhnX8lU4rl8ogY+JOh4Pgi1kqJYtmKpR/CUz9LdrT64TKQgs9f7yN4caTcxek3FuuwUQQvamJH9i5ujj8rRirzR+PAvmtn4vZenLuNHXGe3PVlJZzd8dq5NygIDcHNI0ukVukK2/Ch5G6aAxBYNF2BlcuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMtDExXe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMtDExXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5762C4CEF7;
	Sat, 11 Apr 2026 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775925233;
	bh=EpJ7cnZvULwnwdpRqje5W/TcK0J3y3KDLXRPTpMJC+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jMtDExXefHWh9g0Ufr77FvXAmhFo7mMZG1sl1FdQCiaEls21Pt+1w+hADIokQdUqE
	 2Yd3N+tSItyZzwAiJAvu46jafblC9wTsKy/Jk3r6gFu1AhU9oCfSDxHkCIKKn302uI
	 pH66J8UPU93wF/vQckjrcwVQP/O7O4WVCEqqZNgaDsVavzuXX/tX1IW9B3r78pF+mB
	 6R5spZT30/9MCLTwUirjviFHn4ZFddO1BR+Src4Pm0hU5iQhl/IDTrd3ijAJY/Gd/O
	 XEH7S+FjG5E3+PJ1DOuZcMpiZJ749E22GR/SL/b56XrrffQrb4dkoUubpOLT6QCJH6
	 Wnuxfd+KuMMFg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v5 02/11] mm/damon/core: merge quota-sliced regions back
Date: Sat, 11 Apr 2026 09:33:39 -0700
Message-ID: <20260411163340.46397-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410235527.90900-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Apr 2026 16:55:26 -0700 SeongJae Park <sj@kernel.org> wrote:
[...]
> > Should the merge condition verify that the contiguous slices share identical
> > state before merging, perhaps by checking if (orig_region->age != r->age)?
> 
> Good finding.  I was thinking the scheme will anyway be applied, once the
> quota-split is happened.  But I was wrong, since DAMOS core filter is applied
> after the split operation.  Also, age is not reset if the action is DAMOS_STAT.
> 
> I will address this in the next revision, like below.
> 
> '''
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2439,35 +2439,32 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
> 
>  static void damos_apply_target(struct damon_ctx *c, struct damon_target *t)
>  {
> -       struct damon_region *r, *orig_region = NULL;
> -       unsigned long orig_end_addr;
> +       struct damon_region *r;
> 
>         damon_for_each_region(r, t) {
> +               struct damon_region *prev_r;
> +
> +               damon_do_apply_schemes(c, t, r);
>                 /*
> -                * damon_do_apply_schemes() could split the region for the
> +                * damon_do_apply_scheems() could split the region for the
>                  * quota.  Keeping the new slices is an overhead.  Merge back
> -                * the slices into the original region if there is no reason to
> -                * keep those.
> +                * the slices into the previous region if it doesn't lose any
> +                * information.
>                  */
> -               if (!orig_region || orig_end_addr <= r->ar.start) {
> -                       orig_region = r;
> -                       orig_end_addr = r->ar.end;
> -               }
> -               damon_do_apply_schemes(c, t, r);
> -               if (r == orig_region)
> +               if (damon_first_region(t) == r)
>                         continue;
> -               /*
> -                * If no scheme was applied to the sliced region, the age of
> -                * the slice ain't be reset.  Don't merge that back.
> -                * Otherwise, the monitored information of the region is lost.
> -                */
> -               if (r->age) {
> -                       orig_region = NULL;
> +               prev_r = damon_prev_region(r);
> +               if (prev_r->ar.end != r->ar.start)
>                         continue;
> -               }
> -               orig_region->ar.end = r->ar.end;
> +               if (prev_r->age != r->age)
> +                       continue;
> +               if (prev_r->last_nr_accesses != r->last_nr_accesses)
> +                       continue;
> +               if (prev_r->nr_accesses != r->nr_accesses)
> +                       continue;
> +               prev_r->ar.end = r->ar.end;
>                 damon_destroy_region(r, t);
> -               r = orig_region;
> +               r = prev_r;
>         }
>  }

This could result in too aggressive merging, that can make the number of
regions lower than the min_nr_regions.  Actually this makes one of damo tests
fail.  I will fix this by using damon_region_sz_limit().


Thanks,
SJ

[...]
