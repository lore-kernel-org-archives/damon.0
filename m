Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE343FF8BA;
	Tue, 26 May 2026 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807043; cv=none; b=dds1T3RzXewTWzhSIGpXkjhIiy9joi5Vg1jLpoT/jzt7N0g1VfVa7L76q77p4xZY646mG0BEriP9NmVfUWalcPnP1+J40Tfd2j2dryh5gms7oLDw20VqYKNjzJwP3BsgXQyTom1XrO4OSf6+5vJhsDX4El+oGrR5/X3ZapC/Lvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807043; c=relaxed/simple;
	bh=BNQB2QP3g4bYHwMgQ2eodWaRnpB3pqXfwnJFhwo3pAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcDrpON8jnChcBbV/NM2SzGiREaK3tOX7dG5zZnNmd3zJNQw/+RW4ch/7/WCVRJO5qkqNCya1+THH9ljTJjSdjEe0S+SDAasuYRN8H3pJq9AkkRv8CwxPBeqQWuiP/ZdZ56x92GRaep/jsqyXd4qOwhDebmaoF3xTP5eQGOxVrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3nZbm4w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3nZbm4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF7D1F000E9;
	Tue, 26 May 2026 14:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779807041;
	bh=KEQJG1vq4rGDMIhKxxeJ0wlS7AcPEZB5ET+d2oh5USs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L3nZbm4wfDe8twAoPsMNgGCiU3R2/CjmxN+VmSdZhT1xmCleCgJZxsssDCZAuaq1C
	 rMaEvcmzADTfLAtzNZzIUQfIVPXmQOq1jEBwq6d2jCxUvLVHRRPJD6m7hdQJTM2/rM
	 U6YzHFhZbL7EQiD0KXkBxqj/H+TYwEAMEcYyY1a1lsIOA0SvQejW2Yb8zllV60E6sc
	 tAinYJx11XGZbBK6XF3ss8zxu3TzgOYnaF3VUBAwsexBwkMWpWtKEs6+Snib9BlBvw
	 ixAZPQQsKxXKDlHudjO6mvAIKMbP1RfbP/34Qn+jd/5nxqu5EYKI+O4tP3BP5gqDsD
	 J8ZsHkA2n8qiQ==
From: SeongJae Park <sj@kernel.org>
To: "Kunwu Chan" <kunwu.chan@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	"Kunwu Chan" <chentao@kylinos.cn>,
	"Wang Lian" <lianux.mm@gmail.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: fix stale TLB young-state handling on arm64
Date: Tue, 26 May 2026 07:50:33 -0700
Message-ID: <20260526145034.91594-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <3d09f6b9cf4a9b275876185f5b234253e7af0225@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 May 2026 08:57:32 +0000 "Kunwu Chan" <kunwu.chan@linux.dev> wrote:

> May 26, 2026 at 1:46 AM, "SeongJae Park" <sj@kernel.org mailto:sj@kernel.org?to=%22SeongJae%20Park%22%20%3Csj%40kernel.org%3E > wrote:
> 
> 
> > 
> > On Mon, 25 May 2026 22:48:46 +0800 Kunwu Chan <kunwu.chan@linux.dev> wrote:
[...]
> > > Reproduced on arm64 (128 CPUs, 7.1.0-rc4):
> > >  
> > >  before:
> > >  WSS estimation: 50th percentile error 100% (reported as zero)
> > >  apply_interval: schemes never tried
> > >  
> > >  after:
> > >  WSS estimation: 50th percentile error 0.08%
> > >  apply_interval: passes
> > > 
> > And nice test results. I guess you are referring to the tests in damon-tests?
> > Clarifying the context would be nice.
> > 
> Yes, those results are from: make -C tools/testing/selftests/damon run_tests
> on the arm64 test machine mentioned above.
> 
> The before/after summary was extracted from the relevant failing tests
> (sysfs_update_schemes_tried_regions_wss_estimation.py and
> damos_apply_interval.py) for brevity.

Thank you for clarifying!

wss_estimation increases its working set size up to 160 MiB for this issue.
Seems your test machine has large TLB buffer.  I think we should decide the
limit based on the real running system configuration and apply similar approach
to other tests including the apply_interval.

For out-of-tree tests, we may better to provide a guideline, too.  E.g., run
this sort of test program with this DAMON config to find the reliable test
working set size on your setup.

> 
> > Also, have you had a chance to measure the performance impact?
> We haven't done detailed performance measurements yet, but we can try to
> collect some numbers for the flush overhead on a few different setups.
>  
> > So, I'd like to have this change. But, unless we have very clear evidence
> > showing this change is not increasing the performance overhead, I'd prefer
> > making this as an optional feature.
> >
> We agree that making it optional sounds safer unless we have solid
> evidence showing the overhead is negligible. Keeping the current
> default behavior for production workloads also makes sense to me.
> 
> > For the user interface, we could add a new sysfs file for the option, say,
> > 'flush_sample_tlb' under 'monitoring_attrs' directory.
> > 
> The proposed 'flush_sample_tlb' interface under monitoring_attrs sounds
> reasonable to me as well.

I was thinking this again.  I still want DAMON to be easy to test.  But, is
this making tests that difficult?  Users could increase the test working set
size.  I'm not very sure that is too diifficult to add new optional feature.
Meanwhille, adding an optional feature for only test might make users be
confused.  DAMON usage might also be diverged and add maintenance burdens.

So, now I think another option is improving the documentation.  It shouldd
clearly explain how and why DAMON does not flush TLB and what is the expected
problems (in tests) and recommendation.  In this option, we should also update
existing DAMON tests to be reliable and aligned with the documented
recommendation.  If we find it becomes a problem on testing even after applying
the recommendation, or on production, we can revisit.

Regardless of the decision about the optional feature in DAMON, I think such
documentation and tests improvement should be made.

Maybe I'm biased, so any input would be appreicatedd.  What do you think, Kunwu
and Lian?


Thanks,
SJ

[...]
