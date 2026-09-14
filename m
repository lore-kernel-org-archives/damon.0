Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492B83FADFD
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397184; cv=none; b=XnpPq7NYdkG/k70hOYt8aKfUsDducx2h5tY36HA0tAN3tXf4IvR9cHlrDcTNYHPAnQvl2zqQbeeyN8x7e352xEWUj0B20joV40fs0snU7HesEkLeyiaAQ2wxcAV7VcU8KbNT4GOtTPSoTxrISZPn+0OJ6nT6WTg7vpFH3kWGKOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397184; c=relaxed/simple;
	bh=zBPSdfSx+4Lg1JRd5Kzfubw9RDmU0JAPdQbhO5VzHKc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eP9enUzsyjI9MfXFsfyIAA4Lzn65/4djWesMoVIhJgdJ3besdApYMKGE0LxLar9oOrylD1ri36paRsWHDyclP0nP+K+GFlDrzd3rstLmqRdUczRdxup9hyCD1kNvTUsmPe4gAuM/Tf3oWnjE7C5ioRJex23vPadGNs0ORHtE/fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqvdjV/n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqvdjV/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51A11F000FF;
	Mon, 14 Sep 2026 14:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397183;
	bh=zBPSdfSx+4Lg1JRd5Kzfubw9RDmU0JAPdQbhO5VzHKc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oqvdjV/nMN0vxQF03YhFzGf5MFK/hVDutgY8VlXaBVxkTEBVqD4A7otlxxo03EKq1
	 KLRfe9LU+SErO8axuzLbj0UiP0ZjcEqR6iN7Jkkd74jwjgpe1UL/Rk8zgMtruQCGRJ
	 96M7upwF+kfdZsD57tSDeeOerFvwgvMtJGGkNFVyybYp2zvS13asZ+EBnrZ0ceT6BN
	 pCOzs8pDpu+QRDI8TANSqdEihfdRK/IhoPgq2mc2zb10yot6Qwc2h+/ndjQAlAHiLt
	 OE++vzG/e8LVb6lRnM7w8Pb+1SGWLC+vKbymU7YN716Tw3fTB/XVKUtlsJKIuCXJRI
	 fSDu/48RLYH6A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 7/8] Docs/admin-guide/mm/damon/usage: update for
 hugepage_size
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914144448.93732-8-sj@kernel.org>
References: <20260914144448.93732-1-sj@kernel.org>
 <20260914144448.93732-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:46:22 +0000
Message-Id: <20260914144622.C51A11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON usage document for the newly added hugepage_size data
> attribute filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914144448.9373=
2-1-sj@kernel.org?part=3D7

