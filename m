Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198886;
	b=wbcyq+h+dLVkToYGZphuyXiW70ibUIV2nxwJb89CJmNyIAw/6dBL4US/nn6ZiUpeWVkE
	 CwhbNsk0a8lyDApV+BBehHYoPSaZo1nCVkplFY/ejUl3suJ3p493eMh37x5VS59swtNWg
	 CuZJUZ095WDHIW3jU9ur/LMHEZrAUguyqU1G20tNLjOVeWwIFEwkUwVMNQ7+0cVh6HMbW
	 CSihWKFR74rZtGmOndvQhPCALZpOd5E12F1SHpzRicuorP81JTX1AerOnil/0LFd8hUJJ
	 ooVNBtAZVlJazY+gt0/WEZ+AHJJfOP9VpNlhJAEeTyWGETAUU0IB0GIu0BjBbKPhj0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198886;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uz0buF6CZJtAg2rpSwI46RfClDt8gpe3QerBEAgXMmY=;
	b=XgCNZ9gO2OiLcBqWvnxmv+DOZptDB+FhNS5Vjq3kihZiU01J2zkWhBJLa7WYFRoG+pDo
	 4RamX70aGNU4h6MF7HkpoSm1k2Xnrj3f463xpY1Ghmfi3LfGBe7IUnni/pFpuSyCpduIx
	 ClgKcZfHrQAfxRaNGnRqcq/rbM0Ch/8hAPcD+vRszvwjCtLaiCqov3n79/PQPuUblnXHx
	 40wzQR7vKdTIinCDENdjY2O9hcHKMNzKLkuRFv++0A0NfpANtgQm+NOH5qTAVTaoIIQOD
	 BjqgJTN1WsEd33rGQ+BNXr/XieLIzWIR+8PNMfkA2aM/6+gxCgJge+Z9dST7XsLEYDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hi+LLNnG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7EC606A8A8
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hi+LLNnG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38161F00A00;
	Fri, 20 Nov 2026 18:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198885;
	bh=uz0buF6CZJtAg2rpSwI46RfClDt8gpe3QerBEAgXMmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hi+LLNnG2SL5IFVgPkN03lv8RF5wnpMmSQWA3Q87TO2CLeaklb/x0k++aT/qOOrqq
	 EdMXdJ0vsW7fqgonksZWb7MMvcwOQZXWirsIMFbqhp97GXlTjAE5ABOPlkU2coYigB
	 f8SC4JCE6gHLSPM4OcvlC3H0260Vk/osPSOWuwGberWK2ZE6Gpz+l5MLYu7khwDlbB
	 8ARZxbfrbDM2/zvP/3bz64/x3rQhpYyrILBEDeWpOW6MwAHN0l1qCypznYaf7RyBpV
	 p7HjeT75qKdY/g8FSdB+TN8/mtNyGZp+IM3H+oiNzngSkUXbSSzvTOpymoj6MGaLSC
	 f4sERiyR0Nihw==
Message-ID: <sashiko-outbox-225809@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 23/60] mm/damon: restrict DAMON-native folio operations
 to common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-23-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-23-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:21:25 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: "Gregory Price (Meta)" <gourry@gourry.net>
>=20
> DAMON acquires folios to age them, check their accesses, and apply LRU
> operations and migration. Treat these as general-purpose MM services
> and restrict them to N_MEMORY_COMMON.
>=20
> Memory outside N_MEMORY_COMMON can still hold ordinary LRU folios, so
> it would pass the checks that keep ZONE_DEVICE memory out of these
> operations.
>=20
> Treat these folios like ZONE_DEVICE memory.
>=20
> DAMON cannot acquire such a folio, so it never ages one and virtual
> address monitoring reports it as accessed, and DAMOS cannot isolate
> one for migration.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D23

