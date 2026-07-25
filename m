Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CA12931FF
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785014227; cv=none; b=HDyfr/65RPdpcgOxxpfJKA8Zn4gI5V/8kuiY6DtnpU4TPdwFOHACt+erPlsjW6hX4GKhc1zysESaXEWxa9jKlintHhGQEcvowgoNqs3R7PPNGXLcdwd+HvMfGF4n4nG0zIxlWtckms0sJo0BtYMlB4pBpAB8kigfJuW9cTDvx7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785014227; c=relaxed/simple;
	bh=uhsAEk9Wh+QKliMplXaJDA38Q7R+LO6DMdKyie7nzGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lMvRRuNimJ4ckJFvgsRYLSLwrmCFyvCejz5SYKy6rBZL8VzQLE/rPpocEY77L06kXtzfXHm3wICIaVbI0OOjLKRf7l3Zpn2DReahCtj5PEUOtjoyVe0G4zZdazhrZYnwanRzvXg8x5KUm+lX7AZTwvQuFOAVOxtycQ2LBumutVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjTFfMOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjTFfMOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5108E1F000E9;
	Sat, 25 Jul 2026 21:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785014226;
	bh=dpaHLKNh2D6Dykv3EwN47QrGoG3kTAbUdwVYmM7qK58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NjTFfMOLHftXPWH5sXIOX1sUwFQ0H5KYdkxASaUpD7P0QO/u6bbuKLxAL0s5fZSvG
	 9581SqLaCx9oi41QQrtg29VW3ibIp9yx/WUqaDIw3wyEZ4vKntcqJ+rX5bI8COTMLl
	 gJFOIBYmf7GWrAXvHvFyIqjO1xZCK3QL2Hph3SsykHnHXlmUd/fGmHacJGlbHMyF6z
	 58es3e63bB/NmCmILtZn3h6jYEDGY8rJY45yoYjd2RgXpsbjG/N2jgjNF9+8LqFR3K
	 aNz2jcjchBAaNAeKJ4fqm3b/PDuF2u/10NQexOFsphEv89xrZ7T9Kt9jE4xMDgARfv
	 pXg33gXKnaNJQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 02/17] mm/damon/paddr: support PGIDLE_UNSET probe
 filter type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260725210225.129944-3-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
 <20260725210225.129944-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 21:17:05 +0000
Message-Id: <20260725211706.5108E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The PGIDLE_UNSET probe filter lacks a mechanism to clear the page =
idle state and PTE young bits at the start of the sampling interval when us=
ed with weights, breaking access monitoring.

Pre-existing issues:
- [High] PFN advancement after page-to-folio conversion using `folio_size()=
` causes subsequent folios to be skipped if the iteration does not start at=
 the folio's base address.
--

--- Patch [2]: [RFC PATCH 02/17] mm/damon/paddr: support PGIDLE_UNSET probe=
 filter type ---
commit 97a45c1fa60aa6c710c0c0c9226adf390fa8207f
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: support PGIDLE_UNSET probe filter type

Implement support of DAMON_FILTER_TYPE_PGIDLE_UNSET in the physical
address space DAMON operations set. It reuses damon_folio_young(),
which was being used for access monitoring.

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 5a6a78054784a..199de1463fa06 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -132,6 +132,12 @@ static bool damon_pa_filter_match(struct damon_filte=
r *filter,
>  			matched =3D filter->memcg_id =3D=3D mem_cgroup_id(memcg);
>  		rcu_read_unlock();
>  		break;
> +	case DAMON_FILTER_TYPE_PGIDLE_UNSET:
> +		if (!folio)
> +			matched =3D false;
> +		else
> +			matched =3D damon_folio_young(folio);

[Severity: High]
Does this filter evaluate historical access state instead of interval-speci=
fic
accesses when used with weights?

If a DAMON probe is configured with weights, it skips the
prepare_access_checks() phase:

mm/damon/core.c:kdamond_fn() {
    ...
    bool access_check_disabled =3D damon_has_probe_weights(ctx);
    ...
    if (!access_check_disabled && ctx->ops.prepare_access_checks)
        ctx->ops.prepare_access_checks(ctx);
    ...
}

Because damon_pa_mkold() is never called on this address at the beginning
of the interval, it seems damon_folio_young() will read stale access state
and perpetually match once a page is accessed.

> +		break;
>  	default:
>  		break;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does the address advancement
in damon_pa_pageout() skip valid physical memory if the DAMON region
boundary is not aligned to a large folio boundary?

mm/damon/paddr.c:damon_pa_pageout() {
    ...
    folio =3D damon_get_folio(...);
    ...
    addr +=3D folio_size(folio);
    ...
}

When damon_get_folio() returns a large folio, unconditionally adding the fu=
ll
folio_size(folio) to an unaligned addr over-advances the address by
addr % folio_size(folio). This could cause the loop to skip the beginning
of the next folio.

The same unaligned address advancement also appears in damon_pa_de_activate=
(),
damon_pa_migrate(), and damon_pa_stat().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725210225.1299=
44-1-sj@kernel.org?part=3D2
