Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7436F8E5
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928774; cv=none; b=XFQAnkaDNK8LIrPOo0c5pSr9RfIXNTCtr2vfGH/dSYU3BX6e0PpLIp1HQrqHPvJ0Ml2YHu6sGKmb+Rled5wAj8QQNdZQEMvQ7pbKfhRTs7b+MnQSpFSLuQkkmNeJGxDd0caHU+l4HXRcJATPNNjl5FTFjRQn3hx1o+CyuDig41A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928774; c=relaxed/simple;
	bh=davVIhKimMZmhO7KG99lVd8jPOD/48E7qIkOX3MyNkU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FS5m8mNyVHzmSWVBs6vgfeowTswgQ2fvkDi22nLCrBt3/WRoJLVW95H0rO7o3TrgKoFto0+NrYqq+wdJIdyeSUfLfEk9e79+ztMuaw8if9vAzRKZCy8LVITbZ70H38QFqcBrI/I8qMjIZdvj6kAhyCWv8y+gsDHHZhObjCwbmwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uxp+akSJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uxp+akSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077F61F00A3A;
	Wed,  9 Sep 2026 04:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788928763;
	bh=nAgLCLKcMzHAbura3g96cEGUXuqc+81HE3S9mrPj5/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uxp+akSJ91u1Qe4M9vEXZyUAc108fY88Lhwxlyt84Q6CfKCd9UM+i9FOD/xBWaU5G
	 psK7fZPgaPWA/7738q/+Bi27dAfZzea/+/h99QiYlyJWsP9TlTLp0FjLlie2E0aARa
	 VELoDRFXQXC+Wc4TwmRBmvsSWrL9oFfJKujKXDQXtMT1GUmUhJct8yv1tysZOulTeD
	 pxmpYxImC1HJCNR3++YV4m1zIvR6m0z1MT4crDS1jvA98vATOISFlKn0a5yaO5SVEy
	 JTvh9/mU3tvlKXeLTKsfbVWGsiYzuXkK98uQiK+jcjotMO5psXl7jHw906A3uXl+dd
	 XGiDbjZ5lPNZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/core: avoid infinite
 kdamond_merge_regions() internal loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909042610.203053-1-sj@kernel.org>
References: <2026090834-colonist-recital-c7f0@gregkh>
 <20260909042610.203053-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:39:22 +0000
Message-Id: <20260909043923.077F61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Patch series "mm/damon: unurgent fixes for infinite loop, NULL de-ref and
> races", v1.1.
>=20
> Sashiko found a few issues in DAMON that could cause infinite loop, NULL
> dereference and monitoring results degradation.  The first two sounds
> scary but the infinite loop happens only under unreasonable user setup.
> The NULL dereference is only in a unit test.  Monitoring results
> degradation is trivial since it is only best-effort, and those happens
> from only unlikely races.  Still those are bugs that better to fix if
> possible.  Fix those.
>=20
> This patch (of 6):
>=20
> Due to online parameter update like events, the number of DAMON regions
> could be higher than the user-set upper limit.  kdamond_merge_regions()
> [ ... ]
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 6.10.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 123e4619ab6c8ab1c4cb1d7a58311a2af13929cd)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909042610.2030=
53-1-sj@kernel.org?part=3D1

