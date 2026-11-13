Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585908;
	b=l2cgVclQbiAvERfDZCBmRjPMgWU9mBzuCIr9c9SWqChC6YfAVOLtdBQtJ9SSUAhNMf1j
	 w4ipxeBKAEHTB1jV4783ENOE6kHEZQ8Nq6LDp8ZQf9uUtSlVzjVrvOOwdWeH/7J0pyo8k
	 dEs6SPp0FevUcnukokRK0m03xQRIhqMRla4HgmHLkdRI1efTSLCyz6mRDlXCVd8089Ifv
	 Vofa66bQ2rNwr5x0P6FBp34dX46zHrbj6tAlMnKUuWf4go29vhf7Xju6neetb15wipWvq
	 wRLVvAVVlHUvmL9SIseNHR0UJzoBjkr5MXDYmXXJG9HHDaZUFpvU3tUDLewqH7/kZAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585908;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BIAOZYftQkS+0l6C9wZQIgpcRrU1HWR4ZOdCdQybLsE=;
	b=suYFUvRSn0Bj8uGUWsbArKM3tzfvRvH+rJMIAgne5bl1U5mj9EoHVg49EP2HfGQPlNgV
	 O9FXVW7Xnf5udM5P7g4dUoIwEPPNwCxSN+/fgKkaRvIXG8Dtg39CBuXgNYzRBFVZ72yK8
	 17oxX4mnO18cA40zHTIg+Sz4pHDG9doR6rVVI9dutVogj3TTVMDSQrRETLQ5qfJPxD1tA
	 5g4P3doFnwlfWyoGAjXP+WBEomeTuVoIN8AlJPYGc0eEDmo1T00xQClNZLT2KCzf9I6XV
	 z+NSwQcTgFmtGf3sHno/j3rH/X2K9YO206NoJ3G38nCMGDZR/labQiVPlwgOTyn/4TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ne+ZhmYy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC04A607622C
	for <damon@lists.linux.dev>; Fri, 13 Nov 2026 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ne+ZhmYy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822A01F000CD;
	Fri, 13 Nov 2026 16:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794585908;
	bh=BIAOZYftQkS+0l6C9wZQIgpcRrU1HWR4ZOdCdQybLsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ne+ZhmYyFh0G4SKjO7joPh/o169Oqee2VWdIHTNJ6vfRRB2Ktgc37KvR5Nd/wmC03
	 rU+HK6BokhYUgnsgZqK4K7F6z6FW3pAUS+hwGBMHV+CuDoHUR5MA+ALQ5z9OPCsTlH
	 eikD3+uO5Zf6Ruuh5EDwBvwRdAoNJqDJXyL3nGa0RbRl3F/xleg6jGLqbpi6cpGs/P
	 VydHVzcjaWlu5e8XF98FQLg+DWs9YZSr+EmCZbgvhP1RJgB9db+0BAYxlx3cSAHSBC
	 +KPUjRbBX9NwX1F4J2bRmBABtSQBuO4oM5IzCuIb5V+mGKx3dYG34hD9DSim0fxnY+
	 /Y9dI6Lajx5ZQ==
Message-ID: <sashiko-outbox-213153@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] mm/damon/tests/core-kunit: test
 DAMOS_FILTER_TYPE_AGE_MS in damos_test_commit_filter()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Angelov" <jasonangelov@ucla.edu>
Cc: damon@lists.linux.dev
In-Reply-To: <20261113-test-age-ms-filter-v1-1-b99eab2f71bb@ucla.edu>
References: <20261113-test-age-ms-filter-v1-0-b99eab2f71bb@ucla.edu>
 <20261113-test-age-ms-filter-v1-1-b99eab2f71bb@ucla.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:05:08 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> add kunit tests that commit DAMOS core filter type
> DAMOS_FILTER_TYPE_AGE_MS.
>=20
> Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-test-age-m=
s-filter-v1-0-b99eab2f71bb@ucla.edu?part=3D1

