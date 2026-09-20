Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8259B3BE638
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871879; cv=none; b=BNei8CF/WW2iVnkL07OAlEweYonp1CjgBvGiJF7sWr9qfYDJoH/qkdu+CMUrq3UYP2fUpTxhy84prln32v2l7B7okkZ34TNUoVH0Y/7u7ayUSFQcSHXX3hWmDwumW12ALg4f8CiogCjAuOSwaZl4XUmkXFl+erfPwbIL7MMwgOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871879; c=relaxed/simple;
	bh=wqDkN3fV8vU1c5nhRu3BIu/5B36LSX16iDYyljyzhtU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lyD2GPElzZCgLj3kVbCPDRynIUimlEpwxF/vTR4xtFld+C4bBpaYpLUGu11b7Twd/h6EOY+OicYjwmNd+/rIv/3D0731BQejADVo84dgbqtsSFlCqjFH6OCq3T83A6XVIIEQd1tUcfwEosb3vpixR4hMcBW96TYIjv2MO6imMZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y60WxgYR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y60WxgYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CCD1F000FF;
	Sun, 20 Sep 2026 02:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789871878;
	bh=6sHadti3SxFj09BY4xWNUer5HoZCt2ONS5uOd4q+Ofo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y60WxgYRmklWSwfTO996OvR+32J4pfhnI6ztHCTTLQoVL8RAxsy5sz/Yh0Kr3ohuD
	 klEmmglKO1aIOq+qFXETRZXnyK1RfNfHFgF+kYVZgfGyt92jq7qZ29uJ6BMhoClZsd
	 eQ9lJYtTh6GR6Avf7I0146Iq2EbEiGyYfIHh6sFxR5krNcR5XbzODh+90g2nnHd+7F
	 WNkvZETclljiEnp0ileFhsVTXBEsArSdNc/cThvg7NCXRySDrovdQ6baeLx/a+5z7N
	 gYWCKCa/PXURA7fd10cc4PYvLVzXudyftVpqqsgP4gBwl3Q7gr4oImpv9E0LFDsojW
	 Roqoul+vnrkKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] mm/damon/tests/core-kunit: test the temporal
 tuner's size quota conversion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260920023111.2466265-3-donggeunyoo.kernel@gmail.com>
References: <20260920023111.2466265-1-donggeunyoo.kernel@gmail.com>
 <20260920023111.2466265-3-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 02:37:57 +0000
Message-Id: <20260920023757.D7CCD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_goal_tune_esz_bp_temporal() encodes the size quota in basis points,
> so the conversion is exact only up to ULONG_MAX / 10000.  Pin the three
> sizes around that boundary: the largest one that fits, the first one that
> does not, and ULONG_MAX.
>=20
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920023111.2466=
265-1-donggeunyoo.kernel@gmail.com?part=3D2

