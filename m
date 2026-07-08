Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0740802E
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519432; cv=none; b=h4kplsZSkI/kO+as0PfpSqIhtc/VKQIe0A11chHx6DkEatZSxJz6sZTB3CA6SF7woVp74azFZCwkzPASnVacsYI4JSVyFlujpsy7mc9KK1zGt9QXRrxWJHJ37ECBk5sOJ5UYfyWT2fdo0QMmHYEoiynIDYQAQRka/1xEztY5RRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519432; c=relaxed/simple;
	bh=3DmJLx73LO7N7euc8jARUMzK+hNzRFDaIhRUF8C58ZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YeiGmak9cmT8sJqYAj8bf1PzoTUYjNooVx111jwP0RZDq0ZTnoqG4ywMy/F9H1z5Fu9aBPiIQjTr8hpw/QisGB0x3zq5mkrpqg7N/4N0xs+EyjE9g5abSYOypKaIyecz915H5rozgXuZ3CdkltkLc7rOVr7vrpoi97t2pYZgHsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsoqgUvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsoqgUvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4F91F000E9;
	Wed,  8 Jul 2026 14:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519431;
	bh=Qledq3Rpd9kWyf+JIS/dUhnlK3W+PgN8N1ewzWh8cxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EsoqgUvKcb8PZrmOV6IRfstxTPQTOWv9M179aqq9LbceuMY9h4tH0yDCqW9GWyBIo
	 CWnQ7a6f0B7v05vu21JcEVHNJ72ajzL7Bax/qf7OLwZ4KK1B6VLYF15Mbar9yqC5p/
	 I6JSjZGFhvuM6kMPcroA3Y6Ni7tVQb74vmURWpXrjGT16vvIf8HxaZ4pvxJGht/TF/
	 kKTgWVoK4Z4moQKlE/CAbSwhrH+P5kfurXYRpDebPSSJ7BBcBnzcpiXuaSX9KP27KF
	 QdYCkbl73NNrI3yIXkfXf52Lhv2gGEDqm24xza04iUz+5fPDgyF1sH4NGAp3HPY0rg
	 qiO5cvC1P1Y5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] mm/damon/core:
 s/nr_accesses_to_accesses_bp/sample_count_to_bp/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260708135359.122587-5-sj@kernel.org>
References: <20260708135359.122587-1-sj@kernel.org>
 <20260708135359.122587-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:03:47 +0000
Message-Id: <20260708140348.4A4F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The functions `damon_sample_bp_to_count` and `damon_sample_count_t=
o_bp` are susceptible to 32-bit integer overflows when evaluating large agg=
regation intervals.
--

--- Patch [4]: [PATCH 4/7] mm/damon/core: s/nr_accesses_to_accesses_bp/samp=
le_count_to_bp/ ---
commit 75d19025f9846da2b8b1718a4f36d8064a4aa832
Author: SJ Park <sj@kernel.org>

mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/

This commit renames damon_nr_accesses_to_accesses_bp to
damon_sample_count_to_bp to better describe its actual behavior of
converting a positive sample count to a ratio.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index dea63083917b0..718268df27fa7 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -883,19 +883,18 @@ static unsigned int damon_sample_bp_to_count(
>  	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
>  }

[Severity: High]
This is a pre-existing issue, but does this multiplication overflow if the
total samples in an aggregation interval is large?

If an administrator configures a large aggr_interval compared to
sample_interval, making the sample ratio exceed 429,496, multiplying bp
(up to 10,000) by the number of samples could exceed the 32-bit limit of
unsigned int, causing incorrect bound calculations.

> =20
> -/* Convert nr_accesses to access ratio in bp (per 10,000) */
> -static unsigned int damon_nr_accesses_to_accesses_bp(
> -		unsigned int nr_accesses, struct damon_attrs *attrs)
> +/* convert sample count to ratio in bp (per 10,000) */
> +static unsigned int damon_sample_count_to_bp(
> +		unsigned int count, struct damon_attrs *attrs)
>  {
> -	return mult_frac(nr_accesses, 10000, damon_nr_samples_per_aggr(attrs));
> +	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
>  }

[Severity: High]
This is also a pre-existing issue, but can this use of mult_frac result in
an integer overflow?

The mult_frac macro evaluates (count % samples) * 10000 in 32-bit
arithmetic, which might overflow and produce an incorrect basis point
ratio when the sample count is very large.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708135359.1225=
87-1-sj@kernel.org?part=3D4
