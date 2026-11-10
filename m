Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321153;
	b=X/kZJ0gmVxOgMarIkOlFSShDjX6oJP8ZerUcVIvcJQHj2p13QaGkt73Exsw7/41WcNWI
	 mAILv4rA3E97y6SED4lKK0LYodl+0yWRAjFt3Cm1eX0UyJKL+dU4+P5qDhNGnUi+t1exC
	 DdIyciS2/mrYULaQhoUXpXMYWwjwTD10NK097gvPSgzdejadrbgj/X1GMbaDS+aNt3WGP
	 BjYq84HLWhiWINLZ7RpLFj9POKY8rOg5+CoW+3BYAUa++rPnAvMfG0GZm6pPynMNdN2vh
	 Ly5+ZQ8DqIvpcx+v0vOYA17jWBgIJoxysJR+jVVeCp+rbn2EOTSCba1OFlLZmHriO8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321153;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LQoM5nOZNlBHX41/l/LlXZiZjsaHSH9kVooFnAbN0w8=;
	b=EZXmAOHoMG8t3oTGPWAi1KM/5WnSIU6FDBL3xqEFCzZkB4dRvcWDGIGQ7XmtZFDbl7+s
	 QlPaThbUcMeB4gvWYQ7gyNcF90I0P+GWFFlrFfndxPqYxkLPw48dC5oH2tmMXxZcdGlmN
	 +cyFG5BuC6GdmA6QkQX0IUVgtMMhY0axukPzmAHh54Dk6onZjvKunczmEEpMXFtHc4xAw
	 tzyg2LW8rMKyQ8XqopHceJr/OP02aWYSXkt+vrTK5Pz7g5X4+pIdhW7EXDDSn1p5GNa86
	 WUu+AAi0VVafNmUqcKpx+SwgwtrvWi5wavHym6x6bf/GPNhpa+U6QtuinIBxtCylJQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kEuYXIlm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BEA606A325
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kEuYXIlm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF931F0089F;
	Tue, 10 Nov 2026 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321152;
	bh=LQoM5nOZNlBHX41/l/LlXZiZjsaHSH9kVooFnAbN0w8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kEuYXIlm6W8iZgkC8OJc1JrA2ZtlijRLmx8R/K+HOp3NseLu6KA0uto/5q+FZAVtO
	 AilMLoilCO2tPfJ2s9dU2CUjLW102bpn2JMpotifm9GxowfLP5VRAnh9z2NgDbPjID
	 8DwVs5/wr4i231VdIjiFMpNdm1AvXTKIHYokAE6liGtyQH98SkpW5k0Mx+jfcEhwZ4
	 OqSvWIlWnzLg0T15KlOV1k3mHiUcM8pXwjVJ13Fg3z7/1FZFpkrW494dUXSZutvIpX
	 O6JMdoz0udqjbgv8nUFjDwfx8d6qgQANHBY+NwV2SvrIpq1sw2PvJLqP5Wr8Rwxt92
	 etpY64WhuBoRQ==
Message-ID: <sashiko-outbox-207194@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y v2] mm/damon/core: move static variable
 last_nr_regions to damon_ctx
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261110142832.125968-1-sj@kernel.org>
References: <20261109200407-failed-6.18-26ae50a0901a@kernel.org>
 <20261110142832.125968-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 14:32:31 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> kdamond_split_regions() uses a static variable last_nr_regions, to infer
> if the region boundaries are too stable.  If it looks too stable, it
> does a more aggressive region split because it might be a fake stability
> coming from non-aggressive split.  Because the variable is static, the
> inference can be racy and wrong when multiple kdamonds are running in
> parallel.
>=20
> The user impact is not critical.  No crash, no leak.  DAMON's
> best-effort monitoring accuracy can be degraded when multiple kdamonds
> are used in parallel and the workload has certain access patterns. Still
> it is a bug that is better to fix.
>=20
> Move the variable into the damon_ctx struct to fix the problem.
>=20
> Link: https://lore.kernel.org/20261025164808.152048-3-sj@kernel.org
> Fixes: 75c1c2b53c78 ("mm/damon/dbgfs: support multiple contexts")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Closes: https://sashiko.dev/#/bug/linux-eebfcdde-2881-48ef-8df1-e2019d2a4=
7f2
> Cc: Fernand Sieber <sieberf@amazon.com>
> Cc: SeongJae Park <sjpark@amazon.de>
> Cc: <stable@vger.kernel.org> # 5.15.x
> (cherry picked from commit 26ae50a0901a44f7d50053f87dc38abd9f9a269c)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110142832.1259=
68-1-sj@kernel.org?part=3D1

