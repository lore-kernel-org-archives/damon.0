Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110699;
	b=0B0qhX3gQQAf+13m9P4b906OLvYO0fSUVpRO4pfqEA8+vqUid6fODR0WwOlMOVQHRqKH
	 cPG4uNzUOPHg0zoJRlxCTZUa4t90rme7eK+O4Kw2uuNMtkw7hwUaf3iwRIsE2IjedfTap
	 S5+154AzE8eSSvTqB0uxMLuVM77qUM2rDAAMy/Izzj8sEUnCGzlVJOannetHHW2tKfh7P
	 EE1JaNIuQSDDzc/z1rHppVnI5Nkx8q6QLVhiJGWpdgkOPc3niX7N52YyZp6OUaQbrM+Sy
	 ly8INmKsUMpXxIjlL2SQpQtI4eIngn0VeUK0FOMd5aEX7zaQ4XvObWy7Y8nvsUT/NRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110699;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j531EON7IGE8C1xY+FymFR9/xDCAuZ0dbMY2hQELx9o=;
	b=cyvMlbaWOwIZOPNDX0ArFrS0pCDNilSYJVIUjuH/0XUfiM80QOkojTIdV4kAB3WZ6Foh
	 0Q1CxRar/6vM+7BHhmf9cuF7FladOE5TOkOWM0WNow/pp2ehxC/QQ5Gi83+U7xIJ8u2/H
	 tNBrW/VvdaobuA3R+BSVNjzNIVCHOZ6n2moLgzyEc1zcMRoEbrWCvfQYka6u3QMt7r3DW
	 FS9SkHSip1z9UOBDMHqzC0qQJBYpyw6Kcp7fREEeeHODY1YwFIUNVg7bQFqeiEV9c3Bk4
	 hfAoqcP4XvUN3cvnYtHwNAsG/ZguLNblhGzY0isk/LHCVqR9G3ZzZGVHkaR7BSsSOng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEo8kvOj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5956606A31A
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEo8kvOj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1A51F01825;
	Tue, 27 Oct 2026 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110698;
	bh=j531EON7IGE8C1xY+FymFR9/xDCAuZ0dbMY2hQELx9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UEo8kvOjH/2ZhKDWEO7aKX6DPiRbHwek8PeZ37Rm2jL42BVtG3twfGHszRJDKne8z
	 8QB5gzcOQpfWxP8Zl57l8lNsME5szUFWhn8Q3T6HZweHh5ei4mm5y29bZOWWGpFCUz
	 ROY3cUBedIKCUoSbA3aCefvWhvEdjvwa8c/WwxU4Q+D+DEzaOEkm3wjW1SIUCgGLwu
	 9+JDetvFvcW1zvn5RTC8wASs8i5Fjzl1Go/axTcX9vNR0dn2tiuOg0o1o5HoS/AxyS
	 AFBJy/80HOJFq9Bqh4P30Up+juX2WE5d1h+eX/ybjH10oPoLlE8f7yntv5evQKqyf7
	 U6tMdpDs0dvrA==
Message-ID: <sashiko-outbox-186717@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.12.y v3] mm/damon/core: error
 damos_commit_quota_goal() for zero target_value
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261027140326.153338-1-sj@kernel.org>
References: <20261027140326.153338-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:18:18 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Patch series "mm/damon: move zero damos quota target_value handling to the
> core layer".
>=20
> Having zero DAMOS quota target value can cause division by zero.  DAMON
> API callers are checking the target value parameters to avoid that.  It is
> easy to make mistakes in some of the multiple API callers.  Move that to
> the core layer.
>=20
> Patch 1 adds the corner case handling into the core layer DAMON parameters
> validation logic.  Patches 2 and 3 remove no more needed DAMON API callers
> side handling of the corner case in DAMON_LRU_SORT and DMON_SAMPLIE_MTIER,
> respectively.
>=20
> This patch (of 3):
>=20
> [ ... ]
> Link: https://lore.kernel.org/20260803134034.15217-1-sj@kernel.org [1]
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 610c4438fb66e06d9e693c0ad3b2c1be54c0d61f)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027140326.1533=
38-1-sj@kernel.org?part=3D1

