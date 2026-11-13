Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547378;
	b=ZdK312VZV0I6Q9E8c9v9PFKhVf0kRHKsJAhSfIs4ZbRiK19QYu/Do/T7t6cvHGlx/JrH
	 IKXY0yexyJc8ElivnGwk2Bxnrip/cvDEg+afuLHt+yNEFVXxyIM3C9kqq6yh7xWiTKyzN
	 apHrFXdmA/whR1mlSCgEcMmm3R3vxH7I31GX9WKHCct1kNEeeR0QZasbTTy3E4Njfb9+A
	 BRYsov/p3wLOPcTYMOkNrfj7vMqqhqoYFCGX5AMUwJFG6gtmDLg+nmb4afirdcxPWtkk2
	 ntkVpvI5i9kdn17AjnFYCPNRAK6pEhaJjanGYSG9weNGvd/ZJvLi+l+3Sn9ko6khejQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547378;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L+1cudFYd4xptZT51yyIQUo2/7Kd6/6P7rK/E57o54s=;
	b=OADAwrERagOXqYptL7CHNeH5MLEJ4PfdTcr7nVeJ7gfOklFuMo57sQA4Ylloj3fxrxFW
	 +Z1p6hG5JUe6yWL2UXP4QQvIwUAaQFBy56lIXPrMPiu3ofDxBlBErgWEUBgt1IKUyT159
	 FhzxLDEJkc2xhET0XmGd/zchmfmeFsvqUAmjYamltJA8pssrVhhyMc+LwHu/owAJazsaK
	 JeVDR2c418g3ax+ewAx8DU3/pNLepxpbHq3XMdSAwTwm2y+yZvn8e1KTjUGZVZR02b7Xu
	 vYvfswRGu7nPdEh6KJ6QUCGHAWkb2v/hkZYF/6QgpnttGsdvt8MXoZjQ6AFaioCXxwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELf+V+1A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE48D606A321
	for <damon@lists.linux.dev>; Fri, 13 Nov 2026 05:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELf+V+1A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B651F000C9;
	Fri, 13 Nov 2026 05:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794547378;
	bh=L+1cudFYd4xptZT51yyIQUo2/7Kd6/6P7rK/E57o54s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ELf+V+1AxUa8LsQwxAdW79+koyQCIudwvpqxdMbCbOBaUVK7VDuGFLL+x5HJ/ljAZ
	 eoxmquk9KjJlaVMQv5Iq/dc2zn7z3UdaX8S1C6kcGuoaFrw6ZeoNryeZLV+uMLtZ5d
	 OeD655+00S1RpsI9EP2QJgdT+VmDbO2DpZF3JgocEpix8iaeeXOcquqBjJsiahgNLj
	 Uy1ks+em9p0r1IkOBxJ6suAcWeKjIvCp8nYwoP2E2tKyO9yW4ATC8rSfN4AuJ4iVri
	 4bZLSfVtIH9dy36IEUAe0CtS8v0pWSapuFUw2J6tOPEFraW8rGj2cFWNx7ilMf0ck+
	 hMpqDsQAbjy8w==
Message-ID: <sashiko-outbox-212225@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] mm/damon/ops-common: implement
 DAMON_FILTER_TYPE_ACTIVE operation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261113051711.89274-3-sj@kernel.org>
References: <20261113051711.89274-1-sj@kernel.org>
 <20261113051711.89274-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 05:22:57 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Implement DAMON_FILTER_TYPE_ACTIVE operation.  Use folio_test_active()
> to show if the folio of the given memory is on an active LRU list.  The
> implementation is made on ops-common, so both vaddr and paddr gain the
> support of the filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113051711.8927=
4-1-sj@kernel.org?part=3D2

