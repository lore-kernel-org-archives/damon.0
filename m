Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AFA1A6822
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 01:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783475314; cv=none; b=bDtTFoAyJbbspmIgm41BtMaw6MCXQiSS88vqsos+O3GBRSssD2BQFImjzyh9tCpcZ8fDQ3K16O+jQn+b2y+e92gIz8tUBkLyJXwVZUlV3YAsoFpFHaIzvYy9jtr9rCf2yfb18mPeXvqsulllH++vFTBbjqh/0MdjIQtXIeNtmIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783475314; c=relaxed/simple;
	bh=eAHSjlVQByvxltDPw7EQLO5iMSZZ3SwoFk8hAI/rUG4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JQBs2RQroo8GyXcFV1tGAcjo5JrL0TfgKfcBMbmgNkEoC6pzn3/FcguX7G1NKLjytpEKbGEA9QpcpX+bLz/0lrrh5UHtYSRWYWr6yly9NTrrKB43kUX5diLWfdmKN8BI61/8XrNK66EXAjcyWcLZyw58OfmXDE5Azxmm9nDkx+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fN4IRcCf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fN4IRcCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD48A1F000E9;
	Wed,  8 Jul 2026 01:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783475313;
	bh=zrk4t+e41RnxfQnFin0syITrZxkazab6ABGet+svwRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fN4IRcCfybhlR0kQKDz3eqycxTwINzULveDbPq0brXJRj/RW7e6Avm+SxgiqcVOO3
	 7FVXzCJTtIt+OuwMmL4f0e571I7Ywg2hNXeOfcNnpatnyGns6t+CUVPIyYRImfPaxx
	 cRqRXCxXYReZijNbsmMNLGQDV3s32EMvJ4POxf8NeN1/Pp+Kbr3OUSoRCAcq5T8lJI
	 A34VophJiyHeiTuozEhGBZ+lGhYHcedG2ZeRKPU7Aeh0R593Gj3QFtR3nyZgxoV/M3
	 1UYszYj6Ey25u8iZwk7v4ch5aOQUQjLkn6pzFWSjB5ZrWXAZgfFLq3u1GVriXQmCj9
	 u34t1TGqkNzTw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 4/7] mm/damon/core:
 s/nr_accesses_to_accesses_bp/sample_count_to_bp/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260708013252.95888-5-sj@kernel.org>
References: <20260708013252.95888-1-sj@kernel.org>
 <20260708013252.95888-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 01:48:32 +0000
Message-Id: <20260708014832.CD48A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch series introduces a build failure when `CONFIG_DAMON_KUNI=
T_TEST=3Dy`. An unused test function references a removed function `damon_m=
ax_nr_accesses()`.

Pre-existing issues:
- [High] 32-bit integer overflows in `damon_sample_bp_to_count()` and `damo=
n_sample_count_to_bp()` can yield wildly incorrect sample counts when large=
 aggregation intervals are used.
--

--- Patch [4]: [RFC PATCH v1.2 4/7] mm/damon/core: s/nr_accesses_to_accesse=
s_bp/sample_count_to_bp/ ---
commit ea8982f99be13edf95a6b08dabc871567edc1f0c
Author: SJ Park <sj@kernel.org>

mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/

damon_nr_accesses_to_accesses_bp() actually converts a positive sample
count to the ratio.  Rename it to better describe what it really does
and not confusing for more general uses.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index dea63083917b0..718268df27fa7 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -883,19 +883,18 @@ static unsigned int damon_sample_bp_to_count(
>  	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but could this calculation
overflow and truncate before division when the product exceeds
4,294,967,295?

If DAMON is configured with a high aggr_interval relative to
sample_interval, nr_samples can be large. If a region is heavily
accessed, the sample count increases. Using 32-bit unsigned integer
arithmetic here might cause silent truncation, leading to hot pages
being misclassified as cold, and causing aggressive memory reclamation
of the active working set.

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
This is a pre-existing issue, but does mult_frac() also suffer from a
32-bit integer overflow?

mult_frac() expands to expressions that internally compute the remainder
multiplied by 10000 using 32-bit unsigned arithmetic. If the sample
counts and aggregation intervals are large enough (above 429,496), could
this overflow?


[Severity: Low]
Additionally, it looks like an earlier patch in this series removed
damon_max_nr_accesses(), but left references to it in
mm/damon/tests/core-kunit.h:damon_test_max_nr_accesses().

Does compiling the kernel with CONFIG_DAMON_KUNIT_TEST=3Dy fail due to an
undeclared function error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708013252.9588=
8-1-sj@kernel.org?part=3D4
