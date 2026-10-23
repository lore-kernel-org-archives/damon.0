Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771599;
	b=J23Eu8QIA/rUb+oohOGUG2aVfvEwkc148yNFUrgkmfD7Qjaz9YNfg5j3RIhmVrQSFEbd
	 bSWCIAlD0gqIS7hcGTLpcu2ffNDC5rCrprZiqjU3Wj6TgLQHMqjTIPij/M0IvqHSEtxN6
	 z1si6pMQeq7rKAv7SD3E16NPME5e9I3a3xquJd28G5vkjSejsJi+wa3qLH11/al2FlYSt
	 3QqKHnfLByDYSVHfpDL8/fDDL8POu8MXSuPg5cNDSPRa11kthaVj0DIJBrlylkBg9dZiW
	 d6ccfXMaBqLZwvtVIL0SnrAIhbviVV/Vlqgln4YqOqzRZfCB16llhGZPaNQByhuszxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771599;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=myCIbdvqqjqgbPWFtXi9MxF+1Tah95QnFcjDhR8n3Lk=;
	b=RAMoAUXCORqcc/B7U6m7IKyMZ2FLKN50EVNIEleehsnAMFGP/1EzrubVrSTgUkOdWGfV
	 vDNF0fgKMwuJMrJ1aE5CVLRCaEZ1PXFw7TYNDCLpgYvwUsGJPmgIO40bJXafD0rPdjZRL
	 GOZ+LX0QUrDJVv19GlhZsiKRFQVYoxgxx3LQha7YdZ65tNMWHxoRc6VDwSzcmVkdsRGT+
	 D5TeJzODMn6mqyq+aQPQ0UfQjs/W9DoyQnsRGbbprKMG6Rjc38fgWKclk8Q3lCkXHAD18
	 fmXki73ov2S4c6cijGB34Lqdo09Tkzfy03/+xX/4Z9GNQIH3UhyTVYdTtr+3UYdEPmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIKQtOgp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D4606A31F
	for <damon@lists.linux.dev>; Fri, 23 Oct 2026 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIKQtOgp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10F71F01825;
	Fri, 23 Oct 2026 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792771599;
	bh=myCIbdvqqjqgbPWFtXi9MxF+1Tah95QnFcjDhR8n3Lk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XIKQtOgpoTmmcP6Zru7V3IlUDCFHOmvESR4k5kgVHuLBGK+b+mwDq29Cu0BPVhHpo
	 3n++2/ih8nCGifDUgR8h3NGss7eMdcjrVlafE/k9EOaCTDxkrm1Qg8coYk8TIQlPeZ
	 2cRW+36djrkiVkGta14NiBlAc7PemkEU4WWSCrHA/BdafN4pNRoAl/5Y7oKsnSDQH6
	 uApbI+RRRlfdtDHjkihwuzvoVMJUQYKgdgZQInYKhwMxMYZCIOp+hIosmyTdH8LSmV
	 RFfxq/f/jpU5CXAJJm8AInm96aRvI+6faymCSCXNKVuZZayj+BjE7fzMhrZKJDgcEV
	 ktV/AyX0rfyVw==
Message-ID: <sashiko-outbox-182938@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: reset watermark wait state on each
 iteration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aveline Noir" <jm5905938@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <179277129124.2.16132047926074873101.damon-empty-schemes@gmail.com>
References: <179277129124.2.16132047926074873101.damon-empty-schemes@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:06:38 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Found while reviewing the DAMON source code that if an online commit=20
> removes all schemes while kdamond is waiting for watermark activation,
> the scheme loop becomes empty but min_wait_time keeps the previous=20
> positive value.  kdamond then keeps sleeping instead of resuming=20
> monitoring without schemes.
>=20
> Initialize min_wait_time and init_wait_time on each loop iteration so
> the wait is calculated from the current schemes and an empty scheme
> list resumes monitoring.
>=20
> Fixes: 6e74d2bf5a26 ("mm/damon/core: add a new callback for watermarks ch=
ecks")
> Assisted-by: LLM
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179277129124.2.1613=
2047926074873101.damon-empty-schemes@gmail.com?part=3D1

