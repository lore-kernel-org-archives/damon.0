Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25203A873C
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935214; cv=none; b=iBE6djfjRTym+87jeroTK0+FwI1qdYS70vWRnlJhjYatGNCEDhGu3hgEffMeP0CGg9yZyGtrq5pQQ3bzI3HC8Xto3I8Wx4bv9aDfybp1Wm6WdSKwIqQryVel58b22IhQdO34te0dVpMNUXi8PcsqGnEtaS0Fe0yHOM6nJc3ee8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935214; c=relaxed/simple;
	bh=++nLD4CW/JIxaHgTRwIDBfDpPnRkCTRjFpLZWH3z0gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+U0WuZrHOu2EtelNP6aiOQXPMZqVn5UCkdFB9tFlkfS4TBff6kNSgA9WCxOSVK15L4kkdVfPh2u5gSUo8HzKPgHjHeM+oJIuyQE87UhkyRUM7Sklamd4G7d7LvGcEn8zWHyDj8Gc5bXtDERJX7b56XFYDFz7PQoMU7WeJX5TrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7horAq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7horAq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC701F00A3A;
	Wed,  9 Sep 2026 06:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788935213;
	bh=2KprQSR5vbBz6efSyX+euayQ90qAp2/bQabxYGVABco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l7horAq8pdzLsXkbZNd9tZJAOVVRay+D/RGbLxLbLjROAsDYEbnVziH6h+40ea3rA
	 JbAYh0jiAaSpTYIkYWRWFHc2rH86KOdonj87KRw2/cnp/HGv6xrFSm9MpJrglshsS2
	 Vv7QpM4VmHaJm81f9/CGYTCIj+ufNk7Gcd8y96l9nrXGoaRlVKI8mq5Vly5XJN22nU
	 SezSulSqdF5b6OEDfSfHRJLuJhe8buD5WW0QiQO9A8L9bOJ1+w4lpniCBbscuM8Sod
	 9c6Y8xqtQXrY0I1w+W/7FZfPBL6Jzykk9ZDrtdMa/1y4mUKxiFfBICG4HUayX04XBG
	 CPIDQ38Is4YBQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.18.y] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Tue,  8 Sep 2026 23:26:39 -0700
Message-ID: <20260909062641.24252-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260909034527.D29C71F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 09 Sep 2026 03:45:27 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Typo in the early exit condition causes the unit test to silently skip validation on successful execution.
> --
> 
> commit 8cca227124d565ed51f4791e649f908f0754a67f
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
> 
> This commit adds an early exit to the damon_test_merge_regions_of() unit test
> to catch when the region merge expectation is not met. By skipping the
> per-region test loop on failure, it prevents potential NULL pointer
> dereferences.
> 
> Link: https://lore.kernel.org/20260715031002.108504-3-sj@kernel.org
> Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 6687778752728..c1f0be6746abd 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -264,11 +264,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
> >  	damon_merge_regions_of(t, 9, 9999);
> >  	/* 0-112, 114-130, 130-156, 156-170 */
> >  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
> > +	if (damon_nr_regions(t) != 6)
> > +		goto out;
> 
> [Severity: Medium]
> Should this check compare against 5 instead of 6?
> 
> When damon_merge_regions_of() works correctly, it merges the target into
> exactly 5 regions, matching the KUNIT_EXPECT_EQ check immediately above. 
> 
> Because 5 != 6 evaluates to true, a successful test execution will jump out 
> and silently bypass the per-region validation loop. The validations will only 
> execute if exactly 6 regions are produced, which would indicate a test failure.

Nice catch.  I will fix.

> 
> >  	for (i = 0; i < 5; i++) {
> >  		r = __nth_region_of(t, i);
> >  		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
> >  		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
> >  	}
> > +out:
> >  	damon_free_target(t);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260909033832.132107-1-sj@kernel.org?part=1
> 


Thanks,
SJ
