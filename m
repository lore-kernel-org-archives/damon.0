Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634331;
	b=HJOazvnLbHq8B3nBOBEDtLLpzceUp4co8y8opcqFhaGv4I2hl/WE/ub1YLHJrSNFA1ER
	 66NkO6EmWUsog5MVfZBo1QHO7upRMQQnuyAQq5ecNX8BRPyNnF44Y0kgjjGlJpC8iLvrg
	 j/ZpGYG4I+KRDhTw6C0qoNxkqWrRWSyZcZu11R1DJV1ar/+s/sQXw2joGmWjQ82P1QwFT
	 NTXsqU2UTuB2XTlWA9fNjjFY1MCh+LXNfNCBvARU3IeyUWSIJR6JuMG+UH33ayuL0Zx6t
	 wR8a4QTAyyb2GKLebKZAfo/AuLOjRTC3Q+JtSwhtiH4uHQS1+lj+Bz9XfR9xYr7R+Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634331;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N033n3nRa17LF5U1x1revi8HuwBciWWgJ1U/LawR/Tc=;
	b=aYVouNuuITNdRLZw1F5TefccYx9NXpOSlktN/Y0sdXsmzOo/BeEyuT1gEu8e0ieeYj+D
	 /YbIlYCL9zVOtIViNTjwSb6Jr2f0Bfi+lyoFveguuNB5G0peyE/1jU87HzkRRZOh/M6Cy
	 KEfgSP8YUNLA51iVfQb/dQv+m+gSVCScVSIEADveZARRXVhvsnyywrfUPeYjnQsGtpXpU
	 KIMN6NbpBoV+94A30r/TDd7t6RFp9nWSLPjwfgJtQDaCGCskbp+wVAOyUK8G/lihqppDM
	 T/3l9V3Gk+x2KjfL5suefjFRI/yPmJfJ+KJ0YOJoOC9K4SObTG7qCsaZyfI3X3ZfeBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5yB2u5E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9541606A332
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5yB2u5E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA7D1F00A16;
	Mon,  2 Nov 2026 15:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793634330;
	bh=N033n3nRa17LF5U1x1revi8HuwBciWWgJ1U/LawR/Tc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O5yB2u5E+ZkYXswpoJJhE6WUpnCP9iKxuv+JlEgX82/nTioxKJWy1jukMhVTyDCXK
	 AdjDpgS2R2gBP1qsJfz7Tshw7Dn6AZK0UUJeYiBRT1E/v5C3S7UsxksZufa4wjlDW4
	 NedcvQrSBBO+TthHzH/N/njRmzNmdZP4SeTBFZr2Z/NnguwZYV9J8FdjzBqr9XlwNN
	 OqXgLrdTVO8pw13TlAey975hThsJ8ez2EZUZLMz1XSm2Z8pMPklUxQGqSog6oPbYZL
	 k1Hzrjgoe+cjPrgpUOnRlVp3hQ4IVEeYdVn6sqHe5KkoBG0g2oSVNXDMgixWJAwwkR
	 bg5ihXwj04z4w==
Message-ID: <sashiko-outbox-193700@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] mm/damon/core: copy only installed probe in
 damon_split_region_at()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102153753.97769-3-sj@kernel.org>
References: <20261102153753.97769-1-sj@kernel.org>
 <20261102153753.97769-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:45:29 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> In damon_split_region_at(), we copy the entire probe_hits[] and
> last_probe_hits[] arrays of DAMON_MAX_PROBES size. However it is possible
> that the number of probes installed is less than DAMON_MAX_PROBES, in whi=
ch
> case one or more iterations is/are redundant. To remedy this, iterate over
> only as many times as the number of installed probes. To do so, accept a
> struct damon_ctx pointer in damon_split_region_at(), and update all
> invocations of the function to pass the new argument.
>=20
> Also update damon_test_split_at() and damos_test_filter_out() in
> core-kunit.h to supply a context to function paths that call
> damon_split_region_at().
>=20
> Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102153753.9776=
9-1-sj@kernel.org?part=3D2

