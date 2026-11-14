Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640602;
	b=eUCpEegq6tPdbnupOPzAaBdRI3FhSGDLzRX42rJxQRDQEISNUl+z6FlMqEikYxl4skIN
	 70WYUGem8wiDJzow4OKVcUmoe/ggf9hl8DVWM6AtAoQRD/WPP1iexHN10EKOPYN0PpjVu
	 leQ4e/yHdoMrQi60DqRghM+/OyQ6y4gYpiHDwa2wnBCLbzNdIbrP08erGLS3tbvsXwtLj
	 PiywTUqF6vdrosHAXK/foiok9LGuWsB8N6qtGsEPZqIBhT3QZtAS7iVwwlUxwtjt25j9B
	 Dt11QewhgU9vf8hzWLtmbmCxpruwud2o0pg694xtLTR9bsyMNibMTVUzG752BZEIStQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640602;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bMo5GMV3ldMAcC2TdQvt1FHglmjOCnkleFb1tYssDus=;
	b=F4zWvy9mmoissm2oOG2DVix4UhIyEmVZhEP7PAHUabUwVggTi3QN4bzUgGXz1CHj6+D4
	 LyRaosQIvZUcZPesnKIooHwZeD6dT3XU/oCBoWTNCMAFl5FjUygtqbO2gH/N/mTKgrIGz
	 dcH1LURwLT4Kgc6hulADtULcezK2XWABVUTrCbY98pdl5IY9wU6NM9wHlKz+8l4GXYRng
	 G4Y7108y/CarUjsJWgKjWpTaXPvbcaASq70WDbIclDa8kpHAJsN+aBtSKLgAdvGwy0iOD
	 HN0x7jG5BCmdTPrjDrwCoe7SMK5qRAWxldHlJF5IKgZsqm8JHuc1KscocSp5B1fx7rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrnE5hAQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D585D606A32E;
	Sat, 14 Nov 2026 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrnE5hAQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E4A1F000C4;
	Sat, 14 Nov 2026 07:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640602;
	bh=bMo5GMV3ldMAcC2TdQvt1FHglmjOCnkleFb1tYssDus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WrnE5hAQLAeb8BLnN7f8hWrnXi086Vp4BdsQ2yvBY+KrfezrIhuC3MEpevjKJ/z32
	 C5X4oJ40l+EDRYNXeBb918XU/AJB4pM02xTVr55Vpx0IN9a0qVnzy0+hj8IhY0PTIg
	 9LWvLhUIR+UrvM24gsXbT/gv3uPLg+10rEiCVka+Jpogar9j/5BjqtxYhlcrd1O31i
	 0T75/o0J/oGglWk/0cWYammLjYp6Qc81qPh9WwzRy3cVsattozyXzqUnDcWF5RO/aX
	 ot38XqxuHKvAiCfwWdnWxHHv4dO0O5R5yFXWeCW0YOsd22oHElM4LvwwY6l0ZULhVX
	 PyaoJr37p0oxA==
Message-ID: <sashiko-outbox-214247@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/22] mm/page_alloc: build zonelists from common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-5-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-5-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:16:41 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Zonelists decide which nodes an allocation can reach.
>=20
> The fallback lists hold every node in N_MEMORY, and a node's
> __GFP_THISNODE list holds its own zones whatever the node's state.
>=20
> Ordinary allocations should reach only common (general purpose) memory.
>=20
> Build the fallback zonelists from N_MEMORY_COMMON, and __GFP_THISNODE
> zonelists only for a common node.
>=20
> The build_local_zonelist() refactor lets use reuse the code to build
> a local-only zonelist for nodes outside the N_MEMORY_COMMON set later.
>=20
> Every node with memory is common, and a memoryless node has no zones to
> list, so the zonelists are unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D4

