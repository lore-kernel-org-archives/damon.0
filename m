Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B373845D0
	for <damon@lists.linux.dev>; Tue, 23 Jun 2026 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224128; cv=none; b=nGqsb6flHKsPJ257dSRnbUTPpLF8KYLCW+vxIfFHX1FsQijX5gUgZUqle1KrTMPlN51rSv1p/UB4AGHLX2jmpUCvlVSg6JJ/hZtlvve7ndrimj8w40ka/ZQmzkNRo2EMQlbT1pd7Ftu5OcAm6vYPUitZhV+Lp3SKJMYoZxmtXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224128; c=relaxed/simple;
	bh=Qhx2lfBjPapoGPGrUP3Jo9rOslZcu/9XqdhNfl//ObE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ryi6pJG7ESNUm4+wQWKULSfR/XvQwoIGJhUleP7Tf7fjyuH2TV0xi6DFNicyjzHJYltc8cV/crjD5xkOtkpWKMTawobb80WYoxiHXFEI8oa7EqT+ENUsxrtBMo4KfjYFJt1teYjg1CSFES5XhQfKKTJeI7OiUBA/MuXNn6xqbLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ea6SbRDO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ea6SbRDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044D11F000E9;
	Tue, 23 Jun 2026 14:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782224127;
	bh=Qd3V2shYzZjXQK20HsTz/EyRlCIt4xwphGH9DJ5P0zg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ea6SbRDO78pejx2NQGUqB/EZsqhtGe5zZg1G+ZKXFAyUWWw/zO3lP4hwgdnwCT3Qs
	 cPBFTo3j+HLQDatK1wC7GoP2oQBc+V/GoklYAmZ4Mr9A2iQzgwwGQKxI9Sa6LZ4VW8
	 xAy2FBW9cFnmUraHdGa65zOiCY501ggR6r80uzt+f7DEThXKeda5xpbwl4NJ1vEozV
	 7aP9fi6tzo7meQxumTsZX6Tr01sKTqzl9TuhyDo1FKvuC0A37G6JoRPSI07Uo2DHIr
	 qQ5ysonAuvJz391YjW1z5pPNoWIOA5sQcm/EoFkQKjza67i8D0//tNTwvjd2LH0ZDP
	 ewa1t4enJxMjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/ops-common: handle extreme intervals in
 damon_hot_score()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260623135834.67189-1-sj@kernel.org>
References: <20260623135834.67189-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 14:15:26 +0000
Message-Id: <20260623141527.044D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Multiplication in `freq_subscore` calculation overflows 32-bit `un=
signed int` for extreme intervals, reversing region hotness prioritization.
- [High] User-supplied sysfs weights can overflow, resulting in a bypassed =
division and Signed Integer Overflow (UB).
--

commit 8323dd74c4905401bc8701431eb5fd1a6b12a452
Author: SeongJae Park <sj@kernel.org>

mm/damon/ops-common: handle extreme intervals in damon_hot_score()

Fix three issues in damon_hot_score() that comes from wrong handling of
extreme (zero or too high) monitoring intervals user setup.

Link: https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 5c93ef2bb8a97..d1842e2b00ef8 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -143,6 +143,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon=
_region *r,

[Severity: High]
This isn't a bug introduced by this patch, but could the freq_subscore
calculation overflow earlier in this function?

If a user configures a normal sample_interval (e.g., 100us) but a long
aggr_interval (e.g., 2 hours), r->nr_accesses can legitimately reach
72,000,000.

mm/damon/ops-common.c:damon_hot_score() {
    ...
    freq_subscore =3D r->nr_accesses * DAMON_MAX_SUBSCORE /
                    damon_max_nr_accesses(&c->attrs);
    ...
}

The multiplication of r->nr_accesses * DAMON_MAX_SUBSCORE (100) evaluates
to 7,200,000,000, which wraps around modulo 2^32, causing extremely hot
memory regions to be incorrectly scored as completely cold.

[Severity: High]
This is also a pre-existing issue, but can user-supplied sysfs weights
overflow and bypass the averaging division before this transformation?

mm/damon/ops-common.c:damon_hot_score() {
    ...
    if (freq_weight + age_weight)
        hotness /=3D freq_weight + age_weight;
    ...
}

If a user supplies weights for weight_nr_accesses and weight_age whose
sum is exactly UINT_MAX + 1 (e.g., 4,000,000,000 and 294,967,296), the
unsigned addition overflows to 0.

This causes the branch to evaluate as false, bypassing the averaging
division. The unaveraged weighted sum then evaluates to a large positive
integer.

>  	 * Transform it to fit in [0, DAMOS_MAX_SCORE]
>  	 */
>  	hotness =3D hotness * DAMOS_MAX_SCORE / DAMON_MAX_SUBSCORE;

Multiplying it by DAMOS_MAX_SCORE (99) here then overflows the signed int
result, resulting in undefined behavior.

> +	hotness =3D max(min(hotness, DAMOS_MAX_SCORE), 0);
> =20
>  	return hotness;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623135834.6718=
9-1-sj@kernel.org?part=3D1
