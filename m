Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633493;
	b=iCp+mi0nsnnTjVnO0/4LF0jGT2illZN6gdDP2Ejr0+fYigxySxUugvMIQ2MvPlKsMmON
	 SSOSyyh8OwK9hyDDKpSqzUhcAk4wexDXcK30MHSQb1flHrK8DhBqAf+oLtpd5xIQ+St4d
	 feLRjUni3Wh5hBucSlPJ0WCzABuLrZ7fmQZUFFiyn8KaZ+D21e/vb0pQ4WQ8vlZl7pv6r
	 tm839sO7eenE8opYPGMVf7KVhM4IC8sKbzGk3CG0nYC1WbazsZekjS92a10NNMkRlMhJN
	 Sp1x4OpYFKfnGzi1LUKsiRmrctl25pEDIdRcID5L5N++uyBc0W2kPJwnHpXeL1h4qVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633493;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L32s6S0vUKZsiYS7pN7hr8gAcikEUWWmZIDjAqEYZW0=;
	b=TVbfRUGL9pfKrfTWghIwHIPDetszkWg0Ah+3YbcVITASXOjr8qlWODdBMvTC2Yxyhplo
	 7oHFek1/QdlzkabH848pf/ltdAdWnPYKyUbmEZr6rsTNBlQc9SFFHCQu0LdkshSkNAfqx
	 +KbhOebP/klHy+s954bUBXkOX95JafyaoS3PZXQGEtkkh8MHpG8lTi2nId5kMrFUbAM/E
	 xqNNwAeUPa4WoRO76P8SvM3VdL+l1lEEr0yIn9CFeRHycucdLM5GPN955iAWImjC8wIJD
	 P+/Y/QlVLUzH3AqUuX0uvq8ggeIBrQ3yabrPKj6scIuGRgmUvsMseuPNdbH3JHg+PVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nvG5R6ZD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E9A60D5454
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nvG5R6ZD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D761F00A17;
	Mon,  2 Nov 2026 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633492;
	bh=L32s6S0vUKZsiYS7pN7hr8gAcikEUWWmZIDjAqEYZW0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nvG5R6ZDPMwH2wVjQZpK8fjdI+B78aM7qYpf3uOVesGkjiUqzQDil9G+KKVzhB+Yo
	 qgUeqGrwGDLMB6vqLqxuS2Z4R5K95GqhS8vkCFNHUKEqa258MgsZO5vRNxMHSzksPE
	 zH6GkJCIEI/uHliUGY7EAcJ13CQ0NxQ6dWDolULPrpVsEVfaXZdIzQDDXTdoMkVsRw
	 3Yyk0qQhHvm2n4nzYJzFdCscRGdKzy0iqOm7y4tEijtb96vQLDyBOlm+P3/vT1BAh9
	 cbbEKvaRS50j1d91g9ebAHecDQR2S1B220pvl5TNVlye+tXY41yZt/sgtItDJuUC2k
	 diA2ZhC2c6r5g==
Message-ID: <sashiko-outbox-193670@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] mm/damon/stat: avoid 32-bit overflow in idle
 percentiles
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102150757.93058-5-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
 <20261102150757.93058-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:31:32 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Aveline Noir <jm5905938@gmail.com>
>=20
> On 32-bit, accounted_bytes * 100 can wrap before division by total_sz.
> Some entries in memory_idle_ms_percentiles then keep their old values
> instead of being updated.
>=20
> For example, a 256 MiB i386 QEMU guest reported p0=3D19200 ms, but p50 and
> p100 were both zero.  The issue was also shared with another mail [1].
>=20
> Cast accounted_bytes to u64 before multiplying and use div64_ul() for
> the division. Compute the percentage once per region.
>=20
> Link: https://lore.kernel.org/r/CANOyQmHad1vamnZT12M5yPrJ69=3D=3DPt1U0+MG=
w6u0MuNtr-DRCw@mail.gmail.com [1]
> Link: https://lore.kernel.org/179207592479.3.11595453180868898703@gmail.c=
om
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102150757.9305=
8-1-sj@kernel.org?part=3D4

