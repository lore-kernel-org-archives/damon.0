Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD5635CBB0;
	Wed, 14 Jan 2026 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768369998; cv=none; b=kh+K58tblXkJAkQbrN2hlZAXLp4z2UuDMlGsxoSshYWQZnjY+R/lFBoUxo+4RGRetp7AqqaDYB0d67iXdqg3Bx+cYqoOykAPcVEhvG+4GBX85GC5y5Hu9y9r4PJLTKQ8vWSuKCk2OYh7blEl0izQel2z5KNX1WoQ3ZeLuWiBcHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768369998; c=relaxed/simple;
	bh=V+SlBavLJRAAZg4Ll9BOkS3GsX17kKE4EmJ2ubSxjKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMWE/5dW5Kox1cQdWwxRKpx4yTpamylq+xbG0xoQLlIc/eXQXI0NGn2fTrHM7DzzrE7XcnFHhp4VpGmmgbXhyUj+iIln9Q0Rdu42niTRtaCkLW00T3SPK2AinbwklA8Hmc/kgKyHrtjzNvZT/qJdWreY95wckG9moKSLK28G1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDpC5MJV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDpC5MJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9208DC4CEF7;
	Wed, 14 Jan 2026 05:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768369996;
	bh=V+SlBavLJRAAZg4Ll9BOkS3GsX17kKE4EmJ2ubSxjKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tDpC5MJVH1/nhAPRueH4hsrd7ITCEK5QtUFuz21OuvxBEEOaa8IMvhT64bPEg3bu7
	 +vWn6q1EMRHj9vn40URiDRiKLrqS3iIaaDkM+gOgbVBS/GiKt3L+LAiL04T5PeLikE
	 G82mbGia4WIS/5mjXs60WEpyK6FXeFwQOKfGeJG02E7CKRDIXTzDSv/wGOCSAgAbRX
	 ZWcsKJQpVWxtsL/xmxy0SaUSdySkyYGfv9bNGTZdS9LBRRkYG1o2wgH3vHra7THZu4
	 +FI/W4VABwLr/E/XVWEr5xoz5yWyfrn2OWrB3NleDzsqe9u7wZcXeFhnnF/8sL/kzs
	 tzO1qbfiUN2lg==
From: SeongJae Park <sj@kernel.org>
To: wang lian <lianux.mm@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 08/11] mm/damon/lru_sort: support active:inactive memory ratio based auto-tuning
Date: Tue, 13 Jan 2026 21:53:07 -0800
Message-ID: <20260114055308.79884-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114053629.85750-1-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 14 Jan 2026 13:36:28 +0800 wang lian <lianux.mm@gmail.com> wrote:

> 
> > Doing DAMOS_LRU_[DE]PRIO with DAMOS_QUOTA_[IN]ACTIVE_MEM_BP based quota
> > auto-tuning can be easy and intuitive, compared to the manual
> > [de]prioritization target access pattern thresholds tuning.  For
> > example, users can ask DAMON to "find hot/cold pages and
> > activate/deactivate those aiming 50:50 active:inactive memory size." But
> > DAMON_LRU_SORT has no interface to do that.  Add a module parameter for
> > setting the target ratio.
> 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> 
> ```
> > +static int damon_lru_sort_add_quota_goals(struct damos *hot_scheme,
> > +		struct damos *cold_scheme)
> > +{
> > 	struct damos_quota_goal *goal;
> > +
> > +	if (!active_mem_bp)
> > +		return 0;
> > +	goal = damos_new_quota_goal(DAMOS_QUOTA_ACTIVE_MEM_BP, active_mem_bp);
> > +	if (!goal)
> > +		return -ENOMEM;
> > +	damos_add_quota_goal(&hot_scheme->quota, goal);
> > +	/* aim 0.2 % goal conflict, to keep little ping pong */
> > +	goal = damos_new_quota_goal(DAMOS_QUOTA_INACTIVE_MEM_BP,
> > +			10000 - active_mem_bp + 2);
> > +	if (!goal)
> > +		return -ENOMEM;
> > +	damos_add_quota_goal(&hot_scheme->quota, goal);
> > +	return 0;
> > +}
> 
> The second goal (Inactive ratio target) is added to hot_scheme again. 
> Should this be cold_scheme? Currently the cold_scheme parameter appears to be unused.

You are right, thank you for catching this, Wang!

Andrew, could you please add below attaching fixup?


Thanks,
SJ

[...]
=== >8 ===
From c8dbbf0cfb01de606d47f455bccc2d7b2d6d07ef Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Tue, 13 Jan 2026 21:48:53 -0800
Subject: [PATCH] mm/damon/lru_sort: add inactive mem ratio quota goal to
 cold_scheme

damon_lru_sort_add_quota_goals() is adding inactive memory ratio quota
goal, which is for cold pages scheme, to hot pages scheme.  Fix it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index f3a9dfc246b6..8af97642912a 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -238,7 +238,7 @@ static int damon_lru_sort_add_quota_goals(struct damos *hot_scheme,
 			10000 - active_mem_bp + 2);
 	if (!goal)
 		return -ENOMEM;
-	damos_add_quota_goal(&hot_scheme->quota, goal);
+	damos_add_quota_goal(&cold_scheme->quota, goal);
 	return 0;
 }
 
-- 
2.47.3

