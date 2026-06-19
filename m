Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BBB4964F
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781898753; cv=none; b=c/xG2kxVz87mY9BOqhLkmPPXts+/KWN9mfrsJ0GpDWZ0n461siM1sEo50g4KlLnai7GDUvckqiyNc/aC5oIIO0qHICGskshYC7M3uCAs1jaRUJyxfKdcX4vgRgYLfDRWkT29UC9VrH7yA4mK2gT1uWLRpNFFOKODX6CBcOOv4Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781898753; c=relaxed/simple;
	bh=uxMie8sD97AzGwteBhpTkRPj8/c7hEUDfBce12LLOi0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H4T1yvXlPNk9CBx+P/Sfhs+efPxiQ9jsBJksua5TMT50Nb8qTAl+9V/xwvVV9JDPD8iRTE0wRm848sK1XjVTK6LZxFCOFUhd+ib0srtyhIeQhvFs8J69v2JYosiwXVi6T0wXavPnI/xQsadeHkRIAe8pxbyVzT4OCILlvIEDwiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9pobXt5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9pobXt5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C9B1F000E9;
	Fri, 19 Jun 2026 19:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781898752;
	bh=7kLeJz/s12b3hKOPA5jWSD7eKMo5TasOGlVWzXW4M3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z9pobXt5sQQzdFKJkxD+2lDNomZSVX1DSNlvvnf34xUFatSj1ogxf3uMezptTsGjp
	 KXOsydz/yqJEGPsiUwgBOUIN+CdnWrUpvK0ymXRE+Gm8P8eVPPqZHDDMwlHFe7Gk+V
	 oIBEGADj8wfe8PgnNkcGzpntKegVcE5i+DJ1xqm4xlQVeVd/9F4tqwRWYXFFyPvewX
	 hvMh3w44RsCxkRbp9g1hrfzHtdNJwK9yU1cCSN1CPx6uCcYj7TWAoIBkE1BwpBdnjO
	 l+mbWsoIUkE5hHl3oF0iqiL5fkjMK1G/hJzZ66+HTPfMZIsw24iPXs7U8HcraT1L79
	 Eu39RzyZuiQsQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 09/13] mm/damon/tests/core-kunit: remove
 nr_accesses_bp setup and tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260619193415.73833-10-sj@kernel.org>
References: <20260619193415.73833-1-sj@kernel.org>
 <20260619193415.73833-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 19:52:31 +0000
Message-Id: <20260619195232.61C9B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Divide-by-zero in `damon_nr_accesses_mvsum()` when `aggr_interval`=
 is 0.

Pre-existing issues:
- [High] Divide-by-zero in `damon_max_nr_accesses()` when `sample_interval`=
 is 0.
--

commit 6519e9a3b09dd0793b79fa00b085d57ba68bc353
Author: SeongJae Park <sj@kernel.org>

mm/damon/tests/core-kunit: remove nr_accesses_bp setup and tests
   =20
DAMON core unit tests set up nr_accesses_bp for representing realistic
damon_region, and also test the field.  nr_acceses_bp is no longer being
used for a real use case.  Remove the setup and tests.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -210,6 +210,61 @@ static struct damon_probe *damon_nth_probe(int n, st=
ruct damon_ctx *ctx)
[ ... ]
> +unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
> +		struct damon_ctx *ctx)
> +{
> +	unsigned long sample_interval, window_len, left_window, left_window_bp;
> +
> +	sample_interval =3D ctx->attrs.sample_interval ? : 1;
> +	window_len =3D ctx->attrs.aggr_interval / sample_interval;
> +	left_window =3D ctx->next_aggregation_sis - ctx->passed_sample_interval=
s;
> +	left_window_bp =3D mult_frac(left_window, 10000, window_len);
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: High]
If `ctx->attrs.aggr_interval` is 0, `window_len` evaluates to 0.

Since `damon_set_attrs()` accepts configurations where both `sample_us` and
`aggr_us` are 0, does this lead to a divide-by-zero here?

When the kdamond thread evaluates user-defined schemes, it appears to
unconditionally call __damos_valid_target() -> damon_nr_accesses_mvsum().

Could this regression be triggered via the DAMON sysfs interface to cause
a crash?

> +
> +	return damon_mvsum(r->nr_accesses, r->last_nr_accesses,
> +			left_window_bp);
> +}

include/linux/damon.h:damon_max_nr_accesses() {
    ...
    static inline unsigned int damon_max_nr_accesses(const struct damon_att=
rs *attrs)
    {
        /* {aggr,sample}_interval are unsigned long, hence could overflow */
        return min(attrs->aggr_interval / attrs->sample_interval,
                (unsigned long)UINT_MAX);
    }
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing
divide-by-zero risk if `sample_interval` is 0.

Does this calculation cause an immediate divide-by-zero exception?

Userspace can configure `sample_us` to 0 via sysfs, which avoids validation
in `damon_set_attrs()` if `aggr_us` is also 0.

Since `damon_get_scheme_score()` unconditionally invokes
`damon_max_nr_accesses()` when evaluating user-defined schemes, could this
allow a user to intentionally crash the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619193415.7383=
3-1-sj@kernel.org?part=3D9
