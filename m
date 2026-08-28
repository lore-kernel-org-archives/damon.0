Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE322405EB
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787883801; cv=none; b=aoMwT9kf4vUnaxRYVW6yqbwJ25g6HBy5ozK1/rfm9fqPe25QrT9beuYhkE7IPyi/vvSQCercb4/gpGKeympU3s3lpV/+96RIAyAXI1TYRn+s9SGhvbZoj2TPABnCoemPP0CvUbnnc3wwX7Jja2WA0h1MpFzIk+TJ7IlKSTW8U+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787883801; c=relaxed/simple;
	bh=I7wiy8UpZdtH/v0OkMnzKtW/M73fXJpMnk6tjxufCdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jw+yjKzvDAaj92VnbzagFSkB75Abr9z3vHf1aR1ckzDKuWqVeyhqXdka4HXcZgr+fJoUs/0zTfNIvF56dqZLriubaTdO6fv4aT4NY+nTixGo8JymzhffGajuEo8K6VK9D+5PNy0TG7C861tp9p7DJqS2gcfP70OxlJoUKVJVnho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLGcnXn6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLGcnXn6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB321F000E9;
	Fri, 28 Aug 2026 02:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787883800;
	bh=XNy08MKzB8UlDvVBa+A5Smj7dWPd6ey+6DHLUs36GsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aLGcnXn6rcjFG25Trhysr8a3oBNtaU0jsxUr0xUInfSpPyYBuFFPj9ys6E5usESCQ
	 BiV2gaV1g6JghfJUo40CG2fUUYNqVGSvo3FjLRJXIsyJBl5GkX117aX2d0eodiLEzU
	 w6WCxNDJCW1vNAvvqHrQ/b8LRm0kpZDDc0ObGDXsfwti7zHE1LdtapufDQabhTlARC
	 Vz/GHtoYyTjPxJZmeH0aEqIBVj/aHHvcmEiWx64J86Pyr4e6t1WXvV3TG2rxqdUkax
	 AIUsioI6F7NmF6W9mlAV/nIWDbWjuG83R9XEK04QbTVjeYY6NRrSdm+glP7LlVCTNP
	 ocvfW71vQ+PLQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 3/4] mm/damon/core: copy nid for eligible_mem_bp damos quota goal commit
Date: Thu, 27 Aug 2026 19:23:10 -0700
Message-ID: <20260828022311.122481-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828015635.1B2181F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 28 Aug 2026 01:56:34 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The KUnit tests in `mm/damon/tests/core-kunit.h` were not updated to verify the bug fix for the `DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP` metric.
> --
> 
> commit 2e3746fc6a44e14dd4bda23054c960b1e043e013
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: copy nid for eligible_mem_bp damos quota goal commit
> 
> damos_commit_quota_goal_union() does not update the nid union field when the
> goal metric is DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP. This commit adds the
> missing update to ensure it does not use a garbage nid value.
> 
> Link: https://lore.kkernel.org/20260827045035.94611-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index b0c8e22ab5404..086d2ac57259f 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1136,6 +1136,9 @@ static void damos_commit_quota_goal_union(
> >  		dst->nid = src->nid;
> >  		dst->memcg_id = src->memcg_id;
> >  		break;
> > +	case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
> > +		dst->nid = src->nid;
> > +		break;
> 
> [Severity: Medium]
> Since this case was added here, do we also need to update the corresponding
> KUnit tests in mm/damon/tests/core-kunit.h?
> 
> Currently, damos_test_commit_quota_goal_for() is missing the case for
> DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
> 
> mm/damon/tests/core-kunit.h:damos_test_commit_quota_goal_for() {
>     ...
> 	switch (dst->metric) {
> 	case DAMOS_QUOTA_SOME_MEM_PSI_US:
> 		KUNIT_EXPECT_EQ(test, dst->last_psi_total, U64_MAX);
> 		break;
> 	case DAMOS_QUOTA_NODE_MEM_USED_BP:
> 	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
> 		KUNIT_EXPECT_EQ(test, dst->nid, src->nid);
> 		break;
> 	case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
> 	case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
> 		KUNIT_EXPECT_EQ(test, dst->nid, src->nid);
> 		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
> 		break;
> 	default:
> 		break;
> 	}
> }
> 
> Should a test case for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP also be added
> to damos_test_commit_quota_goal() to ensure the fix is validated?

I'm working on this in a stealth mode ;)  Will post as a separate series, since
it is definitely not a fix.

> 
> >  	default:
> >  		break;
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260828014659.121058-1-sj@kernel.org?part=3


Thanks,
SJ
