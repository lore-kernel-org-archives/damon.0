Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809303093CF
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309297; cv=none; b=FXoX2LIwek10IozBKmGrQRyxeRRKgLiLE+YD5GRToovtlEV0F9qZmvYv87P3wMeDzRhDoRHLimJfcQJygp5kCuSuSUoLJHWSgvAK+GJdzZj1J7kcd/dAFokH9rXlLBi4xqpw1sOCbRPfMxuJXrv1R6z2atZMPCewt4HvdYNMN8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309297; c=relaxed/simple;
	bh=V9lW1KnFdqiM4cIL43Bw0Z8gGkZrBqJzm8eqV7l55SM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VVmpAqKw0513KdIg44nzvz3kuZtYOHdGIl9+PrLk7TGMQUxqPIeqq1fsxFrq/HHSYV5r4MRKBQrijwD4lWEFcAko+c8kOQRvjm/AWvKw2vIzE3S9dgeYRp1dyeswq968zXN9yUQ0rj1gkNmHswLrJflsJBicarK58UhSYE1a5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSPb/CS7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSPb/CS7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5F01F000E9;
	Wed,  2 Sep 2026 00:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788309295;
	bh=0WhU6EtJYo/aOQRKSCIcK8MMaSw+P4CfcYQsqtjjmjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CSPb/CS7N3jPnWPa2fPY9Xa9BPFxQrqYeFQEQFY6eh/ki2bKR/boJf88q4Wyc9n47
	 g0iAruaXYr6WPUI8ppuu7b6OySnICVNvadt7NGVDnPrft+gpmcJikIM5UjpSHFHToW
	 6F6jkmerNgXBxn3KO4IcngnIRxizfJiecobN+SeC1RKdjPe091uOEEDqF6PQMtmPR5
	 KxHB1kgmsFcEe7LX8apFv1KlyHdqch1VzIpqIpN3IWKjRidJmU1IOitr72STc0ye3T
	 ccUr4vGpH9EtJYsxGJJ0JtY8r4ywm4tVYjVA8ByXHNqMTPzGx15ajl2z7oCNzyzmWa
	 rGKjeHmrtLcNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] mm/damon/core: handle uninitialized
 damos_quota_goal->last_psi_total
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902002725.108635-3-sj@kernel.org>
References: <20260902002725.108635-1-sj@kernel.org>
 <20260902002725.108635-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 00:34:55 +0000
Message-Id: <20260902003455.9C5F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> When DAMOS_QUOTA_SOME_MEM_PSI_US metric damos quota goal is set, the PSI
> delta for the feedback loop is calculated using
> damos_quota_goal->last_psi_total.  However, it is initialized only after
> the first feedback loop.  The first iteration of the loop uses the
> uninitialized value.  As a result, the feedback loop can change the
> effective quota in an unexpected way at the first iteration.
>=20
> The user impact of the issue is not big, because the issue impacts only
> the first iteration of the feedback loop.  The feedback loop also has an
> internal cap of the quota adjustment.  The wrong adjustment will soon be
> corrected over a few iterations.  For this reason, doing no
> initialization at commit time was intentional.  It is also explicitly
> commented.  That said, nobody likes behaviors that are unexpected or
> difficult to be expected.
>=20
> [ ... ]
> [1] https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org
>=20
> Fixes: 2dbb60f789cb ("mm/damon/core: implement PSI metric DAMOS quota goa=
l")
> Cc: <stable@vger.kernel.org> # 6.9.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902002725.1086=
35-1-sj@kernel.org?part=3D2

