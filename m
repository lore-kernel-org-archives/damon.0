Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197409;
	b=l8eV0TLsI68U8Wt1YWpRMJ1SBl4nnTz02vkJlNUHuA1UsYfKcwVqDSWuJillKrPH93tC
	 KIe4PmfP+m5hBhRlGroXKa+EPzFSbia0ydv+XdvtHj46kFxdsI9MhF1hN9Qy6p9LNrEfn
	 cOLzBS46mGaIWtBNVhjHNMFh6Ixo5ATxfwHKVQySDIq/n16tqWVnyRMsWR5JfRYizC+wF
	 7G9eCsL4cwn46cr1PsMVbNeKjivN4lUrZX514mcuV3CaS885hW8kx3VKJ233NLrl2B3wD
	 50D6Rz8NRP2k+lO5AdV2J5TQalnzAzh9Y0WhCBd1csjxvmI+TnGo4/I1VbgDvNFzTCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197409;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bQb07XqKHpo/d7XuSadAd2s7QMVnEjP3P01HUd2nU/M=;
	b=VYSJmgGFC3izHPNf39I2+9vI3e0hD6oxY4CPf9OytaVhOZhRT8Co70GhiwkkB/En9pOa
	 X86ywNIt2fzQ0LMDl1s+9p8Vmi1CnM/CdJuGE4P3wcal3nP/ctj5+BeF1myU6+TFyXqv/
	 AeIrPeN3jx1ghGfnCagpE5LwxaISguLkV/zsW1UM3PLCQukaVuB/BWO5jxy+BY0avzqvv
	 PDVkAmJ102g4FjjYUvKIpKrTw3KMzPv2fnrCQ5eXGWeIOwVlIFei4sT3LIjXCQoW6LtlU
	 gf3ANAWSmlHtko5LxDGfC9gzHsFmTN027gZ7dYAJcHwCd/mOwwbbRiU+Cs03ojln/VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXRAZLpz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF260A263D
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXRAZLpz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400651F031ED;
	Wed, 28 Oct 2026 14:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793197408;
	bh=bQb07XqKHpo/d7XuSadAd2s7QMVnEjP3P01HUd2nU/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OXRAZLpz4hcZZ3x+PoAq0FzhDplu4mr0W5+NN00hZfk7zGGTrHQqGQ27XgQ7AMKkG
	 gJXT4QNEZ0el1x3RatwEBVy6Km4JQQ+Sd0Cef27Qiepa9Iz1Sw2btCir/hlf6EwHR/
	 sysCgn6rHGVH8EtmYT076w5+r4q5bNeQK2L4DQO3w+zUkhotEw3kV3pV4S76S71FB0
	 IlgdKjzGMFecCpX5gqGl+ScYg35ZkYUM5fHhmhssmQIE8or9avxpFDgVuMgZe3fGGd
	 jYNcuOADCFHTfqtHeD6dcbu3lMFvoQhsDB3BIqRJgz96pIrerS4Af63suve90VabWR
	 m1M1Sz8S6f4Ww==
Message-ID: <sashiko-outbox-187974@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y 2/2] mm/damon/sysfs: put target pids for
 apply_inputs() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261028141430.161175-3-sj@kernel.org>
References: <20261028141430.161175-1-sj@kernel.org>
 <20261028141430.161175-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 14:23:27 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028141430.1611=
75-1-sj@kernel.org?part=3D2

