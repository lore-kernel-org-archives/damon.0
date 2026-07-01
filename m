Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564B419307
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907337; cv=none; b=b7ZGcuHvWJWQcioJn71keKoi3I6sORrQTGCT2ABoQVRqb/XEtANMbTDpJKfG+2OlPu4LodAkvCG4BtcgaT9ocaqCdJxNJeXEUGqlyoxtQ/fNCrNfFaG6F5RpXsJ1+oRCOsEDbeyS3bYKvctwnyufdoTJt1hSBuAkvOfwGDqUpAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907337; c=relaxed/simple;
	bh=Ud+kDGBO9II38FeocbZxYefijPI5rGArlv8MIF2HofI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J/p1dxbL/NGmOFLSdr9vJloisGyf8rIQf6InKEME0TddzniifDIZ9Ga+uYclZlnyDwwdHp8+bB9MsKh2xi/GBJ4GG38gJeITmjILzuRUpwCXnRLO6Wzsz2irCiYZ/WsqpZ8csI0mgX5JJ8nmZisREgJNaUv9mRwWcXuHhpaGANg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuyweH+3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuyweH+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A6B1F000E9;
	Wed,  1 Jul 2026 12:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782907335;
	bh=PJrEWhVt0HyMHzfjZVA+rrFl/s+ih1pZ0Oz+b6rXc10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GuyweH+3AArZ+1gBCtmiZtCGqYqzHEiNSUJ0UEHzfyxUQ/AWA+rloU++WAMS9WLmY
	 UPRwyymyvGKZAIvLKxOLlFptAncMbQUiYvYXUy/KlblQWON40vrCSNfd6Of9fzdVzq
	 H1XHcLU4WZH4k72gZkkOblgOhXKKxelII/bQjXJUlNCE1yHz8RreuyybxGYrZM+QJB
	 Y4mxunhcx/3KXWo+pbKF9o6I1hSovDCP5fshRMLdsgPXCYf9nkxd+2qIIjrgdF/D1+
	 7VApUJlCy58CUi6vquwvS/sSwYQvG7pSb+SwqnSURKZL8MrDhgHVa51NBMZHVKPdzT
	 MzG4wwuCnS+EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] mm/damon/vaddr: implement mTHP-aware
 DAMOS_COLLAPSE handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "wang lian" <lianux.mm@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260701114716.56503-4-lianux.mm@gmail.com>
References: <20260701114716.56503-1-lianux.mm@gmail.com>
 <20260701114716.56503-4-lianux.mm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:02:15 +0000
Message-Id: <20260701120215.B1A6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] DAMOS_COLLAPSE silently drops support for file-backed memory when =
target_order is explicitly set.
- [High] damos_va_collapse() spins uselessly for mTHP orders because the ba=
ckend function explicitly rejects them.
- [High] Expanding sub-regions to chunk boundaries without deduplication ca=
uses massive redundant processing and quota inflation.
- [High] Stack exhaustion risk due to allocating a large `struct collapse_c=
ontrol` on the kernel stack.
- [Medium] ALIGN() boundary calculation can overflow to 0 for high memory r=
egions, causing them to be silently skipped.
- [Low] Missing stub for damon_collapse_folio_range() causes build failures=
 when CONFIG_TRANSPARENT_HUGEPAGE is disabled.
--

commit 54fd1422ea9f2a5e501241c8565e081399639772
Author: Wang Lian <lianux.mm@gmail.com>

mm/damon/vaddr: implement mTHP-aware DAMOS_COLLAPSE handler

This commit updates the DAMOS_COLLAPSE handler to support collapsing memory
into requested mTHP sizes. It iterates over target regions in chunk-aligned
ranges and falls back to the existing MADV_COLLAPSE path if no target order
is provided.

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index e73ec1ce016e5..eeaa403eb79e4 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
[ ... ]
> @@ -897,6 +898,40 @@ static unsigned long damos_va_stat(struct damon_targ=
et *target,
>  	return 0;
>  }
> =20
> +static unsigned long damos_va_collapse(struct damon_target *target,
> +		struct damon_region *r, struct damos *s,
> +		unsigned long *sz_filter_passed)
> +{
> +	unsigned long addr, end, chunk_sz;
> +	unsigned int target_order =3D s->target_order;
> +	unsigned long applied =3D 0;
> +	struct mm_struct *mm;
> +	int ret;
> +
> +	if (target_order < 2 || target_order > HPAGE_PMD_ORDER)
> +		return 0;
> +
> +	chunk_sz =3D PAGE_SIZE << target_order;
> +	addr =3D ALIGN_DOWN(r->ar.start, chunk_sz);
> +	end =3D ALIGN(r->ar.end, chunk_sz);

[Severity: Medium]
Does this calculation overflow to 0 if the region ends near the top of the
address space?

If the address is close enough to ULONG_MAX, ALIGN() wrapping around to 0
would cause the subsequent while loop condition to immediately evaluate to
false, silently skipping those memory regions.

> +
> +	mm =3D damon_get_mm(target);
> +	if (!mm)
> +		return 0;
> +
> +	while (addr < end) {
> +		ret =3D damon_collapse_folio_range(mm, addr, target_order);

[Severity: Low]
Does this cause a build failure when CONFIG_TRANSPARENT_HUGEPAGE is disable=
d?

The declaration for damon_collapse_folio_range() in
include/linux/khugepaged.h appears to lack an empty stub for the disabled
case, which would break the unconditional call here.

[Severity: High]
Is there a risk of stack exhaustion in the backend?

Looking at damon_collapse_folio_range() in mm/khugepaged.c, it allocates
struct collapse_control directly on the stack:

mm/khugepaged.c:damon_collapse_folio_range() {
        struct collapse_control cc =3D {
                .is_khugepaged =3D false,
        };
        ...
}

Because this struct contains bitmaps sized by MAX_NUMNODES, it can easily
exceed safe kernel stack limits on typical configurations.

[Severity: High]
Can this loop waste CPU by repeatedly attempting operations that will always
fail for mTHP orders?

While this function allows target orders from 2 up to HPAGE_PMD_ORDER,
damon_collapse_folio_range() in mm/khugepaged.c appears to explicitly reject
anything other than HPAGE_PMD_ORDER:

mm/khugepaged.c:damon_collapse_folio_range() {
        if (target_order !=3D HPAGE_PMD_ORDER) {
                pr_warn_once("... only PMD order (%u) is supported, got %u\=
n",
                             __func__, HPAGE_PMD_ORDER, target_order);
                return -EINVAL;
        }
        ...
}

This would cause immediate -EINVAL failures for valid mTHP target orders.

> +		if (!ret)
> +			applied +=3D chunk_sz;
> +		*sz_filter_passed +=3D chunk_sz;
> +		addr +=3D chunk_sz;

[Severity: High]
Can multiple small DAMON sub-regions that fall within the same chunk cause
redundant processing and inflate the quota?

Since the boundaries are expanded earlier using ALIGN_DOWN() and ALIGN()
without deduplicating adjacent sub-regions, the same chunk might be
collapsed and accounted for multiple times.

> +		cond_resched();
> +	}
> +
> +	mmput(mm);
> +	return applied;
> +}
> +
>  static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  		struct damon_target *t, struct damon_region *r,
>  		struct damos *scheme, unsigned long *sz_filter_passed)
> @@ -920,6 +955,9 @@ static unsigned long damon_va_apply_scheme(struct dam=
on_ctx *ctx,
>  		madv_action =3D MADV_NOHUGEPAGE;
>  		break;
>  	case DAMOS_COLLAPSE:
> +		if (scheme->target_order)
> +			return damos_va_collapse(t, r, scheme,
> +						 sz_filter_passed);

[Severity: High]
Does setting the target order silently break support for file-backed memory?

The original MADV_COLLAPSE path supports file-backed regions, but
damon_collapse_folio_range() delegates to collapse_huge_page() in
mm/khugepaged.c, which unconditionally enforces expect_anon=3Dtrue.

>  		madv_action =3D MADV_COLLAPSE;
>  		break;
>  	case DAMOS_MIGRATE_HOT:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701114716.5650=
3-1-lianux.mm@gmail.com?part=3D3
