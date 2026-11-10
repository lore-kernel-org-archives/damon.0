Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323898;
	b=4SIQLEAOwfawzSB70obDxIsPYBZYrMbQJSO/qwxqnbpllsHXk9NwTpoCoycSA7Jwx+Zl
	 RTShHW/fIlECKP7AdeP96pAOnBN8FCzNXb891JcxqXhfyTD1wfFWgpNDB0MWi1Wp8wnZT
	 OJMNB8VrYKZJF3Jhj3MkTaW6F+ETT4Zs5itcJ6vsdnf1ElOqzmVXwa0gTQgofDntSOlse
	 vmncAfFSF+nQhkAPJq23ss+f8kQEpGYOwJ1I8UEHSlqI4URlvymxgXmP2xYVmtuZ5mz7a
	 LIGP4iugXXOnMuDdofWVFhuNPe3LFU1+AtiIcBEKes1w3oys/wEkwatsrx366Iz7oaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323898;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1l6xnI3pplMQ5fNPtII3/PwGcPbjMSVmoWDR9mkWvOo=;
	b=B4XKI3wyTMxNT8Cc2IHZWtVoQuFy0Fsx+D5tGQ9hRFmkj9l/LiK70vhLLovzK1QgvaEb
	 URYcLkGKaJletgTvfhXVtzLmzi7AKv0zNUjM4k0+WQsdzVvRvDqBYUI9G2qB7efsc7AWa
	 YNNpwa/rr5uAPjGYNQQr2w6DWFD3/fAtEu3syTJxIVTdvQXk3aC3x0ypaaz7pidqM9z5T
	 bD99rp7jct7Q2GE0ikctixWEn2AkH5wROJWYnIYT7FXZFr94eY2qu9EDuzTtOGXpWUME9
	 3C4ZXTKayaa7AURQN9MLjiM+KUF5Sg3q9nMuKxvyVYOXkXQ1rirMS4ifNv3gjqX7eEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j05Aayfp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F6606A323
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j05Aayfp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D3F1F0089F;
	Tue, 10 Nov 2026 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323897;
	bh=1l6xnI3pplMQ5fNPtII3/PwGcPbjMSVmoWDR9mkWvOo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j05Aayfp9oaf71chPQc93cxzl2sVD+hf36HAJLbERUeN3UmJ/yMhHiKw9uA7OikXn
	 kfiupV6L53KKfR8V4mJfVhQALaAD1O3h4/bX7wcduJvAdghQVREedNNaTHfztHbpNq
	 vhwKUP1H6LjAv01HtXZ9o0273IZBwXfOO6vKxuinw8Tgj0nXk3XZT3GFIk4+cFhtCH
	 ECIedI8QW+0QYKEZoxD2eGGoIGktQLhYpRdcUP3wqbTDgaq6ISzEbcnV3fo9H2fQwM
	 9PWeN0SoMo50Wfn371fwSYB9fkmBGM6XU1LKbjsJzeI36gfgW2SW1M/yHVgT0QWZ58
	 gnVsx+WjfWOVg==
Message-ID: <sashiko-outbox-207247@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/core: move static variable
 last_nr_regions to damon_ctx
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261110151439.154208-1-sj@kernel.org>
References: <20261109201705-failed-6.1-26ae50a0901a@kernel.org>
 <20261110151439.154208-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 15:18:16 +0000
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
> Link: https://lore.kernel.org/20261025164808.152048-3-sj@kernel.org
> Fixes: 75c1c2b53c78 ("mm/damon/dbgfs: support multiple contexts")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Closes: https://sashiko.dev/#/bug/linux-eebfcdde-2881-48ef-8df1-e2019d2a4=
7f2
> Cc: Fernand Sieber <sieberf@amazon.com>
> Cc: SeongJae Park <sjpark@amazon.de>
> Cc: <stable@vger.kernel.org> # 5.15.x
> (cherry picked from commit 26ae50a0901a44f7d50053f87dc38abd9f9a269c)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110151439.1542=
08-1-sj@kernel.org?part=3D1

