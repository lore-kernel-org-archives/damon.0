Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824912749ED;
	Sun,  5 Apr 2026 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775417109; cv=none; b=K6TDEbGB3sKNrjliCjBqUEPARFCUfQITASF7YYErQVsQNmbKROpc1Q0vosTm6mAyMKVnbkTmcDj7RVlcPIUMk0yNPmY8P4l43xEoq6+V9NgjY1DEQIyV/uy0zPrDv3bujH/qtLQqCPSka+5kG8T9T8k7UjYP/gjbtfD2gKmBbaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775417109; c=relaxed/simple;
	bh=u9kP4a9l9SG7iK+UKEF6ddVw+VEDMWRXTIAT5puUTYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgCXj1JADAcTQwqq5UdXWcNbuZ1faE8rlwt0y1dVac2wj0qI67XUFDE2Wp7CkRiCVpfekhOuPQTo2vnppdztY+D3ukRNUGFbOKJPPyAWVhg5ixjfUTCNbOqeoWpuCVgdIHcUV2chlXCwBEw0Nj05RWIM20tbuhUZPmzk08za+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkrWmJsr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkrWmJsr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CE5C116C6;
	Sun,  5 Apr 2026 19:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775417109;
	bh=u9kP4a9l9SG7iK+UKEF6ddVw+VEDMWRXTIAT5puUTYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YkrWmJsri9ffoOu7ax1E1c3m08gjnDRCJOB8AZWvW9A6XcOp22MmVvAfihfGUpO+u
	 4tupmt/W3YbSWBHGq4uae2ZYIYzC/txvkPnpqn9bkz53ReLQTeaIZP0WL7TQiYQ7D0
	 3UW3wGusFNFdVuzyg5RTam64nCdHpP08ZvP0QdyXB8L2cYhr0t+04fgKeZY64QSh/d
	 LFZ2rZZc/R6Vhp4+Mor0niIUQB43JvmlI+JUqpY7LcKc0s3QKMK5i8biXxWQ/0CB33
	 WSQz8L03t/iUlvGGVJ/3IVMdhJXZfZlykRnnkhVLiLFvzTWngnHwGO52/NPmEPREGW
	 4pyoTxrsSHZDQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v2 1/9] mm/damon/core: introduce failed region quota charge ratio
Date: Sun,  5 Apr 2026 12:25:03 -0700
Message-ID: <20260405192504.110014-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260405151232.102690-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR: sashiko found one minor issue that better not to be fixed, one issue
that orthogonal to this patch, and one minor issue that better to be fixed.  I
will separately work on the hotfix of the second issue and address the third
issue in the next revision of this series.

Forwarding sashiko review in a reply format with my inline comments below, for
sharing details of my view and the revision plan, and also doing followup
discussions via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260405151232.102690-2-sj@kernel.org
> # start of sashiko.dev inline review
> commit feec6568732fbe7a81b21aa5fac5c470ce0f7381
> Author: SeongJae Park <sj@kernel.org>
> Subject: mm/damon/core: introduce failed region quota charge ratio
> 
> This commit introduces a configurable ratio to charge memory quota for
> DAMOS actions that failed, aiming for fairer quota accounting when actions
> do not fully succeed.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -2041,6 +2043,23 @@ static void damos_walk_cancel(struct damon_ctx *ctx)
> >  	mutex_unlock(&ctx->walk_control_lock);
> >  }
> >  
> > +static void damos_charge_quota(struct damos_quota *quota,
> > +		unsigned long sz_region, unsigned long sz_applied)
> > +{
> > +	/*
> > +	 * sz_applied could be bigger than sz_region, depending on ops
> > +	 * implementation of the action, e.g., damos_pa_pageout().  Charge only
> > +	 * the region size in the case.
> > +	 */
> > +	if (!quota->fail_charge_denom || sz_applied > sz_region)
> > +		quota->charged_sz += sz_region;
> > +	else
> > +		quota->charged_sz += sz_applied + mult_frac(
> > +				(sz_region - sz_applied),
> > +				quota->fail_charge_num,
> > +				quota->fail_charge_denom);
> > +}
> 
> Can mult_frac() overflow here?
> 
> If a user configures fail_charge_num to a large value, the multiplication of
> the failed region size (which could be terabytes) and fail_charge_num could
> exceed ULONG_MAX on 64-bit systems, resulting in a truncated value added to
> charged_sz.

It can indeed make DAMOS work in an odd manner, but it doesn't break something
in real.  Also, the real world privileged users ain't set such large value.
I'd not make change for this, as I prefer code simplicity here rather than
handling the weird user inputs.  We can revisit this later if a real issue from
this is reported, or a simple fix is found.

> 
> Also, if fail_charge_num is 0 and actions fail, charged_sz increases by 0,
> leaving total_charged_sz at 0.
> 
> If total_charged_ns continues to accumulate the time spent attempting these
> actions, throughput in damos_set_effective_quota() would evaluate to 0:
> 
> throughput = mult_frac(quota->total_charged_sz, 1000000,
>                        quota->total_charged_ns);
> 
> If throughput is 0, the effective size quota (esz) becomes 0.
> When esz is 0, damos_apply_scheme() calculates sz as 0:
> 
> sz = ALIGN_DOWN(quota->esz - quota->charged_sz, c->min_region_sz);
> 
> This triggers the if (!sz) goto update_stat; condition, skipping time
> measurement entirely. Does this cause the scheme to permanently lock up with
> 0 throughput and 0 quota?

Nice finding.  But the issue exists even before this patch, because throughput
could be zero if 'total_charged_sz < total_charged_ns / 1000000'.

I will fix this with a separate hotfix, like below:

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2683,7 +2683,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
        }

        if (quota->ms) {
-               if (quota->total_charged_ns)
+               if (quota->total_charged_ns && quota->total_charged_sz)
                        throughput = mult_frac(quota->total_charged_sz,
                                        1000000, quota->total_charged_ns);
                else
'''

> 
> [ ... ]
> 
> > @@ -2097,7 +2116,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  		ktime_get_coarse_ts64(&end);
> >  		quota->total_charged_ns += timespec64_to_ns(&end) -
> >  			timespec64_to_ns(&begin);
> > -		quota->charged_sz += sz;
> > +		damos_charge_quota(quota, sz, sz_applied);
> >  		if (damos_quota_is_set(quota) &&
> >  				quota->charged_sz >= quota->esz) {
> >  			quota->charge_target_from = t;
> 
> Since the new fractional charging logic can produce unaligned charged_sz
> values, what happens if the remaining quota drops below min_region_sz?
> 
> In damos_apply_scheme(), sz is calculated as:
> 
> sz = ALIGN_DOWN(quota->esz - quota->charged_sz, c->min_region_sz);
> 
> If esz - charged_sz < c->min_region_sz, sz evaluates to 0. It then skips the
> charge update and jumps to update_stat.
> 
> Because charged_sz doesn't increase, this skip condition evaluates to true
> for every subsequent region, iterating through the remaining address space
> without doing anything.
> 
> Furthermore, the loop exits without ever satisfying charged_sz >= esz.
> Without satisfying this condition, charge_target_from is never set, causing
> the next charge window to start from the beginning of the address space
> again. Does this prevent tail regions from ever being processed?

Good finding.  Not a critical issue for a quite rare case, but I agree this
(charge_target_from never set) is better to be fixed.  This happens because the
quota exceed check logic is not aware of this case.  I will address this in the
next version by updating the quota exceed check to aware of this case, like
below.

'''
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 47770221abe29..42e444b48634f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2320,6 +2320,14 @@ static void damos_charge_quota(struct damos_quota *quota,
 				quota->fail_charge_denom);
 }
 
+static bool damos_quota_is_full(struct damos_quota *quota,
+		unsigned long min_region_sz)
+{
+	if (!damos_quota_is_set(quota))
+		return false;
+	return quota->charged_sz + min_region_sz > quota->esz;
+}
+
 static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
 {
@@ -2377,8 +2385,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
 		damos_charge_quota(quota, sz, sz_applied);
-		if (damos_quota_is_set(quota) &&
-				quota->charged_sz >= quota->esz) {
+		if (damos_quota_is_full(quota, c->min_region_sz)) {
 			quota->charge_target_from = t;
 			quota->charge_addr_from = r->ar.end + 1;
 		}
@@ -2406,8 +2413,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			continue;
 
 		/* Check the quota */
-		if (damos_quota_is_set(quota) &&
-				quota->charged_sz >= quota->esz)
+		if (damos_quota_is_full(quota, c->min_region_sz))
 			continue;
 
 		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
@@ -2736,8 +2742,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	if (!time_in_range_open(jiffies, quota->charged_from,
 				quota->charged_from +
 				msecs_to_jiffies(quota->reset_interval))) {
-		if (damos_quota_is_set(quota) &&
-				quota->charged_sz >= quota->esz)
+		if (damos_quota_is_full(quota, c->min_region_sz))
 			s->stat.qt_exceeds++;
 		quota->total_charged_sz += quota->charged_sz;
 		if (quota->total_charged_sz > ULONG_MAX / 2 ||
'''


> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260405151232.102690-2-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260405151232.102690-2-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
