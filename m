Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792870749;
	b=O47+SxOB8PDUMu+mIAeUv2FcQFcJFGo1wv6a5NZLHAZjj/LniTEZjTAjWNQ4VqEPcLF/
	 xnLor7qo9WxqFv+6m3GJk6xvZk03/Yf6bemHvhZnFYj2PGnYJfNHrV6H1rkjHGZ/8Pd0F
	 o6ZmY3cZp9PKWfnkVrltTctjXMesC4O5gft5ICS5/v1aYwN6De0plPbOz6wJO3fhYJArM
	 9s0olx2T2bBYqhD0Ue+wCFapJbM9yFVPDbcriMmkzXehCfradGlKeFHa9PqOIPFptCxRL
	 kW3XwgUiOirNpZagupHHR3Xv2sstsRicMVp7IyG7FfM8xv7F13ySFBP5ezshV1B4osA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792870749;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y6WQkeLhoAUDzk5AfQnCIESDXDAqBKuD/VOpcZ+jJ9k=;
	b=Wfy3qGKlQIKsgxR7HTNGuad8ocz772ZhYl2OBD2gP6dn5rWAKVFrnOl9L5/a44BvfOjm
	 ElAJ2Z5Do7prAS9/ziA8KXWq0Vgd0XFvnQyJeoPRcSDd39yJyT6hL9L+TxmHgUR4zVhwD
	 11LP50sThY7wETWApCxJ5v5GRV1A3c/byeoMl6/NEmMDbYrWqzkTEVFRA4NwsSjd0DScD
	 0DeNsK8e/VqCifrArU8OsOsUXEB+FgKQ3QQNgdrGhwpkvKfcmA99LJ3B7YGTEs5QlaYwE
	 DOff2VLHRQWixSw2Cw6tfw1/uZxgV9YNrDXjRFzrSoP5NSmcsBNJ62k5zA1zQPezzOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fbdg984b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A0606A31A
	for <damon@lists.linux.dev>; Sat, 24 Oct 2026 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fbdg984b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFA51F01825;
	Sat, 24 Oct 2026 19:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792870749;
	bh=Y6WQkeLhoAUDzk5AfQnCIESDXDAqBKuD/VOpcZ+jJ9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fbdg984bzZLjWGXTRBOlcmrsTSlwJB5LsjggX0D/HDp80DI1xAy8QGZWQv4bPY0bk
	 ZmZDOe/gNjJwszA+tGOtbAq9zf6b2vFUL/RE9erjNFeZR9BQNTRihAAsQ1wq3/yYLB
	 nTwSHJGeml1XnB7Rtbr1ZAQ+PUIeIlwNzj4ziLVS6R4/6NAYIrh3tk4nkwkL+jyYup
	 CsREFWM2QcPYfB2k1RIAfUWRYAPxJ4DEKQ7PVBiYo+kdKqQ2JIx1fcLilsdviv1kqw
	 V7RSKQdeoZ2z4ff3YDLVdbNZ/RhsT5E6j/ECxnzksAoTpXy99BTYxT+ZU3DGs2Vt0h
	 qKdbLNvGPgbsg==
Message-ID: <sashiko-outbox-183858@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/3] mm/damon/core: move static variable
 last_nr_regions to damon_ctx
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261024193351.87130-3-sj@kernel.org>
References: <20261024193351.87130-1-sj@kernel.org>
 <20261024193351.87130-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 19:39:08 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> kdamond_split_regions() uses a static variable last_nr_regions, to infer
> if the region boundaries are too stable.  If it looks too stable, it
> does a more aggressive region split because it might be a fake stability
> coming from non-aggressive split.  Because the variable is static, the
> inference can be racy and wrong when multiple kdamonds are running in
> parallel.
>=20
> The user impact is not critical.  No crash, no leak.  DAMON's
> best-effort monitoring accuracy can be degraded when multiple kdamonds
> are used in parallel and the workload has certain access patterns. Still
> it is a bug that is better to fix.
>=20
> Move the variable into the damon_ctx struct to fix the problem.
>=20
> Fixes: 75c1c2b53c78 ("mm/damon/dbgfs: support multiple contexts")
> Cc: <stable@vger.kernel.org> # 5.15.x
> Closes: https://sashiko.dev/#/bug/linux-eebfcdde-2881-48ef-8df1-e2019d2a4=
7f2
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024193351.8713=
0-1-sj@kernel.org?part=3D2

