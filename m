Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D5E39CCE2
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 04:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013914; cv=none; b=o2vWTb0R0lheCfdcO5MCujcasARxDZiHvoFMPngGKEhi5mjMuHOhbDZ0iwfICxfX/kECM0gYMrmJbKwh696Eum0xQ4e2aWIQaCcqgGA0UbD1DQ/YysULUsa2jmQh5xPWeDg5bemH+zzAA8hyR8feFanQjBaO8lsrmU5NwA1Eo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013914; c=relaxed/simple;
	bh=i6O3WMAXAadxYgrdmd0GuL4HM+T0HQ3RmtDFYqytg4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iw29iWlejNJTK82cWeFjWBdx5FKkwzQ636gNdrDdp7uNm4SxkYR64rTtXA72NAhjl+fWpgn9EX/D6qGfUo1FTBPb/qIP/70AXZOE69lK2YNK6VD3at7ChuwiE4SU+Oqx41QUubOvapI4PrLYrvu8Slfmg37snAiFy5bTZ6YMWXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKjfi+WL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKjfi+WL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BD81F000FF;
	Thu, 10 Sep 2026 04:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013913;
	bh=Fj4j8TyuJVOGkcE0hMq3efc1TTP6plO3JZ8tI/94yUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OKjfi+WL7zIXDaNYzlL8f8yZYLtegHqiGTg1qtdhnSLMsQv8z3iKYwh8RkZhF2JS/
	 GS5SN5Okp4zgKD8Zr8o9a9/5yaXjbCQt0BuOlOQaCEqN7b8cUIpmAaR+1aspRdKHcm
	 i13zWqIcyLp5em9VkTpVeQsg2DSsEiSRG7z+QHfjkVci63WfvkuqaQ9FzTXOG4KXNV
	 c2fRNsHbc7oGXUEbSk79KikmVnbJOXvzAeh8RHfj9CkWAnlpdBZsF6kBpzHMN0dkkN
	 wwa7KsUDU049bQsIx3T5bg7R1cvvluEKsvd4ICDOdYU4Fg1h/S04PifEmjVjECXZSP
	 awq9pEbKjFN2g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.1 5/7] mm/damon/sysfs-schemes: support
 probe_hits_wsum damos core filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910040319.147037-6-sj@kernel.org>
References: <20260910040319.147037-1-sj@kernel.org>
 <20260910040319.147037-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:18:33 +0000
Message-Id: <20260910041833.58BD81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit introduces `DAMOS_FILTER_TYPE_PROBE_HITS_WSUM` to the co=
re layer and updates `damos_commit_filter_arg()` to properly copy its state=
 (`range_min` and `range_max`), but fails to update the corresponding KUnit=
 tests that rigorously check this exact behavior.
--

commit 90fc8bb11dba04367743217a5b35954829f87d9c
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs-schemes: support probe_hits_wsum damos core filter

This commit extends the DAMON sysfs interface to support the probe_hits_wsum
input for scheme core filters. It updates the scheme build logic to set up
the min/max probe hits weighted sum range as provided by the user.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 4d9147d2a269e..d9dd4ee0442c7 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c

[ ... ]

> @@ -2844,6 +2847,14 @@ static int damon_sysfs_add_scheme_filters(struct d=
amos *scheme,
>  			}
>  			filter->sz_range.min =3D sysfs_filter->range_min;
>  			filter->sz_range.max =3D sysfs_filter->range_max;
> +		} else if (filter->type =3D=3D DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
> +			if (sysfs_filter->range_min >
> +					sysfs_filter->range_max) {
> +				damos_destroy_filter(filter);
> +				return -EINVAL;
> +			}
> +			filter->range_min =3D sysfs_filter->range_min;
> +			filter->range_max =3D sysfs_filter->range_max;

[Severity: Low]
Does the addition of this new filter type require an update to the core
KUnit tests?

In mm/damon/tests/core-kunit.h, there is a switch statement in
damos_test_commit_filter_for() that checks parameter validation for each
filter type:

	switch (src->type) {
	case DAMOS_FILTER_TYPE_MEMCG:
...
	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
		KUNIT_EXPECT_EQ(test, dst->sz_range.min, src->sz_range.min);
		KUNIT_EXPECT_EQ(test, dst->sz_range.max, src->sz_range.max);
		break;
	default:
		break;
	}

Because DAMOS_FILTER_TYPE_PROBE_HITS_WSUM isn't handled here, it falls
through to the default case, bypassing validation.

Additionally, the orchestrating function damos_test_commit_filter() doesn't
appear to have a test block for this new type. Should these KUnit tests be
updated to maintain test coverage for the new feature?

>  		}
> =20
>  		damos_add_filter(scheme, filter);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040319.1470=
37-1-sj@kernel.org?part=3D5
