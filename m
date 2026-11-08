Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167914;
	b=IK6gdyZ2DBNHc7ifSAe425b4CCLZ+3o030tZIJ779jX99aNxmLLgssQ9N/me9iznLp4l
	 RItg1KZjMG1ppqKbdmKsvem0Lfk4l0JMv/QLdFcH2VSDZohJm3ZR6SRRD4Hdzw+AEnu7P
	 54dmra8XHoZ3WDzH3TgNtNxjsK62ArDnAx7vCy7Gx44n1AZXNVNC5D0iT56N1t7l0EBiJ
	 /FtVOS2yNoRKi25ojEgdMBfZTO21GuPkczAkCGFL7q2TEhCY8OmaDcA3KgWKyizTSCxuL
	 IxY3RdMra1TknpodINgCS2RGgi4855Qijqr6eYfsvw1765fFXEeXAEcOOsn0+vc93sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167914;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V53rlsVgy5PvZV8iHNpM01AjNY+VwscLtv0DUGrod14=;
	b=CUMv23/s/NID6/zFWyqdhrqo6CJ+Vh7DiJlBgHoHSHoUChMZg+7YyVLS/XDUcN1oxD9q
	 PwMhApAxWNb7qt9a70lWw337QP2WaI6WDHZf4UzWnd1Y6yvwvT5izHBHqKrg+sKwVC0tV
	 gSzSg0tEiUsi9qsEv70JT87z1xrWUD8vTi3ECfyM0cUBZGtRl/L5L2fNKRa7MLhYjee+6
	 sf51Lui5Gz01UcOjy3hcr1XLOj66N4HjhO96iwL7J3GKmnbxt/TIo52Oa61PEZSG7Z9J6
	 ALliZy8iDRanma4A4AVeLvjae4CyFVE+rNzKbDjehufe1f2esVh5+9+zSD5HDa4/Wag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OVLxm/KH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E89606A31C
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVLxm/KH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D571F0089F;
	Sun,  8 Nov 2026 19:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794167914;
	bh=V53rlsVgy5PvZV8iHNpM01AjNY+VwscLtv0DUGrod14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OVLxm/KHP5XdlfvP6M00K9PaaJzInxlpLLKpVJ1GcDQOe+TXsl8tpoBoMdP10/MZo
	 T1TzDZqMj7r3bEV/jbFpIv1DiTX5rgHDSLL/TWQ/LEJVG3NKgbxVEgggxii6OYQbzj
	 zchqHyMddJ5esRmIg8VU9hS8ktskAqnfuo5o3z8BpovByt8B0EzYzSXLTuoUNw43Wq
	 hLE4DuDNqZj9C/LUeo1yQ/Gp6MdU0pnAm4e1N4Gf6qZIS0eb+u3949z4ABqkoTnqKk
	 XVvzGJp+UkVATNcoZfo/6MezrGK2IiUG8auB2cjKYPUhhr45IIOYP95LV2cl+LsRTW
	 2PlFp9xNAdhUQ==
Message-ID: <sashiko-outbox-203998@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y 2/5] mm/damon/paddr: respect folio end for DAMOS
 actions except STAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261108195145.115792-3-sj@kernel.org>
References: <20261108195145.115792-1-sj@kernel.org>
 <20261108195145.115792-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:58:33 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> A few functions for applying DAMOS actions including pageout, lru_[de]prio
> and migrate_{hot,cold} in DAMON physical address space operation set
> (paddr) collect folios of the given region by getting the folios of
> region-internal addresses.  Then, those functions apply the action to the
> collected folios at once.  The collection starts from the region start
> address and advances the address by the size of the folio of the address
> until it goes out of the region.  If the start address is in the middle of
> a large folio, and if the next folios are small, some of the next folios
> could be skipped.  Fix the issue by advancing the address to exactly the
> start address of the next folio.
>=20
> The user impact is that DAMOS action is applied to less than expected
> amount of memory.  Given the best effort nature of DAMON, it is no big
> problem, but it is clearly a bug that is better to be fixed.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> Link: https://lore.kernel.org/20260901131850.98037-4-sj@kernel.org
> Link: https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org [1]
> Fixes: 3a06696305e7 ("mm/damon/ops: have damon_get_folio return folio eve=
n for tail pages")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108195145.1157=
92-1-sj@kernel.org?part=3D2

