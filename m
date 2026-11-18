Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036070;
	b=bfiUNsadKGkYM0idLAApx2EG0VuS7o/o7nTd1jTmZY+AndevUKU9Lz3Gzn5kbAADa4rJ
	 XkMuIYvp/vxsLB3toSFaIiqqcmy9UgyWtKL9yFgw/i0xCeQcOeJAGZG+N4XQomUYulHF2
	 x1TrHSsEfptuXAjGuppp/V0Xtw/vxgBwL5waVCw1ZCr92VsjNiZux79/7pZdXjuqKBnal
	 LqoXz3FtKphywEPjbexPcrfI+dZdT2y6CE7ofHvF/Zdp8reK7Nc3tXrHWnZJZzem5mCoD
	 9Qh53ej0Z3dTRUFp9/JsItMXvR3BES1TbFWNsvGR/Sz0JSCyxth3p/52Kep/S3n9xtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036070;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9LKhaOtNCI4h0Wdsed7Q95Uft4HA4poHP6nkvjVEw8g=;
	b=eZJ1Z/Le6weaYABq9XSk+KH91vGKewakkIZ7d2P1Wy7aFnKBDtVd5eA1NULjH4FCtG4A
	 r6o2ogq0d4QqD8NwIepCl2L+SrRdMSvRA623dfckEnK571oWZQLZsTTYvtfCdpI3y2VGD
	 ikNHD+kC5A2QBeaTJkp+JY6CGWHO39vFmF5uXr26UMWxM+hOZ3iSNF1d2f4Dx1Xx1B6J1
	 duCI1CWs2FW+IB1Bp8jes+ekeOXg0YQvDujpM7rKVnVBd1jyC4Elq/ICnw9KPzsdzuim0
	 qGnoWr5tybA7undLxK04Bf3oK+LM1w/esry+PUYwJ1qbXy6gfWNECPtjyW0LecsQZEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H28xv1qD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFDE606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H28xv1qD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C561F000C5;
	Wed, 18 Nov 2026 21:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036069;
	bh=9LKhaOtNCI4h0Wdsed7Q95Uft4HA4poHP6nkvjVEw8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H28xv1qD1Mzpv71qn9xXZKAYcV2h+ChNan5pO1pPRZXZz8wixmcMzt1kDEGCvAaZU
	 ktaSiDcaDf0F4TdSouKNIz3qNKjxt3dv92LQqiaGa+f7jq82kt9cxeg9APT5xZAJv9
	 B9Uf7TIPranf1UpHe0UgCGxb+t7XF9pU7vWUE7eo6whG17hrpGtePbhpVuxiLATHhW
	 eec9odYw8M0D5Op4VccKYqisSYfjz84QL52dDsrAJzmIBCzJgerIkGNdttESkCNqDx
	 slqckwGo7Jb5z/XpoWhEmQoN5Wf19AHsoBjCtuTNvmePis7aDYTlF6G6+rwq9BfbxU
	 xbE9feZuLLosQ==
Message-ID: <sashiko-outbox-221969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/17] mm/mglru: move add/del LRU size accounting out
 of lru_gen_update_size()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-mglru-fg-v5-8-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-8-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:07:49 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Kairui Song <kasong@tencent.com>
>=20
> Pure code shuffle, no behavior change.  lru_gen_update_size() now only
> updates the per-generation counters plus the promotion move; the
> addition and deletion active/inactive accounting move to
> lru_gen_add_folio() and lru_gen_del_folio(), which know the generation
> and can apply the active-window test directly.
>=20
> The unevictable case is untouched: unevictable folios never enter
> lru_gen_add_folio() and keep being accounted by lruvec_add_folio() as
> before.
>=20
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D8

