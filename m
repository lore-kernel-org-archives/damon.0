Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B474BEE4A
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789321380; cv=none; b=OkNVvOLf8fh6+cZpafYemE5pwhZD+S7HQza90uXK3gEEIROtCE2C2wFbDxbRWEXFKDs1XRR5atrQe5/EBGEa7ZwfUrBVZwQIKnpG6gLUSk8pnFboMIi6ICrsPV2pdffFBWs1aUZSz+BcMiNEv3HpSYzeJOYeCdhajo+GLYQlYAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789321380; c=relaxed/simple;
	bh=gtxJqUXAN8et+RbGNG9aj3kr57QtG7PP6oU3R2QyI6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTcznLPHhVHFn0UKDo/TV0fU+n5ESZVOi4vCzIrFG91XpyYPrCdn8NAVWzSg1Lqus4UfyXlpj/05DFDYwiko947QdwVEmxExsyoD3XnLPBopID0kVmwl+SntESPiQj/MSSs/kjEU2nY56zn3iRlXZT1ftyGLCDXxIA98EoUHu84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6/5eDTX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6/5eDTX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ED91F000FF;
	Sun, 13 Sep 2026 17:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789321379;
	bh=/xAYl1gvr2+BygapBFgn5JdOfoEJe/fO/ytyVi53p2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G6/5eDTX29LwPck3ncZ/3JMip2NEO71yXLxkAaqYPAZw2i34cdeROncAn5ou7UBjc
	 1yU7VTbPTbamJtxeTmXeCw/xrSfq/HzihO2KLN0Liho4KqayklXyRZWqISfrvQz4RE
	 Ha0c+38KjwjkComf7WiPbwalQqFY/ao0BoEwcHXPmYhXpmNP5mefmpkdxxVS5Pz2Tg
	 DngI5dVDE34t/cPEaLn9TW7KOkzak1g1CDod9BBZKYcz5V6CUR5DbRa8AlGVJANHQa
	 TSBjrbIVvGx4GCSQS/TP63ZBSP4UY3Brx1fIc8h36bjCPbzOlbfJc/6aWWskPHLtdC
	 McyJ6gua3zvmw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 6/8] Docs/mm/damon/design: update for hugepage_size probe filter
Date: Sun, 13 Sep 2026 10:42:51 -0700
Message-ID: <20260913174252.105487-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913172453.9592D1F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 17:24:53 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Newly added probe filters of type DAMON_FILTER_TYPE_HUGEPAGE_SIZE are left with uninitialized `range_min` and `range_max` values, and bypass bounds validation.
> --
> 
> commit b9cb7bf28c7342005a919d584ad8cc1ce1cf9694
> Author: SJ Park <sj@kernel.org>
> 
> Docs/mm/damon/design: update for hugepage_size probe filter
> 
> Update DAMON design document for the newly added hugepage_size data
> attribute probe filter type.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 0c98f7e267d07..a3febdc355c1e 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1807,23 +1807,33 @@ static void damon_commit_filter(struct damon_filter *dst,
> >  	case DAMON_FILTER_TYPE_MEMCG:
> >  		dst->memcg_id = src->memcg_id;
> >  		break;
> > +	case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
> > +		if (src->range_max < src->range_min)
> > +			return -EINVAL;
> > +		dst->range_min = src->range_min;
> > +		dst->range_max = src->range_max;
> > +		break;
> >  	default:
> >  		break;
> >  	}
> > +	return 0;
> >  }
> >  
> >  static int damon_commit_filters(struct damon_probe *dst,
> >  		struct damon_probe *src)
> >  {
> >  	struct damon_filter *dst_filter, *next, *src_filter, *new_filter;
> > -	int i = 0, j = 0;
> > +	int i = 0, j = 0, err;
> >  
> >  	damon_for_each_filter_safe(dst_filter, next, dst) {
> >  		src_filter = damon_nth_filter(i++, src);
> > -		if (src_filter)
> > -			damon_commit_filter(dst_filter, src_filter);
> > -		else
> > +		if (src_filter) {
> > +			err = damon_commit_filter(dst_filter, src_filter);
> > +			if (err)
> > +				return err;
> > +		} else {
> >  			damon_destroy_filter(dst_filter);
> > +		}
> >  	}
> >  
> >  	damon_for_each_filter_safe(src_filter, next, src) {
> 
> [ ... ]
> 
> > 		new_filter = damon_new_filter(src_filter->type,
> > 				src_filter->matching, src_filter->allow);
> > 		if (!new_filter)
> > 			return -ENOMEM;
> > 		switch (src_filter->type) {
> > 		case DAMON_FILTER_TYPE_MEMCG:
> > 			new_filter->memcg_id = src_filter->memcg_id;
> > 			break;
> > 		default:
> > 			break;
> > 		}
> 		^^^^
> 
> [Severity: High]
> Does this code miss copying range_min and range_max when a HUGEPAGE_SIZE filter
> is dynamically appended?
> 
> Since damon_new_filter() allocates new_filter without zeroing it, range_min and
> range_max are left uninitialized for newly appended HUGEPAGE_SIZE filters.
> 
> Furthermore, because damon_commit_filter() isn't called here, the bounds
> validation (src->range_max < src->range_min) added above is completely
> bypassed. This leads to erratic memory filtering behavior since DAMON might
> skip or apply actions based on memory garbage.
> 
> Should case DAMON_FILTER_TYPE_HUGEPAGE_SIZE be added to this switch block, or
> perhaps the code could be refactored to reuse damon_commit_filter() here?

Yes, I will fix this in the next spin.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260913171133.102366-1-sj@kernel.org?part=6
> 


Thanks,
SJ
