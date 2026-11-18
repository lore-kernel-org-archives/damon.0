Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794969280;
	b=I/bb23WY4DSwIxDdgafpRh7/4n9Ja2CYNpNumyR0PhwLb0qcNd+3g6ROIQkdeopCm8nP
	 wjbp2+8AkLp4VwbGKTyADgpFbTvqb3y5iPsKalIsRBwLanG6hFqUUHV95+op9Txt1sbkC
	 pkzEAZRe3BZO2Vue2I2zP9hp9fClftbJV1V3oQB/YeOL8tVv2l7Vr/weG+lf1yf9N8aKD
	 HhfyKmPWyjZO4p+SDW1qjx8Nb7EF4kxPSBJXGrnd27oKjQeUQK1zbDxUW59iKVhHFLGOM
	 5CTXMRDBU9MBx1v25vlODtXGLs2D/LojvokM7twYoq3dTVglFNvaUIlWyM0EH0eO9WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969280;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ThhLw19oJEXMzACXZhgQD/lQLbACUUX1UbM4rhv+W7Y=;
	b=OT4QH7Tlme7OC2M1SCdU49Z7Lx5carfhqy1fZdXGPcwa3SjGpJU4ncmrbX3+9wYo5vsz
	 CO4CYBoByV49T9Hl0cMApC+68N1gyaXQh7Jh+ldx0RgCvoPhvv2YSoncUta4G7XugijYq
	 pM6JBRRgqz1ANsjqE6eFknaBOfkFgszg3d2Ryo0e66LQIfk8PTwxytSu+Yw4kxxXDrrlw
	 z4labtTPjxmrufyZahGxPU8InhYoL2IlpLWdD8ZTEWQjH4+x+H1xzGGzo7yntefl7hFDw
	 9PXIEpa2eloHPPyYbj1/JMMTgpPbytPbQXAsxIIFFxqHOdJuxxwOQ+7ikkfT4SMprgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kLYQ0u/k";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FD1606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLYQ0u/k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9251F000C4;
	Wed, 18 Nov 2026 02:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794969280;
	bh=ThhLw19oJEXMzACXZhgQD/lQLbACUUX1UbM4rhv+W7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kLYQ0u/k7P1yxBzazd7RPVgb3mUlAcKPd8Cmo2OaTYiBxJeVvl4DY7lcUwLzyMcub
	 G+GxAKaeBXyw4zHuCQSu6TqJtT7ZxgNw31x49/KoyuQPNEVVfVunmhJij7SuMIRit2
	 WAyX99viJBQEYZRrg0Y3l/2Vo+bbXwmMcClzoYHkuepW9ZrtPmYmyP22CIJObZmQC6
	 BJdb14Ez2NI1+aG0K/9ZyBOvrnd3OcmueGJZcAx19zJ4WJaIAZwvc7dyn+sl9/pTb+
	 i/nw0GghRl6iIt1YxitwE2br8jSCV3NS7jFtlxYI0K62juT8haCt6Dtji5Iwxv5PXT
	 UYgf7J26SIh1Q==
Message-ID: <sashiko-outbox-219971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 09/27] Docs/mm/damon/design: update for report
 system
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-10-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:34:39 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON design for the data attribute report system.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D9

