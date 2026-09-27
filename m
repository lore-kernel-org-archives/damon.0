Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821163ECBE5
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512238; cv=none; b=eNZIHe2fZryKdGs9819KuVfTxMF1+zJT1cdhNK5YOwvV9dYANMt0ByGGRjI5MhUJ3iA+3dSz7aoK+ri8NyZPx6IoDnKrdWOB7KF4+dhgZFbdcSdhEWhxTktYIO2taop9pOTwhz8qUtM+y9+I6Tzsgked3OZsDcPnUKEngiI41gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512238; c=relaxed/simple;
	bh=Yo5F7kOhcIyk/77FijQpQRQPqTdBh3XFRPAU0YXLIH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVUAJLBlMGH1PQrXHJ0kPQ36dT/nBktCmlh2lcH8tNCKCcRL2hobEA+0uxgiHahFAm0Y7BzXT+hnyqHgV7AJ2U1coKbfQJM2/ro+XjsmBMqg/zo9N9nnwB7/oFSUwOWHK/hRlnqJvSL1txiSLKNyN2wZaMHSyBXXJ7ab4CIxqys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsfkbF4d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsfkbF4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167671F000FF;
	Sun, 27 Sep 2026 12:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790512237;
	bh=iebkZUxaovyW3xvOdmedA2yfiS3IsNOm0Jwewf+KWfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bsfkbF4dt326R6RKn2qnvsItRMEvpuh8vV/N4qC6jv+T69vEpnyddxJl9CvfdBIBY
	 H0CG410jLfOVjQPvb5wZrHzfhnHoRo29z04dAPegVdfeNN/zQsXhlAZUGOMXq3L2Gx
	 W1x/RGW8v1GN146vFWkqDnLhidImfijCBaC20sfNX4i6ORkumqKXjsXiDhxwegqTZU
	 Wb09KBnbAQzMrvL+PZW7dKgkdyTpJHAmDwqUP1gQY80sm47HTKBYuiI2tKuvzPcWBB
	 kNEhq/3z9LNkZIle3/48A67XWPhbkL/vsPQi4PijTognY9nTOYccK5LoJDcS1otZm9
	 mWYL96rC3D3GQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v4 2/7] mm/damon/core: add complement argument to damos_new_quota_goal()
Date: Sun, 27 Sep 2026 05:30:30 -0700
Message-ID: <20260927123032.57903-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927121229.7AE811F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 27 Sep 2026 12:12:29 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] damon: build failure in KUnit tests due to 'complementfalse' typo
> --
> 
> commit c13d1579fc49797d69a40d8e22286757e16cdd20
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: add complement argument to damos_new_quota_goal()
> 
> Extend the quota goal constructor, damos_new_quota_goal(), to receive and
> set the complement flag value. This commit also updates all callers to use
> the new signature.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index df84d9cc7d204..20bba7421a406 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -930,6 +930,7 @@ static void damos_test_commit_quota_goals_for(struct kunit *test,
> >  		 * Make it kfree()-able.
> >  		 */
> >  		goal = damos_new_quota_goal(dst_goals[i].metric,
> > +				dst_goals[i].complementfalse,
> 
> [Severity: Low]
> Does this code cause a build failure when compiling the KUnit tests?
> 
> In damos_test_commit_quota_goals_for() within mm/damon/tests/core-kunit.h,
> it looks like there is a typo (complementfalse) which will break the
> build when CONFIG_DAMON_KUNIT_TEST=y is set.

Good catch.  I will fix in the next revision.

> 
> >  				dst_goals[i].target_value);
> >  		if (!goal)
> >  			goto out;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260927120533.50484-1-sj@kernel.org?part=2


Thanks,
SJ
