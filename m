Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23AB4A1DFB
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050368; cv=none; b=LCw3FSN5+J8M7oiVt7hVYIPp0WGcIU1LxSFMQNzFdyU0n0wzJzfVXMhPlw6WlxXTb2aHa6f4bhIz8rrr1Idk5UZInwYcrfBIMeE2WRNwdo+F5/QCBkUjRJYnjezLK4gf94udUWx7+vdK1EakRdgwK4ARg3lt+XaSmzpUIW41BAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050368; c=relaxed/simple;
	bh=LzZ4t0IkxkMY1UKwJKXlOur2EA3O7BWmfLJPUdlxZ+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AoWMAeOwmZCjZwK8UGkb4ViPawG7G1uYvEDcitFupWtugrcMLzqLd8d0gLrFs4P7Yw7xNJL9WQbboRoH/kZj28w9g93C4Bt2xNTx45eGk9FW3QDYbUpGC8AXeYnvD1FDiPP8Dce6gxWsNLV07nkrefMR6b0YIq/y9NCLqw9NGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U//Q3dAi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U//Q3dAi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A281F00893;
	Thu, 10 Sep 2026 14:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050366;
	bh=OjNUGkRriBwag0WMiPLMcWQiPZSwCwt+MDDvwpZtjak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U//Q3dAiA71MKTi9jvNKWHHD2c7WZb8w4kiOcWQK0VgL+ay3aMBVmNKRDFWoKAM4d
	 6UnzTXhLO/GGWd8e+8+MIoGQtDFyvpbjnFbxblqjtfnfNS0gEzZiI76CfwjnOZUvcn
	 rJSPFyhVhqFX/NEgQRNKwBUVHSqmECDBkeB/n/KstEh9aep0fvSqzOs+PFBOb4fKRi
	 99Iyn4SeZz+GZnvCLrTtGpGN0gkt25TVBny4opFPHD1EbyhDhvhhaSbipqDc+KnuSz
	 29n+awari+5VQ62g8KIryxWn+8XP0Ci2XXfyYkVnqr/6xScrz9/2KUgSY8B8eGPn1x
	 cdU8tU6j5KM0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] mm/damon/core: support probe_hits_wsum damos core
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910141849.170896-4-sj@kernel.org>
References: <20260910141849.170896-1-sj@kernel.org>
 <20260910141849.170896-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:26:06 +0000
Message-Id: <20260910142606.B7A281F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing KUnit test coverage for the new DAMOS_FILTER_TYPE_PROBE_HIT=
S_WSUM filter.
--

commit c30ab09af6b4b9ef8cab31ff2d43ce4d72f9e904
Author: SJ Park <sj@kernel.org>

mm/damon/core: support probe_hits_wsum damos core filter

This commit implements the probe_hits_wsum DAMOS core filter support. It up=
dates
the core layer to treat it as a core filter, copy its range parameters, and
match regions based on their weighted sum.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index e9630f41e51fe..d9d56f4be1a97 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -1332,6 +1333,10 @@ static void damos_commit_filter_arg(
>  	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
>  		dst->sz_range =3D src->sz_range;
>  		break;
> +	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
> +		dst->range_min =3D src->range_min;
> +		dst->range_max =3D src->range_max;
> +		break;
>  	default:
>  		break;
>  	}

[Severity: Low]
Should this patch also update the KUnit tests to cover the new filter type?

The new DAMOS_FILTER_TYPE_PROBE_HITS_WSUM filter is not validated by the=20
DAMON core KUnit tests, leaving this argument copying logic untested.

For example, it appears missing from the validation switch in=20
damos_test_commit_filter_for():

mm/damon/tests/core-kunit.h:damos_test_commit_filter_for() {
	switch (src->type) {
	case DAMOS_FILTER_TYPE_MEMCG:
		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
		break;
	...
}

And the orchestrator function damos_test_commit_filter() does not seem to=20
invoke a test case for the new probe_hits_wsum filter.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910141849.1708=
96-1-sj@kernel.org?part=3D3
