Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793335726;
	b=C1AYbWxMeZzV5ox1RRhjCmuVoWCaxxTl21d7WsnwhPFEutRgcAyDEcZSJNRBUSAU3yYi
	 qLENHZe0FN/4U/FT/6hrTSMuDtTyhw6hsSyQ+Iuga0RxTWp91BfgnobfcGNXSqRIClUAr
	 PPMLXzIyqRfkp2CKvuNIQk1uzvt9mKgKVlLr/BxPZaEJ4Q4a8HROGP5/UynyNBcKWJj1t
	 8kYmq+UQxOOYSKJCZiWUdy1rhARnmzNMdLFFLC6vHpDyLv/BlS1EPrmUsMPrfnwbxQrmv
	 4bolyjgWyJxkrSHDGp1atNB9J5QlYIFbt/91fjewB0OvBk35udyvk2daVYzkA0ym1Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793335726;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BOB0P+J5VH8VIl/R+x+pFa4s5pG2n801TWJbdKsASt0=;
	b=OXkcgreCSQDwctAQqBeowXS8f96qP8nfhgUZrlub1adkpF1auzJr8iRYg4+dEL5vEY4J
	 FLJY3nk2UPBb2AE7+BRhiHGB3mE2BUvPLnNW5KLHfMdsbg+Nsz62ILrZLiiVsMN/M9hne
	 m9XCFgp2/jH92+ct5s94+/pPouZ4sE3rdxRbENFZ/WmPy6HV0GtxClgn/miJTHZyx/EZn
	 N52DtvpFtMalObDA3lII43ytCLvp/grlMEAYQk9Pary4cDbOwzq+/f1dAuRou6mGb7Kmb
	 by7A0jXQgUBhcIyjlKja9zqruIzCbgvM4Kx0N4EVRqupEEcmjcsDvO6yYJ0mLuue8yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAR8Cf5T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4268B606A31A
	for <damon@lists.linux.dev>; Fri, 30 Oct 2026 04:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAR8Cf5T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15691F000C1;
	Fri, 30 Oct 2026 04:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793335725;
	bh=BOB0P+J5VH8VIl/R+x+pFa4s5pG2n801TWJbdKsASt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FAR8Cf5T0tBxMqtNuUsPl17qdecqJL71k+xKJ18nTiwfHrMA9ZefXyAY21rrETuj/
	 7R14/c6V5Ey/t9OlDn8+h4ILdKzjhoaONWVcYgUL9knc57U9a7C8Q0nYSrcGdY4d73
	 Kz/1iAHbvlvC8e/i8qUZINArh+cMTGxUvPEcvmdcgA+jHrDPKBp/yphTWRL038oHna
	 qwYbAyDyE+xfm8vN0s2bmQ3b61fYSOOAsyxD5ZKEtXG/E07VI0gqUm8dsaF9A8DssI
	 PAFkNVZuqnwN2mYxaEy5guOizlPmMYpoOUCtUT0q9Dr1tsRWk6FxI88KLS+MZDh518
	 /WVJC/G3eoaKw==
Message-ID: <sashiko-outbox-190316@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] selftests/damon/sysfs_memcg_path_leak: define
 ksft_skip
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261030044643.157105-1-sj@kernel.org>
References: <20261030044643.157105-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:48:45 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> sysfs_memcg_path_leak test uses $ksft_skip without defining it.  As a
> result, the test is marked as passed while it was skipped, like below.
>=20
>     $ ./sysfs_memcg_path_leak.sh
>     Run as root
>     $ echo $?
>     0
>=20
> Users who run the test could therefore wrongly believe the test was run
> and passed while it was skipped.
>=20
> Define the value at the beginning of the test.  After this patch, the
> exit code reflects the skip.
>=20
>     $ ./sysfs_memcg_path_leak.sh
>     Run as root
>     $ echo $?
>     4
>=20
> Fixes: dfa3cf0bc018 ("selftets/damon: add a test for memcg_path leak")
> Cc: <stable@vger.kernel.org> # 6.17.x
> Closes: https://sashiko.dev/#/bug/linux-a0456336-0608-4fec-ac22-0ee61d1d6=
a91
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030044643.1571=
05-1-sj@kernel.org?part=3D1

