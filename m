Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04A5429825
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433200; cv=none; b=PoRKhnexN3upCTy71rZ4EUmzYfTBXujKvyKudAfThTGgFTcV4iuKKieTfDcC6bX+ayQgBRPM5gAFZQMj0YFl7V6Rpf6AS/BIuOmHqn/+xrJvf/1p0uq7iVkanjrd32lJrCD4KZSlTHbvijI4uKmLPtMEM86Q8T6yl7dPQck5hxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433200; c=relaxed/simple;
	bh=KhMi2H+8QGA+lmV3OMO5j9j9geQ2hyiRIGLTUp2xx80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oZerYPv5BWJi8aQERU/lxmFYDqzktGX4lDsvb5o6HRNhrQWq1jHrDc4uTQASNaEuw9k7cophSqX3/acs/mLzLHBs3U8WJ43HBAfteIkLoXJaLEHhJizuFwpPoxyiP9zmD8COYMVY+Bq/hPw0Fe0rg+H0YLEMMQ6+yR3CO3Vup/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2rLp8g5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2rLp8g5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449861F000E9;
	Tue,  7 Jul 2026 14:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783433199;
	bh=UmEZ99ZQ8mdSavD6tEEAmr7ligBD5PxDcDH1g+dvF3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W2rLp8g5gFKpzLXICQ9zmvFuqTiq7irWgEP/kOBfKMBOiIt9VtpZiXjcEyuV5F2NY
	 qX47B/nJQsHVooSMa74opnUGji8E0dheeNuLfLbqtC2I5xEvEe4vHurtbSDNa8+yro
	 zxKAs0BNlKcBlyG8ake8Lck9ZzZtKyaN7KN8+aB3mkwLUgtFvX3dEPjWvjq/xTbfv/
	 VtFsSWG9Qxe9DiHGLp2bENK8q75p6F14qzA3lMfj0F06Gza0dVpqmGNubtQmN2YdUF
	 7pal70qbqL9A3mbpm80P1u3rwA1tjOpHbx9hl8deH43Ts1nI59AV3drz2BwF2df5a0
	 9qv5JwSv7OFKA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 6/7] mm/damon/core: update probe hits for new
 parameter commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707135038.90068-7-sj@kernel.org>
References: <20260707135038.90068-1-sj@kernel.org>
 <20260707135038.90068-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:06:38 +0000
Message-Id: <20260707140639.449861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Silent integer truncation when assigning scaled `probe_hits` fro=
m `unsigned int` to `unsigned char`.
- [Low] The KUnit test update adds the required `ctx` parameter but entirel=
y fails to test the new `probe_hits` logic.
--

--- Patch [6]: [RFC PATCH v1.1 6/7] mm/damon/core: update probe hits for ne=
w parameter commit ---
commit 4d31f2a415d3352c6ff9b689ba6991c3606580b1
Author: SJ Park <sj@kernel.org>

mm/damon/core: update probe hits for new parameter commit

Users can update DAMON parameters at runtime. If the samples and/or
aggregation intervals are updated in this way, monitoring results depending=
 on
the intervals should also be updated for a more accurate snapshot. This com=
mit
updates probe_hits to reflect these changes.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index cda318806b65b..9a3ff0fe55a61 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -898,10 +898,32 @@ static unsigned int damon_nr_samples_for_new_attrs(=
unsigned int nr_accesses,
>  			new_attrs);
>  }
> =20
> +static void damon_update_probe_hits(struct damon_region *r,
> +		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
> +		bool aggregating, struct damon_ctx *ctx)
> +{
> +	struct damon_probe *p;
> +	int i =3D 0;
> +
> +	damon_for_each_probe(p, ctx) {
> +		r->last_probe_hits[i] =3D damon_nr_samples_for_new_attrs(
> +				r->last_probe_hits[i], old_attrs, new_attrs);

[Severity: Medium]
Does this code silently truncate the scaled sample counts?

The function damon_nr_samples_for_new_attrs() computes and returns an
unsigned int. However, r->last_probe_hits and r->probe_hits are arrays of
unsigned char.

If a privileged user updates DAMON parameters via sysfs such that the new
aggr_interval / sample_interval ratio scales the existing hits beyond 255, =
it
will silently truncate (modulo 256), losing the accuracy of the metric.=20

Should the result be explicitly clamped via min_t(), or the underlying type
widened?

> +		if (!aggregating)
> +			r->probe_hits[i] =3D damon_nr_samples_for_new_attrs(
> +					r->probe_hits[i], old_attrs,
> +					new_attrs);
> +		else
> +			r->probe_hits[i] =3D 0;
> +		i++;
> +	}
> +}

[ ... ]

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 9e631b19b184a..b4feef1a460f4 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -591,32 +591,39 @@ static void damon_test_update_monitoring_result(str=
uct kunit *test)
>  		.sample_interval =3D 10, .aggr_interval =3D 1000,};
>  	struct damon_attrs new_attrs;
>  	struct damon_region *r =3D damon_new_region(3, 7);
> +	struct damon_ctx *ctx;
> =20
>  	if (!r)
>  		kunit_skip(test, "region alloc fail");
> +	ctx =3D damon_new_ctx();
> +	if (!ctx) {
> +		damon_free_region(r);
> +		kunit_skip(test, "ctx alloc fail");
> +	}

[Severity: Low]
Is the new probe_hits logic effectively dead code during this test?

The test allocates a new damon_ctx via damon_new_ctx(), but it doesn't add
any mock probes to it, nor does it initialize any probe_hits on the test
region.=20

As a result, the new damon_for_each_probe() loop in
damon_update_probe_hits() exits immediately without testing the scaling log=
ic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707135038.9006=
8-1-sj@kernel.org?part=3D6
