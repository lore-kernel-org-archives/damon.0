Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478738;
	b=s5XEVp9XZDsapJ+fK1JdMAam5bP93un2xYSNmxubF39Q1sMajW6dM667+3zStw7eoBA5
	 2X5+LAHuWRZc27U4dDSF9BqH5gpp0Qg3OrU1ZcYDnu3oxw3ZlNXItTlaVmUjjWRk3iD4+
	 eSN011ftXOEaaFREyNhBtAIp0yQD+57ox6Y3AxQomsgEh5QVryuyYdpnlO3FTalvztCb4
	 8VrqnpaFEA2yefO3YUdvh9cY7CcZeK3UrvMpFrFnUxOma1z+7+WG3EOYE1ljkqSW7Yy2I
	 qzBVZHtDD9OseRmsQbPJkQVWvsPyB2xANSGLWlwgM+oyvvUj5aQEDnJGPkIFOj343Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478738;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FMgfvRp5JPcIJgWwSWUQxOJ1IubweUnndfqAWm80QtI=;
	b=lirWvs9RHE8W8Oi5YgCP/zNpwhmCnbAhzKYt/U7vbpLAPNrXiYi7/LDfaGDTXLRd4aiR
	 S2ToBXB+iiPacYeqO0Hr2u659qHuXZSjYYqGoUhB9P8k0kojjxBmH0pN5a+GR+s58+5IX
	 6sVx6EWxkbjVc0/fZY5LuPRsa5ipA4LekVl25JbMftj5lcoAIbcanPGNlpbO1tic+adtr
	 tVlA+GqrxPZRKdh4YYAXhBLdb9P6VQ2irEsRxrVA8bbM3Ne2AQFjzdbYDL44a6jZyGcDt
	 +YylgNs0A4leEtDP104K8A1T8vw1SLXXlO2giBTzsMjV54S+agXYB8L2Y1r4j83ANAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBxsUNea;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B99F606A31A
	for <damon@lists.linux.dev>; Sat, 31 Oct 2026 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBxsUNea
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6091F000C1;
	Sat, 31 Oct 2026 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793478738;
	bh=FMgfvRp5JPcIJgWwSWUQxOJ1IubweUnndfqAWm80QtI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bBxsUNeak4L10FMk1GCwNSStkMoFzMMtIbTeBSg8QzihLqkryIdhlsJoV9ompFNNF
	 JySi+4MtCD9eNXqLlE0eNeeFrTc1i7zbwjmiEyqNuvfEHiaqEmRf4VrsFWJelJMLry
	 bQxErMQ+FFZCAsRBBrnmLUGyb5rPKcaFxudURr82esHUJE+KVVJzE4oeSPBjDYy5Mv
	 k65J3K0KnRR41q6XfA6km+hfbBeSwk+qgdbGrYp8Fetkkgjgia+lst8AUq3VbtKbFC
	 XQRGWQfxkyzoC23I0ByWo++YT9J7qAMqM+S3HgnRkJeIUAl2NLx56M3NPdrc+3VSLD
	 JeWgi5mD/gRxQ==
Message-ID: <sashiko-outbox-192117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/6] mm/damon/sysfs-schemes: drop redundant and racy
 zero target_value check
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261031202614.96036-5-sj@kernel.org>
References: <20261031202614.96036-1-sj@kernel.org>
 <20261031202614.96036-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 20:32:17 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMON sysfs interface disallowed zero target_value because it could
> result in divide-by-zero in damos_quota_store().  Because similar checks
> were duplicated to other DAMON API callers, a patch series that starts
> with commit 610c4438fb66 ("mm/damon/core: error
> damos_commit_quota_goal() for zero target_value") added a same check in
> the core layer central parameters, and dropped redundant checks in
> DAMON_LRU_SORT and DAMON_SAMPLIE_MTIER.  It forgot to drop that in the
> DAMON sysfs interface.
>=20
> Now the zero target_value check in DAMON sysfs interface is only
> redundant.  Further, it has a time-of-check to time-of-use (toctou) race
> with target_value_store().  It can confuse readers to believe [1] the
> division-by-zero can still happen.  Drop the redundant and racy check.
>=20
> [1] https://lore.kernel.org/20261021005234.94107-1-sj@kernel.org
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031202614.9603=
6-1-sj@kernel.org?part=3D4

