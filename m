Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667690;
	b=tJmjU3sZI+dgtb94DVMhePGCcbjdw1VZxcEvD7x0q4waw7zUfkVUyYdXTv9fwWjpw+Yr
	 12v0f+paW5446uruCLTEL1isHq/A4XonburZqPeIwlvf5rjLtkw/upZPVIMTbc7mIQG3V
	 GmW2hwv3wJ4hZmiNMjTmNe4xkXGarF7sIZTxmWh6grKWup6PGXKWy6Uaza3v2daencSnX
	 Gy2LbBLbqOUeMKJwlD+Hzu/dslxax/G9r+C47XSbK90SO0HW4vHbsCxGFW+SbGv3CX+UW
	 mi8AR8cW5T8zNJerLF+UJqhnDBMYgZCqhxqeQg+RjmAiTjggMD90s5jzZ6fU5NovOtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667690;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ULO8q096KRqaIhVYMSMsGGDVOX5EF7DzgLWYVq9xorg=;
	b=HZBCNEinYRDapcoObfN+2YBCZZ4GaYCRg569wVEQMCuuVCujXBMHcc6ImOstxC5ZIMhu
	 Vf0LIZuxdPzBvqh8w2ehWq7UYWzsPLKwntRCUEuSee3LZ5cYtFMbxPWVv9BoUHs2HYsMR
	 +g0S3w2vOwWnSyfKYrVZMR7CDhVkbXDB9swAv3Vrng84/XcXGIYFy7mhJDVezdQnAxaz1
	 +DYgenRXFrmyh+odi0cMgaI2zPub+fqcrZgERlvcO5QuIfvmI2+WhKc3187jaL4Edlfqv
	 DG/DiufQ6J4clLiI4qb7/zx57xC7MGSG2WeBFVmH8QOV03XjLMHjKULOKzmOzRAqwnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DSIS0zFq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964D0606A324
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DSIS0zFq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E8C1F000C1;
	Tue,  3 Nov 2026 01:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667690;
	bh=ULO8q096KRqaIhVYMSMsGGDVOX5EF7DzgLWYVq9xorg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DSIS0zFqbxUGLYLLf0Rf0Azbivf9IjuiRXk9LYRTZ2b1tMo5S2q/a/JFmScabqr6v
	 xUQc3ECdYZN/+ExsBeMq0CldkzZ9pc7ohDhX8Kcrwlz1IJWTj+B6m3Ol6V+bZROBX0
	 FI8e1vTcFBg18DGutvdi4NGczWoePe5ACm+Gtb4hRVnNpUZba008j5hPI97vi99D53
	 q8o3vBuGteHC++gzuy3qKmvhN7mzqqxJ3frw+YOnuHbwkzaKaLjDz/y6rLa9YcCWlw
	 SSv9AeES/zK2S27b5T7i6mlYJldFzhoyEwQQAe76VGBoAu4nNLoDsQGCIzx5afIyRN
	 hL6nq0DGmHNxQ==
Message-ID: <sashiko-outbox-194409@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/8] Docs/admin-guide/mm/damon/start: fix grammar
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261103005940.91432-2-sj@kernel.org>
References: <20261103005940.91432-1-sj@kernel.org>
 <20261103005940.91432-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 01:01:29 +0000
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
> Fix a few grammar slips in the getting-started guide, like "make DAMON
> monitors" and a region "that has not accessed".
>=20
> "The line of the commands" used to be "The first two lines".  With only
> one masim line left, I make it "The first line".
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Manuel Ebner <manuelebnerli@mailbox.org>
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Manuel Ebner <manuelebnerli@mailbox.org>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103005940.9143=
2-1-sj@kernel.org?part=3D1

