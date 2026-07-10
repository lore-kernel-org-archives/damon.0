Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A0828688C
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692117; cv=none; b=sgvj3MHR83QfmZtW1O39M13ZUVdoILoZSMnLV8qQuzfL4YF/Urs3MsGC4noi6mAsGTqBG3zOv5LIa9bxdeaGGIB/PtW3fK44zrY2WDb31eTlzK3hX7DoBUeL7mMgNM8Zp+Rkw1bAluEObYyCZbK5/xXa7S0aIeFySnlc8WAOsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692117; c=relaxed/simple;
	bh=EEF/rpUM0QcVRO3sTHrH0NhUr3zsRKh2Ja6FEVdIUP0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qu5W9hH+eFTuP3MRyjRC3ve1qpOtLhZo7TAuC1Z1KGLKHZq8FP15eybHCSaaMjQjihxdyA2IiiUWqSr0qhjbscGYL5ArVAjxR4adBHrOe2OlqK4kJwWHaD21bwRMKuvXcmH3idQuttTcWxWi2X93Xsop3pYoqa8pEB8t+NjcBTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVXy9lV0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVXy9lV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3931F000E9;
	Fri, 10 Jul 2026 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692116;
	bh=ZQncVi4AR9x2j320MAJhsq5+JFDZn0miZyKBgtFsm7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EVXy9lV0mtAsNkLELzDmF+fZKYslRg7Hb6SRaHAIDE2NHcsL+XvtNcbiHHnKRbwGo
	 GvITpuFHSy6Xnw9eWiTqRTQ69RlN3LBWOQbllxwf5qyKXIB+5qUidq+7rMHGSqEy0c
	 xy5qVcHWod1sXG7V68w9UDFrnQSznFrOQ89jbrx0Be+9P8Hhq9ykIMeV4hNUUZ+grj
	 8MbjzzdNyIvy/EoSmIv032gplMdk/XLRFpyL3+qkFqyThvKzunhOy9uRyfoy87P+pE
	 Em1xUSm9kN9KWLMSz4pTgoO6w9UCPV/u01vN7PN1xSzUP+xhOjDTRTzOUC9eIoyo+w
	 CwgMejA8sztOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/19] mm/damon/paddr: set samples in apply_probes() if
 requested
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260710134651.18084-4-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
 <20260710134651.18084-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 14:01:55 +0000
Message-Id: <20260710140156.3A3931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Address advancement using `folio_size()` from an unaligned address=
 within a large folio overshoots the next folio.
--

--- Patch [3]: [PATCH 03/19] mm/damon/paddr: set samples in apply_probes() =
if requested ---
commit 60a9acbe070a2be34c313d6be62fe7e4acb7ec54
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: set samples in apply_probes() if requested

This commit updates damon_pa_apply_probes() to respect the set_samples
parameter. It adds logic to randomize the sampling address within the
region boundaries using damon_rand() when requested.

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index b13bf7c6eade3..ff4fcca949660 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -178,6 +178,10 @@ static void damon_pa_apply_probes(struct damon_ctx *=
ctx, bool set_samples)
>  			phys_addr_t pa;
>  			struct folio *folio;
> =20
> +			if (set_samples)
> +				r->sampling_addr =3D damon_rand(ctx, r->ar.start,
> +						r->ar.end);
> +
>  			pa =3D damon_pa_phys_addr(r->sampling_addr,
>  					ctx->addr_unit);
>  			folio =3D damon_get_folio(PHYS_PFN(pa));

[Severity: High]
This is a pre-existing issue in this file, but can the address advancement
logic skip over pages during region iteration?

Looking at iteration functions like damon_pa_pageout(),=20
damon_pa_de_activate(), damon_pa_migrate(), and damon_pa_stat() in=20
mm/damon/paddr.c, they all use a pattern for advancing the address
similar to this:

mm/damon/paddr.c:damon_pa_pageout() {
    ...
    folio =3D damon_get_folio(PHYS_PFN(addr));
    if (!folio) {
        addr +=3D PAGE_SIZE;
        continue;
    }
    ...
    addr +=3D folio_size(folio);
    ...
}

If the initial iteration address is not aligned to the folio boundary (for
example, after a region split or hole), wouldn't adding the full folio size
to this unaligned address cause it to overshoot the end of the current foli=
o?

This seems like it would skip over the beginning of the next physical folio,
causing those pages to incorrectly escape reclaim, migration, or statistics
gathering.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710134651.1808=
4-1-sj@kernel.org?part=3D3
