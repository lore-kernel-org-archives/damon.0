Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794969218;
	b=YXNWucWzp6SGA3Vi6cZt6OgpJtZLSfwQpC2qhihTRsraRW+AlTXpUOplDwj2lIPf24Eq
	 sZFeV+hcCsilCODn1cgzsIvYxqr6xtgkVF7geHdxZJVOzbzrbQv4Zkp2mcIpUeyDZDDp1
	 Skj7yeMm0886LMrOQeOrHvnVT0xCZumyfYODmwnjS7jF12NtjuF4K3gTivslYyaV2a2Mz
	 dXjW+tIsUcznf7XFixhV8BO08OsEnEKjCGnSYE+QeZ7uITGcCho2iR62qpk7c04eLQZI2
	 J8De9PJVasmtmyOw70k+8NvE1hsVWv1MwNoMddzyMudj4sCQuwmageekybqSpRPe2fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969218;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BcjR3KsdFhsRUehL6yYcTMh1U//iUm21Xp2A/gzI1Mc=;
	b=1AhI9EVC4cvPTyb1howd60OyZ+QKB864j1UboY74B9DKjQwb5Z8dPZvUSeKv4p0yP5j8
	 02qbTss3cqpMCj4S+gF7oeI/LQk9jeBassUyhbVaekAmrijq6uy7wMhvRqJu+OPJ2TFse
	 wt3UT5Xb8B+05Iee0kT+vWePUrbSZOE+/iTp8+XRiqKcJZ8/h8n/DmoQfdG5bH8LfPD09
	 lJlTLc2ekzOTf6WBOeOJk5rPlksaVWE+xIPlqqXpQANC7e53hyCn8Z1PA0ZP0D+C6SlkD
	 DKAqQVsiX2oqPtQiNHcytwBmR6FMUS718xQ+GI/vPnODvQeFnU5SQ/Ponwr9T91nUIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CCaukcc/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA6B606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCaukcc/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C1B1F000C5;
	Wed, 18 Nov 2026 02:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794969218;
	bh=BcjR3KsdFhsRUehL6yYcTMh1U//iUm21Xp2A/gzI1Mc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CCaukcc/fpkHTlSm97YmlhsRe5p/Yw+H0GxV+C4O/gzBCrQLP6+BQy6Lxx0dYA8Gf
	 ORHsOcEgwRrqh7GuFextbvfTg++hpY4lVNVDkTP1udjE6XF9LGEz7QwUexoOKub4V/
	 p4SsexNxsNHH/0di+S5Ym55AVdHiraip+IVJIRykZ1AXEY4ERMsMT8BL0FoQxvyMFW
	 YZwoBWDCDhi6L5cKGLxD1GnK7ZNpM/d3fjC99in/9NhHW+WKvrL6JWNTo0TwpAE7TX
	 q07pMFnpO1f1MMk15qBB8ejpE1b3mam8BSK5fVC88U9by0KmbKIJNP/a2M+Djjp17O
	 Tu57VDBt9CnnA==
Message-ID: <sashiko-outbox-219968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 01/27] mm/damon/api: introduce struct
 damon_report
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-2-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:33:34 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Define a struct for data attribute report.  The struct provides public
> fields for the type and the memory address range.  The type field
> represents the type of the report itself.  The address range is for the
> memory of the reporting data.  Data attribute producers can format their
> report using those fields.
>=20
> It also has a private field representing when the report is submitted.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D1

