Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8199B1386C9
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540138; cv=none; b=N3BEbI58McKcY2HfyHC91U/W7vojHLKzvukii2i7e2n/vns7B1LkEMpWQQbvsEzPQfx0j5pVJeSCGOwp7tIOqampSoze/GyiZl2JGtZdFAZPVXLG1BynIdReWhtbcdLgAEaR0t9q6VOiFx2dLro8gAjFrZrFui2Vkh5WMWdE/vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540138; c=relaxed/simple;
	bh=XYwPWd6qG4lDlxkN2aqA+qSmvhraj9XgE9f8pdzMGUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FnmPoIqfglYDmR82XEISNT0r88jlBwElkCvVtVe4YkZQV8Z3bC6heXpIrkRjVkX/0S4qTDKioeWL0y8xhRfQOfOdAlK8btxkgTeMZ1vcVbKyi+/dm0Bh6Fs97HvmxOvggzaV3puO8xGEhHL4cUHcITqsmML8V9N+CsWTrsBcz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH4bxPc5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH4bxPc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22941F000E9;
	Mon, 20 Jul 2026 09:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540137;
	bh=Tu608lEXWmYmBp3KmZY1cP6W1o8Bqu7T8S3vJEZ4lIY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EH4bxPc5hpmJLk9bVPJFYxKVeS2GOP4rIt1k1p2I5veb2L7XlxLYkjNEWSEWRg8ti
	 bKMMVvB27sT9w8SeOm18XMqpuvHKTIZHsZH1a9VDGkQ6avuUxU6MjoXDPMMb9oybi8
	 ZAvx2mvwHJuk5iWV+rZg3FIkVusoWoKn/sB6GZFLcU266A0UrQpfZ5pqM98IfxDu3s
	 7FQvuSLKV82EAhJwcT2wRGadV3rNPmIyaCK5qx8V8ZLTch7lohvs4jLGdlnCLlkmvd
	 UBCy4061Ddm+XH9cVKQ1lgq2fDs2XC2FSWzX45Qw6RLonG2ds1ZAmHiuroCKiGUtra
	 Gi/CY09BAf/Dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] samples/damon/mtier: use damon_addr_range consistently
Reply-To: sashiko-reviews@lists.linux.dev
To: "Enze Li" <lienze@kylinos.cn>
Cc: damon@lists.linux.dev
In-Reply-To: <20260720092355.237599-1-lienze@kylinos.cn>
References: <20260720092355.237599-1-lienze@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:35:36 +0000
Message-Id: <20260720093536.E22941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The commit message incorrectly claims `struct damon_addr_range` =
has an identical layout to `struct region_range`, masking a physical addres=
s truncation issue on 32-bit PAE architectures.
- [Low] The refactoring removes a custom struct but leaves a redundant loca=
l variable `range` and unnecessary field-by-field copy operations.
--

--- Patch [1]: [PATCH] samples/damon/mtier: use damon_addr_range consistent=
ly ---
commit 71c06f0196fa4997fb5e79c1b3b9f9f2e74eb370
Author: Enze Li <lienze@kylinos.cn>

samples/damon/mtier: use damon_addr_range consistently

This commit removes the local struct region_range and uses struct
damon_addr_range for unified address range management.

> The DAMON provides struct damon_addr_range for unified address range
> management.  However, the mtier sample still defines a local struct
> region_range with an identical layout (start and end as phys_addr_t) and
> mixes its usage with struct damon_addr_range in

[Severity: Medium]
Is this description of struct damon_addr_range accurate?

Looking at include/linux/damon.h, struct damon_addr_range is defined with
unsigned long fields, not phys_addr_t:

struct damon_addr_range {
	unsigned long start;
	unsigned long end;
};

On 32-bit architectures with PAE, phys_addr_t is 64-bit while unsigned long
is 32-bit, meaning assignments of physical addresses via PFN_PHYS() will
silently truncate.

Could the commit message be updated to avoid stating they have identical
layouts?

> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index ac9c24b92ead8..67f20b52dc7bb 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
[ ... ]
> @@ -78,8 +73,7 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(b=
ool promote)
>  	struct damos *scheme;
>  	struct damos_quota_goal *quota_goal;
>  	struct damos_filter *filter;
> -	struct region_range addr;
> -	struct damon_addr_range range;
> +	struct damon_addr_range range, addr;

[Severity: Low]
Since addr and range are now exactly the same type, is it still necessary to
keep the separate range variable?

Further down in damon_sample_mtier_build_ctx(), there is a field-by-field
copy that is now redundant:

	range.start =3D addr.start;
	range.end =3D addr.end;

	ret =3D damon_set_regions(target, &range, 1, DAMON_MIN_REGION_SZ);

Could we remove the range variable entirely and just pass &addr directly to
damon_set_regions() instead?

>  	int ret;
> =20
>  	ctx =3D damon_new_ctx();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720092355.2375=
99-1-lienze@kylinos.cn?part=3D1
