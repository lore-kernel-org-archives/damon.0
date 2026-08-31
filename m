Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BA22EF67A
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200132; cv=none; b=Bvmg14YjmC/1lHmiajUh9zgqMPoicA11YXwJJ81K/iZB92/Q+UmFvMtX9jiTtS3HKRNy5knH7QQmViP49O7+I7e4U7OkE8nhtO7OgKsMmFFuFO4REoaW4KPfmG8pa30on4Wg+Fs3Bat08SIu9PQE4mireaqnQTv+bunnhxdc3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200132; c=relaxed/simple;
	bh=85yvcGxCvLbo3x4ALgakH22E4raFR3To4K7qj+mxw5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WDJRJOiYTe2f0o1WhIDw/6+tBTdmHpj7gAx6p4+bnk5pLjLswM9h/vkvzQpWGrZ7/qlNSLk44Ifgkk/VWbg7oWELbKVXX85uHOJeaAbxQcAkxaC8/IqTtSep3V/ufXy+Svm7ciaUrfVTOX60VhkBiwP7gFrxpwcd9wNWD9wkgsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0jXppqk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0jXppqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895641F000E9;
	Mon, 31 Aug 2026 18:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200130;
	bh=wwjWL8KeZDWYjJKMCiSsuxERMpAQ3Xkna6GZEUn4NCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h0jXppqku9Ieu9/ZB3mVUGA/jwzGCSyUcMX2hoRp8k4iarDeMbfODn+8FamdS03cl
	 RHw/almkhQ/GA+lv8tf7v8ibEsXOPZgpsSFxJuVimNZhcQWA05m9zv/Koh/M7Vld0M
	 4Q1KyV7T6ZKhVeh5snaodExuZrPCT47pnfh4JH7p5SedoKP2R6up7yHVPk164tXRA9
	 hHioTtNAkH9SliHmT9g+JOjuCSpGU8ekAyvdkHCkreVcMimFWE0QuVQYKNA1U4Cb/E
	 nWqSgGFPNuQCTY+X4IqrrnTSJq8EWoLMovIoL4eRQT+vlGEJz1e4POQwDbLK3qnZeL
	 qfogFTbLbVWdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/core-kunit: test
 damon_valid_probe_params()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831150650.84829-3-sj@kernel.org>
References: <20260831150650.84829-1-sj@kernel.org>
 <20260831150650.84829-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:15:30 +0000
Message-Id: <20260831181530.895641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Jason Angelov <jasonangelov@ucla.edu>
>=20
> damon_valid_probe_params() makes damon_commit_ctx() reject probe
> configurations that could overflow a probe_hits counter, a single
> (weight * probe_hits) product, or the sum of those products.
>=20
> Add a kunit test covering each rejection at its boundary:
>=20
> - samples per aggregation interval: U8_MAX is allowed, one more could
>   overflow a probe_hits counter
> - single weight: the largest whose product fits in unsigned int is
>   allowed, one larger is rejected
> - multiple probes: each product fits, but their sum overflows
> - no weight set: the validation is skipped
>=20
> Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150650.8482=
9-1-sj@kernel.org?part=3D2

