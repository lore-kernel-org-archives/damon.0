Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86C639CD1B
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050178; cv=none; b=LdZs83uJmMMvMEEospw+4NkoQqxv0rsZit9MC0n1U7K923gWVVtQva3xPYDHD1AA1iHgSGMDJfHvyEQn2Ei0lHz9/oqXHDZuTkiNX2EjKZ4O9WeP97+23bIc+RTyaZ9AXihvaQ0/MP1XGSwC0Oq4R1fjG+2o6T4wWKPXj+4Meb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050178; c=relaxed/simple;
	bh=CF5qW96FOSj78mmP4UFO3cUprQE6OvA9mGPsSbuckdk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BFIXtekOdmCpnXGDDD2OBg+A4OVvHGOFRJZWKXo2dgZr02d553n+7Cx6WOOGfqEeuoIq7R8T3zHqqQk3USnjobtFCflleoJGLm+ugygjdZO6lGfNRwjyrckXYAU5eRQyNl9pf8PtLawq/0ccMRuK5OaPQskDZCbIhqem6BKse4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SurOrmFL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SurOrmFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26E01F0089B;
	Sat,  3 Oct 2026 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050176;
	bh=a0ini9v6jmun+XVq7Czjt/Jwe5v6I0xK8fn2SfgLdr0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SurOrmFLYmbl63YbFV+s9u27Kztqol0+1AcJ9YaiI4BvUilmPqx5BTTBy+WM/sySf
	 H2NiVN448Nut8iSgX9ABa6zmthPgzH2ZhqZuCy6WNi6cpexuKY6TBFBE59G8dH/23Z
	 wwmCIpLVDJJR3tV5J/3vPqpzaR1JH6h2nAhzXSHLgDz3znyNuwdRlQ/4ENuIly8BLe
	 hQjHoAogzu7CS3cUJQlOklWSyI79ojPZW+TXB5Mdree+wRjP4z60L9lq20WVckly87
	 rwlV0bZnc3562EwgcFN2RycT68N8QkvyWVTm5rD4C7I4ygR6jr7ji4QH/Xd9QAwXuy
	 EqpXg5DFvCATA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] mm/damon/core: don't skip damos_adjust_quota()
 while esz is not zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261003154818.24786-1-sj@kernel.org>
References: <2026100318-preteen-hazelnut-d38b@gregkh>
 <20261003154818.24786-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:16 +0000
Message-Id: <20261003175616.B26E01F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] mm: commit message references nonexistent damos_quota_is_set()
- [Low] mm: outdated comment for damos_set_effective_quota()
--

commit bdd4b48218af232c248d2db96f0af460e859f59e
Author: SJ Park <sj@kernel.org>

mm/damon/core: don't skip damos_adjust_quota() while esz is not zero

DAMOS could unexpectedly stop working when a user disables quota using the
online parameters commit feature. Fix it by correcting a wrong quota
unset check in damos_adjust_quota().

Link: https://lore.kernel.org/20260916135020.86483-1-sj@kernel.org

> Other logic for catching that uses damos_quota_is_set(), which understands
> the fact and therefore checks the effective size quota in addition to the
> user setup.  Fix the issue by using damos_quota_is_set() in
> damos_adjust_quota() to determine if its works should be skipped.

[Severity: Medium]
The commit message states the fix uses damos_quota_is_set(). However, the
code below checks the fields directly inline. Should the commit message
be updated to reflect the inline check?

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index fe91b296f4c66..bd46a63b611cf 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1087,7 +1087,7 @@ static void damos_adjust_quota(struct damon_ctx *c,=
 struct damos *s)
>  	unsigned long cumulated_sz;
>  	unsigned int score, max_score =3D 0;
> =20
> -	if (!quota->ms && !quota->sz)
> +	if (!quota->esz && !quota->ms && !quota->sz)
>  		return;

[Severity: Low]
With this change, damos_adjust_quota() can proceed even when quota->ms and
quota->sz are zero. This allows damos_set_effective_quota() to be called
later in the function during a new charge window:

	if (!time_in_range_open(...)) {
		...
		damos_set_effective_quota(quota);
	}

Does this make the comment above damos_set_effective_quota() outdated? It
currently states:

/* Shouldn't be called if quota->ms and quota->sz are zero */
static void damos_set_effective_quota(struct damos_quota *quota)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003154818.2478=
6-1-sj@kernel.org?part=3D1
