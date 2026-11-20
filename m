Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199504;
	b=vnuOxzd2w1Xi0oNoVlCNUYlvHD1iNJSxPg/TOnKTNxXXyZk0N8GdxGSm/Mr/632y8lMq
	 h+06alY6FCQi6tLgd8vQ7zFzkalGU3dIF97tJkMElwfllNzJTNnHD/LxwFMYkxuOP1OkJ
	 MToQEbwtbTiWFhzxmR6sMgZvakmkO+j+h1IfyYvtl/t9AMc7R2FPoPwS0oFpC02TIkX/d
	 yNEXI/oQHPp4X7G8lZXWkM/dd1QjuRacUyPgWKq1+DOQG/6HSfLD/8qoVpoxqlro8IaqV
	 iAae8PJ5AMbhvi7RyDpVGLzQcP9T6mkft6XOM2e4m1KSmu5RJUGgIWbSHYOvrRuHstw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199504;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FhnBwXJta14qA4W+HWY8wkRmIP2pTkoN2jMfvy8KyXQ=;
	b=Pgz5VpKWViy+rNW785y3Q0lQ3IXRiCa4BZy2VHVehSF+AXtQ46rNHNtpP+ngV8HiD0BB
	 yAb7l3Wm9etdNscTF44PjgYj/L0e6E7S7l8PGU9Rtw0vVC2Ok1UlQHh6/ONpVyCb/OC2Q
	 6AEsLICIG7+980m8PuBhP4/puYtGY84F2w0FFrDcHkubD7BoA72xxuAai2RZhiC3Lj4AF
	 r3gy+N3rPTABOWlVjxV1W9Ia8WbFqPW01U/eXlu8CtgXaxTGrR2h1ooDyteUq9dYp6/Gr
	 OTWIbDxP/9filiU1EfCNwd2TUZX8rYs/nRvaJdOozEUOWFAp2injL3mxVk3APMm/DYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHIYEdFI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD155606A32A
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHIYEdFI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73BE1F000C4;
	Fri, 20 Nov 2026 18:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199504;
	bh=FhnBwXJta14qA4W+HWY8wkRmIP2pTkoN2jMfvy8KyXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fHIYEdFIZ2U19exdJRhrsH4dBKrFt+PCsPQvHPWRSfFn6y9TBbj9do0XjNtXzrKyT
	 ztX/P+tWobx/Q9lS03L2/Z/fk28lt0z+dLV+Jkv/izsEaZ+FxP3s0kpp9ZdKUcSJ2r
	 re2gJ0yy1xfNo/Td6nqRCUN9xnpSFUh/fjKTjXDX9QhnaFiemyaI8GBjYa3RK4t6ba
	 /LfInqR8cMhPen04mw6i5LmvbaoOl2KzLawmWFKrO5jgOIr0gyBQuCgNMhoPOrUl+t
	 eAZkDE+MeF28G3zvCFrGbqgBYENLY1WweBzSnT/jI9dWaxLpKBCMitDdndAHQT7GR2
	 0h8miXYuSbM6w==
Message-ID: <sashiko-outbox-225837@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 49/60] mm/vmscan: reclaim private nodes for memcg
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-49-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-49-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:31:43 +0000
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
> Memcg reclaim does not serve one allocation, so it should cover every
> node that permits reclaim. It walks the current node's fallback
> zonelist, which holds no private node, so a private node that permits
> reclaim is never scanned for a cgroup over its limit.
>=20
> After the zonelist, visit the nodes that permit reclaim and that the
> zonelist did not cover, and give them the same refault snapshot and
> congestion reset. The zonelist keeps setting the order, which matters
> because memcg reclaim stops once it has freed enough.
>=20
> Direct reclaim for an allocation still walks only that allocation's
> zonelist. A private allocation's zonelist covers its own node, and
> reclaiming private memory cannot satisfy a common allocation.
>=20
> Without private nodes the zonelist covers every node that permits
> reclaim, so behavior is unchanged.
>=20
> Another way to do this would be to implement a reclaim zonelist that
> only reclaim uses, but this implementation does not carry the static
> per-node size overhead that adding another zonelist does.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D49

