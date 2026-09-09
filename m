Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0E637BE7A
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 05:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931193; cv=none; b=kKobY6QimElA41mXoypwOAQ6k0vLzbc11VQWxxGhtWpo4lIPMLcZ6N3lJejZlYzSUWqUvloKOd6zTbL1tAbkN4MX7y37AKmJ0qXSDaP7a3mLoT/azXfnGOaarLh9kFkKZd4jveAvE69iP+xLFNUjeXDx2mktQRP/AFFdQXHDFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931193; c=relaxed/simple;
	bh=Ix+W4j0Tqhp3G8mL2TwpzA/aeE9EGEAvk91z3xFN00k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oC41uLMxF5tl4G03iPqHdvS62cHlR22GJ8n21+wGOGDqeSTf001HxR/LYxgPXUrusUbIOviz85csyQAROY2fmzIAMvbqOt+2GdAm0XmNM08A8TfVPxWNoWs3Iq61MJAs/c6xYtLcwer7HIYdoX+yrAMFlC5vftL2xwBwu8yGLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsWdvwOV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsWdvwOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59241F00A3A;
	Wed,  9 Sep 2026 05:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788931192;
	bh=uOCoeIvHQa4iB/p8AHOWnzDagxiGA92XRRfBPoJbP0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jsWdvwOVbjLZ7f+8FlBl72hloxs1bRAcTcmXN7WMzGPzA8qiaAKCchBX6/ZkBP9Bh
	 d7duxbem9dsVt+6pzRkp+QbFWhdINYLMdRDmLdZUQDSgygUgcNLNTSJOiYLRUHkeMR
	 +pvXc8VB4Ejr2HUDG4le843/Wzogh8PgtosCRtGIC6h1JlQESUwe4hXEd5hpBqQZV0
	 GjXuA//2tQHX3J2nzwJfj1sUen1/Zf+EcaZMiwutLiRc1aFrWB5x3eZNuL9PHN4NSO
	 ECBzTVjO5aAvQmxVZuwi927mR7mD9KXPnaspE84xaShlqtBp5nXd4NsRE2u+/nA++v
	 y4nsNgOkk24eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7.2.y] mm/damon/ops-common: use nr_accesses moving sum
 for quota score
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909050753.232078-1-sj@kernel.org>
References: <2026090846-diffusive-headfirst-c45d@gregkh>
 <20260909050753.232078-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 05:19:51 +0000
Message-Id: <20260909051951.C59241F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The commit message claims to fix the issue using a specific help=
er function (`damon_nr_accesses_mvsum()`), but the patch open-codes the cal=
culation instead.

Pre-existing issues:
- [High] Switching to `nr_accesses_bp` exposes a pre-existing 32-bit intege=
r overflow when calculating access scores for large `max_nr_accesses`.
--

commit cf110be3286eb027df611ffacfd0b44818373cf7
Author: SJ Park <sj@kernel.org>

mm/damon/ops-common: use nr_accesses moving sum for quota score

This commit changes the quota prioritization score calculation to use the
moving sum of access counts instead of the fully aggregated count. This
aims to improve DAMOS performance when schemes are applied at any time.

Link: https://lore.kernel.org/20260719161136.90191-1-sj@kernel.org

>     Since commit 42f994b71404 ("mm/damon/core: implement scheme-specific =
apply
>     interval"), DAMOS scheme can be applied at any time.  At that time,
>     nr_accesses may not be fully aggregated.  But the quota prioritization
>     score is calculated using the not fully aggregated count.  As a resul=
t,
>     the performance of DAMOS could be degraded.  Fix by using
>     damon_nr_accesses_mvsum() instead.
      ^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
The commit message claims to fix the issue using a specific helper function
(damon_nr_accesses_mvsum()), but the patch appears to open-code the
calculation instead. Does the patch mismatch the commit message?

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 0bcad6b1e5b9e..6a969b1d29871 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -111,8 +111,9 @@ int damon_hot_score(struct damon_ctx *c, struct damon=
_region *r,
>  	unsigned int age_weight =3D s->quota.weight_age;
>  	int hotness;
> =20
> -	freq_subscore =3D r->nr_accesses * DAMON_MAX_SUBSCORE /
> -		damon_max_nr_accesses(&c->attrs);
> +	freq_subscore =3D mult_frac(r->nr_accesses_bp / 10000,
> +			DAMON_MAX_SUBSCORE,
> +			damon_max_nr_accesses(&c->attrs));

[Severity: High]
This is a pre-existing issue, but does switching to nr_accesses_bp newly
expose the hotness score calculation to an upstream 32-bit integer overflow
bug when max_nr_accesses is large?

The overflow occurs in mm/damon/core.c:damon_update_region_access_rate()
where r->last_nr_accesses is multiplied by 10000:

    r->nr_accesses_bp =3D damon_moving_sum(r->nr_accesses_bp,
			r->last_nr_accesses * 10000, len_window,
			accessed ? 10000 : 0);

If a user configures a large ratio of aggr_interval to sample_interval
(e.g., yielding max_nr_accesses > 429,496), r->last_nr_accesses * 10000
will overflow 32-bit unsigned arithmetic because both operands are 32-bit.
The corrupted value is then stored in nr_accesses_bp.

By switching from r->nr_accesses to r->nr_accesses_bp / 10000 here, this
overflowed value is now used to calculate the hotness score, potentially
leading to artificially low scores for heavily accessed memory regions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909050753.2320=
78-1-sj@kernel.org?part=3D1
