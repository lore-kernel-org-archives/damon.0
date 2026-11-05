Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854157;
	b=MNiD1lNINXVY4eVEDtN4uU67wyxXt6iInZSGA6YyBwEimnnfq4SlCIn7Quvm05K8VpuD
	 YRlonackEjJAm4BDCKvJf9Wg0cZueYzcGFClyXtBYBQyRjJFrKg8eVcOl5v0Pn+9r1X/V
	 wor4HSxUwN+f2h/9p6+iA/cB1yhLptX7sl21EY9cJgWdp0WVZ2shMZ17/4ETqP8TYWY02
	 ft2PYR78ZznrUYLGriKqe+kDQwUUJQxYqINaQ0b1FKGngPYshW3nutoDFWPXTbACRpPdO
	 wF9CdcgEH9dxw9XrrtJLZE1JOr5yUkKqGaf1Qg/cGx6QVOlmLPULOBRLWlcsyK4o/hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854157;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P9AFHPNKJe/EYzEt90TSn7j2TBPYPyc37/1QgWuVW9A=;
	b=EREl+5j18zS6ClVn4EORnm3zhzfvP9ZZ1Og8tbiOSsM0tudzTItMsSKLr3CisBJXbsXd
	 LfuBQCWNdvRteTDb10tU5iJ5FAbMyUm0WUuxltsVc05BuBRe0VCqL4H8qDVfKIQ++BE/3
	 VpRESOGFXFxAovktlnrrY5xjm/+TRCYFfOIhom4P1oXNkcSI775XAtOcJZoD50fcilhn4
	 9QZIvX+feDoIUhLt0H8MzSuYTlqTFl7ZzYxr7+unC6g+HvY/DA2l/vW80l8og6YqfoYLr
	 sDXHZ0wF4kZP16GobtUPU+a87sF0wWmaL9YJGpmfXYszFd49+bVcZrkeE2aYmqfMmSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J/hjkhDI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB482606A326
	for <damon@lists.linux.dev>; Thu,  5 Nov 2026 04:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/hjkhDI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6338B1F000C1;
	Thu,  5 Nov 2026 04:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793854156;
	bh=P9AFHPNKJe/EYzEt90TSn7j2TBPYPyc37/1QgWuVW9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J/hjkhDIiskD0Z49j3BwbX30LmCpQYyNhUM/VhNwB1KT4VhBFcKidLvJx9xRumeI8
	 jHa6LxAKjjg/vrTE6ffR37xHQ/Um+MzoTcqy4n0qw+aX3sD95PrGIm5fJ3y9z8FpP2
	 2HRISwMdFvd8GTlaYcJtZTmen6jQ0x61WZjFPMz/d16MulLlk6ia+Rzw3X+5Lgo43w
	 yBgfGvyF37GdvnPdlnxvV4q1CJkCm1LnsL8DKzTlODp3WOtj4jumHkwLWxAEMsREev
	 k1szQDdEIIE5Zgdd+JyAqXjxUKZ7l0EUU5WRHcO6tL4uxe9F2p2d6bXqCRlryI9f7s
	 izMJHtnLVbRBQ==
Message-ID: <sashiko-outbox-198567@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/4] mm/damon/sysfs-schemes: support
 DAMOS_FILTER_TYPE_AGE_MS
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261105044425.87142-3-sj@kernel.org>
References: <20261105044425.87142-1-sj@kernel.org>
 <20261105044425.87142-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 04:49:15 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Support use of DAMOS_FILTER_TYPE_AGE_MS via DAMON sysfs ABI.  Add a user
> keyword "age_ms" for configuring a filter of the type using the existing
> filter configuration interface.  Reuse existing 'min' and 'max' sysfs
> files in the filter configuration directory for storing the age range in
> milliseconds.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105044425.8714=
2-1-sj@kernel.org?part=3D2

