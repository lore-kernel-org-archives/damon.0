Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6E47F765
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269032; cv=none; b=X03xM7Ny/7JKIBbjebyw205h6/25RbwndjCyYDeZFnktwBsd99X2NbyAGViKtWZe21pKpJcSJVqfyecWQLy5MgNWCXXNmyjLxAmnxUyygLeMbKxXBqKYX+ZgbvQEh9E0FFsUdHTi0/vePvQ86wt+6dWhSNOVRIWjUmrg61LobVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269032; c=relaxed/simple;
	bh=tOlsgmZBosHyaQd/DX+y3dZ5EPgWu2eVr1vygpdGMm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cWhTYLhdAdg8qbekSK4AIwoGAHoZc+F31sAM+58OUPQaWdOd3Wc7VhTjtSL79lIaEYKhcRkhtPAsfmcsioxZ+bSEReYvfC8l6a1+LdKvciVc4XreVMcLNeor0PxTQTny6nae8MtqINWqIVuS0nD7ewTTzTtw5IM8zUes/h1yWJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtY9079M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtY9079M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB441F00ACA;
	Tue,  1 Sep 2026 13:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269030;
	bh=zOhBb9gsMUvzQYAeieEO48t0BIHqnj1KRwLei0iA61s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mtY9079MgWNrokDdWrio7FnU99KSlvmY/lmFN1cYERp+iW28+motyd33nthYnIiKq
	 drCPWgdMZ9SotnalY3CxajpadbjF8vgLk+MucC/2DmHBKm134c5/KP6oHnmlbQdPJT
	 kJhtC6tk+pKHze92uP517nSTKo3SUDyAdEIXsvbZ/szttqC4t/LwG0Gz+Y+xwWvzAy
	 me1PV7y7JBI9WTT9TXXDycC42OuN9Xk0yt3m8nD7M5dB2qjtb6SmT4xnUMkbXoZlcl
	 eipAWgcSsWJvvSxSeTN6drR57HtSWI6FWnwgsu7qnGFORMX5r75BSew0OlETkQ5nQR
	 n6HwaaEEr9UNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] mm/damon/paddr: respect folio end for DAMOS_STAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901131326.97615-2-sj@kernel.org>
References: <20260901131326.97615-1-sj@kernel.org>
 <20260901131326.97615-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:23:50 +0000
Message-Id: <20260901132350.ADB441F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The function for applying DAMOS_STAT in DAMON physical address space
> operation set (paddr), namely damon_pa_stat(), applies DAMOS filters to
> folios of the given region.  For that, it gets folios of addresses in
> the region.  It starts from the region start address and advances the
> address by the size of the folio of the address until it goes out of the
> region.  If the start address is in the middle of a large folio, and if
> the next folios are small, some of the next folios could be skipped. Fix
> the issue by advancing the address to exactly the start address of the
> next folio.
>=20
> The user impact is that the DAMOS_STAT-based page level monitoring
> results become inaccurate.  Since the page level monitoring is supposed
> to provide relatively high precision, this is definitely a problem.  It
> is arguably not critical since it is only monitoring quality
> degradation.
>=20
> Fixes: bdbe1d7bc325 ("mm/damon/paddr: increment pa_stat damon address ran=
ge by folio size")
> Cc: <stable@vger.kernel.org> # 6.14.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901131326.9761=
5-1-sj@kernel.org?part=3D1

