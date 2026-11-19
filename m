Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078225;
	b=5nlJDmsvyiw9L7MhZtJQMRwyjIKgpBh4y0YXywK0+HfEceilaPhKE7VQPINBWsWyqhsx
	 JT9Dw9zgF2j2QlGXhZkYAW4jm8qusOmT44zN4+M0rzvDFZtL38EXybyPACL+4nQLFq7ol
	 sWRHRZD5khSrJa8XTnZQuGvJFdZrndBMZndvIYpgxhXAjugD54tQ1AywIJiPTe9WlSQOL
	 XS9zp7B+g0fx5Z3RSO4uulkWWcNTmw4rbofd8m7A7qG5jnxndyuJs1Mjqy5loW57GD1Iw
	 nVh8e0zN+XcgB2VQl7JOlu7lMB3Xjyf1prctBzoIzR+L+YXL6QXKylLa/fsEd9VNsAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078225;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=izi36xWn5SoJc4LGcJaro6G/sMWPTJTjSmrQbpXWeMs=;
	b=zE+A6H2rSDGmlQoPV8ACkBWjz/z5qFhP2zb5yNmDWR1VSwKAB8kvcpesqTN1dKqWlPnz
	 pedQc5HJ9k4EvL+Yu3xVqj4sanT4qG1v6dJqVKcXtO7S5n3Cw5J4ApWPYeFhWlMGsZp31
	 TNsup2zBG3GEJlOfPpm2uI5u9SJZSJiEleBU66mKrhPdvHspbFhYdwgvYJNg9Fyc3QUoj
	 0ETz0+ACwnSth4rg8TflvmN5Ti197CKD6+UgV3igktjbgpLs0CR810XlYCWUZSZTfdnNH
	 M7dxu0slwb9yFBq70ZL9jmreN4x059yAW5w59Jy2LlJyJ8sEpHvU3JhuYjq2Ou0AZpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBR0ZJUA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B362606A320
	for <damon@lists.linux.dev>; Thu, 19 Nov 2026 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBR0ZJUA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213BB1F000C4;
	Thu, 19 Nov 2026 08:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795078225;
	bh=izi36xWn5SoJc4LGcJaro6G/sMWPTJTjSmrQbpXWeMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bBR0ZJUA2iGUKX9xd3q6BBLF73NJj1j8EfoJDvfXEhawmhXS8mPnP7DpVbBypKGtN
	 ZU0dY58Onzhni+GuRfVyA+5FslaXXJTqiF5f+P4XzfOIKpQGl00vK57CxWG+BmZ8Im
	 /y9z2hCyndRnyRlxUjdw6uSitGn6pOI2cWjTTAGnS06VwEGe1nVVdl6G203rpF9qnf
	 bciXeCygbCbDVWw5uc0DbTp4vEQHmjtroPq1ELWXbkaAL083KOByTsA8tLG8U05H20
	 8ogH2PUoB41CJVThCb4jmqF9ya/lxkds/WRaraDqmchS7+N++/8L6GgsGhUyzUUHm2
	 vqNPwxUQibLmA==
Message-ID: <sashiko-outbox-222725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: skip apply_probes() when no probes are
 installed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aveline Noir" <jm5905938@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-damon-skip-empty-probes-20261119-v1-1-ec3e81c1f26b@gmail.com>
References: <20261119-damon-skip-empty-probes-20261119-v1-1-ec3e81c1f26b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:50:24 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> While measuring vaddr monitoring overhead, I noticed that kdamond calls
> apply_probes() every sampling interval even if no probes are installed.
> The vaddr callback walks the page tables for each region's sample, and
> paddr looks up a folio and takes a reference if it can. There are no
> probe hits to count in either case.
>=20
> Skip the callback when the probe list is empty. Ordinary access checks
> still run, and installed probes with zero weight are still applied.
>=20
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-damon-skip=
-empty-probes-20261119-v1-1-ec3e81c1f26b@gmail.com?part=3D1

