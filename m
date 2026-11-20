Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199147;
	b=dNPDGATI6Y01hmq3U5hrUqQ/vmoHE+1L2AaXHENLArEXPlcHnMD9FngmfxDRcf6gtua7
	 n4Vfq0MbW7Kuk61+bTfnRNLyWfHjtUqemy8y25hwN4BkE5sbTOPaIgC3iuO7QXjuqx7xR
	 8NV7UewXmByiiHvtl+BSubjy43q/jksgdgReKgFDGWbAZ3rEb/Ii+Nqa9b+AyTUYrvKMQ
	 lNYcC2tr61jXAZOSc7M2vGVYj9fe9Uw1w3So6YBRtIABHf/CZGlwU/vyT/ah68iqxo8yz
	 1HbSWgizw9syZQ0ZbUZE1SBft/69JSpQPURfoi+B60IETC10b6dLSWE1Q4c5Pb0i2mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199147;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1Y9yN5CtIku6tKzMxiXVgO38iM/d0C29ORixlvAHXmI=;
	b=wh9a8yHl8m78h6p3Sr6SzSwv2X6l/wErH07BOLN31MjOlOx6U8p2ilXScmxHINdud1bl
	 uBx2YzJgpsOX16VKKRRNKJ4xBWzX5C/fL3azsK0a5jFyiCurVTcPGU+B3BMaazkwAq9yt
	 HDaRebB/EK5ZsqRa4IhLm21oWH33lTBb44Z0Ddw8smhyhliWKshBAKcPqpRcHHxXEygqy
	 xNGYN8/OIBObqEz+v35pSt266CG759p+fkV9kutT+FkPx+YVYWV4h0IafgMGKyKYUtWy1
	 cp16lKrFlnOnof+vUMtU62F9j1knkrrUUc6awLvD1nw18eaze6dU+XkvTo3FFCU4Orw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UP4gtdXX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8A606A325
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UP4gtdXX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8311F000C0;
	Fri, 20 Nov 2026 18:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199146;
	bh=1Y9yN5CtIku6tKzMxiXVgO38iM/d0C29ORixlvAHXmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UP4gtdXXh0bZDyRWpMfPQZW8H46KEhrEV5PhUjRzDNxL3gZ4BkExoUiuJzOZgCi3S
	 p0rJ7ixnlqbourRNQpMF/IY/hmMFf2mfTTahlcJBFAGsdGURxP359oAQ7VKXPBxIgs
	 FciGvp9dR3Ics4Rg3zJDOXbs3k4Brl7DufZMixXOKudq4flht3Cm50Nf5DLxd6SyYO
	 y4PyooVGQ10PVH5WFoPeWgqwkl23cxaJiCNKU4to+OxPll9roFnFfRzByuVaox4oQC
	 wv05nx0uuWrv7O8qrUPFGZgeJfSFBoessF4m8O7900xGlP5b3hgfDiuS03qJmU1M60
	 7WsYUdpZModVA==
Message-ID: <sashiko-outbox-225823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 25/60] mm/mempolicy: queue only common memory for
 mbind() and migrate_pages()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-25-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-25-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:25:45 +0000
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
> mbind(MPOL_MF_MOVE) and migrate_pages() queue folios from a task's
> mappings for migration.
>=20
> Queue only folios on common memory: convert the ZONE_DEVICE checks to
> folio_is_common_memory(). As with ZONE_DEVICE folios, the skipped folios
> do not count as failures, so MPOL_MF_STRICT does not report them.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D25

