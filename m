Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921E3542ED9
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088848; cv=none; b=ul1Q4eigH/+I2eqaQj7fJXT/xf/4tOzTR/0qB2VgZ25xNzLQvgotG/6ul62pSKRS7oeswcx7m0soy8tayOelvD5Btz7E3HosR5uol3LgbpTomqeb24SjtMDDScQ9EAmut9/wGBs5zs9XMtt+GIiEol/744NoSE4EzM2oKQqu6BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088848; c=relaxed/simple;
	bh=iAZrRVLwa3h7oc+cn7Vvh4PS2LOLF4vcydZfkEm+L14=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=A9v76IxDm24dwlYl+zRaxXkASQ6z+G5UGOGw9NU+XCuomYkgXW43fK54gQUe5SKmQuYCnTVlXgmbCIAo6TweMJ1whZ/m0HKRQYMcYXratOJo5JURVsXacm+pC6/V4LGD3MxrQ+n1rEOv1KNippZXN8ZUv7uAYg0QZz5bdmLz3Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHe/AJyv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHe/AJyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A701F000C4;
	Thu, 15 Oct 2026 18:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792088840;
	bh=iAZrRVLwa3h7oc+cn7Vvh4PS2LOLF4vcydZfkEm+L14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PHe/AJyveZUqwgIz7ErBdkf0HaLkZLrilMU+D8XGSGjTclsFCq+htrlREwcpTRT3a
	 nJ3KgD9nQm+s4bHbwMQ0edHYlHLXFWNBT+siHj78dqKrVfGlhffp2kGEaBHuyIdDyz
	 Jjchv4h1N7fHG/EKzF5VY6wfp3WmyoxmB7n4Jpl8lhN1epOqAFwjJkyRuSDerZwrjv
	 7n/mnx3uMGFhjUTh3B7yjOR67shFvgsyaUDmc57kxf4gSPauYjYeCBV7M4PipVFPn1
	 llKM39LcYO+quNR0q+ewToUH8X2WG9OcWlQEthpWnR2YKypgz8eOQ8oHZhcm2kxw2C
	 aVmBnchmDIs1g==
Message-ID: <sashiko-outbox-173287@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/17] mm/mglru, gup: mark folios referenced via a
 fast helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261016-mglru-fg-v4-7-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-7-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:27:19 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Kairui Song <kasong@tencent.com>
>=20
> Introduce folio_inc_lru_refs_fast(): raise refs from 0 to
> LRU_REFS_REFERENCED via cmpxchg, or just set PG_referenced for the
> classical LRU as before. No counter update, promotion, and guarteens
> no other complex operations in following commits.
>=20
> Convert the gup fast-path sites. No behavior change for classical LRU.
>=20
> Tested-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D7

