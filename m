Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E24412282
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432704; cv=none; b=UZJmRNo64+eWl55nBmGuU87vklp5Xqyy2WfyEK+O13t6Vk+v8WvnqZZmPQrxSvHBcJAN6i4RXjWOAtbH3LRyQ70AkB6MC5jKfX6DWLEeUxzsJwLvyRwI9sd7y2x9WfgZ8dmtccBBOHZQzWp1+pHfnBCzekRK/xAIpGbdpG9A8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432704; c=relaxed/simple;
	bh=+OlOFQZn5WbnqNfJJWNCMdqfa8XoDvLvYPyXOAgxMkw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tlUG9KlsZE1niq6jZ2XObuOHlYd+QRo3UXa+DOXoCVD97hd6bfH3AMkS2ypFhLQ8CxaG5o31ZybG9sVY89EQucPeGipw0rE1OSbCPUXgRhLCtp/UvL/+2gqQNJPifBU0FlTWJEdQRHtSnFyj2mXOnV/ypyoGNJuQ2+3WYf7fD3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZV8tKlOV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZV8tKlOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C8A1F000E9;
	Tue,  7 Jul 2026 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783432702;
	bh=cFEpnUDxOT83XMrbMjNfFN2AlI6MzRU2h+awLLlEjXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZV8tKlOV9/+oYuUig3nD8Uw71wjszDc+aSw0LDI8zgeZ/5jNH5sCmFzxw8WlOyX0E
	 xnrhxW/tEAxeMWnGNDc+b4IKL6aSsMQXrrzSOqMbVerkvd7ui9/pb0LOV4S4ErjECv
	 mXfRgLJBioACR4uNOX05q7nvD6hMqzAV6qsYWiVf89QPy+EUqEpUdh9MWFY9aT4+IM
	 7kjiyoD5BQGxwU0yxhO3uzvTnTpnSwQRwni3t0eSM4f3WLbrkBVTq/VF39QCBGEN5v
	 fN0qf5WLjzfKuiVqsONp3538du/dxceJgCNxuw8MAteUhBQz8qz5ZqzMQFZSAzjFOG
	 qppgdaWJvZXqg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 2/7] mm/damon/core:
 s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707135038.90068-3-sj@kernel.org>
References: <20260707135038.90068-1-sj@kernel.org>
 <20260707135038.90068-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:58:22 +0000
Message-Id: <20260707135822.A6C8A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Multiplications by 10000 in DAMON basis-point conversion functions=
 overflow 32-bit unsigned integers when the number of samples per aggregati=
on interval is large.
--

--- Patch [2]: [RFC PATCH v1.1 2/7] mm/damon/core: s/damon_max_nr_accesses(=
)/damon_nr_samples_per_aggr()/ ---
commit f63888911d3e9e966f4abf35c7d87cb96cc0e08b
Author: SJ Park <sj@kernel.org>

mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/

This commit renames damon_max_nr_accesses() to damon_nr_samples_per_aggr()
to better describe that it returns the number of samples DAMON checks for
each region per aggregation interval.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index a15005db82899..177e5abc981ef 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -880,14 +880,14 @@ static unsigned int damon_age_for_new_attrs(unsigne=
d int age,
>  static unsigned int damon_accesses_bp_to_nr_accesses(
>  		unsigned int accesses_bp, struct damon_attrs *attrs)
>  {
> -	return accesses_bp * damon_max_nr_accesses(attrs) / 10000;
> +	return accesses_bp * damon_nr_samples_per_aggr(attrs) / 10000;
>  }

[Severity: High]
This is a pre-existing issue, but does this calculation overflow 32-bit
unsigned integers when the number of samples per aggregation interval is
large?

In damon_accesses_bp_to_nr_accesses() in mm/damon/core.c, both accesses_bp
and the return value of damon_nr_samples_per_aggr() are 32-bit unsigned
integers. If an administrator configures DAMON with a large ratio between
aggr_interval and sample_interval (e.g., > 429,496, achievable via sysfs
with a 1us sample and 500ms aggregation), the multiplication will silently
overflow UINT_MAX, yielding much smaller thresholds than intended.

>  /* Convert nr_accesses to access ratio in bp (per 10,000) */
>  static unsigned int damon_nr_accesses_to_accesses_bp(
>  		unsigned int nr_accesses, struct damon_attrs *attrs)
>  {
> -	return mult_frac(nr_accesses, 10000, damon_max_nr_accesses(attrs));
> +	return mult_frac(nr_accesses, 10000, damon_nr_samples_per_aggr(attrs));
>  }

[Severity: High]
This isn't a bug introduced by this patch, but can this macro expansion also
suffer from a 32-bit overflow?

The mult_frac() macro adopts the type of its first argument, nr_accesses,
which is an unsigned int. Its internal calculation of the remainder
multiplied by the numerator (r * n_) evaluates as an unsigned int.

When the remainder r (which is bounded by samples_per_aggr) exceeds 429,496,
this multiplication by 10000 will overflow 32-bit boundaries, leading to
incorrect basis-point ratio calculations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707135038.9006=
8-1-sj@kernel.org?part=3D2
