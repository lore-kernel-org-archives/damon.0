Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082586;
	b=gzTaaSZpwaomjOpUa6xS0lg1B6xX/K39ho+N1ppVAQwk3Zn5OqZFJvXYJ/naIEn554jM
	 c4tb4T2Y0BKf5Xc/YePkYnVUiRcItYA6OJDWaLGO46lQMjJLDZtc1hWWZIU2tXK9oV5Hs
	 b0+dlMzA/rYZrHwgXaPXg8g6zjmG+BypuTirqGvwGPuhCZ8yRPBGQjMng+aPRa2Jzu7dJ
	 p7tf3STPLJS/nXnG/J/yO7no7Jsqy1qCKJ5J4sSbePBRvAxBh+ezMbcu2WAKgfa+fvUt5
	 XjqN7MD3s8diqroAtzUfPpEKBHwFhtEN/wOIMKcll6/PQJa+6YeRmFhqi4NG8b/Jheg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082586;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M7g2pr3kkD/CSWJUpDzGgViLett+jFEZktD5nsKbj1s=;
	b=i/yTJCS62b1oDsMaNKE1sTm0MtSOnyBG3AyWaVtHz1ZAaufMnwW7kxq+Zz8QPnJoCUKy
	 44WP/Oc3xi8wwdTx1ln7YGxMAzbE8zDRSMIg+sYTmF5il/sm4Z6Bvo4VhHCyQYF55x+/6
	 DrGfa8dG0fV0jAck6ufQDLSi3lYz17zlBf9E2pHD65WMoZT9nXEIU3rwm3P1ezK+I2fy5
	 Y0LlW9S0wzFR5y2MoCcvKq0AcRVjGgLWu93M0+QX14qU/Lf53GdyFeXgYCUgGgPYJe0bP
	 0GsrINgOZi6IXwyTitETcyvg+uEvC7srO9WOpfZ/yLgtf1x5gwXPhnKfFGSHmLYCSmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YA//QQ1G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B78606A331
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YA//QQ1G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391D91F0089F;
	Sat,  7 Nov 2026 20:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082586;
	bh=M7g2pr3kkD/CSWJUpDzGgViLett+jFEZktD5nsKbj1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YA//QQ1GrkHwK19OK91/wAhu1y+2ZKJWaKNB+bPnpNQ2zWz/6gWBi6RBt7EEjPfnB
	 apd6s0nIuN7r59bbYvUBzwCPk1B3Yc4cCuKC+7hDYGVlnB50MnXz+BEtrAvm7g4L3p
	 u/UxDPJkLpmc0ARmBZHEbr17GwZQOYA3tXE2YF3kNaPTjumg4B/eohsDe7BnqDhMxr
	 Zb/IgGRcElgGtzlOivirPagg2Y/s0BMQT6d6nRSG3aANYkNR+05cpforrkiRypkEBj
	 pSg9+BDi2Z4EwNjL8QOJkGZexBkh1urjWnZRLvd6QLmLfNte3waxyzWxR5qkMhE6jN
	 kFhDhnuLW5L3w==
Message-ID: <sashiko-outbox-203256@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.18.y 2/5] mm/damon/core: handle uninitialized
 damos_quota_goal->last_psi_total
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261107201001.206120-3-sj@kernel.org>
References: <20261107201001.206120-1-sj@kernel.org>
 <20261107201001.206120-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 20:16:25 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> When DAMOS_QUOTA_SOME_MEM_PSI_US metric damos quota goal is set, the PSI
> delta for the feedback loop is calculated using
> damos_quota_goal->last_psi_total.  However, it is initialized only after
> the first feedback loop.  The first iteration of the loop uses the
> uninitialized value.  As a result, the feedback loop can change the
> effective quota in an unexpected way at the first iteration.
>=20
> The user impact of the issue is not big, because the issue impacts only
> the first iteration of the feedback loop.  The feedback loop also has an
> internal cap of the quota adjustment.  The wrong adjustment will soon be
> corrected over a few iterations.  For this reason, doing no initialization
> at commit time was intentional.  It is also explicitly commented.  That
> said, nobody likes behaviors that are unexpected or difficult to be
> expected.
>=20
> [ ... ]
> Cc: David Gow <davidgow@davidgow.net>
> Cc: Quanmin Yan <yanquanmin1@huawei.com>
> Cc: <stable@vger.kernel.org> # 6.9.x
> (cherry picked from commit 29c6084658af41b5b1fefd873d26d441830ced34)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107201001.2061=
20-1-sj@kernel.org?part=3D2

