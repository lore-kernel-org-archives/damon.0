Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478459;
	b=kpQoas9rj0rc3NXhBBOLlIhgtGePkHdY5BpBv0tdE2uFQv2mRcjnxe3mk2406hURTem8
	 eNCK8Eglp7XttB+F2dIyK1QMy30LwAqayjkGwmRZmt24WxlSN82sLRKoIFZ2WK9z956D2
	 uMTi696ZVTj0+lmUH0ASP49DAtuY85VhKmOkGgFWNa5vGK9Rt3E4YP30aM8G36H4gS3uW
	 KqZY637hu6PgOZkMHTf3XGVnfFXDzQ9S+A1vJCUaljJh+HIbcV7S2EQWwBHAoOeN/RWVw
	 k7iKN/G8c0GHuysykcWSe4CSddOzFixQLHX2c4u08FpGrMzO+Pmb0uKDplMGjcJBUvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478459;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mZ9kecFWOuK6ShOJ/dSeLTa+mal76Q93Gs9KIOCyi6M=;
	b=xuBIjfQqw+sdlzqi9E6JLjF+hVka/6Cm/T6IKtSwoPetEMZcFWcwvZqvSaCdD47T+tvt
	 EznXNr7m/wYiPWojESRUvroE3UbyYIZamEj3/cB/nimBgj8G7F/NqJtP64KHOAIWjOoi1
	 c3vCHkDMcdUBgDyujHJGBz2aRj90QrXfQB2oqn/Gew6kJwR8N+MdYl8PbO/ckj2lp4bC0
	 C0sqfAWpm99m3cBcyNqdBv51CZ7JXuPV5Bp33YkFi0LegSx4pOLRKepzMUdo9/S3GxcIF
	 p0cosqi/B7OmhQaKAZpwGH/b7ufZO9gJ3CINPVy9O/ugfRc6xu7DyH2I0Nz3U1zVFQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehxKoEhT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C033606A31A
	for <damon@lists.linux.dev>; Sat, 31 Oct 2026 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehxKoEhT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58A11F000C1;
	Sat, 31 Oct 2026 20:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793478459;
	bh=mZ9kecFWOuK6ShOJ/dSeLTa+mal76Q93Gs9KIOCyi6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ehxKoEhT02+jdqk/N1mlsV8ESY0HFFiFYfgxfw85Mix/Guk0vFkIa6mJBbroCyLbx
	 bt5qgOfdDOJlsHbz4caIY8jGIbkn/OLEV2FoVtJatV5uWgJlGG3mhfUOmwIr7ADSiy
	 Wb80Lwyfzk6pHuLRYwYtL2YfKvADtKo7PMWF1+ldXEmZiHPHSxqq8dcf8JyKjVm6Pl
	 sH95fMN6i7qz6A5y7nNo/cGRAGT2cgdITFpwqHTuo4uhUr078AgZVrak0stuTBwzWR
	 /imtVCHfIWew4WgU2zz/ktJtTx3nzlv/7MnOXIkoAMR7s5mS0M50nl2+wIvCXiPKQq
	 FZVgYfrcmJnyw==
Message-ID: <sashiko-outbox-192113@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/6] selftests/damon/damos_apply_interval: remove
 unused variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261031202614.96036-6-sj@kernel.org>
References: <20261031202614.96036-1-sj@kernel.org>
 <20261031202614.96036-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 20:27:38 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> wss_collected and nr_quota_exceeds in damos_apply_interval.py are
> assigned to but never used.  Remove.
>=20
> The issue is found using flake8.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031202614.9603=
6-1-sj@kernel.org?part=3D5

