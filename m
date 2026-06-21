Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404F31F151C
	for <damon@lists.linux.dev>; Sun, 21 Jun 2026 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057782; cv=none; b=RTwLj0rPZqXO+VIuF7c4JfmgzYWrHg/h4cVjhD4FPtvGWSfOK1kc1pGL6tL1eltE68AG11EpRE0UJ3FQKX+15lNqCBoGOn3duMR6a7PWda1ZKFuICuyEr3EEpG21Xn5E0cp78hecpKs+ZHepn+qDTqirF3zwl1Ae+GLN+f+EIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057782; c=relaxed/simple;
	bh=ZYd+TBgA4nkknrsQgrsIHuqLMcuamf5X8X30R6pQpCs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CFnx/2Vhq9hf5Bux39tW8MLLOrFcFON2JRuaNzefbgdDsObxz2TdYJGMJ1O28VM+jbyA8JXelwciB33FlvdtGnok5H621E+1G/maUqaGk0HjGxf1+lpsM3zm3lq/iJpUu38asKp1bs1w+jNS0YyifoMQyB8dZ+FjRgJha9woBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3tXFBo6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3tXFBo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD861F000E9;
	Sun, 21 Jun 2026 16:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057781;
	bh=4f8Jv7NkJP/te3BhQagZ7MYYu2FgVVQt1NvCTTG7aL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O3tXFBo6S53NSrdr8wStsgTlS7DdON9BbxV4yoU96l1Dc6c0sRW641GEHusv/i91L
	 jRa166uOepMZzhyhEdxiKjqb6g3JG2DL/+kUAfqY0GuPqagB92d5mlYmoEgnA7w1SN
	 uYHqZXRHUj6AmY7WJhJDmLTXaTz2z+Dgvf8i9MwlqklsAqjEgqidSo1YbRPNhxj41X
	 1hZ+/J4ewJFjqy3ufu6TpCNGbqf/o9cBv5bsMhdR4CyjYWox4zpmoCfW4ScBbqkqDn
	 LEGQr2nxew8Q76+H4GrNciEm0S9b2Ds2dBmUoHuz1MY9tksxIQjNuzX9zYqMwCj1Qm
	 AMdB9oaeiCx7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: handle zero intervals in
 damon_max_nr_accesses()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260621154808.86431-1-sj@kernel.org>
References: <20260621154808.86431-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 16:03:00 +0000
Message-Id: <20260621160300.EBD861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The patch resolves a divide-by-zero crash but inadvertently in=
troduces a critical out-of-bounds heap array read and write when updating t=
he region score histogram.
--

commit ba1da1a76126be43fbfd5ff0c59d54a52b8cddf8
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: handle zero intervals in damon_max_nr_accesses()

This patch modifies damon_max_nr_accesses() to avoid a divide-by-zero
when the user sets the sampling or aggregation interval to zero. It
ensures the denominator and return value are at least 1.

Link: https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 6f7edb3590ef9..888570f55b416 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h

[ ... ]

> @@ -1065,9 +1065,13 @@ static inline bool damon_target_has_pid(const stru=
ct damon_ctx *ctx)
> =20
>  static inline unsigned int damon_max_nr_accesses(const struct damon_attr=
s *attrs)
>  {
> -	/* {aggr,sample}_interval are unsigned long, hence could overflow */
> -	return min(attrs->aggr_interval / attrs->sample_interval,
> +	unsigned long sample_interval;
> +	unsigned long max_nr_accesses;
> +
> +	sample_interval =3D attrs->sample_interval ? : 1;
> +	max_nr_accesses =3D min(attrs->aggr_interval / sample_interval,
>  			(unsigned long)UINT_MAX);
> +	return max_nr_accesses ? : 1;

[Severity: Critical]
If sample_interval and aggr_interval are set to 0 via sysfs,
damon_max_nr_accesses() now safely returns 1 instead of panicking.

However, damon_set_attrs() validation succeeds because
attrs->sample_interval > attrs->aggr_interval evaluates to false (0 > 0).
Because damon_update_monitoring_results() then skips resetting
r->nr_accesses, it can retain a previous large value.

In mm/damon/ops-common.c:damon_hot_score(), the frequency subscore is
calculated using the return value of damon_max_nr_accesses():

freq_subscore =3D r->nr_accesses * DAMON_MAX_SUBSCORE / max_nr_accesses;

Since max_nr_accesses is 1, a large r->nr_accesses will result in
a hotness score that exceeds DAMOS_MAX_SCORE and is never explicitly
clamped.

Later in mm/damon/core.c:damos_adjust_quota(), this score is used
directly as an array index:

c->regions_score_histogram[score] +=3D damon_sz_region(r);

Does this allow an out-of-bounds heap write when the histogram array
is indexed by the unbounded score?

>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621154808.8643=
1-1-sj@kernel.org?part=3D1
