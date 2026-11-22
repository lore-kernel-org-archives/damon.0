Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795307635;
	b=He5B8tTISqz30zrhPu/pPtBvZhHSUz7ApodQoheF5/NhJTF2xicXExKks/2jJoCiiYMc
	 o1rxUZmVudnN6d7qa4fj3U1fCkCyofshYjGCpdS54br6jIV8PIQn+9mbXG9ZQme5RdJV7
	 V6XdoFnKBpWIpcDi3p71op81sDUQg4M4qom4WuesF9sreVR1WrJagx/XeJjfiKpI83u1R
	 tZ39sxEKIvNBm6+NoMVfBwLOY637xuVkFBj9o9q5X7nNkMX05i7DyMC/Y/l33cO+hDpf8
	 irLTn19BPMCvw5MFOBRKdbKFNwehpJxqWBHMyotpwcO40p+QgEW9jNj8D/jV7IQ9afA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795307635;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S5Vt0J2ubXWPNOQ/Q8svA+1mKnl9uRHMUsR9p9nrE7Y=;
	b=IANj6H3WCTKuOVbHNWPsTzmOF1DqWrX4AiO2826So2u9QMr56H4RjSOjqZY6zkkDUhAW
	 kt60FI3+VThvK/89WwdFnViwzBq4X5VfM5cC4FtShuZs5jN4hvgHfQi4BWb7Xcie15jZl
	 Po1qaRMfa3jlvdTdZQ1Y+rtsom1WViCaVPmlTGbsslLGbPYB8DU7VVtzHfQ1FfJP78dlG
	 Hqf+kifomVzymkbdgbaK4IT1Xo4LxuQh0SbfSAzGA9uz7+SMfZ7ue3b2r6nERag95bAhc
	 tUYf4EMkMKkNAKooGLFsBEI4xxCn8jVKION0XNnYRQrHIle3XFtqbmOWZ4t5SqGAL6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSXwUlls;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB927606A320
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSXwUlls
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD461F000C6;
	Sun, 22 Nov 2026 00:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795307635;
	bh=S5Vt0J2ubXWPNOQ/Q8svA+1mKnl9uRHMUsR9p9nrE7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PSXwUlls1W9OoDvbmmk77MtqrtM6EKuWSHmurqunRvwLU9aV56RFtk+1+W49Hk9CQ
	 WJJhqZURPWhZwz8No/FVcNNXGHxsaBWHnjoXjPMLZlZ+k+CLgIBerCzPKXxH0utKJN
	 xIntUPZIPo9b+B66pelSQGky8KUUEZwEPpHNVUI7xIcd7xHGIRrYSEDPG2/+HsDNkD
	 2KuVe0dEBM4z20LsJ0cHTz5jqy+fjCcmXYwV/CKJn9bvPlNjkigBgFEuOR7VQ+p/mJ
	 OElzTVQ9wkTQ/jqbKGGR3Y2eG3AJmxAblZTl58Evnka8DcmmM7t99hPCJyS7uuXLeD
	 LJzrCWYzfhipA==
Message-ID: <sashiko-outbox-227574@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: do not overwrite wmarks.activated in
 damos_commit()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yifan Feng" <evanfengff@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261122002930.98401-1-evanfengff@gmail.com>
References: <20261122002930.98401-1-evanfengff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 00:33:54 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damos_commit() copies the whole wmarks struct from the source scheme,
> including the private 'activated' field.  The source scheme is a new
> one, so the field is always true there.
>=20
> As a result, a commit turns on a scheme that the watermarks turned off.
> If the metric is between mid and high at that time, the scheme keeps
> running, though it should stay off until the metric goes below mid.
> DAMON_RECLAIM and DAMON_LRU_SORT use the same path for commit_inputs.
>=20
> Save 'activated' before the copy and restore it after.  Do not restore
> it for DAMOS_WMARK_NONE, because nothing sets it again in that case and
> the scheme would stay off.
>=20
> Fixes: 9cb3d0b9dfce ("mm/damon/core: implement DAMON context commit funct=
ion")
> Cc: <stable@vger.kernel.org> # 6.11.x
> Signed-off-by: Yifan Feng <evanfengff@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122002930.9840=
1-1-evanfengff@gmail.com?part=3D1
