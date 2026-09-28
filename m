Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF8A47885C
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585060; cv=none; b=gCu7LsNsYlCQDYU9SwAk5NeT4J59j8L1CTdjjuAtgbBYn8uiLz7/XwYo66CToac7ejG4zs8o0s5IFfQN0pJDWSeac6hwMatzT6E5YqiBVKGZ8B38pfLL4MQNYwMz8Ppezj+IY9SAfAPmvkc4wAp3A210bNBqv1b+IMCm8ucWHfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585060; c=relaxed/simple;
	bh=YMjTGS6RgS8e3O1N0EwkCOpi5pB9rslxYCr1J+XCQLE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uZSCASky4Vl9rr6ODc7YLcIK84c+D86HkraFmmQo4jID/SmXaM9RX+fyzUGT42xFwl3tJMH5mmeYBcNli0eQNIDFfQDiRYH0aYIQ+fAvsG0eJPeXLUiI/cZxOah+Xfam/eBMh3mXPozjjqNj9b/H+oDr/AJjxyYKzimMCkTdFls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wke2IwVJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wke2IwVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4286F1F00893;
	Mon, 28 Sep 2026 08:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585058;
	bh=YMjTGS6RgS8e3O1N0EwkCOpi5pB9rslxYCr1J+XCQLE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wke2IwVJ88bL0wTJW/KRznSJhbMYV56JdX6TNOy/qOgJhxG4iuWGNhKP9GoZxOcQ4
	 POW5lV4sJK8pRvT3v/XXJ6cy+GSPWRuf1vR9qG0+AFl9b0l8mPkzM6hMjwyFVK3zlL
	 rIosLNZ03kEIvWQtsZ4CkyYMmlh+pJrMaF+Tu68xfnNFIpPz8bTp829CgUjkYJ/CuQ
	 z4AX1eV5pjGDRrSAQnudkhVlaPsdyM4im+H2+wiBejic+EB4+OP9RKZYx7DotWkJiF
	 1j8+WhndWr/I9VPA92YRotZmy8n1/4arwxz1MtRO9MEIpFFrYpFZC1lHWYfhbmptvs
	 ofMfmRkaHto1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] mm/damon/tests/core-kunit: test PSI goal values
 with explicit samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260928083959.4030-4-sj@kernel.org>
References: <20260928083959.4030-1-sj@kernel.org>
 <20260928083959.4030-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:44:17 +0000
Message-Id: <20260928084418.4286F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Karl Mehltretter <kmehltretter@gmail.com>
>=20
> Test the PSI current-value helper with explicit totals so the result does
> not depend on the test system's memory pressure. Cover an unmeasured
> consist goal, unmeasured temporal goals with zero and nonzero effective
> quotas, and measured rounds for both tuners. Check last_psi_total after
> each call.
>=20
> Cc: Lian Wang <lianux.mm@gmail.com>
> Cc: Kunwu Chan <kunwu.chan@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928083959.4030=
-1-sj@kernel.org?part=3D3

