Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082619;
	b=07c6td8AiJQHNmjoQDq1RMMCOtEwXAT0Weu0ZFPnpvKvv7ENn2rcsxCTJgL3VkAxXVRd
	 KzGyTq1KDol2kt7lsJAptADCZBmPP5CFZowSyNwLbzoH05b7FGW03Hany0PJ+t6PuwLpT
	 mwN6H/WGYYlmooIMCAhNGDvhjMHHnBsISC9hyGU2iI6kBPxIv+IcnVKuVmIOdIFtMbaQo
	 xzKUrUvlNM/8HlLf14QZpPdvGKzb9t9fHGYC+oiwyI7wHlhg1ly5u11PZrJdqiyf3Q4Uu
	 zb0ElE8jQ7h8eUX5s0BtOe8yDL1h/43mizOGaZUzMkRefUOJZdvVI7RXM4Adfi7IU4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082619;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o+ZMjVLJcfcDmMSakGA07yGVejbhw+dwwn3jlM9VjIE=;
	b=v9+H/Vg/p8cEd/J5LmhmUn6rSQv3lC/Fdk2rvqnL+wm4g2/7HIo7hOAr9AqxGtGmf31t
	 by9qZcCK9UPNpJvqU56xOlnypvhIc2xmyWliiwfwCCpitiQG3NykbdblztEFuotkn234y
	 b/WXjAoqt67O3aRbjQqh4Ap0fHSRWBGFQZRCB7QzaysqJmucqzdO+vvlUETACDP3Aatc3
	 I8KSgtmCn7bNZhvDNQwZLApY1EN1UPJ/MwEZsh7YCSKhHijupS5OaHg4aWZAN/Qq8M0p1
	 Uq+mtmLgQHBNMJzQJlYzIz87CwZQRoPSSJD0h32FEeY0qojTFyA5kKioKgIZohPTc0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T11aGfsf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B182A606A326
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T11aGfsf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F011F0089F;
	Sat,  7 Nov 2026 20:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082618;
	bh=o+ZMjVLJcfcDmMSakGA07yGVejbhw+dwwn3jlM9VjIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T11aGfsfSszaoqxxQK1Cl6JQU/4IIj2OBZjZAxw6TF1slNvKNZUOE6iKpaxopjgN0
	 vRtucqazIE/xdnSiUO89eoBJtnJQuWlcdrbnLc7XI0p44nHWBcHG+CR+BGr7YUmowV
	 eDOvXNX/0ZzDww9Fmyc9gU15kQZUkipOP0WIzX/qBSqkCbSFB6zIF9DI6i6TtJqQnO
	 j6geuEOg7ESw8+ajI3ZaOsRZyJ3EouqIOCfeA92T+RuQqIsnTEotOOSr1EGkbol4GU
	 fjqhVN/LT2bK+E53QIivnm8Mf8GqQVKzfFqB/N2qXkCUBG7oDqAReN9l/yECLsP5LE
	 Ns/ljFpGGNXBQ==
Message-ID: <sashiko-outbox-203259@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.18.y 5/5] mm/damon/core: filter out damos address
 filter-split failed region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261107201001.206120-6-sj@kernel.org>
References: <20261107201001.206120-1-sj@kernel.org>
 <20261107201001.206120-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 20:16:58 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> When an address type DAMOS filter is configured, DAMOS tries to split the
> region for the filter range, and apply DAMOS action to the filter-in
> region.  The split operation (damon_split_region_at()) could fail from
> allocation failure under extreme memory pressure.  In the case, DAMOS
> action could be applied more or less than expected, ignoring the address
> filter.
>=20
> The issue only rarely happens under extreme memory pressure.  No crash or
> leak happens.  Occasionally not applying the action to a few regions
> shouldn't be a real problem.  But applying the action to a region that the
> user has excluded via address filter could be a surprise depending on the
> use case.  It is only theoretical.  No such real case is found yet.
>=20
> Filter out the entire region if the split is failed.  Update
> damos_filter_match() signature to receive the error from split.  Also
> update kunit tests for the updated signature.
>=20
> The issue was discovered [1] by sashiko.
>=20
> Link: https://lore.kernel.org/20261020004119.106690-1-sj@kernel.org
> Link: https://lore.kernel.org/20260801203121.117449-1-sj@kernel.org [1]
> Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos f=
ilter")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: <stable@vger.kernel.org> # 6.6.x
> (cherry picked from commit bbeec2d8324d7aac438bb12dd2d22b184e0a8d43)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107201001.2061=
20-1-sj@kernel.org?part=3D5

