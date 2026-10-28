Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793155182;
	b=HZ5F8kQc+o6C6R5tYWiS9kSxIwqQSN5sHZUHF2r1y8qLNCyY+eH9MLUQXFJfOKia5Mwe
	 ykOPpdjvkEAQF6OVEjbdv2P4k+Jm3UZUUGAlHNGoDLyNAR9uBIXBxGNzhEg7q1z5NXEBf
	 yI6lwAQIgPO3mE6KTmCAQiJfYR/5IIVhCw6V7cb7ArJK8PE2Zk2r0wpeZJmiJwCHPqbzl
	 p/bOxyJNvUH5CXCeta4RvRgbnPUwOotC5ptIVId0MUSdn8A3sLVaKJESCWfnUTPNDS/r9
	 77FJ8LgEr1r1iHCqH3SlqybMPT38bcZNzf2vYwpf6sVgG31J1PtkL+VH5/E68FOJXUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155182;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CSYYa0XleAV81e2G4TUKPzenaDlnv01ydJ1eiMlRcFs=;
	b=KLzgXFOBlXIqaDdpOA5N+6ooPymFwRleJmAmLgCVOZilAKzcRFhhdvsQ5DUJ2q6CKpEX
	 +9JUpsy50JA+CboX3Xp5mASECTSg17yD1/nh600ITANlfKs2oNooPeeRGMPf6Uz9sC0Mt
	 ocqdNhm+uzFjjZc9mLg5Fo9NGI9MSEscHXfY9w+C3Q9CXJRWbiBTNxxqTv4JxI2Xjyccb
	 j1IugikKtfSUKKHEPufbN3hmheJo2KHA5uDSN5N+l9zqwFLQaEn/HF1jLu/tGyeSq8ONy
	 5SBjV0vcyevLnGSeZZ9nNlCGGziJWEvnMo3IhEvn9RmlnGnTKoTI2GaCvmZlIIDzb9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvViFLAP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D1606A31A
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 02:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvViFLAP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5D51F01829;
	Wed, 28 Oct 2026 02:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793155181;
	bh=CSYYa0XleAV81e2G4TUKPzenaDlnv01ydJ1eiMlRcFs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lvViFLAPS0/FNCdmwUlm7GUjwjSZX11lftC8jhBiI9h1SHRBr40UFZKPKi1mBz2w3
	 PkFYGrnypzPthJhJYEVD/iGVQ4jAUdDhizZIFb245+Nvgd9h4yYsTp0D/fIuaL4DGb
	 wKDH1VxfbF7tEs6rk4rSMJnPihMcAQxmrjjxk1xEXPzXGb0FiYQX6hd62PaanNpQsC
	 mmHnuzEU6LxBTnvkTuCFynT6DZ12osGL1B/Yt1HkJQoVJvqq2f5PEtTkEMmZEyXFfZ
	 pOsww27l4SA+K/5XEV2tifIGYns8phyjMO9tFsbap3IA5fbk5ljM4CStY7lKrNDB5W
	 EDnYFcal1xtgg==
Message-ID: <sashiko-outbox-187361@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Docs/admin-guide/mm/damon/reclaim: document how to
 disable watermarks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, damon@lists.linux.dev
In-Reply-To: <20261028023628.795637-1-ruanjinjie@huawei.com>
References: <20261028023628.795637-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 02:39:41 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMON_RECLAIM runs its scheme only while the free memory rate is
> between `wmarks_low` and `wmarks_mid`.
>=20
> But some users want to reclaim cold pages even while the system has
> plenty of free memory, and it is not obvious that the existing
> watermarks parameters can already do that. So Document the setup.
>=20
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028023628.7956=
37-1-ruanjinjie@huawei.com?part=3D1

