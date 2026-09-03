Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096AC30568E
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788398105; cv=none; b=axTnjeIDxAInoIRbPnczv9EYAmX8FakKBzSqkpEIkpe69T/gWvFdK43AMdU0j/irfD20GVGecoYO/cZckgnbsLMfaF5lCCkT+P21DeFl7VkQYr4dGmOMBVmXGVhse+9r9gSNlsiymoeyGix0IXq8LXoViw6+U+7q3HZn2hyJw8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788398105; c=relaxed/simple;
	bh=HKH0Dc57OkdCemYC+02zMw0MQtCrjVajJYEa+2UA3+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RGU4Tl+P5grhsRZIkdUcHtNrNOwhFNdI2/Z47lfJSVjlGx4OVtoVfSMvbwatVKAzNq+S+vIQo5EXw/WTenqg0ozdLFC7TvZ9j/d5g9GSBH1TLEs2N2IaVONgMvuk3rQpT5IRs16HvEYu85NSE2Eu4EcPWVZK6+DeiX7kQrYuWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8y55RMa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8y55RMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E78E1F000E9;
	Thu,  3 Sep 2026 01:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788398103;
	bh=p1P/0dqwDqHBQwPrfEU7NFTVqf7uRYH9CgP6yZw+EwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T8y55RMaaAUIJCLWLXSXr/uIchE4bfUu7k+8BbYy0FcswLABGiQ4Rdg/CciFtfX7T
	 scTxC4IRdAEuKZHtl7BzLv7IfRPIOs6+zMaWGz9apwm2+ctUojaI6H59PzP2gIcLsY
	 SLsD+mwZE+93b1Tbccco+PwueKt6k00XXh8NzhFdrmJD1iTAZsq+IOEi5TmncUqPgh
	 kucAlfOoVJpFbDjVIVKxFlDGkMW/2WAfhJRBw/RNzjfZAdug75MKJVSOFIjispPHql
	 aqdNorM2SlT48VLvlFxdfMur4eUOqvyHrrUXBw/83BxQSrSmlvlC1NIH1slImXLMTS
	 FjTDjf/JZRIiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] Revert "mm/damon/lru_sort: error out for >10000
 active_mem_bp"
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260903010722.94244-3-sj@kernel.org>
References: <20260903010722.94244-1-sj@kernel.org>
 <20260903010722.94244-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 01:15:03 +0000
Message-Id: <20260903011503.7E78E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> This reverts commit 06befa61c427e74319781e6f35a364cfc32dbae8.
>=20
> The commit was made to avoid zero damos quota goal target value, because
> it can trigger division-by-zero.  Now the core layer handles the corner
> case.  It returns an error for any attempt setting the aero
> target_value.  The corner case handling in DAMON_LRU_SORT is hence no
> more needed.  Remove it.
>=20
> Note that this slightly changes the user behavior.  It still disallows
> active_mem_bp of 10,002.  But now it allows other >10,000 active_mem_bp
> values. Setting >10,000 active_mem_bp makes not much sense.  But it
> doesn't cause critical problems such as memory leak or crash, either.
> Arguably that doesn't deserve additional code complexity.  Just allow
> it.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903010722.9424=
4-1-sj@kernel.org?part=3D2

