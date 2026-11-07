Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082882;
	b=bxUgYFCBCQkN4RGhnLWOflDdjy8QdebeQyA+gUV5U1Wh1qXzc/xfqo0RyPe/J1Wl3tZm
	 QdQZEkp2nO0kDsYy145bXZ0TYqmOk1cr3qO6PzsDNIDkzLoYE9QjjOzh1zyLJsDuFtetn
	 O4YeUIh0TXMdPjEQqypp0ycJQJR6rG8NxSqGZNQ5YJh6SU2HsVVMmRf8LpoH9VL7Q8Ucz
	 uXndmGwXq2MKrowwBM5T/czaJuvnu1PAGGoF/RsXZZoVELV6Im/8BQegoYmXw3Hp04xbX
	 bfQgdawdfdD6pO34XV5XvBIluP+gqB+FkeY/KencZsdeKlaNfHlugFdtnsILtx92dbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082882;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6We6rYrg+ReKBWigb/yjU/6KNb5lrBLOloaJS03fYtE=;
	b=fo6D3STaO81YczLloGVPQi8JLvyGJmEj5t0ManxLMxcJIOy5K/8Ja7qEzZAN1b3QQqMs
	 sandGmE+z5HgLa5o5MNY+IDNd/i/xMbhQo6zpNpb3VivlHaCsWij3gLFo0aMjzzwEYMiT
	 Zppg9AJ1tH8p13lzhzDVi1RxaJTAvz6cuydp71IPlbnVwiEVkW/ZjDi3kIjY39VEZE0rT
	 vvNDPhuxPp7N8TgDCiyHvsLk8hAUn15Fu4K8tTgLRC3UMOiLYzID6NB0io9RVr06T9JN3
	 MU5B5hBDoWZb7OEmjrsmTvMtPhXGCNdz/L5YlQ27QuI95WosUDEKvo/YgZJGC7F4x1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K/rBbzx7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6076C606A32C
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K/rBbzx7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB021F0089F;
	Sat,  7 Nov 2026 20:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082882;
	bh=6We6rYrg+ReKBWigb/yjU/6KNb5lrBLOloaJS03fYtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K/rBbzx7Or16wEeuZZOyKPiYdmdCkTueKIMWjHQACzPqSRdt0S+WaEf8e7J57BIb3
	 4/QcQ3XmQc1AfqV68hb6dGXzxmvR03yZhTJpqFXjkcSJ0AwBiw5vzt9OWeGBk5+Fg5
	 XCyQKHi9scXsvQNsJS2thQolFgLqSRAwyGoJoenG1sj9WZsyP0MLdCuGlwWcDuyTl2
	 wK2SLKaS18m58xv5UeShuOHWtaEJeja4pTM3p73weZmT4wuQBBleZlTBorWuOOzL1Y
	 R7qGkwzPRrSxLuDsUhInBO8zeSQQIya8JxFJVUbq1xTDjLN41+xDSeWBvSNZ7GpGFb
	 d2rVr7i3NBWTg==
Message-ID: <sashiko-outbox-203268@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.18.y 4/5] mm/damon/core: remove unreachable damos
 charge_{target,addr}_from
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261107201001.206120-5-sj@kernel.org>
References: <20261107201001.206120-1-sj@kernel.org>
 <20261107201001.206120-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 20:21:21 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damos_quota->charge_{target,addr}_from saves the target and region the
> scheme's quota limit is reached.  damos_skip_charged_region() skips the
> target and regions before the point.  The target that was assigned to
> charge_target_from could be dynamically removed from the context by the
> runtime parameters update (aka commit) feature.  In this case,
> damos_skip_charged_region() cannot find if the point is passed or not,
> so the scheme is effectively disabled.
>=20
> Similarly, the user could also remove all the regions of the target
> using the runtime parameters update feature.  It would be uncommon to do
> that, but it is a supported feature.  Because the skip pointer detection
> logic (damos_skip_charged_region()) works for each region of targets,
> this result in the logic is entirely skipped and the scheme is
> effectively disabled again.
>=20
> The user impact is that the DAMOS scheme could suddenly stop working
> under certain uses of the runtime parameters update feature.  It could
> surprise users. No crash or leak happens though.  Users could also
> simply work around by re-installing the scheme.
>=20
> Catch the corner cases in damos_adjust_quota() and reset the pointers.
>=20
> Link: https://lore.kernel.org/20261020023958.108276-1-sj@kernel.org
> Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Closes: https://sashiko.dev/#/bug/linux-cd0c55fc-0cc8-45d8-9637-3334811c4=
9b8
> Cc: <stable@vger.kernel.org> # 5.19.x
> (cherry picked from commit 5695abc4e742b947f586bfb6a080a80ad9957e5d)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107201001.2061=
20-1-sj@kernel.org?part=3D4

