Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A31C377ED9
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 04:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618169; cv=none; b=lVRoVfa7Z0TNJoT11y0Amhj4uS7lqFjnxTylTgggcjAD0YeBabIOt0CwoL8f7eotMPgwEuihLZbgBhcq9Gk2kvTDC8QB6u0HJxAotJIT9HTTAd6KbsnNtjMCi1pnxcYS2qdKIDiga4iShgw4tBuy5nC3h0sgepQTswQ6U3f+zWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618169; c=relaxed/simple;
	bh=7w7UuaFp0vNS/rmN8jyst49bP0Pi1xTSnTyn9Ked79U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qmsszUy87hCYyc55n8w4WUiP2M9/RmpkEMGlj+WAKQlsrlnvr5VwwST2cgxzwrATdz7FBMbFwBtdNG3ESOJVYqPlfMYHoEA6nikJJB3PuJuBzEQGy9aDKcOfh5m6oh/E6Y7Ye6z+DaSXgWRdVDFXXxsy5B+jrVXZIkqRCNIyU+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmkqohPA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmkqohPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667A41F000FF;
	Thu, 17 Sep 2026 04:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618167;
	bh=+/Jw7UXEVsXIFII/L3POFdpx9OYPEGpbiOP2dJPe4FU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HmkqohPAw0aEeD+4SMDDFfR/NXC8pDsPxI1FTcC1CiAi7aRbpNGa+oCbINkHpUQ/y
	 fTJGx6IZ9ppxamtXCJ1w4mZDlZCWDv1mPxcrg6BsCiHPXH0SgMU2HRLl1gjEMRWXkS
	 qHhZy5Wgvh0tnyzgxw6tGaoP7d9/uY7S1Wdn9kKSxPoeeE+hqQt1WFPQIE1tBC0P6s
	 u0h/jXAqIZX+l/zQardHdcrlXgfTpoux3NY+bCR+wSlsCO+Xa74TVgNg57Oqj0ba70
	 EXjAK9ACDvPYigdoVjQI5fPikQHcERvnt+ixsQH5uqhkywSeAH3alp+00TYm2cqLNW
	 a2xmHy7vtMWGw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 03/10] mm/damon/core: use mult_frac() in
 damon_feed_loop_next_input()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917040537.107341-4-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
 <20260917040537.107341-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:09:27 +0000
Message-Id: <20260917040927.667A41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_feed_loop_next_input() does its best effort overflow protection.
> score_goal_diff is always smaller than goal (10,000).  Hence the
> calculation can be replaced to use mult_frac() without concerning the
> overflow.  Use mult_frac().
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917040537.1073=
41-1-sj@kernel.org?part=3D3

