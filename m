Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795290131;
	b=C0sfZ4CK/lNM0LpCjhumK3nhMtWIKzSgNf6iq1hML8dD74uAMGX37AH9jkE5AoO1EtqH
	 khkSBtFZNMC17PdONDiuuHUedBRYrUSBme4qiSUHYovtjJpiad3k7l6YdKqK05H2KyNbb
	 5FBSg4f0wSHijMuVmpOAqQN1GwsxhJqmZzYs5xhznic25yv7Tkn79qU0rcoJizhaGgXLl
	 ZKtGwCDmpw4UqCq/guZRwfg/C3hj+DukDXVy4NaTLubSM7CD2I7MVrMMSjmXpXmqHI1Sh
	 mVJf6oNelyPgIXGynT6ChRXritlSZySObEeCniwkuiYSJY+bFblmLRnPXb5pUqeyfzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795290131;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sULQB/3Q3yNuI6DbYkIoJUffkHiAfgS8UC+0bPKsFgU=;
	b=fFiNP8cufUiMkrQpOS9HLctqgJWyRj52Ds92+qyo/zd+TTWuSruH3apgUkr6Qqg+1312
	 W/++QS23fg6k5gyPZJ72yX4TLz4xokLHtK5cpNKQ+8X6U/a+Njjqn52lnDLNE89Fx5SZs
	 idKHyX+/vZ+ttEP9ncsd09hIUJ/bFSpPlHXRXXEwLBQK7x5moSR34WVivz6MioNOMpyqJ
	 Y1F3+H3zOKR9JjmotrwHHciULIIQy2zghNDCPJzZO10KuVMcnYoSjeRDbyZktlyf2LeWd
	 17RQiI6VFtnMUrK+FeHzs32DeaVq3QJ8hYnJ8bsCBm64xIRuU2VksMSBP7h4TX8gaNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bedBI7aV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15C7606A331
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bedBI7aV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5290F1F000C4;
	Sat, 21 Nov 2026 19:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795290129;
	bh=sULQB/3Q3yNuI6DbYkIoJUffkHiAfgS8UC+0bPKsFgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bedBI7aVCspHsh4ZdaN1XF+8PoUrhYhmAa8fONB2RqeBqNI8NUgkMAfWJK4+tFIsB
	 aZz/U7Eibxdoarb+NrxYtaCm5xilWsYkvCHW1SEjSLhzc2t/66QMhRtlIblAXB/hqU
	 rQqZcxL+IbXOAt5xB+s7C5dMQuK04ST3PoChVFNHzCL8JevR83Of2cPPa94MyTOQQO
	 m+JIDzi2piV7ZCclyV86C09qdgxviyciM+7M5t6P6kF1kCENTuKvUSjqWH/JzeWen7
	 c5VO76dJgNfNi3dXLgpbKdyu5esf7LfcUXGE5H/hNgIbRXhq7EBy8Wyo+cfOsNtClf
	 yk3Sw/p8qFpwQ==
Message-ID: <sashiko-outbox-227319@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/4] Docs/mm/damon/maintainer-profile: use damon.git
 for patch baselines
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand" <david@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Randy Dunlap" <rdunlap@infradead.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261121193331.108587-3-sj@kernel.org>
References: <20261121193331.108587-1-sj@kernel.org>
 <20261121193331.108587-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 19:42:08 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] Docs/mm/damon: commit message omits MAINTAINERS section name
  update
--

commit 6bab7534a11559ea9b976bf2b9816f3e4a1d90b2
Author: SJ Park <sj@kernel.org>

Docs/mm/damon/maintainer-profile: use damon.git for patch baselines

This commit updates the DAMON maintainer profile documentation to direct
patches against the damon.git for-next and for-next-fixes trees and updates
the referenced MAINTAINERS section name.

> diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentatio=
n/mm/damon/maintainer-profile.rst
> index c482690320249..cc6b79c066a64 100644
> --- a/Documentation/mm/damon/maintainer-profile.rst
> +++ b/Documentation/mm/damon/maintainer-profile.rst
> @@ -3,13 +3,20 @@
>  DAMON Maintainer Entry Profile
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> =20
> -The DAMON subsystem covers the files that are listed in 'DAMON' section =
of
> -'MAINTAINERS' file.
> +The DAMON subsystem covers the files that are listed in 'MEMORY MANAGEME=
NT -
> +DAMON' section of 'MAINTAINERS' file.

[Severity: Low]
This isn't a bug, but the commit message only describes updating the patch
baseline branches to damon.git and doesn't mention updating the MAINTAINERS
section name reference to 'MEMORY MANAGEMENT - DAMON'.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121193331.1085=
87-1-sj@kernel.org?part=3D2
