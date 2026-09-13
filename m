Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D50931E84B
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320811; cv=none; b=GACGOgk08Z9tT2NyCSPTkg9M+sFs5JPvkEgEK0n3WfUVPhBYVTJT8sd1Kvm8UJ+IMY/suonFtmKIo0xTOf8R1ofO6eG5wTdMqYCoPT7pp1pcIUTGN6Q9vrz2zXxaE0LdMuwt438wfC61wgk6L8778c4ohNpUm92utMW6HsnkfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320811; c=relaxed/simple;
	bh=JWFaoccugLerCCbof52PXiB7T8npQtI3SRm7466oEv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeVJ5YuEwv1zTdiQPbuWTzw/UhzfWD4UhLbp+cQRL7gAP03kcKuSYUvyz2UT5rPf3JQUNzX0Aqb80T8/qa51Vw9vC6ZBTLS5tD5ME9S+kGufBTz+irlBz/QImw0iz6Hr4jk+824JBUgsNB1zjNtQxBoieVbgqINv4plE2aSsfw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvGYC4CU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvGYC4CU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCB21F000FF;
	Sun, 13 Sep 2026 17:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320810;
	bh=CfSsiwqyo6oVT2QNma4C7UgaBBJ1OcjgWlMGubPFAeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BvGYC4CUh8kppNADbqbQxJl8x7ZlsjG3ILYkUuRAHaA+xrm7yRBjLWBVdkpAfPCew
	 KRvEcLeECaU2VtJ770GmZYqFxA+V07dOjBYHvkDjFSGKXLX8ami2oSSEVic2biTg5S
	 FKSwmH4lQXlHIiukt0bhDnuzHKY83fLLO1TOI6mD9vaYmY6wF1z9pBnXrWKjkrI+3g
	 dJrHa3SWGWjePU6W8UKTQE0TDpKQ0pMgSNbDqhApHIpqO/zXXSpm6gqRPhAJ/rKo9b
	 6lStnpOJzxN0ISLMu4hVjSkis7Y5aOjZGG3vppc8S2or17vr6ctPi1Tz60DG6BzF0E
	 GxRnxlXsLM7Vw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 2/8] mm/damon/core: commit hugepage_size type damon filter
Date: Sun, 13 Sep 2026 10:33:22 -0700
Message-ID: <20260913173323.104247-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913172422.3F7811F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 17:24:21 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing initialization and validation of `range_min` and `range_max` for newly appended `hugepage_size` filters leads to uninitialized memory usage.
> --
> 
> commit 2b0a5f30b2fda9db59b511fc77d64fcbd35378ca
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: commit hugepage_size type damon filter
> 
> Extend data attribute probe filters commit logic for the new
> hugepage_size filter type.  Since it needs to carry the size range of
> the hugepage, update the logic to update the size range fields of the
> commit destination filter struct.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 0c98f7e267d07..a3febdc355c1e 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
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
> 
> [ ... ]
> 
> >  	damon_for_each_filter_safe(src_filter, next, src) {
> >  		if (j++ < i)
> >  			continue;
> >  
> >  		new_filter = damon_new_filter(src_filter->type,
> >  				src_filter->matching, src_filter->allow);
> >  		if (!new_filter)
> >  			return -ENOMEM;
> >  		switch (src_filter->type) {
> >  		case DAMON_FILTER_TYPE_MEMCG:
> >  			new_filter->memcg_id = src_filter->memcg_id;
> >  			break;
> >  		default:
> >  			break;
> >  		}
> >  		damon_add_filter(dst, new_filter);
> 
> [Severity: High]
> Does this code leave range_min and range_max uninitialized for newly
> appended hugepage_size filters?
> 
> If a user writes a new hugepage_size filter to a running probe via sysfs,
> it triggers the filter appending path here:
> damon_commit_ctx() -> damon_commit_probes() -> damon_commit_filters()
> 
> When the new filter is appended, damon_new_filter() allocates memory with
> kmalloc(), which does not zero-initialize the memory. The switch statement
> then omits copying range_min and range_max for
> DAMON_FILTER_TYPE_HUGEPAGE_SIZE, leaving them as uninitialized heap garbage.
> 
> This makes the hugepage_size filter unpredictable and could cause incorrect
> memory pages to be filtered in or out. It also completely bypasses the
> validation logic added for existing filters in damon_commit_filter().

DAMON sysfs is not allowing hugepage_size filter at the moment, so this issue
cannot happen.  A later patch of this series will add the support with correct
range setup.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260913171133.102366-1-sj@kernel.org?part=2


Thanks,
SJ
