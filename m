Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CAC3AFD18
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668977; cv=none; b=eS3ZrT1BaY23VeqPBOKBFd1lIKoKowJS8CqMVMj6vy5fP9eV+Iqo8yrTR77tbQfE0xFkPxl60UNxzfWG8cW1b6Eib6xfKZRy/QJtAADj/txJib5ZURFoNKSB11SPxRg2/Hw/hjMR8YfQi6qFerqoltcCYw2qRGFBYnq5E34RSAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668977; c=relaxed/simple;
	bh=udrNaQYJyI4giXZl5cAQrTrv37ftBCSYuht2Zux0Sy4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PdIjwm3HKqjYNoHL/TMPCNftzXnbKlLNAyE6hEp8s6KBqcBoKwXN5mOus2QEYLQCSK9/SNRcZirY79Gx5hHPOKaMAheiDZThQaVZd0TrsWk9J24WH8GpUhVd1J15RvR9hU8alv9PNVvu6EewIZAQDLaiSGdm8+aZcPDFDkGPOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOUFd3W8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOUFd3W8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6C01F000FF;
	Tue, 29 Sep 2026 08:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790668976;
	bh=udrNaQYJyI4giXZl5cAQrTrv37ftBCSYuht2Zux0Sy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GOUFd3W8g1P9uz3oSH7GVcznSFWkoar7H/XqwVQzW9LlvEXLEydjsF93z60uKCbvI
	 fuFN728aj1oCRp/+pF80q+N4szsL/PtfRO8V8qJvuGCigOS1RvqLETsoWRav4IwpXV
	 lsceiCWLK30Dz0slu7+je3ENKfFAXO+Xu/Ps9cYol4Fx1n0xvgx7wwNxK/1eJpBtvx
	 DBzMBg5hUlCYGHbMnMKTT8y1c0PVQEgnkMkDNn3Fz2ll5LYn2K8WaAFswOgGZbroTG
	 krnisSncMc1Wd+7wy44nI3tUTkYd0uioUZ8GnTpbASMpUy5/CSFm2aN3+BRcBkDEuh
	 yHNlJF2adYNlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] Docs/admin-guide/mm/damon/usage: update for quota
 goal complement file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260929080113.41708-8-sj@kernel.org>
References: <20260929080113.41708-1-sj@kernel.org>
 <20260929080113.41708-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:02:55 +0000
Message-Id: <20260929080256.4B6C01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON usage document for the newly added quota goal metric
> complement sysfs file.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929080113.4170=
8-1-sj@kernel.org?part=3D7

