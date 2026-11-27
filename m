Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817334;
	b=VIi8r7UVzp2E/nM8cFiS3FvEfvVSWriU2OEjAm4ReKc/RcuaHkbbN8Sy9SUpD8i4uvP+
	 nfAgKuYGj3GjmIm39gkm1Ubhlqj2QhVOciv7OOOx+DRBs0fdkoWOtuQunTqabcOGxv+Kn
	 a2egZuGo/A/iy35p+DrlUkzgdmeEbBsL6Zx+fvDw+7ImCXMLVlqbUVh5ceZYRcCmGszTz
	 0yo196bwpEW/cEFLq0CAPAEvh815hIT44FNBSDitr79NtALhfakYAdeP6Z92pzUNHsQXA
	 Zgj1dE9jdXfrY+Os8Tzi0+5zg6RHZaFiqMFwqUXElLLEo1SyvEZo7I2rbsERo66JM0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817334;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ox3siBKoD9wrVnAUcaXa6vuV3EeHMRtdbta2mqyHbPQ=;
	b=KtgX4zzNvJXYGcCSV5pmpxQqOEhy8q6eVSIELDeZ/m70d/C2rIK3IbsKB+KXhxO3X3J1
	 HNuRx25bHxL0fo1BgxMTM74XXQOtubcYaJOyUvaOEtI9cHYUL9Q43kRCLUPejCJyq28jh
	 uSTKrXE9ER0+CfOX5vU32VgIN33LsVtl1xcuVSwK6lz9jUe7pLkeouaO32NJnx74Q+f/P
	 KfCh2LT3lLkuvmyAmrBLPHdx81nW7nr/XGSQ+lFnp/O1F1U8DJ6SYY3w7tHuN0x7yLpuo
	 irwC88pcR6um7Yxi+pgnBkJWk9lZscuynLN66xdbX9mtC2PO6BeG8ML9NSbAncfJxTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnA5rolu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF4606A31E
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnA5rolu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B681F00893;
	Fri, 27 Nov 2026 22:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795817334;
	bh=Ox3siBKoD9wrVnAUcaXa6vuV3EeHMRtdbta2mqyHbPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DnA5rolu+qG5dJb0STDqXfFSP91vkjw1rGLZs20UhWLVUU0AKCi+haTZDPBta8jGC
	 rsl+Pdk4F57W5J9nzfuvXCg3QuJh/ZDKsoXPcGw5F8YAyZpf3vyPLxGjY9dQIdfB1t
	 Qb5IfXE0g968xxcPGd63FUIp0qA+9Nw3W9zWXmE3BaawYamRCX1+w+mnRKhqnrwTyP
	 srLJ65+7IQOX/gnTuoCVOok4a3gT68FFETydU0zquMCgLtr17wWV6KTSvZi8sUkDw3
	 iLVB2wnLHwqFwnpQGs+aGstUXYlMW4KIFyGI0TSBHttzwvCmtVmP+rvoRkWCA4pyZC
	 tkgrQUZIdEuRQ==
Message-ID: <sashiko-outbox-238321@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH mm-hotfixes-unstable] mm/damon/core: let kdamond
 freezable
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261127220255.99924-1-sj@kernel.org>
References: <20261127220255.99924-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 22:08:53 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMON's worker threads, kdamonds, are not freezable.  If DAMOS is set,
> it could migrate or reclaim pages while the hibernation image is being
> copied.  It could corrupt the resulting image.  As a result the system
> could run with the corrupted memory after resuming from hibernation.
>=20
> Users could work around by stopping or pausing the kdamond before the
> hibernation imaging is started.  But it is easy to forget.  Just make it
> freezable.
>=20
> The user impact is quite bad.  Nonetheless, the problem is only found by
> the theory.  No real issue from such memory corruption is found and
> reported so far.
>=20
> This change was originally suggested [1] by Lin Ruifeng.
>=20
> [1] https://lore.kernel.org/20260408080652.1745410-1-linruifeng4@huawei.c=
om
>=20
> Fixes: af122dd8f3c0 ("mm/damon/dbgfs: support DAMON-based Operation Schem=
es")
> Cc: <stable@vger.kernel.org> # 5.16.x
> Suggested-by: Lin Ruifeng <linruifeng4@huawei.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127220255.9992=
4-1-sj@kernel.org?part=3D1
