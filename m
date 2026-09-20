Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58993C871D
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789872033; cv=none; b=LaEPahm3d6AHbooF6ks/7wMFDbgTfXD8NWX7XEe3fauyZkgLgqEJteMEmN8PEL9OOo2vcvMHHluukZFeQpbSLYWVbCXsRD9dUhli0FoyTky9OVS92cB84ZXRA5ECfOGlPzLN8fmxevktnBhWG4WzmSYx9KV3yD2CGzSHRj9LCo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789872033; c=relaxed/simple;
	bh=5AK5WmQAFcpaPsphEk8zvWYM+kvisghPvBCrWSZ39wU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bo9TRHy0wI9ahuUFJRDTfjz5+phQYziLtDH9s+pvwM6qAjK9dBzecTmoBvD+Obwaa/y6YAK68M35iUqBT11SfW04bI/klrCd932QN2zjTX7m2N6zbiTzyHD5rv367jj6fdYne78qPtCwUlUHYO/hc+tpK2FTMNWXnMthdj/p5pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRm377jl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRm377jl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3FB1F000FF;
	Sun, 20 Sep 2026 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789872029;
	bh=GEyRKO+/Ynn2kLGj4nUSDGPUr4l8Wxa4gDHOvE+UC0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XRm377jlVIlt9EFMim47Jq0nZIA8tR4uRhnCrTs5Ld7QQ12Ui5LGulFJK91/Oi2cM
	 N99Qth2LqsPTFaTFTNm9f7RZYy8251tHQ8nvu6CiQvrH/JpbCgPHpt6zRzbVoehLHK
	 E7VqAwLwEXXA8safwP7rRmCI0SBILRZK/MuG8GVztcyjdp636tiRaeeA3FWcuNbe3G
	 IVogH5v8PXOZT9C+bwsfnPtCW1PXKpB5Sn7FAAWjqf7NVI4JNxvu/+zLGE7OkXKLt0
	 90jDK/KkKccIjx6nk8k1RR841BLVBPpwc/Rl5MTUrrb/VQ6lBD5mQqfsPv4xuj/4Ck
	 yN5l4ScdQyVpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] mm/damon/core: prevent size quota overflow in
 the temporal goal tuner
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260920023111.2466265-2-donggeunyoo.kernel@gmail.com>
References: <20260920023111.2466265-1-donggeunyoo.kernel@gmail.com>
 <20260920023111.2466265-2-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 02:40:24 +0000
Message-Id: <20260920024029.BB3FB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_goal_tune_esz_bp_temporal() converts the scheme's size quota into
> basis points with "quota->esz_bp =3D quota->sz * 10000", both unsigned lo=
ng,
> and damos_set_effective_quota() divides the result back by 10000.
> quotas/bytes is unbounded; bytes_store() hands it to kstrtoul() as is.
>=20
> On 32-bit the product wraps for any size quota above ULONG_MAX / 10000,
> that is 429496 bytes.  Documentation/admin-guide/mm/damon/usage.rst
> instructs "echo $((1024*1024*1024)) > quotas/bytes", and 1 GiB * 10000 is
> 2500 * 2^32, so that documented value wraps to exactly zero; 256 MiB and
> every multiple of it do the same.  quota->esz then becomes zero while the
> goal is not achieved, the trailing "if (quota->sz && quota->sz < esz)" can
> only lower esz further, and damos_quota_is_full() is true on the first te=
st
> of every charge window, so the scheme applies nothing and the goal is nev=
er
> approached.  Other sizes are wrong without being zero: 500000 yields 7050=
3.
>=20
> [ ... ]
> a dead scheme.
>=20
> Fixes: af738a6a00c1 ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEM=
PORAL")
> Cc: <stable@vger.kernel.org> # 7.1.x
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920023111.2466=
265-1-donggeunyoo.kernel@gmail.com?part=3D1

