Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6D74854E7
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397987; cv=none; b=rnH/hfHDQmEIy/XCQk6tDcegE1j80U1Qh1FuXdy7/1MyUZFR8coQmn47JaAsMvhRt5MTnlwLd7seZTyt1RnEP+o8iPRoNBmpmNDcjKKB8xvGTFUibo9ciEhf5f4spJZRh6TPLValPzwcPFSQJKFamKHI8eJpNbnJJ24B2ueEaUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397987; c=relaxed/simple;
	bh=7mSFec4Dzfqo9adj3rqMeQofCG97B3WL23QaZZk1YQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7YTcyY9PPEUF2odBe9qhQd3NVZGVhaGwluJctXOfgUZbjkOs+x/CGmBkdp51OqxiuHZBb2+80ry5HjF/KbWdP3IAHIuYgiEi7d6XzL1YyWC+ApiAIz705h9tf8dLE1zuAwLSTxzk/0cik/MNLU9MPK2tR+mSECBZZGW3/HT/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUPJqIhA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUPJqIhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8781F0089F;
	Mon, 14 Sep 2026 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397983;
	bh=U5PbhPfUs4+Cbc0crAamR90TrNpf/zrG2JqeGSrcUHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lUPJqIhANnYNtxfQZ+CduMyTjzsS/1VTN+vOGieD8fA8mZTP1/VqTv6yinZHcsbz9
	 B8jp2hmzqx8bcf5MQDK6urShEefvfWc37Jdm3L874f9tQbLNkuinhxua5bde3tzrI6
	 aCh9PHn0LvbLdVGTa76ml66y/G+4nrIaRNfED+k9ccrbGyLqOvw0LYnfao1rv0+Cj4
	 LdbpaWlsh0KcnSaFTCKssYC/mzyXpqpW8V+/k1fv++DFl9sK4pmnxHWeGNuvHevDNA
	 TEPF+iN6fEVlJ5bUE1O/ADh+9MLkyiuWcJ/sW0hyLtoVYo5J6UdXkHPuSrNbv1Ruae
	 cgc222MhXHqLw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 2/8] mm/damon/core: commit hugepage_size type damon filter
Date: Mon, 14 Sep 2026 07:59:35 -0700
Message-ID: <20260914145936.94909-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914145217.671BD1F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 14 Sep 2026 14:52:16 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Memory leak of newly allocated `damon_filter` on the error path in `damon_commit_filters()`.
> --
> 
> commit 5bd56b851690ccc1ea59e5d967224bde8e275c2a
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: commit hugepage_size type damon filter
> 
> Extend data attribute probe filters commit logic for the new hugepage_size
> filter type. This updates the size range fields of the commit destination
> filter struct and validates the given range.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 0c98f7e267d07..ecfe99450e5f0 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -1838,6 +1848,12 @@ static int damon_commit_filters(struct damon_probe *dst,
> >  		case DAMON_FILTER_TYPE_MEMCG:
> >  			new_filter->memcg_id = src_filter->memcg_id;
> >  			break;
> > +		case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
> > +			if (src_filter->range_max < src_filter->range_min)
> > +				return -EINVAL;
> 
> [Severity: Medium]
> Does this error path leak the newly allocated new_filter?
> 
> It looks like damon_commit_filters() returns early here without adding
> new_filter to the destination list or freeing it. Since this is reachable
> via the sysfs interface when a user configures a filter with a minimum
> larger than the maximum, can this cause a memory leak on invalid input?

Good finding.  I will fix in the next revision.

> 
> > +			new_filter->range_min = src_filter->range_min;
> > +			new_filter->range_max = src_filter->range_max;
> > +			break;
> >  		default:
> >  			break;
> >  		}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260914144448.93732-1-sj@kernel.org?part=2


Thanks,
SJ
