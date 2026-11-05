Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854049;
	b=ARuR9eBXJLW7KRHq1G7XBYain4dAcfWI+jJsRzCIfDvoAhDM2ghlsjySwJRaKto54+f5
	 XCwqDKLb4cOTg/32yCquZsLDhpjlFLBtvz7ly8xVWUCUdIK3N1qHkwm9NvwizSGxZStXL
	 qSmnU/shW/gPDqy+ar0pZoRLlNHiDC6x8h6sqUfIz8Vfh5/hZ+AQAOxHg+OLgQPkPi6HN
	 yGuZq1pw+PZi4ttdkS5rPS/tj9HqBh8mkL/mVxG/0OxOzGb64xuLjQuqNCisW2qpvKmJv
	 H6m3c4gy8E3yttF+CTCU3X2x+ISaHpEPw7KV420GLq87+uRV5esacd17NeJroJmb6vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854049;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZZTxL08jjxOKVFpk1aJJ+Sxa3rYWMyEMK/SbGsnebZA=;
	b=oP15Wwdur2yNMP8umLVDBiSjK9M6LBEFvfUh2NSWtC05AKyhEPu716AIfnIE8AIaF/Vo
	 SCZp5tcztpYRjMfsD1fWvD7XZpA3+B/+AS2lpGtX89hiB2DqXRm7ihm5J2iJSS2lHRN5Z
	 ujKGPlDfMPIy17qko50o6DMhlcyD1ity5OQkcwg3BZt/wKlrlhs3CQdwNDaRl+kp4IKWJ
	 GpY10E3aqh7RHZz8Zxrv2WStIqSrqFy1p3ifjqvQp4menC+ohAJ6g37bdCaOijM3RxL/9
	 nO7HLIis0P9ei2iQ2yeDep2NTtJYMf19XRtExkhnvoGtm+0k3S9UW7ifOHaMO0u3RNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4KaJyRV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA2B606A332
	for <damon@lists.linux.dev>; Thu,  5 Nov 2026 04:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4KaJyRV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33AC1F000C1;
	Thu,  5 Nov 2026 04:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793854049;
	bh=ZZTxL08jjxOKVFpk1aJJ+Sxa3rYWMyEMK/SbGsnebZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B4KaJyRVBwQ1D2YyVDfu0SGPwVHknu8dLjZm0dyPvSU+f5k6bVn8eh/fLMrdvV5KC
	 TNJyUzKtlMCsYjwt8jK9rwzTUvGvgC6qihNOkpLogWrMZJH++d3WyecdGOx8PeTPHD
	 3zwaGmDGkeNYVg0tT45eQW+zsP50sILaB7UKAZWEi1qbRZgzgyBMbmdik94HfvqLte
	 YRAxNCW1Oj+HIrPdUmr3M44QZUbJI+MgWNCcsVXnNOh3mFotQCIf3jR92ydbIIq9Cv
	 n9fsPGWGvysER5BIdL6J6TpA/fBa3+ixcFDoA9XHR/ZILvImXUGsUAiPQFEAir9/Qf
	 UdMq+FaNTuAzQ==
Message-ID: <sashiko-outbox-198564@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/4] Docs/admin-guide/mm/damon/usage: update for
 age_ms damos core filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261105044425.87142-5-sj@kernel.org>
References: <20261105044425.87142-1-sj@kernel.org>
 <20261105044425.87142-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 04:47:28 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON usage document for the newly added age_ms DAMOS core filter
> type.  Add an explanation of how the age range for the filter can be
> specified by the user.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105044425.8714=
2-1-sj@kernel.org?part=3D4

