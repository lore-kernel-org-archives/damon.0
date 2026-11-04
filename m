Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807516;
	b=IbxejRpCvzkszqgOMKpNAIN7P7Pi5wl0hoT7FEeRiPsJUF7NeLNrilkEsb9t4EoJB06T
	 GtADcZBidOJWUTnoNxh99qHx3p9kpkp6UVoq/LQkR9Uf6DldTLRNUQlDFx6QBMX6boob1
	 Dv2L9RcH+ElFgrg2CwESlhEPgrHaVUFZr30fEHmeVGDUhJqaYyw/k81HvYCIDURhtin2/
	 i7nopev5/rJ6Uh+cIdYszcZS7B7E/Y8kOxB8Keii6uSrHdBEwGsvBd9+Jt1idVSXZrqxp
	 0yFSAHS2G/PeVIuDdGQeV1MytLDThvV/tnd+cu86KB8sEJd/Xu3UsD6M/TCuIKFf0rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807516;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0sBhfxVoPTNwyeJI8hydpBvqTMqtbq2SWkwYzUSeiS8=;
	b=Gwo43DjMaNLWf2w25GMMvH8sf40Q9JXY3Tsae2Ibln8F3jotHvbpoFWfjHgBGwb3GE+t
	 Sl1lmcEBKvAqVeWfUG8ebbt/sMc2cpNOfdVLJxan+y0Q1m35wjlub4ObJ+CchSeDE+c+t
	 8GFlAobpdthwj3iuPkGkCufQc0rrwcnUfkUnc607YZ2YT12RccCeZaxsQgOBHwYpLIidp
	 Cc7OYg5iswJ6RoaBoDZvhuXvtQSGvonqoyh/ZOERLQlx8R7VLYc/mm7EpkBQrVz0pnyd8
	 2132/ejF1mvRnDLE+zTZScKXb8UlflIC2udlzhJBVGBfnpON/E0kE0wAlYXTN6JuQZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gff6DAI3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B91606A31B
	for <damon@lists.linux.dev>; Wed,  4 Nov 2026 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gff6DAI3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EDA1F000C1;
	Wed,  4 Nov 2026 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807515;
	bh=0sBhfxVoPTNwyeJI8hydpBvqTMqtbq2SWkwYzUSeiS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gff6DAI3lDNr7WYHV7JCx2pC52NmJjHoPQgqc/VkOEq9fdWYQis5DMFvbCzY25Ctl
	 U9pJMb5uIugekGGGmQ3CqC472HfaSwIVObDXyjL9k67p9BNeIdJykNPnKVRLgPhAGj
	 64DqMMdiDIS1KSrbjzumz9znjgaGIuvjMGFKiyHYJnvUCPFPelQvQoYh2VfrjgkjlO
	 mZX8rmADzAohUe0sl9VFGRvIZYndscQmo8tvz+VrOFcpGpFza7QWqVWariHyD1k3Ga
	 TEwnx6odKrb85JrWnBXBFWq7rdHEmiT+6il5ccSvbQZx/gaPMTHT1qIGwBprJEPpnf
	 qbleMZyN3ddaA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/4] mm/damon/sysfs-schemes: support DAMOS_FILTER_TYPE_AGE_MS
Date: Wed,  4 Nov 2026 07:51:47 -0800
Message-ID: <20261104155148.83931-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-197544@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 04 Nov 2026 15:50:23 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] mm/damon: 32-bit overflow calculating age_ms in damos_filter_match()
> --
> 
> commit 9c78f1b31239922167bf213c5406c37c05fd310f
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: support DAMOS_FILTER_TYPE_AGE_MS
> 
> This commit exposes DAMOS_FILTER_TYPE_AGE_MS to the DAMON sysfs interface
> using the "age_ms" filter type keyword and the existing min and max sysfs
> range files.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 637f1bd0c950b..230987efac3ac 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> 
> [ ... ]
> 
> > @@ -2875,6 +2879,7 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
> >  			filter->sz_range.max = sysfs_filter->range_max;
> >  			break;
> >  		case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
> > +		case DAMOS_FILTER_TYPE_AGE_MS:
> >  			filter->range_min = sysfs_filter->range_min;
> >  			filter->range_max = sysfs_filter->range_max;
> >  			break;
> 
> [Severity: Medium]
> When userspace configures an age_ms filter with range_min and range_max via
> damon_sysfs_add_scheme_filters() on a 32-bit system, can age_ms overflow in
> damos_filter_match()?
> 
> When kdamond evaluates the filter via
> kdamond_apply_schemes()->damon_do_apply_schemes()->damos_apply_scheme()->damos_core_filter_out()->damos_filter_match():
> 
> mm/damon/core.c:damos_filter_match() {
> 	...
> 	case DAMOS_FILTER_TYPE_AGE_MS:
> 		age_ms = r->age * ctx->attrs.aggr_interval / USEC_PER_MSEC;
> 		matched = filter->range_min <= age_ms &&
> 			age_ms <= filter->range_max;
> 		break;
> 	...
> }
> 
> Here r->age is unsigned int and ctx->attrs.aggr_interval is unsigned long
> (in microseconds). On 32-bit architectures, multiplying r->age by
> ctx->attrs.aggr_interval is performed in 32-bit unsigned arithmetic before
> dividing by USEC_PER_MSEC, which wraps around once a region's age exceeds
> approximately 4,295 seconds (~71.6 minutes) even though the resulting
> millisecond value fits in a 32-bit unsigned long.
> 
> A similar 32-bit overflow on r->age * c->attrs.aggr_interval in
> damon_hot_score() in mm/damon/ops-common.c was fixed in commit 0284dff76e87
> ("mm/damon/ops-common: fix age_in_sec overflow on 32-bit"). Should
> damos_filter_match() use div_u64((u64)r->age * ctx->attrs.aggr_interval,
> USEC_PER_MSEC) as well?

I will fix [1] in the next version.

[1] https://lore.kernel.org/20261104154746.83311-1-sj@kernel.org

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261104153645.82945-1-sj@kernel.org?part=2
> 


Thanks,
SJ
