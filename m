Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49421396B76
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 04:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014228; cv=none; b=iFODgV4EP1j/7F0z/8FqKHAEv34diL3gQXkEqQHcB7bdm7/1EHxxltB+7Kj6YiQAuJOndxMt0vyzw8W9mWKGNEG4rRu/0cvyxovc2Hor+Kbgp8DXpaHkjoKeTwDjMbUAA/EDHGGYMR05bbAsUNwk368jPU4uFjolPzqGobnFp1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014228; c=relaxed/simple;
	bh=e69MCGIHpaCyxGGjGSrTQUAiocExpb80ry0v8wQVQNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sv5k3dKcyf1Pn4AHLC3NfmX51ZiSQYVaJwI0ISI4Pt+h2qZpj+zc4qDtCBVTId8+8htStWkvGm03oKMdY5A5ORVCs08lui8XyaY58qA8ivtbSisLTHI0qLwJg7o5lBGqPIAiWhgAB9rNKWmMA3nEdYWBwjUYAAmqHLS6SyfYvrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSCvpFY2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSCvpFY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2021F00893;
	Thu, 10 Sep 2026 04:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014227;
	bh=Js7QT0GboUdEtvzK6lcVpGKT1RV+dP5tO+eJN025m1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XSCvpFY2StRGGgjVTs3ALfxS6Ux99f+eN5pvpdCgE4QBaEeRQlIk30+2pYO/+QrnZ
	 4RLZWPfLhnF94NrK+txuR14D14f+rs6u7ADNfyuc6G8jLmgB/u7j22MqCt9a5/1NuY
	 GKLbqVKhf1FtG0DR/RTn7IU3zUHgSW+Iu3DM0UMKXqSqt5HSnZKeYypeJ/JVBRg7fq
	 fmBG+IQraRIjVPei+GTFPOMAUGSXdVXg/ygb5+3Vd5QPZmh7p1jHXMGVPEuBUGHYej
	 1cfNLY6KQHZX0AefGt2gi4sanMhCsx6IjlGl28m4AqmNoFTBDyQFbw8P8sJVA3ea9X
	 ZGKIsKoAOxq5w==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.1 5/7] mm/damon/sysfs-schemes: support probe_hits_wsum damos core filter
Date: Wed,  9 Sep 2026 21:23:38 -0700
Message-ID: <20260910042340.162267-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910041833.58BD81F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 10 Sep 2026 04:18:33 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The commit introduces `DAMOS_FILTER_TYPE_PROBE_HITS_WSUM` to the core layer and updates `damos_commit_filter_arg()` to properly copy its state (`range_min` and `range_max`), but fails to update the corresponding KUnit tests that rigorously check this exact behavior.
> --
> 
> commit 90fc8bb11dba04367743217a5b35954829f87d9c
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: support probe_hits_wsum damos core filter
> 
> This commit extends the DAMON sysfs interface to support the probe_hits_wsum
> input for scheme core filters. It updates the scheme build logic to set up
> the min/max probe hits weighted sum range as provided by the user.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 4d9147d2a269e..d9dd4ee0442c7 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> 
> [ ... ]
> 
> > @@ -2844,6 +2847,14 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
> >  			}
> >  			filter->sz_range.min = sysfs_filter->range_min;
> >  			filter->sz_range.max = sysfs_filter->range_max;
> > +		} else if (filter->type = DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
> > +			if (sysfs_filter->range_min >
> > +					sysfs_filter->range_max) {
> > +				damos_destroy_filter(filter);
> > +				return -EINVAL;
> > +			}
> > +			filter->range_min = sysfs_filter->range_min;
> > +			filter->range_max = sysfs_filter->range_max;
> 
> [Severity: Low]
> Does the addition of this new filter type require an update to the core
> KUnit tests?
> 
> In mm/damon/tests/core-kunit.h, there is a switch statement in
> damos_test_commit_filter_for() that checks parameter validation for each
> filter type:
> 
> 	switch (src->type) {
> 	case DAMOS_FILTER_TYPE_MEMCG:
> ...
> 	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
> 		KUNIT_EXPECT_EQ(test, dst->sz_range.min, src->sz_range.min);
> 		KUNIT_EXPECT_EQ(test, dst->sz_range.max, src->sz_range.max);
> 		break;
> 	default:
> 		break;
> 	}
> 
> Because DAMOS_FILTER_TYPE_PROBE_HITS_WSUM isn't handled here, it falls
> through to the default case, bypassing validation.
> 
> Additionally, the orchestrating function damos_test_commit_filter() doesn't
> appear to have a test block for this new type. Should these KUnit tests be
> updated to maintain test coverage for the new feature?

It would be good to add a test, but not necessarily together with this series.
I will consider adding such tests as a followup in future.

> 
> >  		}
> >  
> >  		damos_add_filter(scheme, filter);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260910040319.147037-1-sj@kernel.org?part=5
> 


Thanks,
SJ
