Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195992D23A6
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261282; cv=none; b=LqDwygV5QnnXNqOCGZb037OUwNeDOo3NUuO5xzZo/PovgZfmX5vMG4IeWDFbkH9wK+xZQCgKiTlMKUSWWvgtZvFF2XrQPvVydfpxME+d3VlyobdLDd18CBYoNBqzi6AqZmxmXIkr/iJj5yWwIPS+6kaH6k1g59XpQlgA0vIwxYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261282; c=relaxed/simple;
	bh=lnK81uhcINvS4PjiT1Af9hP/QBl0e2iZ5lXGNco9SSI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UJDuaqY7OpZp0tOYAMo/EtvKzQPLkrIVNcSVszV8R0uN5iwy4B1+hIsC7pB/g5fiZ86DpHfdtsy++s1Bv/r9TW0H9zuBCpD835uIDskK+hwXUH2oZBZKoHFrdF+X0EcM1Wdz9zG8yriOnO/m8jkc42GYNYJByjIe9ONEUdzFZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am1M8Q49; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am1M8Q49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39471F00A3E;
	Tue,  1 Sep 2026 11:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788261280;
	bh=81pybpG9xPb2nYazAfzKyoMVVBuuZNbHz6fR2MM79m8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Am1M8Q49lfnnnagMCSVrDyKO+6RRAAN03fQKnrbnoQvDLw9DrOXduIk7xaR6bJHPV
	 eGmRcE3cZXompX4P7p1zSjstACjtXJGZnGSWZBngrTpnuqwURImDT7HIlz1LzVWv5h
	 8tt8vkTZ7R1dOr9GRiSqxpATnE0LjoeeEvYdEo78ZLoE5GUlnAnj1xvv0QTcYwk1G5
	 NUvFbNmMRRi8ibDTOJJcFaLXRCVXN9o86/gYbM6ms6cpg+Sg0RFTEot4MlIVedlig+
	 +71XEHyZhuCV5bYkNCGs1tc4Rh2ggjBVNuemScHtvsIqbMp3QZSbfM3VuuA1xAuPqO
	 cq/fBvWJhk9Hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: fix quota could not be set to zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901105951.106246-1-aethernet65535@gmail.com>
References: <20260901105951.106246-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 11:14:40 +0000
Message-Id: <20260901111440.A39471F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch places the `if (esz)` check after the throughput calcula=
tion, inadvertently reverting a previous fix (commit 8bbde987c2b8) and caus=
ing schemes with low throughput to permanently deactivate.
--

commit a1511f591a76665e55c325a03d3d47bf4ba87dc6
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/core: fix quota could not be set to zero

This commit modifies the damos quota setting logic to skip clamping to
min_region_sz when the effective size quota is already zero. This is
intended to allow the temporal tuner's zero quota goal to be respected.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3f89cfdf5f022..fdec7c0fe913a 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3122,7 +3122,8 @@ static void damos_set_effective_quota(struct damon_=
ctx *ctx, struct damos *s)
>  		else
>  			throughput =3D PAGE_SIZE * 1024;
>  		esz =3D min(throughput * quota->ms, esz);
> -		esz =3D max(ctx->min_region_sz, esz);
> +		if (esz)
> +			esz =3D max(ctx->min_region_sz, esz);

[Severity: High]
Does placing the if (esz) check after the throughput calculation inadverten=
tly
revert the fix from commit 8bbde987c2b8 and cause a regression where slow
schemes permanently deactivate?

If a damos scheme with a time quota processes regions slowly, integer divis=
ion
can cause throughput to truncate to 0. When this happens, the calculation
esz =3D min(throughput * quota->ms, esz) evaluates to 0.

Because the new if (esz) check is placed after this min() calculation, the 0
value causes the check to fail, skipping the max(ctx->min_region_sz, esz)
clamp.

With esz =3D=3D 0, damos_quota_is_full() always returns true, bypassing all
scheme operations. Since no regions are processed, total_charged_ns and
total_charged_sz are never updated. This leaves throughput permanently at 0,
resulting in an unrecoverable starvation loop.

>  	}
> =20
>  	if (quota->sz && quota->sz < esz)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901105951.1062=
46-1-aethernet65535@gmail.com?part=3D1
