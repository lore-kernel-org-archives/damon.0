Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A362D73A1
	for <damon@lists.linux.dev>; Sat, 23 May 2026 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779566228; cv=none; b=rfzbhAbrAlLp7kYCSokVKhZtKUpiSXttTJrujLyeIy5ZLBNNNb1a/nIX833MuObG6E6Nwp4tUmwoyCfUPDpINHUaVsHfTcqbGah+TXTVAryQxDgHg1frevRa60eYHI2ES232kredv2/ur48qz3VEKAS6PFrCBgZs7szeBhNN/s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779566228; c=relaxed/simple;
	bh=WqAShpbsE2ltPUNs4OhsAJOIq645HqXcTjOBpWToWJ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O5LM7j4ODQQEgvaYRnU5XJgRTziX0ifxiBRMrVM7EHGzgqV5rmRtluQX1esJAbWxqS4JNrXAdN9lT8cbUa2ZizRlKtlcqCkc7Yjk0cBiLWrzfvR1oEJwHUq6Now03/8ztHceNHBhnlKoWtfrOjMrtfG29JGC5oF/1js/3vHcp4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7YG1B9/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7YG1B9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB2C1F000E9;
	Sat, 23 May 2026 19:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779566227;
	bh=YETQXvsbEIl9q7IbCnTG+Epsblpmng2hYkyTIAfedqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F7YG1B9/4DpaFZlM97uP/8INLB4zQVzaq85QA2N8CdRFeQ0GAZeCl7yzUczKvX/0U
	 AcLZvR67wVvyYvJXpqHAAEqb7AZPx6j2fnaLFVlXbxfaifd3J3evtXxMKY29JvutA3
	 eOxWUmhhGvqqK//Y+GA1VJ6HTO34tHIZBM5vVp2s5EpWW9zglgFTCOh5a7RB7QYwxI
	 x4ppCVoiRY8oyLTNvb7/z6v926wGYQg1zczNwdAkJKgIGbX+5uaC5hWayTzFF6yOyL
	 WIKmmlMLWpne1QfcwBoNvTKE7Fmwf0qgGa4qLbfcc0jCVfqkt2wG7s+rDeO5LSfGYe
	 5aniEbAdzTHJA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon/ops-common: call folio_test_lru() after
 folio_get()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260523194145.93122-1-sj@kernel.org>
References: <20260523194145.93122-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 19:57:06 +0000
Message-Id: <20260523195707.6CB2C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Speculative folio flag access occurs before pointer re-validation,=
 triggering VM_BUG_ON_PGFLAGS() on tail pages.
--

commit 119755fb3390d2b7d6c7f2278054cc95e95531c6
Author: SeongJae Park <sj@kernel.org>

mm/damon/ops-common: call folio_test_lru() after folio_get()

This patch attempts to fix a potential VM_BUG_ON_PGFLAGS crash by removing
the speculative LRU flag check before trying to get a reference in
damon_get_folio(). It moves the LRU check after a successful try_get.

Link: https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 3a0ddc3ac7196..d3404615f9b75 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -32,9 +32,9 @@ struct folio *damon_get_folio(unsigned long pfn)
>  		return NULL;
> =20
>  	folio =3D page_folio(page);
> -	if (!folio_test_lru(folio) || !folio_try_get(folio))
> +	if (!folio_try_get(folio))
>  		return NULL;
> -	if (unlikely(page_folio(page) !=3D folio || !folio_test_lru(folio))) {
> +	if (!folio_test_lru(folio) || unlikely(page_folio(page) !=3D folio)) {

[Severity: High]
Does this sequence reintroduce the same bug the patch intends to fix?

By placing the LRU flag check before the pointer re-validation, C
short-circuit evaluation will evaluate the LRU flag first.

If the page was concurrently freed and reallocated as a tail page,
folio_try_get() might still succeed. Evaluating the LRU flag on this
unvalidated tail page will trigger the VM_BUG_ON_PGFLAGS() in
const_folio_flags().

Should the pointer re-validation happen before accessing any folio flags in
PFN scanners?

>  		folio_put(folio);
>  		folio =3D NULL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523194145.9312=
2-1-sj@kernel.org?part=3D1
