Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640690;
	b=CBFCGD9RoLt7hoW7WKnrh9iN+EKyoEIYSUpI4WnGKlsBupvbjD/VZAcAAAnLfkDGLwKR
	 X8GkGMsSipRcEqtvdSLRwSwxFiPMoP4Rht3AjG0wDvk3TMv4A9mNgR26Zvgk83/Hap/Gz
	 zrdhbYhPhWjy+J9E7/rrgDkttGvWr0kHhQBfzRrZrTySGQr2dGYztmCOZzoMAT4520r79
	 27tjeyFNPaoMF1XC6uNfOVaqUGP2PZOtUKB+2GJNaZKhn5NcRwjOICykIDHNhprmub4o7
	 aZE+G4G9Oda6Vy+hxMtwYQJQez5JY44GX4buQXXZOfoe3JEmGdGnGqEbulAzNQ70WCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640690;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F8nhrFRMqh9ZYVAVmCfhQjfTkBxbQgbJhNI+rxcgEsE=;
	b=s9EuP0JYRQUbjyYNj1+BDcsQzZnbXVv2x3Mg0jmUwuNuKSekIyChJt6mD4l/F5X/PwYP
	 AuzoP+NY25xWNcAJzWMsKfWzzkwGyR2QY9v/5hVtxHmg7KYKC/d33JtyMYnJ9W9t2RIkw
	 3GWr3oNMiOUzWF9VvKov+jgTGJk89e/3LQLOLQ9gyaUvvnvMMTKIoZJNHx1ZbC0sIPoXW
	 Og3i6bZcoo67+Ap8RVwFdRslCfwkaIorY0xtF9YCOaCEhqh22W4fDuptdCL1JaACvwq3u
	 /sFgxMQFl+qf2hBvc1dCP6b9jvnTpy8rAr+49BTJ1mbck/E2j4aj8jNnrPnNzjASd1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8aYMYMF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B0606A323;
	Sat, 14 Nov 2026 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8aYMYMF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711411F000C5;
	Sat, 14 Nov 2026 07:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640689;
	bh=F8nhrFRMqh9ZYVAVmCfhQjfTkBxbQgbJhNI+rxcgEsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P8aYMYMF1wuuppIs8VZmPrPebt8Nn+P1ENoOcNv7zVCcKU3XoAj3162QXrAaqvrz7
	 LK8PsqI4bPN3VvcAmAlKPLkxBi2gkn5LEiQAcpXg8Ov/OiwdKXhGXYEMmwZqOxSNPA
	 eAnk9arxy2fU8PH9lWLPYGcmmYj1t/NW1dV7czripdWT0xuzfWLTCqc8UoZgOtUwAX
	 rravXkns+MuF4bPVvEucXSP5+vxT8WE3t6M7nml6zKtgt5ff4yBWwtoyR3j5VM9dix
	 YGneLFCNgQru5/dH+BO2/GzVlNLkalrW/WtkWtm/gvIeZJzRzOcEAaSwrzMSium+Hs
	 zg2KczKLcl9vA==
Message-ID: <sashiko-outbox-214250@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/22] mm/page_alloc: count common memory nodes for
 kswapd recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-15-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-15-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:18:06 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> When a zone recovers above its high watermark, free_frozen_page_commit()
> clears a hopeless kswapd state if more than one memory node exists,
> since allocations could then have fallen back to another node without
> triggering direct reclaim here.
>=20
> Only common memory provide fallbacks, so count N_MEMORY_COMMON nodes.
>=20
> All memory is common at this point, so behavior is unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D14

