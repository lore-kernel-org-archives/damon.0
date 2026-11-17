Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884492;
	b=qL1hINUjKBNLohwTRjeOVMW0n9mGe8R216UmPnKrhpU9+cinaK9853aw+1SrEAqHURx+
	 hMHys6G4h4RTT13/eumzrYXq1O4jSqROQ8FSmvWf74z7U6oJpoL/vUyBGW6SomG2EeUWZ
	 t5H6mxI4BiefWKsofw0h2Dvuk7ch+JlJ0Ro2AMNkXCgUGqUV/V8Dg65PyxD3XdBZnPbkp
	 dEVcY8pqHIGr3oFVHJfheSbYZNVcLdsetU1qAqZgFh8z2ZjhgRDH4K/hN1xtXfEc4ra2u
	 u6ezAp2KaO04iDBuCrIVAMYiA1gA10r3m6JW/C2cVXTFKirPM1NEF3U4WdzupcaqcxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884492;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aAtY2TFWLZYMInMCh3jlNE28xH3Q48Z2D2fdcOdVe2Y=;
	b=gCFOInjptyFrbcSqDijv1vlTy+M1XxY+f9ZwzJZPu/5jzpEdnlaMYb2binhsonKwCuS3
	 6k3fFM3WfswQo5I7mDs2Tk9qDkPnac6GwBIrYZsgyeV+AUw+GyMplu6jRm2Vle5CafM63
	 pdiNlKX8ThK12O7cvxbXi7sH7LfJYuUoq34Dqybb9BZVdwof90qe5ue703OEAJAbE6Dp/
	 HUs1JO1mIdZXLqecChIbqswR9NUIOt60FQVFqlB8s59uV5B48L/cDbXc/M0I8FJFfLiA/
	 kMYDrsV/evlxWgf4ybKO6gyYJnr9x6O++Y7e2Ccj3TAdA8AR4Kp/CGab2lYIgu/l3pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nz0ZXGlA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34283606A32A
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nz0ZXGlA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D479D1F000C5;
	Tue, 17 Nov 2026 03:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884492;
	bh=aAtY2TFWLZYMInMCh3jlNE28xH3Q48Z2D2fdcOdVe2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nz0ZXGlARzORzRLvY6wPfQ8bU4/mU/NQ12VEPQhSmaqxt+zqLA0b69HiJzP/kS9LB
	 jc31/S4kYCHgzaCU9Cxma5Zom9I0WPXWL91kTfwXeOlic63Tqr7fdZEq3VHXiYRKT5
	 fj2uNdBkCVB4dGMNmqdWUMMnhbSSmpEQVggShsxonMuZmmVQyELFCL5G20nL/Oz/Ki
	 9pVUAEdKBSBt313ho1LRP6TS8InWz+65z6WpSGxEHwqzj9bWAxyP+Sw4I10wrZpCwN
	 6VQ9YfdDIbNBkb5Tf+7V1Hm2sL5DhzuN2ku/+0+60KHJK9w8XowqIaAs7E4moP2Eym
	 nN8O9N7LfUvgw==
Message-ID: <sashiko-outbox-218109@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/reclaim: use parameter context
 correctly
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261117025144.117100-1-sj@kernel.org>
References: <20261117025144.117100-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 03:01:31 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: SeongJae Park <sj@kernel.org>
>=20
> damon_reclaim_apply_parameters() allocates a new DAMON context, stages
> user-specified DAMON parameters on it, and commits to running DAMON
> context at once, using damon_commit_ctx().  The code is mistakenly
> over-writing the monitoring attributes and the reclaim scheme on the
> running context.  It is not causing a real problem for monitoring
> attributes, but the scheme overwriting can remove scheme's internal status
> such as charged quota.  Fix the wrong use of the parameter context.
>=20
> Link: https://lkml.kernel.org/r/20250706193207.39810-7-sj@kernel.org
> Fixes: 11ddcfc257a3 ("mm/damon/reclaim: use damon_commit_ctx()")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit fed48693bdfeca666f7536ba88a05e9a4e5523b6)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117025144.1171=
00-1-sj@kernel.org?part=3D1

