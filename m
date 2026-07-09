Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0285B21E098
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606608; cv=none; b=AOCnjNUfMAjN9t9guwuXvQs21BhspoGhUbr8Eor41vJG3EQLOPYerd+agDtNSUJRQgqKXvMMbBqlnXNGGDaQDBgqjDZK5sPeR1iyLSadvYa2QL2li4WO+7D1ifGmfJ/8uYqThsum6PEWR9IgJSFLZObh6WXa9gvCaUj679QO3Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606608; c=relaxed/simple;
	bh=6WH38W9fcIJA0lPviWIHR8c9XO8k0cvn1svxJTZoggU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pSbwjNvH9hgFc3Ys+r2qZV3mAywUl06CdmtcqNR/TxgT+5PdOlpJGWw8fzo/mc0p6VDDMk9dR/1nLXEiMaOq/xdLlmdOrL8+SucZ0huK7GUeIZYpWd/dNvhVxlNuIUHV/c7X46z6p8jRO0lIE+niCEANDo3ZsFF0PXXNd/uA1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq+6yXjh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq+6yXjh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725B41F00A3D;
	Thu,  9 Jul 2026 14:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606606;
	bh=zIqoXras40Oqz1gsNF8nQuvVCpYJ3obyX/s13/uCU8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uq+6yXjhMkrqcE/LIB3BkzwRn5ei1M3gqJ7oxZw98c+N4a/pitUl9rD0atcO5IMW1
	 IMUsK/6rMhbNKgLi6QUxkzILLLQ1F4782kHtc4gDHtw9JPLQnyaYGwLRy8+kczPlBR
	 Q6fHwWeP0MbV6CDta6PvwuS3uKFABXuBOq1NtcZOJW3aH2DOhk8mYzZl/tNRKNzHvl
	 UfF5OZa9QWHdtLagq3OYlFtNqoARbw3HFWm/YEMxJ50xtTd5YQjUJJHnxTFCjcV7Xi
	 4hcmg4w6XcomdseAU3cKKlBBm2QjsjUj4kZDdO1uPiJxUth26WuXSxEu5oXpsmT6eU
	 Zkb+frjQv2dMA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 02/19] mm/damon/core: ask apply_probes() ops
 callback to set sampling address
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260709140600.90950-3-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
 <20260709140600.90950-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:16:46 +0000
Message-Id: <20260709141646.725B41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `damon_pa_apply_probes()` callback ignores the newly added `=
set_samples` parameter, violating the updated API contract documented in th=
e header.
- [Low] The use of `&set` in the kernel-doc comment will generate a warning=
 during the documentation build.
--

--- Patch [2]: [RFC PATCH v1.2 02/19] mm/damon/core: ask apply_probes() ops=
 callback to set sampling address ---
commit d206ad52f1017ca79add3bb060530dc8e4e317fd
Author: SJ Park <sj@kernel.org>

mm/damon/core: ask apply_probes() ops callback to set sampling address

This patch updates the apply_probes() DAMON ops callback by adding a
set_samples boolean argument. This allows the callback to optionally handle
sampling address setup to minimize unnecessary region iteration.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index d8251c83e6e55..3c2a4d673bf62 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -647,7 +647,8 @@ enum damon_ops_id {
>   * It should also return max number of observed accesses that made as a =
result
>   * of its update.  The value will be used for regions adjustment thresho=
ld.
>   * @apply_probes should apply the data attribute probes to each region a=
nd
> - * accordingly update the probe hits counter of the region.
> + * accordingly update the probe hits counter of the region.  It should a=
lso
> + * &set sampling_addr of each region if ``set_samples`` is true.

[Severity: Low]
This isn't a bug, but will this use of '&set' in include/linux/damon.h
generate a kernel-doc build warning?=20

The '&' prefix in kernel-doc is strictly reserved for referencing structure=
s,
enumerations, typedefs, or unions. Using it to emphasize the verb 'set' is
invalid syntax.

[ ... ]

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 6172464981730..b13bf7c6eade3 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -166,7 +166,7 @@ static bool damon_pa_filter_pass(phys_addr_t pa, stru=
ct folio *folio,
>  	return pass;
>  }
> =20
> -static void damon_pa_apply_probes(struct damon_ctx *ctx)
> +static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_sample=
s)
>  {
>  	struct damon_target *t;
>  	struct damon_region *r;

[Severity: Medium]
Does damon_pa_apply_probes() in mm/damon/paddr.c need to use the new
set_samples parameter?

According to the updated API documentation, this callback should conditiona=
lly
set r->sampling_addr if set_samples is true. However, the parameter appears=
 to
be ignored in the function body in this commit, which could lead to incorre=
ct
or stale sampling if a future caller passes true.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709140600.9095=
0-1-sj@kernel.org?part=3D2
