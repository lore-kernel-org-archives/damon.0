Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC823AEB27
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 01:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783475140; cv=none; b=AvyU0MFArfLHLD4Fty7a/96OYwSL0dedeukEhGeon9g4aOZm6QzYGLs9cVdqAAH1oPdu0dZgEdR+vpzLKrEYvVyFr8YbMGF0950KxhF0NplkQKe/M7QRxzkWU4rXcC2lRtDgO7VTMq7crfPMvINYp6R8y4BMHqjMzs0SkSUWHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783475140; c=relaxed/simple;
	bh=4CR93EgnuofZ9/UILGPrGBAgisaDa1O7e+nB9RaZWfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CHB2qw2hIrnNBG9APtfCxEyiR83jnB11SdSUrjzP4cnqb+ptBMSBxEei9ALzb79KhBjnFKOaD9Ito/yBsf9zvPg+xGLqiIgW51F4j57CnSvwuIUf0ZR27WWli84LqaWyoIiDtIve8EGEp1Ok1eOV7Di5cod1Qfdla+Xa5IsAqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLL2oXvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLL2oXvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F0E1F000E9;
	Wed,  8 Jul 2026 01:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783475138;
	bh=R6IL0J3ZEi0hb3ZYtEEuDozM8M42hDqJ4kCe73ouPIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KLL2oXvfJHaItQVPMkfhoh89OFWCYZxJ9HFTf15gUHIBVM7vwr7nRgQmDjxsz00EA
	 jFMTprcsC87+aIoYWKY6G7y15sCg1fh7V6qIqIc+PbKqh+uYCSRR9oyIo+OEkcsris
	 6DZ1EcZB4vX7ttuBqSrHlJ2ANy1ZcuZFf/gaLrkRujubWubi8DrK1M54u/cha4wlcs
	 sTIuKgHLRuH6IfmD3hJywzqVHBZD3EIOrJJdIkTRIYK6+fG6MYF5/lcicEuRUZiTWU
	 yALmWOW18OKRuoL5avdXgvbwuzHTJW8S5jeN7+VX5V5se5KzeqaKnd104t4yT0l/2p
	 WLWFGhlhYuyTw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 5/7] mm/damon/core:
 s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260708013252.95888-6-sj@kernel.org>
References: <20260708013252.95888-1-sj@kernel.org>
 <20260708013252.95888-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 01:45:37 +0000
Message-Id: <20260708014538.58F0E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch series introduces a build failure in the DAMON KUnit test=
s by leaving behind a broken, unreferenced test function.

Pre-existing issues:
- [High] Functions `damon_sample_bp_to_count` and `damon_sample_count_to_bp=
` silently overflow their 32-bit unsigned integer calculations when the num=
ber of samples per aggregation interval is large.
--

--- Patch [5]: [RFC PATCH v1.2 5/7] mm/damon/core: s/nr_accesses_for_new_at=
trs/nr_samples_for_new_attrs/ ---
commit a57666ff806c37c47b5fa8f1ce4de7e70616ac6d
Author: SJ Park <sj@kernel.org>

mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
   =20
This commit renames damon_nr_accesses_for_new_attrs() to
damon_nr_samples_for_new_attrs() to clarify that it can be used for any
positive sample count, not just nr_accesses.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 718268df27fa7..800ff6b6d2473 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -890,22 +890,21 @@ static unsigned int damon_sample_count_to_bp(
>  	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
>  }

[Severity: High]
This isn't a bug introduced by this patch, but renaming this function
propagates a flawed arithmetic calculation.

Can the 32-bit unsigned integer calculations in damon_sample_count_to_bp()
and damon_sample_bp_to_count() silently overflow?

If a user configures a large aggregation interval and small sample interval,
the total samples per aggregation can exceed 429,496, leading to 32-bit
arithmetic overflow during ratio conversion.

In damon_sample_count_to_bp():

    mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));

The mult_frac macro expands to perform a 32-bit multiplication of count
(or its remainder) by 10000, which overflows for counts exceeding 429,496.

Similarly, in damon_sample_bp_to_count() (just above this context):

    return bp * damon_nr_samples_per_aggr(attrs) / 10000;

The multiplication is performed in 32-bit unsigned integer arithmetic, which
overflows if the total samples per aggregation is large.

> =20
> -static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_acce=
sses,
> +static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr,
>  		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
>  {
>  	return damon_sample_bp_to_count(
> -			damon_sample_count_to_bp(nr_accesses, old_attrs),
> -			new_attrs);
> +			damon_sample_count_to_bp(nr, old_attrs), new_attrs);
>  }
> =20

[ ... ]

[Severity: Low]
Does this patch series leave behind a broken, unreferenced test function
in the DAMON KUnit tests?

When building the kernel with DAMON KUnit tests enabled, this causes a build
failure due to an implicit function declaration.

In mm/damon/tests/core-kunit.h:damon_test_max_nr_accesses():

    KUNIT_EXPECT_EQ(test, damon_max_nr_accesses(attrs), 1);

The function calls damon_max_nr_accesses(), which was renamed in an earlier
patch in this series but was left unupdated in this abandoned test function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708013252.9588=
8-1-sj@kernel.org?part=3D5
