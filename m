Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640586;
	b=XUjHEBIa33prZMN3WQFj/rtlBVfx5xf/3t8i09rh1QV59NTFaFkRTZlvPbz0YZ/Rdi3u
	 Qz4BYTFa+3OV31rSJ2vzYDgZy4h3q4uQcKU4pdD4oCIoLKVZc82hOJ/YN82HjaBHI2TEM
	 xmYHTMkrDlUXdEamhJYSqlDtBXkZtp35B4OIYZK477u/+uqZJIuJsejcH1SmDNOryN36/
	 FFCzmng7ujDy4DT6G100Axsax5yiZVBhfJBNeu+4zoVsoL3gvAfsBYpiQYp6ubIPROV/f
	 CEhrJPeWlqDHDg+l9yozP9hwP9Kp7BS9xjmoLVqaQQrW27lI98x6dsCeIIMPNij6uBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640586;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hF6MnC2Bdo6u/TO9Q5fSduy23TG0fG58X5kT58mkY1s=;
	b=NbxVRemVZpPlU3OR2XSdoFgf3hnW3+kwKzniqHZqiBdr/452ccxKRDb/D7l9ypcPcsjm
	 alyeGrnGhJrwXWSfAavDTN7g+okFmqoPP4Z6paaTaWxH0V1mU3Q6LFPS4lb2/W/1L17CC
	 Do06Vi4l2/pOQRfvvPV3itP7dtMBbcAI15nYqgZu+mtd2HwqYTMm7KcuTNz32seKA+stH
	 kXcEwweXB2LUYUokAZZ7Lh28ZF9+L5UEnWPHzUvODELSuQ9puszrUzTGoA5FnDxRBS7fY
	 RWpZpVq47DkyBjKXz2zU6dbGsAEHlP/UA8/EgGqSH8GkNKECgN4Qpcsh6FW6diG5NqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SzRQuvID;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FAA606A327;
	Sat, 14 Nov 2026 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SzRQuvID
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EA01F000C4;
	Sat, 14 Nov 2026 07:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640586;
	bh=hF6MnC2Bdo6u/TO9Q5fSduy23TG0fG58X5kT58mkY1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SzRQuvIDMf4viW751w0KwakvCxPzz0EYs0WujJ4oXu9qDEGapopzoVASFV5nh2t8g
	 jE9hA6Igx/EBCVTiAsRMl9SvYe0O9L7/uGbLLmI6PCWtsURw4kleU3uK+PfeilPfCv
	 VQCISUF64OtuPll2Hco/t2gJOjImPrSA/2MHmedBW2fQObzpnU4oE9tofiU2AuWz1C
	 NbihniP08nBvIMk7GZ41aaCwAjdGxoxZZKzF+kQIQ3HPvUPKsVrnjZosm+h0kpXVa1
	 7+gVKnSqFTZWl84CZtVKuTMuCVxBjTOMZGe9aiIGFHtsKImR04nkvW4L/IrATqpYR/
	 dG2W1d5WxBULw==
Message-ID: <sashiko-outbox-214246@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/22] mm/mempolicy: don't NUMA-hint folios outside
 common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-12-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-12-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:16:26 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> The NUMA balancing scanner installs PROT_NONE only on folios that
> balancing may migrate.
>=20
> folio_can_map_prot_numa() already skips ZONE_DEVICE folios. Skip folios
> outside the common memory pool (N_MEMORY_COMMON) as well. Do not inject
> hint faults on those folios or migrate them.
>=20
> Convert the zone_device check to a common memory check (which includes
> the zone device check explicitly).
>=20
> All memory is common at this point, so behavior is unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D11

