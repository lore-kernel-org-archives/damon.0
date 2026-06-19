Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF043368AC
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902986; cv=none; b=ogFAQPVY1EeXq9QhQG2m2ouoKCjzC/YZf2z8tJ1xPpzqtjZIUz9BkqSc/4BtTdozcMVuePxVtWhhi0GVeCTlACplg9S/Pf+DUMsUqI9WlvYbluwWn8XrDu2d5tajOvIpY0tS8nkE1fzezjrX875hiFMrnf0+9VOU+kddwVRZx3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902986; c=relaxed/simple;
	bh=vm19XUGTp5B5LKA3OFSzGN9PogbDgP94rW5dgIutrqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WxYD/0tp2PoKucShz+y8SW4ndEUf/TkMw8WNibA2D2AK42dnL3OIVdXtGeHEbV25ZRzYQmqmC5FhffJKKmDBKrVsnx5somN9QJ8sG4bteGi7egL0zsB0e9jNKVcrBtYkvGr0LKJU5CNjeawGJMh7NZGz521CzTghVKahGYU7Ddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ab8sIh9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab8sIh9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89AD1F000E9;
	Fri, 19 Jun 2026 21:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781902984;
	bh=L9kECLL3qXobjv6JfJ1OKhEGbZeKsT8vCNbDGS8OF08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ab8sIh9j7//v191zK3RiGqJEPvGQWH/RTIR1iN+6K0jqxCFs1/ZPLGe+Jt3h54aD7
	 iRGKjPi7UScSenSPC+xuLwq0p4DPNiu72GjVuBfsqNbIJQdiknj7HZagYHj52uHkC8
	 o6HLmtA1/cZ/MhazfGcPjea6ByACWNOFB7TK0idFuxgGNZeIz3bwaVSiu3bUV10QM2
	 CKNAFjxk50Cnv8BX0TsZlo7mTEaS4zSaaYtc1emaqTs9NiwWrYY+IfbUf9seBxE2tY
	 kKfbaegLC/0PeTjEBNDgoKBu5Qd6mDlH7PUwcVe/ejV1nhyA8WAcFqPKGYV6XWL2HK
	 0qQl9yB/BASHQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon: handle zero sampling interval in
 damon_max_nr_accesses()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260619205144.150664-1-sj@kernel.org>
References: <20260619205144.150664-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 21:03:04 +0000
Message-Id: <20260619210304.A89AD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch replaces a divide-by-zero crash in `damon_max_nr_accesse=
s()` with a divide-by-zero crash in caller functions such as `damon_hot_sco=
re()`. When `aggr_interval` and `sample_interval` are 0, `damon_max_nr_acce=
sses()` returns 0, which is then used as a divisor by its callers.
--

commit ca6b91d50d3b7234e014066f6e835c8aab906f49
Author: SeongJae Park <sj@kernel.org>

mm/damon: handle zero sampling interval in damon_max_nr_accesses()

damon_max_nr_accesses() causes divide-by-zero if sampling interval is
zero.  Fix it by handling the case.

Link: https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 6f7edb3590ef9..83b43d8ffef38 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -1065,8 +1065,10 @@ static inline bool damon_target_has_pid(const stru=
ct damon_ctx *ctx)
> =20
>  static inline unsigned int damon_max_nr_accesses(const struct damon_attr=
s *attrs)
>  {
> +	unsigned long sample_interval =3D attrs->sample_interval ? : 1;
> +
>  	/* {aggr,sample}_interval are unsigned long, hence could overflow */
> -	return min(attrs->aggr_interval / attrs->sample_interval,
> +	return min(attrs->aggr_interval / sample_interval,
>  			(unsigned long)UINT_MAX);
>  }

[Severity: High]
This is a pre-existing issue, but does this patch shift the divide-by-zero
crash to the callers of damon_max_nr_accesses()?

If a user configures DAMON via sysfs with both sample_interval and=20
aggr_interval set to 0, damon_set_attrs() allows it because the validation=
=20
check evaluates to false (0 > 0):

mm/damon/core.c:damon_set_attrs() {
	if (attrs->sample_interval > attrs->aggr_interval)
		return -EINVAL;
	...
}

With this patch applied, damon_max_nr_accesses() prevents the initial
division by zero by defaulting sample_interval to 1. However, it then
evaluates min(0 / 1, UINT_MAX) and returns 0.

Later, when a DAMOS scheme with a quota is evaluated, damon_hot_score() uses
the return value as a divisor:

mm/damon/ops-common.c:damon_hot_score() {
	...
	freq_subscore =3D r->nr_accesses * DAMON_MAX_SUBSCORE /
			damon_max_nr_accesses(&c->attrs);
	...
}

Since damon_max_nr_accesses() now successfully returns 0, wouldn't this
trigger a divide-by-zero exception in damon_hot_score() instead?

Could we explicitly reject an aggr_interval of 0 in damon_set_attrs(), or=20
ensure damon_max_nr_accesses() always returns at least 1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619205144.1506=
64-1-sj@kernel.org?part=3D1
