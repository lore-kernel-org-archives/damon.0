Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931049;
	b=rKy3EjwjCbaEakxjjC6EFWA/WRXduPxYPlZ0LUt+tLCdTEDSh1o4AYymWVaHCvCjEfUe
	 sxz54LkVF64bnAZ2nh6sLZRHcpRnKNqgvLRBrXzUKvdf3kzLwHQvwht/HNIvbVM+zSstX
	 RKwJb1OVwsnSeIyPYT1Qqz9MiGYctrDeZNDTQ4Kr2/+iMbic7B5Zu9hLfLsLWRBogUW4Z
	 skofLqDRI8WTL/8sdWv2HxzRrAvbDE3MMOc2SUBfF67Ew6BYpLNT9jwzLdYyn5jr8y2RF
	 BC6dZkXCghXFGYr2M/1n1DUdfmQk4surb1Fvn9/wDsCJ3YLE0RJsatGf24nMFMgVxEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931049;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ueM5KNYVTwi/OJ0trM5o4FDhB06pV5z3pZAwgri1GCA=;
	b=x2k7fi8KAE5tl4QSKDQuVTkNThTMNVE1iO3Ky/3qAU6CENeOdOklN2LHg5O9QLHwnx/r
	 k3G9+4aD29ZzMSSmd1JuDvhwaqPiOqWq4FSQ/BkH2c2EmV1DEbkJ1+PvNdCeV/ia0M/Bv
	 OgnCsoUgNGRksnMsYysmb2vh/SQFTkkc+PtZBhNsLyjj2HiF44DlbKrzdyFAHpdm56Tvy
	 zySnDTrlTpgrwayLVUFFNoeX6HuL/OOWq6RU5Ge8addqXFULQ1QUolWVJ+5+zrlQokn7r
	 bjUVwCpjRdTkGR3+wMqhHFAhBThdnokDX82M65+Wt7AhDygb+xc97y69SBNsW99l4WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2sPoJs2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A7606A31B
	for <damon@lists.linux.dev>; Fri,  6 Nov 2026 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2sPoJs2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8B41F0089F;
	Fri,  6 Nov 2026 02:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793931049;
	bh=ueM5KNYVTwi/OJ0trM5o4FDhB06pV5z3pZAwgri1GCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y2sPoJs2173ceQPYrfbMS5SQNItQ6v9lusp+Ax1Grj+PPq3lzg+MkJzY3Q4yPmkHR
	 5K+SQyKC8hh3Jo37x1Op8mEEYdBSxX00EomItN5c3XJkD+6tiqPwSNuDM7UcgCSfIM
	 wmRGEsVPmch3Nv4wY2IDWG8Toh08NCNziESFWV3WWcvGgpifR/0dd4g2+y6zHeM+9b
	 ockZ61I3NEumODlj5Z2RYoMwkNV9MHDEj4B1TTl3pBxagWdAJqfUgqxatifdLAaRWm
	 5gsIWhQ/JvkppuzjItyeMONmktQTbQjyXFqDGgKKENgJNdJzw0olT9HcK9EQuc4nFS
	 7tDUO4o+3YGRw==
Message-ID: <sashiko-outbox-200580@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] mm/damon/sysfs-schemes: support
 DAMOS_FILTER_TYPE_AGE_MS
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261106020559.98352-3-sj@kernel.org>
References: <20261106020559.98352-1-sj@kernel.org>
 <20261106020559.98352-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 02:10:48 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Support use of DAMOS_FILTER_TYPE_AGE_MS via DAMON sysfs ABI.  Add a user
> keyword "age_ms" for configuring a filter of the type using the existing
> filter configuration interface.  Reuse existing 'min' and 'max' sysfs
> files in the filter configuration directory for storing the age range in
> milliseconds.
>=20
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106020559.9835=
2-1-sj@kernel.org?part=3D2

