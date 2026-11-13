Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547182;
	b=p2etbmM4yhpxEtj1M9paZQTAM+zOnx2GPPn06zntdoGt5Cm7b9NXnBev4u62diHU8wRd
	 1sp/TTFh32BfUo7fhk91M1mcla4+QvvIG5k9iO5pTQbQ/aHVkM7M5Q77vOq1g8T3ULyAd
	 pI+FcztW5dZPHnQjo6y70MAetMCoHtns5lfyzOnK7sqAsjQ5USgHnrynYbObD4umfoRrU
	 NArr53P0CbdvuJmXmjAL4Ry/DV7gUKuZY+DPXO5a1iQHb1L3NqEPAcRJPuPUKv2G+cjdp
	 kNCko1FKNOKHSuhBUxvgm/2yUc/pbUuaKVzdKeMJ9DvQMUnmIOuKbz4m0zNXkVp6lJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547182;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5ZcyNgmy/SPfasYBFdMnzLixsPWLcxTmQZ/PEc1YGqs=;
	b=TN/fQGG+phCmZ3QKhcl8iBZrjbLy3sG/BiAiR5amTCNEJu7bdSBgC5J5IlLxWjm7FRDg
	 7UhzQmaXY6ouGdHnIEDcNkDKhntgR/kBDvl4HEScLDzNHNMAZRReCyDQBGNePI1AN5HBh
	 RoI9tdC4yy1XNxw9mdbhiUG6yDFnlG/8FHO8LOEiRQOqe0DTjOkjck+9JiIo+AxLZ1M1s
	 8vUdxAY0yrK07h6QiJrfDT7wXy26VvbXOWY1AhCX4aLSZVQRODgCSMtwmvpOUkUcedx6P
	 Ex5ChU7WaxOfW074a6YLom3KW7wYKhUgvqY48rOpHCiwTgG+k/f3E3JbQ5FFLfEYxDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SiBOU12X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DA6606A31C
	for <damon@lists.linux.dev>; Fri, 13 Nov 2026 05:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SiBOU12X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550781F000C4;
	Fri, 13 Nov 2026 05:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794547182;
	bh=5ZcyNgmy/SPfasYBFdMnzLixsPWLcxTmQZ/PEc1YGqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SiBOU12X//J2xZvy8U92VkA5mxjOgLehli+rI3F6y1PWxpdA/E3Nt7+kbZ9LK1BM2
	 IU+ebTi+he17S7TeBBZAuEqMd6Zv09L0n0z1a54z99PKvfGlYJjaAhLNzYL6vGynmS
	 1D6O5AJttQAQfxOS/QOVlX5vpzs1nebWzv5AY5ILXkSaD8kqqG0zx0y358kaAxKP3p
	 Gh9PMkISwTW0nRRng6giyH7MO6QfCJlXPD6fZ/cP1MO7L81ShlRwRXtTmqY+zoysxy
	 JYNDF1lc9Bqzv4A7/8ob1UAp4oEjFJ637wfoPUbVPACxGRQZ1XkgAs0mmstCVhhYyY
	 rmAXEYJdQ9n/Q==
Message-ID: <sashiko-outbox-212217@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] Docs/mm/damon/design: update for
 DAMON_FILTER_TYPE_ACTIVE
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261113051711.89274-5-sj@kernel.org>
References: <20261113051711.89274-1-sj@kernel.org>
 <20261113051711.89274-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 05:19:41 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON design document for the newly added LRU-activeness DAMON
> filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113051711.8927=
4-1-sj@kernel.org?part=3D4

