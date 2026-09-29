Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F084D2D3225
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669211; cv=none; b=H02p5XVMmZZa3jL7e0iy4kCrRbITjCAm5RCpJXK8yGIdRugdHARQjelaozS3pcZEgJ0VXE9AIBsGJBh5cBtJH2+z0xyLl9ACD7waEkdGaQX6Rm0op3f5xGFygR+y8CWead+NBNn1jl4l+HRbTXQkOiCkVRjdbIeh5zuMuzv3+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669211; c=relaxed/simple;
	bh=rwtTvttti4JDmDZbtWlvO5NAgo4xq3GzLS6PocabM2I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WBjzqgwXnecprjPVW04f3sKSOpf2RWZq5/fhc7HcAuAqqH13+qSeixLyMqKuuqf4tU9an26s0mEH3SbRc8tsispPWvSlrVTvBMfcCBeUFKnHAE8khaQ9yzjDvgeMDjT1wY2OeIqfGIU/VhH/ZuR/bIzJCI/XuSB5fsYN6TQ84i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ6Lpx9E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ6Lpx9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6031D1F000FF;
	Tue, 29 Sep 2026 08:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669209;
	bh=rwtTvttti4JDmDZbtWlvO5NAgo4xq3GzLS6PocabM2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nQ6Lpx9EmX1hWOLS17WlL+/WUgAjnIjzBisV3/Pnjg0AtHrnuEgApCcZfaPNYqwev
	 i3e9a7dSa2uqJgBspn9jxErhPLnrtW2WjHcibaSxLDHjo9MTRnxmy7t5oVN6sb/bso
	 +PIB7MG6FJw6juNEagUiEXvs7Yx94wi99Cj5wzkR7qukBgdG4JPLOq0COiAfpuU4iU
	 wA0Ich2Gkz2R328rLYMNFJfFR4CmuLQvfzVl+LClp+t1JShMNT1Uo/m6zEAhCNaBBP
	 3FO6yk0A8DHKdR88MFizxyNOTyHFh+GdXh899O0mCZMrLoyDaC/bxg4h2TbM08evz4
	 r4wzzCu9kLpEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] Docs/mm/damon/design: document damos quota goal
 complement flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260929080113.41708-7-sj@kernel.org>
References: <20260929080113.41708-1-sj@kernel.org>
 <20260929080113.41708-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:06:48 +0000
Message-Id: <20260929080649.6031D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON design document for the newly added damos quota goal metric
> value complement flag.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929080113.4170=
8-1-sj@kernel.org?part=3D6

