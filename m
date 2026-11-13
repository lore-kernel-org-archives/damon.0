Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547343;
	b=B7U7Ah0FLHXsXD9ThRIC6b6Yhv55Ag6kIGLclL7YCcZLufkIkjii1ZBtTyo9IXa+qdlc
	 esUXzu/nM5azZ5QaSozOne8c9DHdkuWIEmpLRfDHtapYBnU6zeP0xNtkjA7HYNIHGOm0W
	 x+LQMrrAOg+1PgxMhgzvPN3VEiWZjSBOvmN4CWXyhPWP2so/sLFSHHMromxstLy1GKoYy
	 dFj1N5UozFoA2N+CcXbM7dGCjGA1NcqJnQw73fkzGGTCJRKtX9PF0GC9l33/MJ4wSTtBQ
	 YYdU3jcrsGQhcXMc6Bub0yvvGAKxBimReDuv8wQYgtpLeDyObhFDApinDQt/vrCNYDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547343;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y2R1+W7Io5snerteO1pMXOgYXQe8yqN9RigHWAlKMHM=;
	b=s2YLTVRCW+ZF5gmftKmgD6TxmgvcJ6w4VykziijLL/7HSMyeqwj7DUQKs1CAObiVDNIG
	 bEYEww/zzxzFwBxzlk0qBh6e7ubbq3aZJjwrtMUR7PRgF5btO1JhzLam4xL2aSnxyjEfM
	 nhLsnXr72MhXJ+jhwi4E7ielqWyUFyHuO4snesE5n0KM8HSNaMzxPRT1tkoGHjqJ4gxAx
	 9XCPumE8NRTCVtZxAqKyAewPKJKGRsjNQkCFYCdvouttDqAAOcrDXP4iHo4BPkiuP6ZkI
	 T+zn93ii7fYDbtuPvZZSy/yKHYkWAl9Ce5qb5DEzVD4TWea0b6VKjVWd/4Hnyn10WJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mucn8oUR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F060B606A321
	for <damon@lists.linux.dev>; Fri, 13 Nov 2026 05:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mucn8oUR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC6E1F000C4;
	Fri, 13 Nov 2026 05:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794547342;
	bh=Y2R1+W7Io5snerteO1pMXOgYXQe8yqN9RigHWAlKMHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mucn8oURkj4t5dS2SbTPNOFEmSS7wphyGxiGFQoRVAOW3wK8OmSaGkrSVAdFZQb9V
	 L15lo/Q/W+y9/ohvivPtGDbijajhG5R/VSngL67L9xSRAoaS6TGvnuxaM2Oa6d+2Hz
	 ENIWxjdpEFcRb55j3BDOm7BpMHyT1YikWI+aqWAjTSVEp3mVGF6Nr866Tw+COkrqde
	 eurIbSOzMschpFDbjjwWz3qbP/by8xxjn2cQcsz/O4of1OcwmObzBN3X5vvwVoP/Sz
	 glTlRIPbdX/GSHB6y5iIt+Z82nrvy3M5w7mg47+sqNvNKf5i9lga2ajJAGTKZS6cy7
	 z7hYz2eBJzZ7A==
Message-ID: <sashiko-outbox-212224@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] mm/damon/sysfs: support LRU-activeness based DAMON
 filter setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261113051711.89274-4-sj@kernel.org>
References: <20261113051711.89274-1-sj@kernel.org>
 <20261113051711.89274-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 05:22:22 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Support DAMON sysfs interface based setup of DAMON_FILTER_TYPE_ACTIVE
> type DAMON filters.  For that, wire the type with a new user keyword,
> "active".  Users can set up the new type of filter using the existing
> DAMON filter setup interface with the new keyword.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113051711.8927=
4-1-sj@kernel.org?part=3D3

