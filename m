Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1971FB1
	for <damon@lists.linux.dev>; Thu, 24 Sep 2026 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281321; cv=none; b=tN7KHAITlrJ9HcpEVMsFG3DrwfeDMk3OAfpFACNv+In3VdaUzmo5FyzfU4sgvSyIJyzD6hqXYxSGn0jGDeCyDhwyEaHz9DVCkpFIUXiKeM1VVDXf4TmPunADd+B2QnVO3a7PTWNYRDuX+bAKJNy5x9/lH/dPRIj/1gjcDJPgCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281321; c=relaxed/simple;
	bh=8myU76XZUSqIXsKZ4agDWbW67o6dysACkaIg4YilaS4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XDJRwfEQKEZ/7WM/8Z9OfzIm8m1XSfC0ywujlK7A3Nc1+9AWCvP141ZhR4VQdIYwE7XXbnWr91wriTII9h1ccWD5YFDcikJiJAsSbl9AlFK75m1YDbYqp7t+1iHJav2mvNVHRUJtpopIlIPumWnhMexe6YH+RwQRckMr+Oil7LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwDpXfxq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwDpXfxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6655B1F00893;
	Thu, 24 Sep 2026 20:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790281319;
	bh=8myU76XZUSqIXsKZ4agDWbW67o6dysACkaIg4YilaS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CwDpXfxqvcCUkY1HqWHEnw0Wl+PpRE2gATddDNaC5zacM0UByg3o5UfaSANfl9Rju
	 dYPe2Q4xmoImxOUfs1JQY7I+uUB9s92A4JHBqQ8tPbJ/ibbrAFFGp+im51MJt1TLC/
	 t6nCfgJwFZ+vXSv+k4qNSfimDtY3X4Nuk0Bu0fhYnE8311a/tjtEj1o+OgwQdL7FBL
	 j1NxKVBSNwVMtZIdhSC5sUvPgm7KECZgT5tzQtqf3KGJrOKgWBaLvHgsaKECn3CID7
	 TUQayhl7HGQEqGxHOTkDbtffJWRpVBk7M8MpDTnYXWHYVlHm2hzHxwPpAygF4//gBS
	 ENq9oLdgpk5tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/core: preserve the quota passed to
 damon_new_scheme()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260924201615.4478-2-kmehltretter@gmail.com>
References: <20260924201615.4478-1-kmehltretter@gmail.com>
 <20260924201615.4478-2-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 20:21:58 +0000
Message-Id: <20260924202159.6655B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_commit_ctx() first commits the running context's parameters to a
> temporary context for validating proposed updates. When
> damon_commit_schemes() creates the temporary schemes, it passes the
> running scheme's quota as the quota parameter of damon_new_scheme().
>=20
> damon_new_scheme() calls damos_quota_init() on that quota before copying
> it to the new scheme. This clears the running scheme's effective quota,
> feedback input and charging state. Even an update rejected with -EINVAL
> loses the running quota state.
>=20
> For a size quota, this discards the bytes already charged and allows the
> scheme to use a fresh quota before the reset interval has elapsed. For a
> goal-driven quota, the consist tuner loses its accumulated input and
> restarts from its minimum input. A time quota loses its throughput
> estimate and falls back to the initial estimate.
> [ ... ]
> Fixes: 60bd24f272d0 ("mm/damon/sysfs: test commit input against realistic=
 destination")
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/r/20260702212143.0CB6D1F00A3D@smtp.kernel.o=
rg/ [1]
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924201615.4478=
-1-kmehltretter@gmail.com?part=3D1

