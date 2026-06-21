Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D642050
	for <damon@lists.linux.dev>; Sun, 21 Jun 2026 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782065396; cv=none; b=mVRz2EHGNaaMYU8lTWVf1v2pcP+WzOpj/jCmLk2FyCh9LqFKCy7EWSO++XJFZagQehyh3zT8wH2YseMtCvzkS9Z1dVg3tVS3zi1Jnf6esyrPRAz30Q5dJFitKonsOfIPkX+/CBGnCJw0m+1dWebzExB3zZdh6E+lusPo3SEKXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782065396; c=relaxed/simple;
	bh=F8hKRIciYATc+UM3ygbXtxfXXKiwYEBdypRCNCLSGZ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jW037uKO9iwCaLHn5N9wr/BBFDkH4R6hT+CHFPmRmTZ7XxwCO94Rg2ug9D73jIxWPr0KCEVsEEeSg13TrwcGSI2nsXYXF4ulHPsL3kX/PmtRjL48qZQ8D+/bHvilD9wSr1/8cLZypiW69qB8HNfUnX0UsODOl8vpuvlg/R089CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0S4J1oU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0S4J1oU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442ED1F000E9;
	Sun, 21 Jun 2026 18:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782065395;
	bh=NYYKLhitE0IaNG9lar7LO27WmG57QjUBVaodG4AZi0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D0S4J1oUQ620p41NB/b3SuNq6bxFLIyYrWD4PCuEdtCDYctrTmPiteSphIFtqfbXD
	 tD1FmIxT4XOZDkl9D3xotFa2XIUMCDajRe1GxavrOsAT0XnCOlyoSOGWCsihKoD9Gb
	 +1JVsrM9HoXau6D2Oen28hU/DqXPSbsxNVHo2HSKDqazdij5f6LvKPwWcoB4jJCpP9
	 AF1XVeN5QXzDzbukax8ZwW+DwtWi/6wH7sXFFqfVseQ+gYsBqSn0pXe0Nd/vgMiF7K
	 FQxYIhuamySzL0W1lU91fJnAUG2VLHsrUAU/9nlGByc2sds/V/OUvVX1tWbaWNrohb
	 VscQlmDuZUlBw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 09/17] mm/damon/core: remove
 damon_verify_merge_regions_of()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260621155715.87932-10-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
 <20260621155715.87932-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 18:09:54 +0000
Message-Id: <20260621180955.442ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing size-weighted averaging for `last_nr_accesses` upon region=
 merge causes erroneous age resets and corrupted metrics.
--

commit 6d81112ae07520e7dd1deaeaf23912d17d4d8a57
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: remove damon_verify_merge_regions_of()

This commit removes the damon_verify_merge_regions_of() validation check.
The nr_accesses_bp field is no longer used for a real purpose, making this
validation unnecessary.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index ee19238d62f5f..94d8ec2965451 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3114,20 +3114,6 @@ static void damon_merge_two_regions(struct damon_t=
arget *t,
>  	damon_destroy_region(r, t);
>  }

[Severity: High]
This is a pre-existing issue, but does damon_merge_two_regions() need to
calculate a size-weighted average for last_nr_accesses alongside nr_accesses
and age?

Currently, when two adjacent regions are combined, last_nr_accesses appears
to be omitted from the averaging logic, causing the newly merged region to
strictly inherit the left region's history.

Because kdamond_merge_regions() iterates its merge loop until the region
limit is satisfied, a region merged in the first iteration will be evaluated
again in the second iteration:

mm/damon/core.c:damon_merge_regions_of() {
        ...
        if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
                r->age =3D 0;
        ...
}

Since r->nr_accesses was size-averaged but r->last_nr_accesses was not,
this comparison evaluates against mismatched data. Could this frequently
cause it to erroneously reset r->age to 0?

If so, this seems like it might break DAMON schemes that rely on region age
(such as pageout schemes meant to reclaim cold memory) by continuously
resetting the region's age. It might also skew policy frequency scores in
damon_nr_accesses_mvsum() if damon_set_attrs() is called from a user context
before the aggregation interval resets.

> -#ifdef CONFIG_DAMON_DEBUG_SANITY
> -static void damon_verify_merge_regions_of(struct damon_region *r)
> -{
> -	WARN_ONCE(r->nr_accesses !=3D r->nr_accesses_bp / 10000,
> -			"nr_accesses (%u) !=3D nr_accesses_bp (%u)\n",
> -			r->nr_accesses, r->nr_accesses_bp);
> -}
> -#else
> -static void damon_verify_merge_regions_of(struct damon_region *r)
> -{
> -}
> -#endif
> -
> -
>  /*
>   * Merge adjacent regions having similar access frequencies

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621155715.8793=
2-1-sj@kernel.org?part=3D9
