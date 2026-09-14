Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2062547F771
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400701; cv=none; b=qQOusVQKP0UPXwUp7WXV+6CTcz4tH3QpwQwQrG7S8lwaNyLTYwUU17amKDWrwGSlruPIKLTFr5VGLvYqaHjTRQr7ZU16ct8SUwOBkgOTupwExm1hlpTzdBMchhOjEfmxK8f9ubSb5aYYemUwHc4KsAO19+A2pENkEQgpHzJ5tuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400701; c=relaxed/simple;
	bh=NkMkWhlE/YMQ8uxhc9ft71As6wrESPESQmARSIm8Hv0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Is1bzrdsUKTGWGqyIAMkRiZWG0FAcCO8t53RoRuvoF5++XmMCLVHtNpAIqavmFd3NgUiQss/oJTfmqhJT1GNGrJTBi934XYOIDvIjhdc8/XnKjMkgCscbtZXQw21bhsbE02uJ2o41NNSGj9K6MSxidxi8SBvWpiToFP/UeNvdfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYjsafaM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYjsafaM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF891F00893;
	Mon, 14 Sep 2026 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789400699;
	bh=jVPQ4SuLGZgQ3st86jmECtrxrTdFs4lB7jjAGLptgew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eYjsafaMgmcHeHBfXTMKXHJIZ7Ibo4HZKT4xcC68ixGFwdvVOKzlD2I3w5Yp8CZyX
	 LqaOOaWqpFzH+R+sr9/e+phmuaQfsGeadsdBc2MrJhVA3pvOcyOXfpfyEo13bgwknw
	 dpIDoG/6fOI6xQ6lkAeFPEkgkmNT7ULVBmVUzasqUxBWs+gIi0s5pv8T6cM9sClP45
	 dirZDun/WDJ5pDiL5mGGyqPepdlpfhWRMmaM2cN7BIWBt+MsAAFoZ1VKl+Xnu4scvA
	 Iezmc4CVZEDZIzKB5Sa3d8T5cceAltnkdhUkErkyz5A2U2zUhOa8aGFhCtMeBFFaLx
	 2P8YkmlgMQdOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] mm/damon/core-kunit: test invalid damos filter
 commits
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914142327.92510-9-sj@kernel.org>
References: <20260914142327.92510-1-sj@kernel.org>
 <20260914142327.92510-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 15:44:58 +0000
Message-Id: <20260914154459.6CF891F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing test coverage for invalid DAMOS_FILTER_TYPE_PROBE_HITS_WSUM=
 filter commits.
--

commit 3dd853ee9735627ad90ea3f3d15874f043b5bdb4
Author: SJ Park <sj@kernel.org>

mm/damon/core-kunit: test invalid damos filter commits
   =20
This commit adds test cases to verify the validation of damos filter argume=
nts
at commit time.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 2b0931cf6fb32..527abc2570616 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -1184,6 +1184,13 @@ static void damos_test_commit_filter(struct kunit =
*test)
>  			.allow =3D false,
>  			.sz_range =3D {.min =3D 234, .max =3D 345},
>  			}, false);
> +	damos_test_commit_filter_for(test, &dst,
> +			&(struct damos_filter){
> +			.type =3D DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
> +			.matching =3D false,
> +			.allow =3D false,
> +			.sz_range =3D {.min =3D 456, .max =3D 123},
> +			}, true);

[ ... ]

> @@ -1197,6 +1204,13 @@ static void damos_test_commit_filter(struct kunit =
*test)
>  			.allow =3D false,
>  			.addr_range =3D {.start =3D 456, .end =3D 567},
>  			}, false);
> +	damos_test_commit_filter_for(test, &dst,
> +			&(struct damos_filter){
> +			.type =3D DAMOS_FILTER_TYPE_ADDR,
> +			.matching =3D false,
> +			.allow =3D false,
> +			.addr_range =3D {.start =3D 567, .end =3D 456},
> +			}, true);

[Severity: Low]
This isn't a bug, but is a test needed here for
DAMOS_FILTER_TYPE_PROBE_HITS_WSUM?

This patch adds negative tests expecting failure for invalid filter argumen=
ts
using DAMOS_FILTER_TYPE_HUGEPAGE_SIZE and DAMOS_FILTER_TYPE_ADDR.

Because DAMOS_FILTER_TYPE_PROBE_HITS_WSUM uses identical validation logic in
damos_commit_filter_arg() that rejects arguments when range_max is less than
range_min, should a similar test be added to provide equivalent coverage?

Also, earlier in this file, damos_test_commit_filter_for() validates
successful copies for other types, but lacks a case to check range_min and
range_max for PROBE_HITS_WSUM. Would it make sense to add validation for th=
is
filter type there as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914142327.9251=
0-1-sj@kernel.org?part=3D8
