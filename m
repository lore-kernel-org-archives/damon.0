Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792870679;
	b=U0j5Cx8byrjX2qNVf8e9dZDbFlLdzZXfd63to/pbr4G+vurQKjLMDuDD0/qTlpqpaNEt
	 X4iaxb3eJbTUeFcMhAT7Kp5k5dIVzouPXEtiLg8/5oG+bOYGP81vlUJiMTu53eakTldcW
	 pmR5R/DNOudb1gKl6FR+MeyTtKuE4R83bp+gLb7Qf6Ch7o8wYqbQJs80vLuA55W+E0c0j
	 GPHVdoPVkY52SSgbP2OQ6P92QQD36l+4QVc3j3cxEboN2dh1Y6XFp38uQTVwTVUEkGJvh
	 gLkGKEHTJK0Uy+ChSclqOFfvfckYtqK/BMrMM/B+YXRCxjCige+h94jzVu31yNJjonQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792870679;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+Pzz7RDGbeDVMlHCw90BfOaItY9ndlh0La0QPsFQ+Ug=;
	b=wAQ4VZyrnISeNQOynglQo4k3FHv+9zdBamu3ofUfAKQ+4iBp2BkaalfMd6FDYAvQTM9j
	 F1dqZI3hLSSkW3qiTtQ33dolVuluUo/KcLBWRbG1Moq4VLtr5iYXVsq6fK3ixPZdhGbrY
	 UzN1PeP3gBivGF0H/IxjjA/Uq9eKzy+qYV3zgLlS85cv79+7ymeEqzaTe/lpCYSpZVkHn
	 tu2WQ1Je6z1ZXCuNp8sejmrt9BamJjG1R6iC/fPYUBncbqbiicK0f2RQracNsbUVHflFG
	 UcXge/DfuR0PqZ0r/z9Czlb72p8PNJaTnoJn+bER7AXovv1PJqIITbXL20FqHO/oxUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="C5Lz26h/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4F2606A31A
	for <damon@lists.linux.dev>; Sat, 24 Oct 2026 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5Lz26h/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3451F01825;
	Sat, 24 Oct 2026 19:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792870678;
	bh=+Pzz7RDGbeDVMlHCw90BfOaItY9ndlh0La0QPsFQ+Ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C5Lz26h/zD/vOJVTDHuP1cda68RluoDwXCcYQ4ztUeESSDg1lY2GLston/bqEtSvd
	 IQr949QRWbGvhoHvjSnZi8VWwTFN3jFWc4gLlgFCiafvewkhNxbKCjxrA1O66f/A/x
	 T78/vWXd9FBmvIVwINAUgxzYdtSLiQzBw7GJSZUp+fYB3BA+9rsJHGAncHKVNm326t
	 6z542zFFjmA4xhrrit/yYHhJhb+muuQnF29H05/JAvvhN+s+pWa9t+GTEDzTntTsBF
	 AHPqVBPLjOMSzdobV16/7VFOBv2CakJSJz6JxGDPH+I5uNZw7Zu9XQowYSXd4k/bUb
	 1k9IJFo5y90Fw==
Message-ID: <sashiko-outbox-183857@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] mm/damon/core: move static variable rotation to
 damon_ctx
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261024193351.87130-4-sj@kernel.org>
References: <20261024193351.87130-1-sj@kernel.org>
 <20261024193351.87130-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 19:37:58 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_split_some_reigons() uses a static variable, rotation, to remember
> how many times it was called.  It is again used to determine fair
> selection of regions to split.  Since it is a static variable, it can be
> indeterministic and therefore less fair.
>=20
> The user impact is not critical.  No crash, no leak.  DAMON's
> best-effort and indeterministic monitoring accuracy could be slightly
> more indeterministic when multiple kdamonds are used in parallel.
>=20
> Fix the problem by moving the static variable into the damon_ctx struct.
>=20
> Fixes: 1a582e6e0174 ("mm/damon/core: split a fraction of regions when nr_=
regions exceeds max/2")
> Cc: <stable@vger.kernel.org> # 7.3.x
> Closes: https://sashiko.dev/#/bug/linux-eebfcdde-2881-48ef-8df1-e2019d2a4=
7f2
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024193351.8713=
0-1-sj@kernel.org?part=3D3

