Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA814488DB2
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585803; cv=none; b=Ch/68hU2mnRhzEAk21Fwi5Waf+pz1Hl55H0zqKj8S8asSMMJM7PuXrYc2O/pWLqoUp98A6p++yApQSSAVRt4hc0e5NrXEfk1o/7uFF+I8e9RRK6V1aY//UaR9us36l4kPnGJs5TCskvYmt0aNxRedNkqVIooMtzE1m1/fyyWyFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585803; c=relaxed/simple;
	bh=kc5PDyZRjoV3XQPtl4qGYAAa8C9N1hvRTLOAY7TNTds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A08dWU4qZ7FHGWZ492eBxo/2aYtlPvXfkTicZztg/Qgc01QkWC+Afvp4tbO4JW7MFdln7C9GImz4pkU/FmztKJfzaFkxRZglSyk1dfN4USWmNZbCg1KF9bp7aF8Ckp8g+WTKhw4L6x0saxoPlhkD+rMpPpkssesjCGrjOKD+ldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDJVc92c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDJVc92c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFF61F000FF;
	Mon, 28 Sep 2026 08:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585801;
	bh=zjLn9EsC8vh8WP4VIv6xeW6J3Gg858jpmOyA32trhog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZDJVc92cotodtFi9eqAbGIV9yhE2krwlvZ5vKtREHepFLiFcXbiikWHa6YGBc1gjs
	 9XMMT5X+C7cx9G/2Fjp+EAF94vPe5pIQXWJYYCTnq1tCTOO+U5eN1GBy/v9BmIxoXY
	 sEtHgddM01u9BZ3UOxhUGTj9sqH5xLQj98IJW5qaJZqShgvFPIaMkZDet0sT3BnzQA
	 WrgjMrybYCc+tLI7KMpvMeR8SFhzx1H/m85iX9EOoCNxEBrm7RZIk9bNqsn0+/xcvr
	 FpRDDuC7Vu1+eXaCj4EJY6N919QVqNBIGoek+9yPeBMXHA1mzhAR8clfEjzO72fqj0
	 a2Ri4m6LmnsqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] mm/damon/core: prevent size quota overflow in
 the temporal goal tuner
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260928084816.5575-2-sj@kernel.org>
References: <20260928084816.5575-1-sj@kernel.org>
 <20260928084816.5575-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:56:40 +0000
Message-Id: <20260928085641.3CFF61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
>=20
> damos_goal_tune_esz_bp_temporal() converts the scheme's size quota
> into basis points with "quota->esz_bp =3D quota->sz * 10000", both
> unsigned long, and damos_set_effective_quota() divides the result
> back by 10000.  quotas/bytes is unbounded; bytes_store() hands it to
> kstrtoul() as is.
>=20
> On 32-bit the product wraps for any size quota above ULONG_MAX /
> 10000, that is 429496 bytes.  A wrapped product below 10000 divides
> to a zero effective quota: 429497 gives 0.  damos_quota_is_full() is
> then true on the first test of every charge window.  Other wrapped
> values are wrong without being zero: 500000 gives 70503.
>=20
> Triggering this needs a scheme with a quota goal, the temporal goal
> [ ... ]
> Fixes: af738a6a00c1 ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEM=
PORAL")
> Cc: <stable@vger.kernel.org> # 7.1.x
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928084816.5575=
-1-sj@kernel.org?part=3D1

