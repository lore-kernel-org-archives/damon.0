Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F49427A907
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932753; cv=none; b=cJiIpn83TpOp1JcByrxK0sVpqQjDxWRVxM+Cgk0J/UFe1y+A22tG/UPkGqJhBcLlgF55jlo88C7azx9R5bLzDK+FtGL55XsD/h1w8WMmMS630H3zrHdJdqlqmsgqq19DV5DsD9jOu5i2JqVwLxy6LEpy5hmZl8qlQNYc5IIDE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932753; c=relaxed/simple;
	bh=rAxxa3oVztbKrlVg4k8ZeSMq5sU4NZKxrJQ+/YIe28o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pwtA13uWqGXAoePrbDdWoOljvLVZQmWXqYqLxk4GhUnDE60I7REzADyzHw7QJahubOaag0o16myMNEgFF/RKIKZbgvT7tV7FiOzLsM84SVuzxN1Avc0+XNgDNtDyH/Y9m5JgAZJfqo25wFAWDHtm35K+IfrFHbk2ZfuGYRTbTmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOEKMMvW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOEKMMvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB841F00A3A;
	Wed,  9 Sep 2026 05:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788932752;
	bh=xne6g00QTbEyIHsqtXK/41YYJU40rvuyxMSsgl1Auzw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XOEKMMvWkuw9gtZHvBdnWnwQNzbv+57w7Vh82bV7bkHg6TlvSkM9pt1JMvMZLcxTD
	 4A98tuaFQjl2ptsFCsLREw5u7uiUwbQudOSE6oM9U8Jjs04PIzZYNtASwILlLH2Hgt
	 MV4JLr8L+CeW03LYyauXdn9mDqVfTf6eAgiQjZlJUgsAhZmBTnkaZzlsQf3YLeNtBv
	 Rg379L+8GAYKhmb3cHvPAw2hHSEcpGZ/8Ci4pPaTzIl5h0vgzKSc/qf+xBNQN+Hk9S
	 XZcWXzrEsd6lxkwU9b5yNa9Ztcs1xdKhb1UwF5UFtJv7flkN0Nyc417I1QcU/188qs
	 R24EDtT4+LSUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] mm/damon/paddr: drop last same folio access
 check reuse optimization
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909053834.248582-1-sj@kernel.org>
References: <2026090852-ought-makeover-4182@gregkh>
 <20260909053834.248582-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 05:45:51 +0000
Message-Id: <20260909054551.DCB841F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> It can race when multiple kdamonds are being used.  The problem from the
> race is doubtful, but the gain from the optimization is also doubtful.
> Simply drop the optimization in favor of code simplicity.
>=20
> The user impact is doubtfully trivial.  After all, this kind of
> interference can happen only by intentional user setup.  Even if it
> happens, it will be rare, and the consequence is degradation of the
> best-effort monitoring results.  No critical consequences like kernel
> panic or memory corruption happen.
>=20
> The race was discovered [1] by Sashiko.
>=20
> Link: https://lore.kernel.org/20260715031002.108504-5-sj@kernel.org
> Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org [1]
> Fixes: a28397beb55b ("mm/damon: implement primitives for physical address=
 space monitoring")
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.16.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit f23f0aa62b2f32c2b12f95959fc4603ef81678b2)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909053834.2485=
82-1-sj@kernel.org?part=3D1

