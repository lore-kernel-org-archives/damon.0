Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633720;
	b=uUb1jr018+AoR9WFS/i/ogo+oi0CB9DHVN8a/8aXOexdK3HZN1XRdiJ46wY+XARHfQdB
	 5l2hiScg+kDVPwFK90/iMF4fMZGb/zAQgmv5hvf3qk7+u2KWP7jp7+LtH5kDpQ4J3jI9P
	 GyUGZumiuOrewmDYOaQbHtS+RsF7ydOESEg4MX3apZ3M4eGiLm2fzms9tHUvbxBiGE+2+
	 dohYG0PqpPrIznprdl3qs0J+0knj7VypM1dhiQz8ysSPR84MLWCAS2jHPHruAZl/Rj2b1
	 p5hPC1KusJlfHNA1d1r058g3GWSUfezvI8J+x/YRN19Nn/mpvyfPv6BuEbAxTSYQbLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633720;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4Kx6cnkg+ffkcMFdDLtYLoFOKMBC6uYRYC3NKrUDa/w=;
	b=J4I0t0uuSvlciK+CGfgdoN1UJoreQjiA/PxINEBYCzH1GXHTBMrxRJMgxUFvPUqGTSSP
	 TZ/DwNmpOc+lj/srDhu60VU6G44oejq0O+4fygqOO8TrmcvXL2VhHIFHoVqOiDSHj232k
	 +hf7CB+vWymhG6HR2NkkZVYZb9SBzQnntDF7v107+cCWq8xUr473H+uJxTClTP0w0c3Sp
	 9lm0L7yrtLkmvqnmgTxVF5Qdf4NlLQ7wlMefgg7cGO6k9VI37YMA7VlEkolRVdQk7S+jL
	 DEHh8ZyCRC0K77QWssW8DuiQNJws/ReunsySVoLYecccLC4RjBuC51jKzpFrc7sepLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7lWMx7U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E56D60DE998
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7lWMx7U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535871F00A16;
	Mon,  2 Nov 2026 15:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633720;
	bh=4Kx6cnkg+ffkcMFdDLtYLoFOKMBC6uYRYC3NKrUDa/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7lWMx7UuuKG0s3fZz0fuHGE70ypWN4hVgmaJwn9qlstvt6qMXNC2zOmmEOlxgm3L
	 C7PlPMPJR8zNrefGP4Hk5Veo77Ffgo6kVadagEr+mntVsrWVlN2iCcaHkujm9I/LqH
	 W95d8qvQLNotZKssbyV3YnsR6Zocqw2QLxkrR4wi6i1wIJV8PdakrTqCUTSdLw4/xI
	 VmsaHzWl0eG53ott9OP7IO0kddVikEEg1cA5D1LWPFH4rr1InjiMGPAYyYYY0K6Ivs
	 kEFfTgFXuDXQimpzBwBZ/aX2ceDrnvwBZFl0rtfF4VNR4ng0Gai03bY0qYBSkuE+za
	 KQwLudzALf5SQ==
Message-ID: <sashiko-outbox-193678@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] mm/damon/reclaim: fix typo and grammar
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102150757.93058-8-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
 <20261102150757.93058-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:35:19 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Manuel Ebner <manuelebnerli@mailbox.org>
>=20
> DAMON_RCLAIM -> DAMON_RECLAIM
> set as -> set to
>=20
> Cc: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
> CC: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> Reviewed-by: Enze Li <lienze@kylinos.cn>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102150757.9305=
8-1-sj@kernel.org?part=3D7

