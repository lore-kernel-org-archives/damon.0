Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5122AD37
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 03:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925529; cv=none; b=mWo+2hAdAi7yEOr3g7bv8f8Pljk/g7H8shvlfdU2yzTsruJWEo/38RAazaQxw7/chMa9JfxZYd4eh+5GUNudBfIiSsfhsbsLNrpOKBGINe66BoFU7MvTSYNm44owMdrWVFjq/owkgYieReqk/fqvkdkQ7HUbyuGugtYDp0f/qKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925529; c=relaxed/simple;
	bh=yN672SbwFgRbwFJ4CJE5QSjDusLJQ468NurgZnE05Ng=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jx25F8r21MEl4Mr6yZ8HVt9RzRni6lYQDESqnlfh/wE2K4mwj7HU/Klh0yAvH0N9NmpP9b8aO+mt3ghsJcGhSvuioAyjbG5XrG7fSSuLO4TRs5lQT/QJQEulYA4BKoCpSOfM+fU8eDJXu5EKlgwua+/zRh5ngfiZc8TZj2ldax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMBVVShh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMBVVShh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29C71F00A3A;
	Wed,  9 Sep 2026 03:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788925528;
	bh=B7hSH+RE9sZfVQJb0NbutC5xcf2p0L1KI0q2H0ehRg4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YMBVVShhV6xLliRF8QqB6ZAScjn+4jFds9XFZJFBT5xhgyj1IXNmDAyaAIdb5uXIR
	 JvyVUkV+uPIzpESs9h1H+BAAdI1pcfP4yROIRlpRG0F/mS4oK6gkHXO6JH84KhZrQS
	 b5am/sqcsA/uX89xI5wfxJD/09hoNylPC5Cq3aQUeqQzWPPhqH6Za4ehlKmBtvHiEJ
	 nPIMgllyj0hP2bWC6ilXXmyHmzntexWJko6irJBHi9YvW/Rr3s3VNc0i2gBysqdNwF
	 BBgJzlRFTJAGJ0XojkEWgDopMaasGMtpbuwT/xIGnqOPT7Mpzu9Pdp5LlkhkHT54ml
	 pu2Ik7ImNAiow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] mm/damon/tests/core-kunit: catch test failure in
 test_merge_regions_of()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909033832.132107-1-sj@kernel.org>
References: <2026090808-phoniness-repaying-46f0@gregkh>
 <20260909033832.132107-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 03:45:27 +0000
Message-Id: <20260909034527.D29C71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Typo in the early exit condition causes the unit test to silentl=
y skip validation on successful execution.
--

commit 8cca227124d565ed51f4791e649f908f0754a67f
Author: SJ Park <sj@kernel.org>

mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()

This commit adds an early exit to the damon_test_merge_regions_of() unit te=
st
to catch when the region merge expectation is not met. By skipping the
per-region test loop on failure, it prevents potential NULL pointer
dereferences.

Link: https://lore.kernel.org/20260715031002.108504-3-sj@kernel.org
Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org [1]

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 6687778752728..c1f0be6746abd 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -264,11 +264,14 @@ static void damon_test_merge_regions_of(struct kuni=
t *test)
>  	damon_merge_regions_of(t, 9, 9999);
>  	/* 0-112, 114-130, 130-156, 156-170 */
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
> +	if (damon_nr_regions(t) !=3D 6)
> +		goto out;

[Severity: Medium]
Should this check compare against 5 instead of 6?

When damon_merge_regions_of() works correctly, it merges the target into
exactly 5 regions, matching the KUNIT_EXPECT_EQ check immediately above.=20

Because 5 !=3D 6 evaluates to true, a successful test execution will jump o=
ut=20
and silently bypass the per-region validation loop. The validations will on=
ly=20
execute if exactly 6 regions are produced, which would indicate a test fail=
ure.

>  	for (i =3D 0; i < 5; i++) {
>  		r =3D __nth_region_of(t, i);
>  		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
>  		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
>  	}
> +out:
>  	damon_free_target(t);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909033832.1321=
07-1-sj@kernel.org?part=3D1
