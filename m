Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E33434994
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907697; cv=none; b=rt56VHz7d6vsOUMDutESb0BJXw5g9QdCD9xN+ZzNDT1pmY1nr+RrQE7sw8l8mCUuySDssEO8FCIKO7CYKWpTlUNr3rtmBLv4+WJXDkfzYOXlj52WoL2VlT/3p4naB82OCBEA5ApXEf3eFbJx5v0JAlKNvHSHeGQP1Ac4LwSoAOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907697; c=relaxed/simple;
	bh=ZyIIyyfU6yioK5m+aLXaE45Zb4u1JWFJjBr5JtwwkdU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tYtl0taYni9ccP7gMep3hKc3QuCFsXIe3If1aWZRxxlxyqIu3ZBfCncw8EzH10TkZs9aiCh9rdnsLG3aCqvlqtYBkTnhpCHEtXqvDCVoOnQDYEENni+JAwCrzGvtKe4DAhMVHYudC6E+W+5vtDTq8WEuFvQ7Og7Hi0vNdcyHiuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPpNnCKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPpNnCKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D631F000FF;
	Sun, 20 Sep 2026 12:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789907684;
	bh=5+wCtXf0oDxUpWLfFFXlkB5imm1AYRSoQajZql5/SK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NPpNnCKLO2hhr9rQykrdskXBMsPuEbpglQzQ6UW1CDpPdOAttJExf7nAVWKVtm/Wi
	 PRY4W5iXpYB5KLL24Nx2dr8nAIpiYZlXhZza3hpkO8MWOuEpbZ9e+GC+f8FDkDz/1P
	 qi5b+VrJszK6qYcAECVx4BgS8tXwXq4gsi2icHKl8QrnL+a6Xripj2v5HBmIYlgLeG
	 G++nL/BDAoVecML3vjif0buzfzmFIMUOtwyl1QZZGzF2oXYVg2PH8G5wwnofAicjoJ
	 YIQBmjf1MRE3udSGabV71+OKHU0Uod9DBOUsIYRFYvZCQBGwPwMm86WTK9n5DmwqbP
	 c1VlKSsBaZNVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] mm/damon/core: prevent size quota overflow in
 the temporal goal tuner
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260920122411.610213-2-donggeunyoo.kernel@gmail.com>
References: <20260920122411.610213-1-donggeunyoo.kernel@gmail.com>
 <20260920122411.610213-2-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 12:34:43 +0000
Message-Id: <20260920123444.54D631F000FF@smtp.kernel.org>
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
> 10000, that is 429496 bytes.  It lands on exactly zero when the quota
> is a multiple of 256 MiB, which includes the 1 GiB that
> Documentation/admin-guide/mm/damon/usage.rst uses in its example, and
> a zero effective quota makes damos_quota_is_full() true on the first
> test of every charge window.  The scheme then applies nothing while
> the goal is unachieved.  Other wrapped values are simply wrong, and
> any product below 10000 divides to a zero effective quota too: 429497
> gives 0, 500000 gives 70503.
> [ ... ]
> effective quota becomes ULONG_MAX / 10000 instead of a wrapped value.
>=20
> Fixes: af738a6a00c1 ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEM=
PORAL")
> Cc: <stable@vger.kernel.org> # 7.1.x
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920122411.6102=
13-1-donggeunyoo.kernel@gmail.com?part=3D1

