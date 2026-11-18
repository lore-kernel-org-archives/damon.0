Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968965;
	b=ilnAE0xcql4saBDmRs9cPo0ZLoJvBJW0l3VDhqzhH/2+CfXUfFoWnEJTQCMZ/MfXwLvc
	 lDZn0F5oUCNS8sDCyR0vgT97zGKULBm6siqon6P+7P7KYuNNMV5KGl79BbGITn2RPkcD9
	 OiEoO5MH6aVGTJtAPW23Jk4kqqPR1sCcseKQtZefslE0kMeShfnamKM6beabrI7MR4YKQ
	 1YHDNNXfKeF9n4J6qt0ODWiPIxaWvJ6mPMLdtcRC8f4ok5tmSs670vd8GcZMXmm1Z4IR3
	 BYPsip2oF5yQw1qv/1z7OCyPELJ+HcbgG2vD7dt5KBaSs3+gfIt83iBsR7oPMFx8siw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nyaKeAMfysfn8CTGxI2PV8iIdYMF5PQkp5ehyhWEdak=;
	b=VHGS+QU2xJHxNdYtf8Qr5HnpCnwux3PZyvsS5/hnAIgUodniVwR0bWMlJu45FL/LoUxZ
	 qp6LaFRVjHkwCX2sgAqzKoofiOeg/9UHHVC+M1T7kkVMwAIeUJVH51zFlVC6AOlRWfOwn
	 ZFAcYl+kxsTJgt1Cb/IEUMAi2GR//Ul3e0rOpIrBfe2YDd3dsMb4xFsquxm2F5AP9i1uj
	 UYONr5CJvf0s6fVHp74hAWMB/SwlvPR1kXurrP8zj8cNO6S+OWizkFGMNFL6SaflTLuN8
	 x97BSSKRroFEQbTdeOP+vOAK2ROnV0ZFMNe71YuBJGVOOuuB6IDYvY4mAaoqyxySFIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLXeXjEI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79966606A325
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLXeXjEI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5411F000C4;
	Wed, 18 Nov 2026 02:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968965;
	bh=nyaKeAMfysfn8CTGxI2PV8iIdYMF5PQkp5ehyhWEdak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YLXeXjEIyOiyrbBQTUC1j9u8bu2JW5xQQ3yMRom2LWBsM/NGa9hwUPlKm99+74c4K
	 uIzYwtVzmTmsgUzULo/FwgCwBYfDdlXuL1lcD8X0INk+zoE4lcKrFMu8RAHFsSbSf5
	 5ut9SXWyhWarCXoyeKosjLVp/PH7ifiZCUjbSoRynUsppoQyiwSeZkf8tBybOZaTxU
	 ojBWvJV3N2XHcOsW76H8CtzD+/blTw6GcjnlIAQKh6d/YpEyAk34sCCDIFPokc1T1j
	 fUB2KSi7UudL9wCS0bEjlQNMedaRSukCd5/8DA/rWRkRSCIeJEXOMNoHexMYshH2EI
	 KAZ07eUdVO+AA==
Message-ID: <sashiko-outbox-219957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 20/27] mm/damon/api: introduce user_report report
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-21-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-21-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:29:24 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Users could know some data attribute information and willing to provide
> that to DAMON.  Introduce a new damon_report_type,
> DAMON_REPORT_TYPE_USER_REPORT, for such user-provided reports.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D20

