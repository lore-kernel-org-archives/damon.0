Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E4E4A68B3
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004128; cv=none; b=TboTpbvFiFY1EwBH1yUKo96MnGamWPa/NfeWehpq2bxGdHYBMFTVGzR6Cs4DSlCjZA0f/GFIZutxKiObKYvowCmUwC3rf9AZZFV2ArSGH0OUJIlv4fTzahoaODi891/3qPcCA3nXF3RZ7NhkW70q1bYQAAwjw+supA5l1nn48y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004128; c=relaxed/simple;
	bh=3SgE1FcuxDdE/qmCm0Y8COTMsk+QJ9BK+sC65qPHMHo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ALjBoBFvC9IrnQzHSrkyQlJimeWhE0iHeYF3RdZQWHzh/njMWqBHXsBij1APeRxi+M0pjW8Sp2kJermv4ER/AMIbKmX7FVHR6JjiIUb1BFvG+pCnST19x5lcuSOgfnOU39X9b/Hu2LD/kALRD2zjuUhKt98xMh5XwwrbLiFdEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAp+GFgW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAp+GFgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1CA1F000FF;
	Mon, 21 Sep 2026 15:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790004126;
	bh=CXf82MBmT68QIl6Z6B8XESarGHC78aGvVNsYKAca7oE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XAp+GFgW09zsj6LoHNu47I4yTiBvrcKFONGs2Et9zBMRoW7uhY59WefY4L+H3o8yL
	 XdZqDwiSHf5jZW5UBuND64/GZHUzOEDBpJ3DlWQHE7YSkrjuKCO+QvXgfxunmF+M+s
	 2+IyxBy98T0gnq30eK/rP2py+XuiAvBD1rLoNjOHGap/I1c+raY22ngyN7QmMc0oqm
	 e5thHorjBYVEXc3gH5poy8/becEU74DOSEuTeq49BUItXuoYUZXh1us486KBU7Cgip
	 0WXYJ0DMEFu4I1NNolzRaaab8byScf3cQ4CfHeeaC0OnOcyvGOgODPG3Zp/opVuANB
	 kibM58P86PtiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] mm/damon: document that a zero sample_interval is
 accepted
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260921151547.78472-5-sj@kernel.org>
References: <20260921151547.78472-1-sj@kernel.org>
 <20260921151547.78472-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 15:22:06 +0000
Message-Id: <20260921152206.9C1CA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Karthikeyan KS <karthiproffesional@gmail.com>
>=20
> damon_set_attrs() accepts sample_interval =3D=3D 0.  This was reported as=
 a
> bug in v1 of this patch (rejecting it in damon_set_attrs()).  A similar
> patch was already declined for the same reason: a zero interval is
> intentionally supported [1].
>=20
> Document the behavior instead of changing it.
>=20
> [1] https://lore.kernel.org/all/20260722094304.3132750-1-dayou5941@163.co=
m/
>=20
> Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921151547.7847=
2-1-sj@kernel.org?part=3D4

