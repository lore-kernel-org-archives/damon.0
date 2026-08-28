Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F083839B2
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942570; cv=none; b=o91lvXj6aq7n33UiF6yeHUa6D2mXx42j3h9syObacsPAfgnpiaNvGvRHroaiWwtgkdCYTf3BsrBeHyLzpM4gdTOnCvjsfDCaW3UeuG6cVlUuke3KMXL2Yn2Rjv4+J4jpojZVrA7iYTzp50cFxxou0dfQolChxMRtZgL53ilSGHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942570; c=relaxed/simple;
	bh=fYiVDs4h7XpWLWTtZfC0Cu4Z2R8h3fMZsX8MsMxMq4M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HBxpwFhGdZAI9W+2c7PZ8dObH3MgjFaskt4OZ2goflM/joMzMI2NbDAMlsKsW1s09E1M/qdKp0EcnW1Bvhvb++Usx8IIJmP2IUGhQQFD8Jytratlx2HHI9BKNfedQS8PRF91FZCe6XgQ+ht1ecTHcBDQ9nEUoHw0bvj4I+lA+VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DewQ6jHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DewQ6jHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885261F000E9;
	Fri, 28 Aug 2026 18:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787942568;
	bh=ZNjp3ZjKY5kQz+Gh4tukws9OtzCmeuG2jZI3m/yNzrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DewQ6jHtz3NaLLiPwjnfNjyyQm32Qd/57aFeCrRlS6U6K4hlaeQ1/ZMjOyy28+zj1
	 iSJVvRhQF0/9+k6wcmTLrfUlYTNgmBkl1U8OAH5MVBRW9OQItIHzZWHtQrqghWfN9p
	 LkOJdVpRv8LlwqMBpI0P40KmbM/rnko7dFnY0V1P02uvFrBpznvAK9HXzV7AZbLl6N
	 pAGXDe3ItwqorP2G3DigbPNBNtbEuF9WvJNBU7guUv7DinpbgNmrkdMMPlbjZhW5VG
	 2QSSwi6mbGZlhllT3R5cuSQDJT7l/Qd+w58kASEQDGZTZwmvaH3ifked/jukrMCA7Q
	 pTW9WfR28v0kw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 2/4] mm/damon/core: handle uninitialized
 damos_quota_goal->last_psi_total
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260828183649.71192-3-sj@kernel.org>
References: <20260828183649.71192-1-sj@kernel.org>
 <20260828183649.71192-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 18:42:48 +0000
Message-Id: <20260828184248.885261F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828183649.7119=
2-1-sj@kernel.org?part=3D2

