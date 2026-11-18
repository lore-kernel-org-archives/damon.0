Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968798;
	b=r3bdeANn5Vf+HZ/F1HvPD0D4gtWKne2rePnRJclu6qpXFfusHmT2zaaWsV/5sm4W/8MM
	 2wmr0GBgsc+b6O6OBMJsdH6DlUzY0TCEFgmU1Z3zO90+n86vHJ0GVuzTC7EdDOYfD9MS/
	 62bdAGwjujYda0prZoSkEDTppCOh4ELoLNrYni8PHqPc0DE7D/519J0XmLJqWjbwOS6FO
	 r6gazSDFQ4hJx023qVYZoAZry3T+BWPLamEmqsBkxv8YlmhtCOOX+4ps3WfYvd6izhu0h
	 plz3rUxFBxQf26t9d92W06rH76NS5uRosnA3TzuZqoLpaSwMONDlfNLegPsk2GNQSeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968798;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zF7WhOmVRynojtBT5o9arFMBsH+7fgfe13/UzTVstgc=;
	b=A0E40gzJjJ7LGtqmXgzA73eKuk2xt5UP1/Uw8clmMXgQ2J5b0qmNdVTOVli7/+cT3Db1
	 ucqx/PXHDn/au8ad46Ow3fmfSncyJ9tt+cLpJ05yEshcdAFv4I6BpjmL5vTxbQbQ2nwiV
	 sgA7skIyGjp6Vipo2ZARhsSuvHzXPIWJvmThWhyfPfSwm3CYs+h/79cEt9Dl114CvIUuU
	 ctADvvSRUAb00gPmRrsFHt+KHke8jhi9Zjs81PgUJGxADwEOTRnRD1XaYd7CP5C2U6Xh3
	 XSTLP92np6vMkx1xVBoJRQs0rnI54l58J/tyqRnaSrtAM2QK0Pca2fxH+cOplZigC+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cs0i++a0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F7C606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cs0i++a0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9311F000C4;
	Wed, 18 Nov 2026 02:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968798;
	bh=zF7WhOmVRynojtBT5o9arFMBsH+7fgfe13/UzTVstgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cs0i++a0Nc2uwP0NrlWsimzUJ2vgZLkToP4QTTTCKghtvs3h6j/onyuSMJIbXSdRe
	 JaiSuell3fzWS5xr58fqqoPNaZXLhWaR6VPvwvSZfP+K9+0VCChzr1KFFgs+xgP66o
	 o1HVmlXzZO7dvlEbMBIqrAZqaNliXijiEUVj23yaJ90UjIHwDY7MEvGPdqJvwuIUef
	 cDc9r5zMIpEisjfkqSM/VicwJ/T5aodZ4MhRN0CDjR9rtmwDdZCRsCR9X9up7vz6Ix
	 bFXAdFCpSi2j8d/QvLROvgwna+OshtUBqLQ8fBdrKx9fb3QFZDW4WdegMcdvOuIJxn
	 DkvTmIXO2Kv8A==
Message-ID: <sashiko-outbox-219943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 17/27] Docs/mm/damon/design: update for
 report_made probe filter type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-18-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-18-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:26:37 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON design document for the newly added data attribute report
> existence type probe filter.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D17

