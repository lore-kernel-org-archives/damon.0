Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794897608;
	b=GlGJChYoAfBwmpUbFIX0x1VpCsb94XP21GwE/gl3kvpJgzEmCo2I5t9LBD2HIP/i14ZY
	 pDLNG6fHAmaTi6b3NdtBWA7Nb9rjMoaXYVaHSb8eoc73hRnOcFXFTD4j+hGPWELGJhv3I
	 c5Ti19ELf6QSHdRyY6QcFO+UBdBhcykxyvnNAg9Bb6Dt8Bdc/oS9m1g7qQmttoBwIxu87
	 TZ3tSVtOavksQQBAPrmtDYIJlqkHetl2v+I1Iaq3D1OC8Pv/ynQ59O1DLLvS/CpCQ0lLs
	 v65pp9nn3PeR0qbU5Rb2HhAP8JmwcKsx6CcU8EwOhuA/I0pEU573jZjusld5ztWxH2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794897608;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n8xoCSTxj0+mDGXwSoYCn/zQ4fe0z5dSm205OjrIiE4=;
	b=WgdbKr0BDaFalW06kM9cWbJ01k7lJT8LbHXgSuEIiW5cqewOqv1ca5rMBfAUdZvc1pXW
	 EMjryN8xDKx77PfB3oU9GXOxzgPYIRXeO5PNIT2PUW4BVi77HPcP6FghvacHNDSxszscH
	 NTkN/hyJTizlVD8eiLwRItcfR5wC3KIJJZ6GPiX5dgRJs949anIGJBbx7KNwh8BB4bpyo
	 A6DhChBXimSx+phDmfgcD/Vbhgdb5gRcLsLYzQkZcZ+qE5YIdPE2m84r5yl6JJwnyrZzi
	 W/8WOVvgeUDIB5xetdfFHfSEVUGI64lXQnEj3PkCYD4+fdLZ42bch3s1E3l14AmPf/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvpfM+9W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831F7606A331
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvpfM+9W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DB01F000CA;
	Tue, 17 Nov 2026 06:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794897608;
	bh=n8xoCSTxj0+mDGXwSoYCn/zQ4fe0z5dSm205OjrIiE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YvpfM+9W2cizHz/Ed5CvVHV478DTbqmzwNlPui0ADHtmnmgsCK6rNbycqmlq8JFkq
	 IWqRuzUJtCJWOslkQfg9w+vkLpW5u+ApbDmdaSbtIQUu3izbz03D53qvHM7Iqe1Jh+
	 xsG+wNTzrZhDdsWlh9LCqaRwwihVqXNtR6WIcON93ti8uuUzBqj7PUVFJtg8KsCDuV
	 4IhFMut2ptS609gAq2KfUxKDaKVRBmhuTkDUPkbmr+O/hvZvYT06jYLWT1cQHCheXp
	 t6OBcCIRRH8Lzy5xrzEx8anrNDb7vLTJvvb7banXYrOFjEwXKC2LAQv3V82LFjSr1a
	 TmKigT9b+tm7w==
Message-ID: <sashiko-outbox-218268@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/damon/damos_quota: skip the last sample when
 counting exceeds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aveline Noir" <jm5905938@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261117-fix-damon-quota-selftest-20261117-v1-1-c65d687d3def@gmail.com>
References: <20261117-fix-damon-quota-selftest-20261117-v1-1-c65d687d3def@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 06:40:07 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damos_quota.py expects qt_exceeds to be increased for every sample whose
> tried_bytes equals the quota.  The kernel increases it only when the next
> quota window starts, so the last full window may still be pending when
> the workload exits.  The test then fails with an expected count one
> higher than the actual one, e.g., 15 < 16.
>=20
> Do not count the last sample.  Also drop the sorting of the samples, so
> that the last one is the latest.
>=20
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-fix-damon-=
quota-selftest-20261117-v1-1-c65d687d3def@gmail.com?part=3D1

