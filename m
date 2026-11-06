Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931191;
	b=sJfrGp/7LujOkJISN9tO64erVdmRSd9CdlA/n87LZtjGpsljabpi0UtnMJJq6npqBGBF
	 UgM9MxbvId8R3AcN2kxzBwj5R9StcLywd+cHPv2ZXivEOd837dnp/pxYutEJiuyqGwctQ
	 UWwIeIVZ+pqIUbgAKFruAi8ljX6Juw6TNbEUilcT+wxy1Zq2Fo/w6H0IkXlbZzKgJg3Er
	 KJwjXI1sFAk3RMTosyNAcjSDqEsD+oXlPHHh3yCfcj0rllOYFCaCjsTvkOo6nwqMtoz2w
	 9EwAAUJMoq+CkUeOokS9uvPrF7T6L7meBH5BLKUTE3fu96sYLiKhZGS8XepxBF7YC4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931191;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ku8Qo49ZURg71fWym0nQCP/fM/833QFX3S5KtLmUDgg=;
	b=3GaaTPRAWYTYwQcRGJ7SARR238gXnIhB+2jwNXTc0gtQHk1j9F0C1Ue3thW9l+bMUzpJ
	 mW8jGUyJDPMmK0LhgvQXJDGBRJv8mzusS4XAArx6xYFW3cSiWdg5apn/O+h/ebpMs5Afx
	 M1W9RyBOiA1JES2CIqbSLXWDCT95GvshgDWmyV/Qkw/EeQR9VHjgLBdYG1f5fLJrVQtnf
	 P4UVTK5V72ONzq/kx1XjP7aYou6Ju29cXPM5hngF+2aPaf1q1zE1INC/LP/HAZpMDZfL6
	 D/gCjOqQagc2FlSTEoiDAquaKjT7Blq+RiVSmrpRG/dijPJYhbhOppPQpffEM0/vN9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0kYOQsj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BAE606A31B
	for <damon@lists.linux.dev>; Fri,  6 Nov 2026 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0kYOQsj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900B41F0089F;
	Fri,  6 Nov 2026 02:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793931190;
	bh=ku8Qo49ZURg71fWym0nQCP/fM/833QFX3S5KtLmUDgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M0kYOQsjKRogJha9JJymF/X92TJmiEGdDUt/4K7VPunkbV7EK5qKKH2j0VLe2657Q
	 +FVIg7MfNufERxg485LXNJnJKCjoUJg+ESQnkJJPWHclclQnVBuOnMuuFl5Vnx3zSC
	 M+sewWGMRfNxU338zmOz31wPQHvaaU6R3qEyT2cQgU2CWP37UWoXid94n55MOojbUa
	 x2fRyr8H8tx5C9lpu35VFrbmu2sNkTlxheEYNkg+A6zDIbg9je1HkGQUyskTK1AlDI
	 O3EU3mfGW2V74COXbfVGG2NCU9YTnbWdtfvQuxjLxd1JYhYvV7T+T76DLT45YYIagK
	 ufjY9hJvIdm9w==
Message-ID: <sashiko-outbox-200583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] mm/damon/core: add DAMOS_FILTER_TYPE_AGE_MS
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261106020559.98352-2-sj@kernel.org>
References: <20261106020559.98352-1-sj@kernel.org>
 <20261106020559.98352-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 02:13:10 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> There is no way to specify DAMOS target regions with a deterministic
> time based age range.  Extend DAMOS core filter to specify target
> regions with age in milliseconds.  Introduce new damos_filter_type,
> DAMOS_FILTER_TYPE_AGE_MS in DAMON API, and implement support of the type
> in the core layer.
>=20
> Convert the age in aggregation intervals to milliseconds and use it when
> the filter is evaluated.  Reuse damos_filter->range_{min,max} to save
> the age range.
>=20
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106020559.9835=
2-1-sj@kernel.org?part=3D1

