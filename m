Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197123;
	b=CBnHzc9Cfl0gOHCWPwFphX5EpqJhSsrOSdztS6PbxxtzaNpBVb3Wg9/Q+JVn/ea7uIUG
	 ovHleF2FdHK51/qXnEUY0I8XDu2UTg5UaUULxlluYbunyJ+p4IQ3CoPPQ1ngOJlY3FcNp
	 KBzVAWhWgX85REKKIO7Ij18/lXJ5x9FAwRllWv0DVNuzzZl39rKXb/nU36VCaOALrtuhP
	 0SYw/Ikv/0uJXcMmN0bfmSOU0CZf+DtmpNHux4JFsXi41ZYLc8S0GuSBQssOlIBwt6x5f
	 541Y2BW4lPjkxKz7/UNUqXfPvm1NUQHZ11/fWHm8ijA+V0Sz6TaA0fyK9AsWSqBpEzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197123;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KWB0ZP76P8Kz/RAwE7RaXHQLu9ptnQ578G/hm/eG4Kc=;
	b=1ei/nVIzABxN5Hwa643VVKyLvefuMCQcZDHxqU/2JPKY94pQQuT4bIeIdyMCc8VmK6sh
	 4a7ezrkLdjWLHw9uTOHvkm24tvVIqFyM/vE3xFkU1rxnyIjNpOZ5uWBsvh0NgS7/9RtQY
	 sjs3yUAoDKUg6SN9tX1NawdCJlfbP3/OdRvz80ml4dFzF81enTgKhnmA+Nl1nfmY02hbt
	 oX1Y7Nl0ATJVAwYFGAPA7JMphDCaRN9fDBKE0eBQVy8PJ4tXeUSknONeg+JQ2ci5cYECC
	 7HCsIHvgXtQo9Qbx9VCVaKo2rtmvy3lJIhm88r1s4BWtTC94dV3j7QxCbhylLrxNRBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dY4rc3Zy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13E9606A330
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dY4rc3Zy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ACC1F031E1;
	Wed, 28 Oct 2026 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793197122;
	bh=KWB0ZP76P8Kz/RAwE7RaXHQLu9ptnQ578G/hm/eG4Kc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dY4rc3ZyVWlTiGFZOdLlR7ESXbRfu5cR08+NIHnAjg63YuWVF3NzfYaz/mC1VjzEC
	 tRHRHCXH/WZvx3Vgvg889sAnc4EjaNpL50w8BF2nI5WemQFLnYurQwcjoj06fXmv8q
	 TIVzCoNJHWjW5WZmGX+yeeoW58qiBS9tw91FOVhnpDjQzWWfvFhwK8PubsHCKwNhOQ
	 rDpPcZoTigYmCdDmkoT5VwLRbqZ2kuzm4nbsMFY7RUchF/aJoaFkDTCiYx1JyADb21
	 bq1U2HqHScTKr0731BZxZ2kOr0DXfPsj7q8vGwxErxhZ3Wl4z1Rro4Fc2Uo1Arm2m5
	 eFBhGGOfTd4yw==
Message-ID: <sashiko-outbox-187968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y 2/2] mm/damon/sysfs: put target pids for
 apply_inputs() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261028141150.160711-3-sj@kernel.org>
References: <20261028141150.160711-1-sj@kernel.org>
 <20261028141150.160711-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 14:18:42 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_sysfs_build_ctx() invokes damon_sysfs_apply_inputs() for setting
> damon_ctx object with user inputs.  If it is configured for virtual
> address spaces monitoring, the setup also increases reference counts of
> monitoring target pids.  If the setup is failed, damon_sysfs_build_ctx()
> deallocates the damon_ctx object without decreasing the reference counts
> of the pids.  If the failure happened after increasing reference counts
> of pids, the pids can be leaked.
>=20
> Fix the leaks by decreasing the pid reference counts before deallocating
> the damon_ctx object.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260730040740.140836-1-sj@kernel.org
>=20
> Fixes: 74bd8b7d2f8e ("mm/damon/sysfs: move targets setup code to a separa=
ted function")
> Cc: <stable@vger.kernel.org> # 5.19.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028141150.1607=
11-1-sj@kernel.org?part=3D2

