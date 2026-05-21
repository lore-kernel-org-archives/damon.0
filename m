Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF92F1FF4
	for <damon@lists.linux.dev>; Thu, 21 May 2026 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376770; cv=none; b=Wb8oQuNdQq5XAZlTOZM4KG0K9azdOV51ivK6UmqY+/rPMi7YHgxrQncstOOsy0Fy9UkxkCtS9+53Hs/1s4OjbCS2+J7/RIB5BKYv44AF/btNrzOgSsXfw/eNwY5CtUxeFbj1m7izHGxbwqhztKgMaa5Q300wfPBVNBvEn+5uXto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376770; c=relaxed/simple;
	bh=Evoyel9GNSwKvGEu0dzaLXSBOb2EMBu6HkWYZjRvNyQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d8cTs5xq7j/jlJhjz4uUQ/LqnPXUS9FRu0Jp/v9c/OxxUOeTLUJJJpigwdMyPYCN8J1O4CZcATWGDOaL70uCxxQjpgnyX/MERtImsd2iqO+ONWcIr/I7wpZVGETVcSIV+ArMzIpBSttwmNwLisicewCtK2G2x3XPxn3bHYuJzoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8LqH6EB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8LqH6EB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C25C1F000E9;
	Thu, 21 May 2026 15:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376769;
	bh=bbsnCpbnjDjZl9bmhCcHgynMvvXk2B2HSkU6FiylJgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c8LqH6EBg2AJ0nI17eBPjad6zlPLovNtf4x3XqxdNQpt29Qf6re70EycZqWm/kfH/
	 FqZMYGpWuR5yQA09zQ1cAIf5JlzCihD766x8zHqPaYdb82iObZ4bIIQIhDCZK9G8yL
	 TH4nSo9UIL18ZN18DXOfHBvBqRTYhIqHi6IAjEYEG8li2XVikYX9QY04z48JFAYopV
	 VHqtHcORweV/r56cml4hd0VLKUTPEZVt9bR/fDY+ZPFZao5mDspGIM6D/pkPWpAhEZ
	 LvMghJJ4Ta5YNmUKB8mTiWifO47i5TpBFXs6OYVcfIrm3/EIv8Dejk2BA+UpB2eC8X
	 kvNdrwjKN2g2g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 01/14] mm/damon/core: safely handle no region
 case in damon_set_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260521143428.83157-2-sj@kernel.org>
References: <20260521143428.83157-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 15:19:28 +0000
Message-Id: <20260521151929.5C25C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The ALIGN() macro can overflow when processing malicious or ov=
erly large user-provided region 'end' values, creating invalid regions wher=
e start > end.
- [High] min_region_sz can be a non-power-of-2 value, which corrupts region=
 boundary calculations when passed to ALIGN() and ALIGN_DOWN().
- [High] Userspace can maliciously trigger a kernel warning (WARN_ONCE) by =
providing a region where start =3D=3D end via sysfs.
- [High] A memory allocation failure during region creation results in a pa=
rtial state update without a rollback, potentially leaving the running DAMO=
N context corrupted.
--

commit fa588352eaf7b151171cca8c2acb0bb710a71c75
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: safely handle no region case in damon_set_regions()

This commit refactors damon_set_regions() to explicitly handle the empty
region list case without depending on the internal implementation of
list_first_entry().

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 4e223857a0f99..d0bdf6e01dff8 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -356,6 +356,19 @@ int damon_set_regions(struct damon_target *t, struct=
 damon_addr_range *ranges,
>  			damon_destroy_region(r, t);
>  	}
> =20
> +	if (!damon_nr_regions(t)) {
> +		for (i =3D 0; i < nr_ranges; i++) {
> +			r =3D damon_new_region(
> +					ALIGN_DOWN(ranges[i].start,
> +						min_region_sz),

[Severity: High]
This is a pre-existing issue, but can min_region_sz be a non-power-of-2
value here?

If sys_ctx->addr_unit is set to an arbitrary value via sysfs, min_region_sz
might not be a power of 2. The ALIGN() and ALIGN_DOWN() macros internally
perform bitwise AND operations with ~(a - 1), which assumes the alignment
is a power of 2.

Could passing a non-power-of-2 value truncate arbitrary bits and result in
misaligned boundaries where start > end?

> +					ALIGN(ranges[i].end, min_region_sz));

[Severity: Critical]
This is a pre-existing issue, but can ALIGN() overflow when processing
overly large end values?

If a user passes ULONG_MAX as the region end via sysfs, ALIGN(ULONG_MAX,
4096) will overflow and wrap around to 0.

Would this result in damon_new_region(start, 0) being called, creating an
invalid region where start > end, which could underflow the size and cause
out-of-bounds memory accesses?

[Severity: High]
This isn't a bug introduced by this patch, but what happens if userspace
provides a region where start =3D=3D end?

The sysfs interface end_store accepts arbitrary values, and if start =3D=3D=
 end,
both bypass the start > end validation check. Since ALIGN_DOWN() and ALIGN()
return identical values for identical inputs, would damon_new_region() be
invoked with equal start and end arguments, allowing an attacker with sysfs
access to maliciously trigger a WARN_ONCE(start >=3D end)?

> +			if (!r)
> +				return -ENOMEM;

[Severity: High]
This is a pre-existing issue, but does this allocation failure leave the
DAMON context in a corrupted state?

If damon_new_region() returns NULL due to memory pressure, the function
immediately returns -ENOMEM without rolling back the regions that were
already removed or added in the previous loop.

Could this leave the running kdamond thread with a partially modified list
of regions?

> +			damon_add_region(r, t);
> +		}
> +		return 0;
> +	}
> +
>  	r =3D damon_first_region(t);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521143428.8315=
7-1-sj@kernel.org?part=3D1
