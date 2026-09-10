Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89943515C2
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 04:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013857; cv=none; b=Z1J+F3IaK/wfa8gAo4+aFWYuXfPm9zpHkhBmjNFpPb7NzkqeSU09W8NElAxNGsQ0VlFUSIODqWXaMBwLVQ0aen8YvNCLA5aCRccH3XC1FD4wlha4meS2YMWOFcWutmFf/udprKd174YlbeXLBA2iBsu4wJvjFIGwc0npHovzbtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013857; c=relaxed/simple;
	bh=l0Oqghn8WPzbJ5NFTj1yrjkV5IM+8cP5x6MHQoLt2g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CW78u+RrHy4QftQJ0JkUVkIL1noPFlgOQhFwEqixFbvZjdwcPMBiElawQejsHFz5roVuq7hYZuf0pD3AyzhNHdPoEZJAI1vGsOD24JAdmMn1QX2WeWG96RrkybkOoGto1k7DNZskdQ7NWmgE+6JxVSX0dOH4y9F5N6ekr4plTiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7wux7ND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7wux7ND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833EC1F00893;
	Thu, 10 Sep 2026 04:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013855;
	bh=FUsCGuTs5KNxXdjfhxV7BRtihWotHU0oWphBeEsZa4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G7wux7NDYrmHdXxRGAVgSXSIfwB8A1PP6HSBjbqhC8XR4NNUrfrN0+JTQt/4j3R4z
	 YVtbWW04y7CCzvsL8EIqdaa5YD5xEyRzXK/bTgf0TngUcXtBGCUauFAm4JcFUB34u4
	 lKZmosJq9+TElRE2aKuidxjWVq89rIg1SG1cq4gd2z3T9oIGZLr8iqUJvFIi22LaTT
	 pmIcYMKWIOk3zkt95zMLrT9Dy/yK1rmZjCvdnAY7sw4scRt1Joxn9AsoKVSWx6Mk12
	 oL6GByTTOQIxrVrhZasoEteziFcvcgawuuZ4icR9M9AQLmLYCUhYUi/ZYm2Q5SB4Qp
	 pZOMKS7ETKHMw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.1 1/7] mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Date: Wed,  9 Sep 2026 21:17:26 -0700
Message-ID: <20260910041728.149031-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910041358.8DB181F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 10 Sep 2026 04:13:58 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The kernel-doc comment for `enum damos_filter_type` inaccurately describes `DAMOS_FILTER_TYPE_PROBE_HITS_WSUM` as an operations-handled filter instead of a core-handled filter.
> --
> 
> commit 03957fb4685434f4e403efc7bb804cb84f796dbd
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
> 
> This commit updates the DAMON kernel API by introducing the new DAMOS core
> filter type, PROBE_HITS_WSUM. It allows API callers to filter target regions
> based on their probe hits weighted sum by adding range fields to the
> damos_filter structure.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 871d26adf6ae5..1deda16bb70b5 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -399,6 +399,7 @@ struct damos_stat {
> >   * @DAMOS_FILTER_TYPE_UNMAPPED:	Unmapped pages.
> >   * @DAMOS_FILTER_TYPE_ADDR:	Address range.
> >   * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
> > + * @DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:	probe_hits weighted sum range.
> >   * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
> >   *
> >   * All types except &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET
> >   * are handled by the underlying &struct damon_operations as a part of scheme
> >   * action trying
> 
> [Severity: Low]
> Should &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM be added to this exception list?
> 
> Since PROBE_HITS_WSUM is implemented as a core-handled filter rather than an
> operations-handled filter, this kernel-doc comment for enum damos_filter_type
> might need an update. Otherwise, the documentation inaccurately describes it
> as handled by operations, creating a mismatch with the actual core logic
> implementation.

Good point, I will update the comment as recommended.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260910040319.147037-1-sj@kernel.org?part=1


Thanks,
SJ
