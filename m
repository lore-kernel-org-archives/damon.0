Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F469248896
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789802460; cv=none; b=uwL1/0YwuYYrch0M1t5wjNxlOH+Lr0WpiXTOFOskGcC04braQbSKrQt7mDrJ/bOyA/g0LL7UT5gb6V+Wd7Etx0sox6eJKLl1hJ9spsqVsg13/G07gIykcUqyb+m79cx6RBqphWy1PILBc0ABKxp8VBPQo4aLQIlGaDJbHj+hdCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789802460; c=relaxed/simple;
	bh=+50OQtdP0vPz7oY8IBpoJ+f+tMI+etzUrEq+bZ5+gDM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hvMwokZERNZ4jm+pQBBcVDG03lShKqatJmO2HU9BZek1Dlv5IGJBVK8y/NiEO9oY/X5lKIttywa3Amzp/R0TR0Qc6J8eCv5Ex3lqKC/JHeBCAIYmQkdSWS2d3L3t4V/BliDWUlUQCRfcIrQScmwmxD0PwDKzl8hAQ6Mkey6Ri+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qe+Iw2Lx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qe+Iw2Lx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B341F000FF;
	Sat, 19 Sep 2026 07:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789802459;
	bh=8phgAajhoUCWQb4ITErL/wtMigCdFV0YDjCYDELuUD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qe+Iw2Lx1oYxLxrZnLJuSlxDE7N9j7Svk3w8J0r1MVdr+e0pkAerFKhRlR59crHRu
	 52wdn2Z9pv/lG2iT5iVZl4qiIjl+fYHDli+f/DmhBSO2hfAHQ5l1d8k3W1RxQjIxUk
	 KbFtRrCHuYw6RskZDpEUo5hwJdjFiV9GsyZD4kJqzI5OKPPI6o37amaqDpNR/In3uN
	 zS94Ge6NZATcLGZMD3BRsCwhmzbUHvkkY0YTJl6qC+4b2DXZLnEIZMsJAEuLpT76IC
	 jxvmPm2Vk/p+E3KzuDSd3v2CuxcJiGCZ+3n/ruzcgsESZyltx3HxuLs12X+Nz986zr
	 0lJoFBJ/U6HkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] mm/damon/core: prevent size quota overflow in
 the temporal goal tuner
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260919071324.1583280-2-donggeunyoo.kernel@gmail.com>
References: <20260919071324.1583280-1-donggeunyoo.kernel@gmail.com>
 <20260919071324.1583280-2-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 07:20:58 +0000
Message-Id: <20260919072058.E1B341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_goal_tune_esz_bp_temporal() converts the scheme's size quota into
> basis points with "quota->esz_bp =3D quota->sz * 10000", both unsigned lo=
ng,
> and damos_set_effective_quota() divides the result back by 10000.
> quotas/bytes is unbounded; bytes_store() hands it to kstrtoul() as is.
>=20
> On 32-bit the product wraps for any size quota above ULONG_MAX / 10000,
> that is 429496 bytes.  Documentation/admin-guide/mm/damon/usage.rst
> instructs "echo $((1024*1024*1024)) > quotas/bytes", and 1 GiB * 10000 is
> 2500 * 2^32, so that documented value wraps to exactly zero; 256 MiB and
> every multiple of it do the same.  quota->esz then becomes zero while the
> goal is not achieved, the trailing "if (quota->sz && quota->sz < esz)" can
> only lower esz further, and damos_quota_is_full() is true on the first te=
st
> of every charge window, so the scheme applies nothing and the goal is nev=
er
> approached.  Other sizes are wrong without being zero: 500000 yields 7050=
3.
>=20
> Saturate to ULONG_MAX, which is what the same function already writes for=
 a
> scheme with no size quota.  Widening esz_bp instead would reach the consi=
st
> tuner, which runs the same field through damon_feed_loop_next_input(),
> unsigned long in and out; bounding the multiply keeps the change to this
> branch.  On 32-bit a large size quota then behaves like no size quota
> rather than like a dead scheme.
>=20
> Fixes: af738a6a00c1 ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEM=
PORAL")
> Cc: <stable@vger.kernel.org> # 7.1.x
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919071324.1583=
280-1-donggeunyoo.kernel@gmail.com?part=3D1

