Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC123ACEF1
	for <damon@lists.linux.dev>; Mon, 22 Jun 2026 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139046; cv=none; b=NiAKMdUjSb2bRodUJWebj9dH2vGUwBB/WXnKjzmeFGH6BtHAnWlTktffzCvHBt045eQArwK8hM/ZE6cobg2ftmxY+yN2gfdTgnn/djthEyy/fk9E/h5h6mENm1HYzrl7byu/IBm7O4xsUIL94XKa+XYNjNqKZk8gnpL4xCIAsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139046; c=relaxed/simple;
	bh=OfGz1Owx/4+t9jaddWgU2CiEgMpkVbuWVP9NnLc+0w8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lBqS38N+/RYmFoKBKU1dpr/CNQuBaOyktBPETqXPUs749FF0vnwgEUjOfzI43+HJ8CnfWRq5O3euk8RQQvpydb0rOAYJ+nQ3QwsS7iez6btCG/f5O2670mJHVAt/ckJiGh49XmxpzhCgPIy1FBexWVEEqZHHpA8BFX7AjHNduPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5DDQYr1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5DDQYr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CCA1F000E9;
	Mon, 22 Jun 2026 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782139044;
	bh=ehyqVNLMRKTkQSm9hLqP9m8BmUE8DOTemeDlHQVni58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y5DDQYr13Wv+aQNYJtznTnViMdJd1eF40UUmltQ2ZnhNV8zrxRMajQ540ubnxOBh8
	 8lKj5uj4gjKUVkyGVqigg/C9kdrduASxsdbXNrOdB79R0fw1rYO1xiNiwveesCMh4A
	 fvNI9hjUeQEkH906C1bFDvwruv1EX88eqXkBFi5PaBNZGMcQtDoePFJZElFP7oZT1v
	 Tfa6ls8P15FdUgQ9JbgmunDgew9sX241MSEhqfUg4TgsERBHcWhsU9DiGEGAgmHZA5
	 C1QgQdZh1p0Qbi51tVo3ZQeM5baixqYVd7U4fls8nDivpYQ5FR71Y9Dgj4cObwdzK4
	 gZtmyrz0ptVgw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 05/18] mm/damon/core: use
 damon_nr_accesses_mvsum() in __damos_valid_target()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260622142139.30269-6-sj@kernel.org>
References: <20260622142139.30269-1-sj@kernel.org>
 <20260622142139.30269-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 14:37:24 +0000
Message-Id: <20260622143724.A7CCA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] 32-bit integer overflow in damon_nr_accesses_mvsum() leads to inco=
rrect region access frequency scores.
--

commit 31c0062dc1352032d1779ac0035b6e2cd5a7461a
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: use damon_nr_accesses_mvsum() in __damos_valid_target()

This commit changes __damos_valid_target() to use damon_nr_accesses_mvsum()
instead of reading the nr_accesses_bp field directly. This provides a more
error-tolerant moving sum access score for DAMOS scheme logic.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 8a7351b4a27c2..b9d47599f5cbc 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2128,10 +2128,11 @@ static void kdamond_tune_intervals(struct damon_c=
tx *c)
>  	damon_set_attrs(c, &new_attrs);
>  }
> =20
> -static bool __damos_valid_target(struct damon_region *r, struct damos *s)
> +static bool __damos_valid_target(struct damon_region *r, struct damos *s,
> +		struct damon_ctx *c)
>  {
>  	unsigned long sz;
> -	unsigned int nr_accesses =3D r->nr_accesses_bp / 10000;
> +	unsigned int nr_accesses =3D damon_nr_accesses_mvsum(r, c);

[Severity: High]
Does this introduction of damon_nr_accesses_mvsum() expose an integer overf=
low
on 32-bit systems?

When calculating the access frequency score, damon_nr_accesses_mvsum() calls
mult_frac() which performs an intermediate multiplication:

mm/damon/core.c:damon_nr_accesses_mvsum() {
    ...
	left_window_bp =3D mult_frac(left_window, 10000, window_len);
    ...
}

If a large tracking window is configured, for instance with an aggr_interval
of 1,000,000 us and a sample_interval of 1 us, window_len becomes 1,000,000
and left_window can reach up to 999,999.

The intermediate multiplication for mult_frac() uses the type of left_windo=
w,
which is unsigned long. On 32-bit architectures, this intermediate value
(e.g., 999,999 * 10000 =3D 9,999,990,000) exceeds the 32-bit maximum of
ULONG_MAX (4,294,967,295), causing a silent wrap-around.

This results in a completely incorrect left_window_bp value and drastically
undervalues the access frequency of memory regions.

Since __damos_valid_target() directly ingests this faulty access score, cou=
ld
this regression lead DAMOS schemes to inappropriately skip highly active me=
mory
regions and break memory reclamation or migration mechanisms on 32-bit syst=
ems?

> =20
>  	sz =3D damon_sz_region(r);
>  	return s->pattern.min_sz_region <=3D sz &&

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622142139.3026=
9-1-sj@kernel.org?part=3D5
