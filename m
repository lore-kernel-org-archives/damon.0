Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B33371873
	for <damon@lists.linux.dev>; Tue, 14 Jul 2026 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039110; cv=none; b=qN1NkCi7Ko6+yICc/gBCCPW+ctZM/xA5nwtMA4zLM/g+4Dsr705PFUM3OjugkKLXSLhp0RawzHreiGsTw/btx8DfrzHWeNEvCutQ3ZPwuAjoCKnPABZAzuTn64Gjyveymbf307ez1t0FGMUR7CWf5jP3ZCEvr2hRnIRmNJH/XIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039110; c=relaxed/simple;
	bh=p0cp703n4Eyb3xv7jhrNB3wZMywTRRMQQFTPYa1kOew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FzPC6OzvAdH81R7d9HwJZ9dywCHoMZN5PDyqZy8sdgh1nz9jXKLtyTj8rDNmTuFjzWRydOLPMJU5WHdmJI97ANe8k0NHrPitBAf4DPfACizOCeUiu+804lLRFZxaYvVZUez/PYSl7gWMxrTFqy+fYMwiu+GbO8QijxVf2KPZT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctLJ/6p7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctLJ/6p7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010D91F000E9;
	Tue, 14 Jul 2026 14:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039109;
	bh=clRBIa28cYGbhkB5IfowPX4hBM+Q1WlVRrYPfWndB5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ctLJ/6p7UvqeibJXxVOttY2YFuF7IigxdtaNStsV3t02h8pg3dMfXM6GlJis7AsVh
	 dNFag+t5p7wRtPElSe4+66m8irT1grHy3ctwosJCHE+aVOgcZwFH9MIXoHCveVf7n4
	 7tXzF+5xCj3cyQD/hek6z/iITh8DDdsGbN2XW+P3TahD3Usz3pbpbp4Eucsc1Z7l2N
	 8Vn6H54oWfpxOsjLFrpKFbtPLFZkoK/fcj3/1llmSv8R+TZWORU0sLamewFL+o0Kmf
	 RSmh0PaThciY4ZqjnZqLFH3GYaD8Xo5cKhJuaeNMUcDlMQfP1AMcPlCsSzA/ddtTjF
	 p+3A1bMu9QX5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] mm/damon/sysfs: read ops_id only once
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260714135236.92699-6-sj@kernel.org>
References: <20260714135236.92699-1-sj@kernel.org>
 <20260714135236.92699-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 14:25:08 +0000
Message-Id: <20260714142509.010D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch implements an incomplete fix for a TOCTOU data race. I=
t correctly uses READ_ONCE() for `ops_id` to prevent `min_region_sz` corrup=
tion, but leaves an identical unresolved race condition for `addr_unit` imm=
ediately below it.
--

--- Patch [5]: [PATCH 5/5] mm/damon/sysfs: read ops_id only once ---
commit f0f9d921acb64429b2f4e2895a8088cc3b5477d5
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs: read ops_id only once

This commit addresses a time-of-check to time-of-use race condition in
damon_sysfs_apply_inputs() by reading ops_id only once. This prevents a
concurrent sysfs write from causing min_region_sz to be incorrectly
configured.

Link: https://lore.kernel.org/20260703172417.95426-1-sj@kernel.org

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index b5fe036f78015..60a1a9e4ada34 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -2094,14 +2094,16 @@ static int damon_sysfs_apply_inputs(struct damon_=
ctx *ctx,

[ ... ]

>  	ctx->addr_unit =3D sys_ctx->addr_unit;
>  	/* addr_unit is respected by only DAMON_OPS_PADDR */
> -	if (sys_ctx->ops_id =3D=3D DAMON_OPS_PADDR)
> +	if (ops_id =3D=3D DAMON_OPS_PADDR)
>  		ctx->min_region_sz =3D max(
>  				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);

[Severity: Medium]
Is there a similar race condition remaining for sys_ctx->addr_unit?

While this patch successfully fixes the race for ops_id, sys_ctx->addr_unit
is read twice sequentially in this same block of code without protection.

A concurrent sysfs write to addr_unit between the assignment to
ctx->addr_unit and the division in the max() calculation could cause DAMON
to inconsistently calculate min_region_sz, degrading monitoring precision.

Should addr_unit also be read only once using READ_ONCE() here to fully
prevent the race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714135236.9269=
9-1-sj@kernel.org?part=3D5
