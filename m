Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012349;
	b=0KEn65bhzx/FLkrvCFky6r0LOHZCUobxY+h4+sQ3enuRIEzpDYZ0gkfqVTDN2Ouv0NBE
	 ehB/NvI7N0N4NZnDeuA7uD3Ggsmxwm3yiSus4yilh90ZoC8sg/XHO21OI1adJo5u+lHSi
	 DFKXHkwXingt4oVgOjSK72kA2t17ekBz5/7nU2BIV7zb8wB5udep1/eMNUYSLOkmNZTUR
	 EI54wwlhv3VDXOQ7Zak6jQUQFdhTGb7wDzSDGannxOSOriSC5zw03degQECY8rZI7FTre
	 sRqXRrSXDcjBKWbubJ8IM2Pqpzq/5Fp+ofITe0XzfVYuKMKnRJbdCWIVHUkCrEdq3oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012349;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Xro5bAWcQ7J+wUjAxpsNwmybiIrFkyfAvaD7dSESW/k=;
	b=ADDT6MHYnJDStQAtxNBbbJZmnWWzt+Y72g02ZRox/6PN3hzG2v/6sdq3whbkImAm4cMo
	 kJGl8XDh0gexFiXIXPVASfZqNd3T02gSLJuJxijCb/4spSFsY4o/ryRTXt2migxcrP/Qv
	 V/sj4b9W8Xl49pcIo14ub2FK4y8QEcM1Bv11M+nMYwOwJC9vV2MiaPYbd6a8ivVVbLqV4
	 bXaABGyRR1wo8e1INN3LPn/qLnHgEdKvb/CDTM3IcDFMkhUTkd4Zu0bNmk1BtGthZZajo
	 1gDO6xuhM2LTT2xjO7ScHa8FQfLP7rRaK1jNO3BkoDWox/ovmlYH7NDHDe/CuKeeStg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpfl78Cf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B73606A326
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpfl78Cf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660491F031E4;
	Mon, 26 Oct 2026 10:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012348;
	bh=Xro5bAWcQ7J+wUjAxpsNwmybiIrFkyfAvaD7dSESW/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mpfl78CfEK3Yzz0Rk0owuee84I/e0fjjMuW2FlX8V/Es8Hiv5joE87sYmIbrLwNde
	 Q4e55OKpzJ0PwvttfxzqFEbxPwKliAtj9k+yVJ3WU4wN4zc9Nm5yR8xrdUagq8aZSj
	 DSaP+VBI3qLlMB9glbsUQBPGWtn6kkZq2KJJrapXILvHUdOAVzpmS+nHTfLUDWSccY
	 a1fR+j0Bt0bTU02B0qvAHRisTI5DEHq5IkFhGnsUnoQVplPdbtzjpyvh04kZP7pYul
	 ZnJzIcjuhrI3JRWC67fZiB1bXN1l+aRWP9471fjMo6iJH4Y5svtrawCEDb9xuantSG
	 eB9qFWQt7TFcg==
Message-ID: <sashiko-outbox-185035@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] mm/vmstat: remove unused folio stat helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261026-unused-sym-v1-1-82ca2dceabe1@amd.com>
References: <20261026-unused-sym-v1-0-82ca2dceabe1@amd.com>
 <20261026-unused-sym-v1-1-82ca2dceabe1@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:59:08 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> __zone_stat_add_folio(), __zone_stat_sub_folio(), zone_stat_add_folio(),
> zone_stat_sub_folio(), __node_stat_add_folio() and __node_stat_sub_folio()
> have no callers.  The last zone_stat_sub_folio() user was removed in
> commit f1ee018baee9 ("mm: use __page_cache_release() in folios_put()").
>=20
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-unused-sym=
-v1-0-82ca2dceabe1@amd.com?part=3D1

