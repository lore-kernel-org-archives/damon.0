Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE33B9956
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088877; cv=none; b=W8PnozMLeTNN37B5+M0W9rU3iqxLXEhml722a0Mti194LbPem2ENYm3Ao3WIagKsMbXNrwQXDlK6UGElk2RP9pq+Mo1rOUs4Yij0K7hcWPVPhsX0SHEqi9MKEix5cYwV/OjEimx4YrOJssoxkqm+glkbqwMjhH6cjm7bwUsaHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088877; c=relaxed/simple;
	bh=RfWqShQ1PDhpWGPq3lOy6x1WdEm8jyW8cT0MQmUvsfY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bnfaaVICa3FY+qJboIiAsZYM3B+GLB1ZQAoqdklOmuLpOx4ePU2mGP06/xzq8lpd8ikr6ljsDzPqK33neYI9pY7qLhFT73Jl1nkt7kYHhGqPQu4qOkHfdGz/zXah5xzrZWgo0jIdla4utluvT2QGLzL8SXtWtP8Ig0N3aqJPP7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6KXZyY4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6KXZyY4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8081F000C4;
	Thu, 15 Oct 2026 18:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792088871;
	bh=T8aCiEZGg9ZHBuMdq0Ow1pwyVAgHp1fHwiMJnEVr55E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n6KXZyY4DtDmhoqAJRf5daJ7w9LWZn99urXQLSecumsJhSZcv34pN7PL+r78vd1Dx
	 kD0TXW+v2QKXFQmskAjh8UCNMJFvAnLMHHrUNnRWgrnWCNPQ1trghZejw6J5zFDoke
	 /UoCO1N4i9nr/ZQ9N11wK7+3wlsCBIlss4TxRMLhsSYm9zLUcmIpyTvZI2wdRPnptY
	 WKKTQ968YGjyvAEqFYgYWtyXXZHKJWglMudgXIXpCN7s7AY89GaWJ30pxxTzTBBnVD
	 c57KJ9KlhjwD8h1O9/r6lJWYB5fv0aQSfw8Y6fbqQ5BsewkbKR/1ZUtD8oE1PZH1Ub
	 iIR8qNqTaRizQ==
Message-ID: <sashiko-outbox-173291@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/17] Documentation/mm: multi-gen LRU: update for
 frequency guided promotion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261016-mglru-fg-v4-17-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-17-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:27:50 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Kairui Song <kasong@tencent.com>
>=20
> The design doc still describes the old tier and promotion model:
>=20
> - Tiers are no longer order_base_2() of the file descriptor accesses.
>   A folio's tier is derived from its referenced count, which counts
>   accesses from both page tables and file descriptors.
>=20
> - A young PTE no longer always promotes a folio to the newest
>   generation.  The first access only moves a folio one generation
>   forward if it is at the tail of its LRU, i.e., in one of the two
>   oldest generations of its type, a second access promotes it, and
>   executable file folios are promoted on their first access.
>=20
> - The eviction no longer uses the first tier as the only baseline.
>   The type is selected by comparing all tiers of each type, and a tier
>   is protected by comparing it against the tiers below it.
>=20
> Update the aging and eviction sections accordingly.
>=20
> Assisted-by: LLM
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D17

