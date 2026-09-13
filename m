Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A3F377ABE
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789298077; cv=none; b=dKpyL0InQnJq+MxVR0Y6M3Ymk+ejrOgFvLm160g+PUMDx3zchKRyclFhynwAon2n0ynpY7jRrtIxZa1o/rIuCuyZHWkoiICeZMoC1SFEquEyMg+N0INk+nega2143Egf7PJjP3P+PxpX1ylazZkoB6LwXwzO6VdthV26sZNcceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789298077; c=relaxed/simple;
	bh=nXkQxBYcOO8xdSa2nhzIeTt7ybRWz9Lsn7mwLV3tSA4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jlppDYwpxfLieTeIPhvPpKO+OdfFyws0YD3ZwxKRbaOS+ZI3734hmasC0T/1z0G3h7OAf5HEmrXowzh1XsAX6YzdTgGXpoo9p2hOgI9GKXASUMikK+bWme8R/nKBX4N0Nd2NoSpS2Y2p4OQiruZCFKpYp11rqINqoF1kV0m7Vw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWtH2c85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWtH2c85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459011F000FF;
	Sun, 13 Sep 2026 11:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789298076;
	bh=iw3psnpv1hjn+EQ4/eTVYHKUloofuSihEchVTKnpc2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bWtH2c85xns6CTK/Y2Ina3lqxiDeCY7NaCmoidBrtJCXyPebx+uIvsaftGPJy2ZqO
	 +EiU2ItrdZih9BbT1HpbFL6bx+R0mu0jY5/zdCookZa1mI/qT8P9XXTDCOULiEtpcE
	 kmY5TsJgPI9SBVUXFEWfsvdLzto/hGJnsiEgGDnp3mlToEX8w4AiC68hWelbev/lw/
	 nkb6A3F8anyeZpKw7R9QQftBrSaha6xNfIKTzpwM3WQsQ45AYsijcrFVPF8x64TqZ/
	 JzRK03m76UXPsfaTiDZC7ma7zEMURdXL45IsYTjIjRksmv2oIAaFwaekkGvnOXG8Ct
	 Mh7l43fbOuChw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: add short circuit for esz<min_region_sz
 in damos_adjust_quota()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913110407.32558-1-aethernet65535@gmail.com>
References: <20260913110407.32558-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 11:14:35 +0000
Message-Id: <20260913111436.459011F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> After damos_set_effective_quota(), the effective size quota may be lower
> than min_region_sz (e.g., when the temporal quota goal is
> [over-]achieved).
>=20
> In this situation, damos_adjust_quota() will still calculates
> quota->min_score.  However, this min_score will not be used in this
> window, because in damon_do_apply_schemes(), damos_quota_is_full() will
> always returns true, preventing the scheme from being applied to any
> region.
>=20
> Therefore, add a short circuit for 'esz < min_region_sz' schemes to
> early return from damos_adjust_quota() before calculating min_score.
>=20
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913110407.3255=
8-1-aethernet65535@gmail.com?part=3D1

