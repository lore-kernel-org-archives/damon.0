Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC97E4BEE4A
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789321273; cv=none; b=YmLoobNhcLeClDLzpys7d+AO7GXmoPidn2ODxmcQm03ggCyiRl3xUGU+J58zIqVtD5kBaY11SekNJBI59pkk6efI98Jv+rG/0Cpsrv0xIh+Y+fBaEa6IcCjnuS0AXZH3SyftnylK8xqnIqvPEKWJUX/OCJ0nhS7BvW5Ty5blcf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789321273; c=relaxed/simple;
	bh=rMVe4uV9BO4NiTJI1UljoDSjpcyi4l3JYLvu+J7h6Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRg1Ec7WpIeTMfClsPJ/1UItHCFy0zfdwwqMCIdGoEoggcYrlSVQ+ZPANCnyeNsqYNvoW70qVlqfEnqBxVn9IXKRzpvXVmKw3V5K0UdrZKzFoXHZp4hE8JpEEKz7bbygwz6cn2+eoL1N8JoYNhzQOfpAl4zutdSGwm3PsN6uYXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIjxj8tC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIjxj8tC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EF11F000FF;
	Sun, 13 Sep 2026 17:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789321271;
	bh=fiIFdKR/VBEY6SBz+/DBbAEZWsKEiG+maDs+eD0MO20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iIjxj8tCmlHqh4QIjKmilb/f4+89U3aelz1emu1ZSjyq7NyHuVrCcI9iDOKS9M50g
	 VELuef6g/I6KzhxnfUHR+MlXIm4vW5LRq4oFzwK9+MgwmbJtE4DC7UvQ63OgbsFGOZ
	 avwWjskBhBRtScPyvscimq6Q7oNCjCEuOJA7GjB8vgFh5bw/Gd7fky7zvermanCz1s
	 ER+nK9PSI6fL0+s4qlCXF/B9LjUqKTphIsqyPVfPxbyJU8XeM5LPd4QnW1t1lqXcI9
	 7PPqiVkuAK7Ay2uVunsbgGRwwF52AgNJSOfK3hBTRh9/PNSp/FFeg116zL99x7KAyR
	 GTXF7Xvq8xc/A==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 2/8] mm/damon/core: commit hugepage_size type damon filter
Date: Sun, 13 Sep 2026 10:41:03 -0700
Message-ID: <20260913174104.104908-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913173323.104247-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 10:33:22 -0700 SJ Park <sj@kernel.org> wrote:

> On Sun, 13 Sep 2026 17:24:21 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] Missing initialization and validation of `range_min` and `range_max` for newly appended `hugepage_size` filters leads to uninitialized memory usage.
> > --
> > 
> > commit 2b0a5f30b2fda9db59b511fc77d64fcbd35378ca
> > Author: SJ Park <sj@kernel.org>
> > 
> > mm/damon/core: commit hugepage_size type damon filter
> > 
> > Extend data attribute probe filters commit logic for the new
> > hugepage_size filter type.  Since it needs to carry the size range of
> > the hugepage, update the logic to update the size range fields of the
> > commit destination filter struct.
> > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index 0c98f7e267d07..a3febdc355c1e 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > 
> > [ ... ]
> > 
> > > @@ -1807,23 +1807,33 @@ static void damon_commit_filter(struct damon_filter *dst,
> > >  	case DAMON_FILTER_TYPE_MEMCG:
> > >  		dst->memcg_id = src->memcg_id;
> > >  		break;
> > > +	case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
> > > +		if (src->range_max < src->range_min)
> > > +			return -EINVAL;
> > > +		dst->range_min = src->range_min;
> > > +		dst->range_max = src->range_max;
> > > +		break;
> > >  	default:
> > >  		break;
> > >  	}
> > > +	return 0;
> > >  }
> > >  
> > >  static int damon_commit_filters(struct damon_probe *dst,
> > >  		struct damon_probe *src)
> > >  {
> > 
> > [ ... ]
> > 
> > >  	damon_for_each_filter_safe(src_filter, next, src) {
> > >  		if (j++ < i)
> > >  			continue;
> > >  
> > >  		new_filter = damon_new_filter(src_filter->type,
> > >  				src_filter->matching, src_filter->allow);
> > >  		if (!new_filter)
> > >  			return -ENOMEM;
> > >  		switch (src_filter->type) {
> > >  		case DAMON_FILTER_TYPE_MEMCG:
> > >  			new_filter->memcg_id = src_filter->memcg_id;
> > >  			break;
> > >  		default:
> > >  			break;
> > >  		}
> > >  		damon_add_filter(dst, new_filter);
> > 
> > [Severity: High]
> > Does this code leave range_min and range_max uninitialized for newly
> > appended hugepage_size filters?
> > 
> > If a user writes a new hugepage_size filter to a running probe via sysfs,
> > it triggers the filter appending path here:
> > damon_commit_ctx() -> damon_commit_probes() -> damon_commit_filters()
> > 
> > When the new filter is appended, damon_new_filter() allocates memory with
> > kmalloc(), which does not zero-initialize the memory. The switch statement
> > then omits copying range_min and range_max for
> > DAMON_FILTER_TYPE_HUGEPAGE_SIZE, leaving them as uninitialized heap garbage.
> > 
> > This makes the hugepage_size filter unpredictable and could cause incorrect
> > memory pages to be filtered in or out. It also completely bypasses the
> > validation logic added for existing filters in damon_commit_filter().
> 
> DAMON sysfs is not allowing hugepage_size filter at the moment, so this issue
> cannot happen.  A later patch of this series will add the support with correct
> range setup.

I was wrong.  I will fix this in the next spin.

> 
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260913171133.102366-1-sj@kernel.org?part=2
> 
> 
> Thanks,
> SJ
> 


Thanks,
SJ
