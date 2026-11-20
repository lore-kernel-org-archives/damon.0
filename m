Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198811;
	b=fY2R3yIIeU2OYOcHRtk2FIpH3/oVujxGSu/XsP5luyRuwuqyW5FfJ5h4pg4BT5AEGUVq
	 cyUOaKeXnoJs+YFFa73/9WWxYazQWiJ8Tg65EetQiyWMzULwcYzfH1zd3SEMLW2mWp2uh
	 TRuUQY007BlN71dI+mFk2LlndMdQtFL/wm9D4ScHnBjbz2ixSU2v9UT/unRpswbnSqXH0
	 3BR3s5vXlNUoJf0MjQQql30oOHweU/5/HuhJFRl68CMqwiWfIphyY4MMRWFZniJHTd++Z
	 Hg6oIz0FqzflIJtrN084KgsHgiqf3hbWqVPH8k0f0SLYbulAxYYbV99UilcoUpsLBRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198811;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LAg0p3A4q97u3tMt6ZQN56fWB/HHwYiazjpPcX1UdmQ=;
	b=PZp06sUqwteRSPkW+uIBb9sXVF1D1qFcUmQ8qG/oOvAFxQKxLl910z5SJK/2SvjlmNG+
	 IkRRYCITEeNAhGzEZXm9irESpIR9CBCwlRXv3Ve1+I7nBFxwkb5OdDCb/+4O3+34d5PE5
	 72v5Sb0Ubb8GbB8S5+7tsFeDl/nysemdS7YhiUn8+f8gBvjKglwtYHFtpzfrxw1109jQ0
	 AWm+7Vcsrl/SnEwYUIKvT8Q2xBPbYtkc8xzgSzYHIqPpXivw1d5VUqWt8oarDU+aqxBQG
	 OlEIBixOK419OHE0smHPwU3qNa7SwiHZORIBovqYSzrmOY0B3HenVCb9Jg5gv3th1HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NeNSzDTk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2687606B20C
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NeNSzDTk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE681F000D8;
	Fri, 20 Nov 2026 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198811;
	bh=LAg0p3A4q97u3tMt6ZQN56fWB/HHwYiazjpPcX1UdmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NeNSzDTkbtipPKaA4SQ9/2nKi23L8JLIh7zuGrvNqkGkzgFVnYDkRuiP8pgxedsbN
	 BWsNONPW6f548sThYzsRJt24zzjOZqBsquBs0Z+phrMK0YNUkmjv6McW6hMmDxSnAR
	 sF4eNX15L540X93BK9+miPl0+eM7ePlsXBL5pEvgyO6M20cotnG5mpc8UTIgsv7z/S
	 afSXThddr/nS7fm6o6R3HVlRUuC9+ntjyEgO9/TyNWlWKGFIFuqgyoVYfrnPYo+5hh
	 /wwkiI+jCUo1YsbdmeFEtvxLfVaGwjnE5pCbcL/tpYruiEoYr2TFKmwhqSwzwFqsHP
	 ZX84w92y4Q+EA==
Message-ID: <sashiko-outbox-225799@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/60] mm: publish and clear node memory states via
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-2-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-2-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:20:11 +0000
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
> N_MEMORY is set in free_area_init() and online_pages(), and cleared in
> offline_pages().
>=20
> Centralize those updates in node_set/clear_memory_state(), so states
> that subdivide N_MEMORY can be published together with it.
>=20
> Behavior is unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D2

