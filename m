Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793161915;
	b=MWyUITB3IhETszsiBdqlyT7SCt9173zsOEibNNBRsKQT0E2uYeNy4IvMSZ7Y+/sb9gQu
	 eKJkQMlgz6Bg2aorTHGctwRyL1ClSYXoHKbEqm3khBFnyhwM0dPsHj0JiPmqWuZtijEAG
	 0u3H3Vib4WbxOQn0x5n/TgtEb6E1vfhZKA9Dxm42MgYNDNz7j7YCBsTgCqf8JJYTGto4M
	 ZkBARFyAtI8RLa0oyhAZBckq6Y7hAH3dXdC0PkJPh6oHYpgz2NjfK6p9cvwIC+agV5hEB
	 9Zhqd1pTtRpMss5pk63SLQpw5njbqzUrkqDb9G+ITsxa3ePpFCmcYqSIx4cIvN1im/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793161915;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XCD2hM+/GQLkGi8pQaZJTcxueXQp0xR6Gs7+n6dSBHw=;
	b=10L5VYm6XFm0X0GwQJLSq6gAyThpZsHLkue5aykhVTSHfdlN+F9M8n9nFwtyJcOog4kP
	 pdavpnRIBw4FDxIFbj4bXnDrQ2AzLJ9bjW/xJhGYhiW1en6VzxtutrWAomNCVkzUJ0Th9
	 3gNDmBs5Z2BbZBDtcsodZYRNF831QsvYPaFXPRHOtK2VO9QZ7LJ4ZUs4NfN+T5frXcg0q
	 3UeuwWg/9zNdHZ5cSLqYYE6xR8KZd8lCsSem6faxvhDifbMdHPGS3+jIQQX/Bm1ApnidS
	 0M0MrCRWDkudMZnv4FsVKL42focFI6AQ4Yfcb75y5U4r4b6yr56KnRUHxUf1Xb6gLIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mJsVLuX/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D490A606A31A
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 04:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJsVLuX/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8BB1F01825;
	Wed, 28 Oct 2026 04:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793161914;
	bh=XCD2hM+/GQLkGi8pQaZJTcxueXQp0xR6Gs7+n6dSBHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mJsVLuX/Vn6LCW6KI8jGnuT0fvqlrtKwB1bP7lGbTZ6MXbU/4iuIlqTgBP62gRh3m
	 u+DP0TGufk6x/eJYosHh+zGBubfEYISFcfwb2bzfZU+HANdr9DnFEICmBLoPY0pQKy
	 4d2Ec786IR1TaTYaWzeZwsS0O78fpV2QxV4nxZ4D+x76TwK2im8I1ehU8Iz5eH+Y7q
	 12HQubBjehKNqJynXiZeBg6CBizR0P0xhxNWbN0v7f4deuB1yo0x7sTDhWwUPKf52P
	 6vvDEEtZ+zuYqCg+2ybyJpr2jtbJdSP4NpjDGvPpvWuave4WgR3w7i4NhMf8jtUJcG
	 o8zQTVpsUSCWg==
Message-ID: <sashiko-outbox-187487@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.12.y 2/2] mm/damon/sysfs: put target pids for
 apply_inputs() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261028042617.165657-3-sj@kernel.org>
References: <20261028042617.165657-1-sj@kernel.org>
 <20261028042617.165657-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 04:31:53 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_sysfs_build_ctx() invokes damon_sysfs_apply_inputs() for setting
> damon_ctx object with user inputs.  If it is configured for virtual
> address spaces monitoring, the setup also increases reference counts of
> monitoring target pids.  If the setup is failed, damon_sysfs_build_ctx()
> deallocates the damon_ctx object without decreasing the reference counts
> of the pids.  If the failure happened after increasing reference counts
> of pids, the pids can be leaked.
>=20
> Fix the leaks by decreasing the pid reference counts before deallocating
> the damon_ctx object.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260730040740.140836-1-sj@kernel.org
>=20
> Fixes: 74bd8b7d2f8e ("mm/damon/sysfs: move targets setup code to a separa=
ted function")
> Cc: <stable@vger.kernel.org> # 5.19.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028042617.1656=
57-1-sj@kernel.org?part=3D2

