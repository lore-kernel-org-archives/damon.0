Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB813890FB
	for <damon@lists.linux.dev>; Fri, 25 Sep 2026 04:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790312313; cv=none; b=sfFcXB3E2a9CSNDa0BWM7lkNLJ2bcRG6ysfORobYXvo+g8q1fjcB7CBvUS/t2uz/tXyLilN15W2XjmyDl1XdGsqNsyE13yDTTI3lwwTZ7Lmh/DGYkmC8k4kAt3yOR8fdj8T8f4UGdTYRKlgBwuwAeCSDzSuEScRZZ0TAkzIiMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790312313; c=relaxed/simple;
	bh=AUHhikV232P1KFjHi/1CW2u7Vb9sgtyLIe9Mh6m+uok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nWetb3TsRKNGSC5swI3g/q7xNq7RLixNybMoRC5JXQ3FcKDwrPjL90imKrh+YcGg6gveoVCMueFk9UUZ9VRyDzTPWBh4g2G8pNqWSiYmD37X1jnLvXVAFpqWtWLsoxW4lvDHZOhgJBmDnIEy/9Ps1174d5x0p01dadBKdbqqKyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mlyk+H7f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mlyk+H7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8FF1F000FF;
	Fri, 25 Sep 2026 04:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790312311;
	bh=muTbN3/OJgTsijwg2MAvTZAXu3//lJrW0BZceRV1hwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mlyk+H7fqUumP0a49GJ0FkYkiI5B+iuOvjpQsH5ZsHuAxT5/qdcTQfsW8eMPmXyCF
	 B881Jy74g1hTPkpWNafh6Id7MoPdf+L4uAz8fQei8HyTGk715NO+sL80wN9qf9N+KU
	 efRDQgEK+H13p1CiUPEKR+MAtdU2LvgLQFEOB/3j/E3WVCAR6B60KCAH+k87cL7kBK
	 KQdx/gfUCHyjT7IYkR94memiA2JKyhpRCzloJ23yBOnOR2YGM6sa554+9SG3MWLe0w
	 ZWUrTBqMDyCIcdImwz/4qCaZy/Lb7V/z4UVL+UdcvIx7Jo4Wo+eOog+D48vVGX9efA
	 8aV3cWb5LMIiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/tests/core-kunit: add test for
 unconditionally skipping the last region
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260925045350.66595-1-aethernet65535@gmail.com>
References: <20260925045350.66595-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 04:58:30 +0000
Message-Id: <20260925045831.4D8FF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Commit 50585192bc2e ("mm/damon/schemes: skip already charged targets and
> regions") introduced a minor issue that causes the last region to be
> skipped before it is processed.
>=20
> Example:
>=20
>     1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
>     2. Quota is configured to process only 100 bytes per window.
>     3. Window 1: Processes R1 (0-100).  Quota is full.  charge_{target,
>        addr}_from is saved at (Target, 100).
>     4. Window 2: The loop reaches R2.  Because R2 is
>        damon_last_region(t), the old code unconditionally returns true,
>        skipping R2 entirely and resetting the charge_{target,addr}_from.
>=20
>     Result: R2 is permanently skipped even though it has never been
>     processed.
>=20
> Add a test to prevent this regression in the future.
>=20
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925045350.6659=
5-1-aethernet65535@gmail.com?part=3D1

