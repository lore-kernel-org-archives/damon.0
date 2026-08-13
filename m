Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07274412294
	for <damon@lists.linux.dev>; Thu, 13 Aug 2026 05:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786600676; cv=none; b=RCuYIyLHkJfrjPrm6Fh/2PsPywjTwZaB/iEw6pYLvq0qgEo4B0ravTF/gVMgo+FiMz6Zc4FEceuuCT02aVh8rDRmYhIjhLuSSnCYnZCKy72AvHXoGfmyekaUTuB8OSZpi80y5sAyxnZiBbZ26WIMqKeIOeJtxch8ARK+VGbLBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786600676; c=relaxed/simple;
	bh=d1PObw6bkWyMeUpbEXrco/OajewNRKjgiZcISUnhfdo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hCWYzp67Z5v0K2qFHZEwps5Sj17bxyI8BWooYmPZQIT9Fr9FqLmgezToJtGQxfdKiyy3bFA+6lYlSGGnX4ope501nH67wQRCVg5mPwBMQEz16uwwjG2pQK5waiG6+0MKKw2fg6xdAiE1Yred6tuP6nrevb3bTPUQObDHo/vPp70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJv56pwO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJv56pwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE961F000E9;
	Thu, 13 Aug 2026 05:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786600674;
	bh=GU4wbAtxsfACEKmQ2Mx2rDnpFbTicR/CtPiJmXzzhZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lJv56pwOj67Irzu+n3ksGX6ZnYDct+3yc6yQdb1fJFdDato11Fkv1mQllrk1PF2C1
	 T7m75squ0q4a+kMMeP1YdYDR0SymMF6uIO5uad0u5BJNutKsWMKBfCQKSl5CaR0ds+
	 EQy3TeqtD7YsxzDmLREHaF+R7JV3QwCNfF00889kL0bY6G/W+wGqKWsskiZeTWn9yB
	 8x7pJlfuaOCxdNCKTBnto0uZUd5wau7GL2Dvu/+77oqbSr/RYAfFcDRtz3LbqqQnRN
	 CIQWY1fbDfbijrOK+NMO878fuCqFG3RwgOyqEJHS4+4Vi7iJvjD2VvJoPr56dgTm9n
	 1p/aqTunKUvnQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] Revert "samples/damon/mtier: error out for zero
 quota goal target values"
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260813054432.101197-4-sj@kernel.org>
References: <20260813054432.101197-1-sj@kernel.org>
 <20260813054432.101197-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 05:57:54 +0000
Message-Id: <20260813055754.6EE961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> This reverts commit a16fd3ad9d89b05475864da97327870464611736.
>=20
> The commit was made to avoid zero damos quota goal target value, because
> it can trigger division-by-zero.  Now the core layer handles the corner
> case.  It returns an error for any attempt setting the aero
> target_value.  The corner case handling in DAMON_SAMPLE_MTIER is hence
> no more needed.  Remove it.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813054432.1011=
97-1-sj@kernel.org?part=3D3

