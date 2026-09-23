Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82432C08D0
	for <damon@lists.linux.dev>; Wed, 23 Sep 2026 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123646; cv=none; b=A6k0fBR0jXO+NF4zHksH1AqcaoTQJjoNkoZO9V1/oWicornnngAv4zRlKcINJd9+tIGo59S4CYeOHbwCe5tBO4Pk2eTS6UVRPl4TF5lX7LcuiYdcGX3HQ6f1PtOjAEtlvLiEhwsMgRcT+ZKAyPoWrFRnAJN34hK6r9dKw6rTHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123646; c=relaxed/simple;
	bh=Wvz3Tz/fz39QCmSvknT2TS6xWxXiwAHUOlR6wcv53l4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SEW2nLKmgkG6sRm+uuG0E8nXB5cl+6YZ/jTYmQ4AxIjgI++Feu4XshC1LONlIAXZa+rP7iYtc4R17+JZicq+yjvJ/SrgNxkiF9m5RIzcBMC3vquanDgzbVKRbumdDb8waSzgNDIcIBr2sxd5Yolejd/FIBZ/Sz/XbjYnD1DjWxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yvpmm+bL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvpmm+bL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234FF1F000FF;
	Wed, 23 Sep 2026 00:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790123645;
	bh=IPY/g2mwWK52tfeUgYCpBrQrrrVlvqtS4bzFwsGug0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yvpmm+bLM5V4VA24O15e0yPsJmW1iL6gFphfa6/ODDbWvqM/L4Gvv/qvTssbiA16M
	 YaDgO9nUBDlJRYoAt/CEc6X9SCSE1tg2hwmbELp9jd8bGprO1i4Kc+xBqecvXZ1z87
	 9P8OtHo5bFosaXj54XHyf/5c8YP5ySOGICFPz+CSVWx2PRyrAAe6o7Q8/cwvhSz60u
	 CS8kyFN6v6YsOQdgpXmiusBzA+CVaPyIKIken9e92D8F80lGIQF4ORdyu/bpzGc6ur
	 3N/sp1NXRxarCEDyNpIe7xp5S2iYkU2x1UJUYhFNZIUaNeH5dP/u8Ap8Nf29+MNqNO
	 GZTWDACdK1OyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] mm/damon/core: prevent size quota overflow in
 the temporal goal tuner
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260923002600.1825448-2-donggeunyoo.kernel@gmail.com>
References: <20260923002600.1825448-1-donggeunyoo.kernel@gmail.com>
 <20260923002600.1825448-2-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 00:34:04 +0000
Message-Id: <20260923003405.234FF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

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
> tuner, and a size quota above ULONG_MAX / 10000 -- 429496 bytes on
> 32-bit, 1844674407370955 on 64-bit.  The scheme then makes no
> progress for as long as the goal is unachieved, which is easy to
> notice, and writing a smaller size quota restores it.  Nothing is
> corrupted and nothing leaks.  This is unlikely to be hit on a tested
> setup.
>=20
> addr_unit does not cover this.  It only scales the numbers a paddr
> context writes to quotas/bytes, so a large enough scaled value wraps
> just the same, and vaddr and fvaddr contexts take raw byte values.
>=20
> Bound the multiply.
>=20
> Fixes: af738a6a00c1 ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEM=
PORAL")
> Cc: <stable@vger.kernel.org> # 7.1.x
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923002600.1825=
448-1-donggeunyoo.kernel@gmail.com?part=3D1

