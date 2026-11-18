Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968793;
	b=DqKPoXdc20ErJ9J2+LqzW2GL4YZyI2117fU5x1HHVcYdGUhqsquBGilN3l1RhJK6ptMH
	 OajGCUAFFeSTSqO4VmIJrrIWeetN5cQUw6wZI0xUwODbngOqFWiqQyPfc7T/0MznoX3Ge
	 FdJ8lKO9FMjp5YgajnJTMy/mvwVepER35vDMZwvXR2cIx7L5ARnxoK+LCWhQWXShCxNPU
	 DUILJETLcjjqrZKfSMXzJMQMqRB476fDz7MUnFXXpl5OQAaqz1GpqodFwYraX3kMfmJci
	 hMuSELaoMN3JKZQZVatk892+XZQvzvRYtNGy0EmZQErGO/GUlkdd9hl0+V9kMscmcCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968793;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FFallkk4mzcmUUa18dH/gtvX32LskhcZ2yrPxt7tEeU=;
	b=Y00Rwb3u/L2L9kqqMw5TvXlQvg0NU6d9OWs3e3N/ZZtcMDQVg9Rbq5oFO0EQlrrzA7Lp
	 6gK/PbG1LeK7b63L/K7uPx1xEIZusXfSXfJc4/kxxzccORMJReOuWs7FWTfBjrP/743Qg
	 18lev3/HXowpRZAPmkkyUJ2P8JpHO+KwHdVxv6qkWGaY5YFV7MhdpcseA+fi031wONLG1
	 1cFWU7YkXgh+MobJVYWve/yUyIJOU1zikA/+Uuh+bD9A/iNbOZNQPfyjKLKBXlnk5CIWW
	 EY7RbvQV2NxpoFo+jD6nMFmOJesX/K0oyDBbV+OGAd46wBvp2OKbx5+b0NW95/AFsgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbEzIPQe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622B606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbEzIPQe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967681F000C4;
	Wed, 18 Nov 2026 02:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968792;
	bh=FFallkk4mzcmUUa18dH/gtvX32LskhcZ2yrPxt7tEeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KbEzIPQe7TidlFlEiMaK1J+/kk9nk3jvKVc4zBsmG3Jx835Do/qmfQfcZNrYdlaYT
	 oH/JV95A0t0M5nc7sMFpjfkKOcTz6s90htgslBkEsasLrFXRcf9ZiBXyHsFLQycwRS
	 JbcntEBCzWkqQHrxPFsy6Vv/nPnjS92EnV+COEt9QiTEgCodt2YQusp9KwRIY1mLmN
	 M7a5QgUzRcvXSP58yhhRpngsQF7cO2cixqOtiw8MF8kdQ2b6UjhFW1VUuq79fTwwF5
	 mpprH1bJhCKUm0cSP6ApYphVD5pYAyUleHDACgGcWN7dMrw1TFGBLhejjfo1B4Vka5
	 Ys+ThCCXRZ8Kg==
Message-ID: <sashiko-outbox-219942@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 07/27] mm/damon/sysfs: implement report producer
 directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-8-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:26:32 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Implement a sysfs directory for each report producer.  Create and remove
> the directories for reports/producers/nr_producers file writes.  It is a
> placeholder for sysfs files that will be used for controlling each
> report producer.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D7

