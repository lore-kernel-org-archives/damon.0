Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F5423152
	for <damon@lists.linux.dev>; Mon, 29 Jun 2026 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745278; cv=none; b=hfOEP0xg7DdGr4yyBrcAlX0wwgn5bcxomfuDC6Znd6EfLLGi49jsRXdgx59oocuwpTFq+qDTAgUtpCtaz44zrVWP92MzW6reR7d9Lug7QZ5O3cFdBL/a5qqaU/20O6QGjHTxdd/iJ29oxGpz0gmvIVzVyiMl/E+vFeTjHFMkvw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745278; c=relaxed/simple;
	bh=buINkP9eZAvdY4i6xWIBNf97SSpBCjm+pS5+4jXQVCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XYIcKerm8vCxlrAnEpMvHt15zIsJb3lG3zPiXGNuwo/ox6iOqw9ceQHGkdWlThruGBuFkRNhV7Prleydj7C/JmTTyPgctYZUYc+ZLURknmQKXovHUIoZVzWWEtf6FyED1T1+5Mvy4RYXjs2c7ZgIDJ5d2vZoKbzXLLniah/GveM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUbRWyHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUbRWyHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6EE1F000E9;
	Mon, 29 Jun 2026 15:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782745276;
	bh=ZTLi6UQAI+kokh/ntutwCKwUY5k0Scn+KFmOb1xu/tI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FUbRWyHtG+A9w3D+MnWENV9Ig59oByh5iMNq1zv47fwPBK8DWUHh4wnsOJEf05ah/
	 2ltrQYskV/NNDi2EzEMs04dMJj1L9iI4l+nP/UAsHvBkVFdWEr6dhKL1AiF5Su4Qtk
	 mQRbW1ELdTODwp1mXPtjjN8LCzKBwzltEG0PxHQ+K5CuHYpZlqQkmWL8fC0cp+VdQP
	 gLirA+24zfiee4f3D7YamXmYQyh9Hts4+QXCBK8DvwD4oBoN1GbLxWuIekqTRUqQPS
	 3F8Hzr6Kihq3uFBaZZ2pSVtT50i4VzOFPOWD4IuEGzPqmTLZi83RsudwxBJYdYZObw
	 zbsFfgOqpaLpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] samples/damon/mtier: fail early if address range
 parameters are invalid
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260629144432.133962-1-sj@kernel.org>
References: <20260629144432.133962-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 15:01:15 +0000
Message-Id: <20260629150116.1C6EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The sysfs interface allows creating zero-sized regions, leading to=
 a division by zero kernel panic in `damon_merge_two_regions()` when mergin=
g adjacent zero-sized regions.
--

commit 049fc008d25fe73be336de6b00bf5512c8f6ec71
Author: Zenghui Yu <yuzenghui@huawei.com>

samples/damon/mtier: fail early if address range parameters are invalid

This commit fixes an issue where invalid node address ranges could trigger a
WARN_ONCE. It prevents zero-sized or negatively-sized regions by adding an
early failure check if the start address is greater than or equal to the end
address.

> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index faaaaa12e6206..e567f4edd80ea 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
[ ... ]
> @@ -120,6 +120,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx=
(bool promote)
>  		addr.end =3D promote ? node1_end_addr : node0_end_addr;
>  	}
> =20
> +	if (addr.start >=3D addr.end)
> +		goto free_out;
> +

[Severity: High]
This is a pre-existing issue, but while you are fixing zero-sized regions
here, does the DAMON sysfs interface have a similar vulnerability that can
cause a kernel panic?

Looking at damon_sysfs_set_regions() in mm/damon/sysfs.c, the bounds check
only uses strictly greater than instead of greater than or equal to:

    if (sys_region->ar.start > sys_region->ar.end)
            goto out;

If a user configures two identical zero-sized regions via sysfs (e.g.,
start=3D4096 and end=3D4096), this check passes. Furthermore, the overlap
check allows consecutive identical zero-sized regions because exact boundary
matches evaluate to false.

When DAMON executes damon_merge_regions_of(), it identifies these as
perfectly adjacent and attempts to merge them in damon_merge_two_regions():

mm/damon/core.c:damon_merge_two_regions() {
    ...
    l->nr_accesses =3D (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
            (sz_l + sz_r);
    ...
}

Since both regions are zero-sized, sz_l + sz_r evaluates to 0, which would
cause a division by zero kernel panic. Should the sysfs interface also be
updated to use >=3D to prevent this?

>  	range.start =3D addr.start;
>  	range.end =3D addr.end;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629144432.1339=
62-1-sj@kernel.org?part=3D1
