Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4D61632DD;
	Fri, 10 Apr 2026 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775779922; cv=none; b=ZOECJ1c2B7oVtxE/2VcznhqXQtyl0TAND4wFqs0297ndfMAnfqrPifvcXX6Oew/dMLT3sv7j4LSLxZYNoBWXbRUr/g/Z4rqrK8W6Tpa6+dqKREyMU0ZnXMjtXjAEbx0ztZWdlsEsMWikuxLwxE8aZvK5UNZSH/yGcSKJOiNf0gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775779922; c=relaxed/simple;
	bh=Dyj6DdBLJ8yRouWJ2nAzD7cNHqNhbULuYxPjo7BULS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWlx3HFIrxs3j9hSM3j49kqV32sEUcC456kwOhcoLh0HYEy2ULlrYUj0C59uinXX4ack4w9KOwCL2Rofu7cUtqPbdo41x+B0Y7MsnLyMXUCMael1Y2U6zm8/b/gGMVVW0dE52IXPu5kEdiDAbwLD2COFzulxqRvBvdzJcu8to9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li6mSTkb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li6mSTkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391B8C4CEF7;
	Fri, 10 Apr 2026 00:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775779922;
	bh=Dyj6DdBLJ8yRouWJ2nAzD7cNHqNhbULuYxPjo7BULS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Li6mSTkbLPgUlVnGG42ioTKx9YBJ9oGfyO2hE5zOWffSBlOCa9c7K//W/Wc6IxYYr
	 4d7BE1jEs9wV5qobdskJxM99JHfB2OFCdUo/6x4/VNRQ5xwTcHF0noP7gNwFvQLjDq
	 6NGlshdm2m3Wtrw9v/GYubdo0T/l9/qNtMArKzyJD3NFJ81owy9+fdTE3VPwN6x4h+
	 pXS9c1RS+xFoGRQg5p0e7KW49Ch/yxyCHJ13qthmdxcbT5XZCwYVp4PDYgxmCuOI5U
	 c4fT5jxhXB4sq+m3FbdbEUrysuynpma1hIG1Mh+fTM0ULKeGPhvrNpX7IRvNanmmDs
	 7qyap3l9d+Ang==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v4 03/11] mm/damon/core: introduce failed region quota charge ratio
Date: Thu,  9 Apr 2026 17:11:54 -0700
Message-ID: <20260410001154.77757-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260409142148.60652-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

# sashiko review suggestions
#
# 1. Consider reducing recipients.  Maybe the author,
#    maintainers, reviewers, and mailing list of the
#    direct subsystem and parent susystem mailing lists
#    could be a starting point.
# 2. Add short summary of your opinion at the beginning.
#    For example:
#
#      TL;DR: sashiko found an issue.  I will respin.
#      TL;DR: sashiko found no issue on this patch.
#
# Please DON'T FORGET removing this comment block before
# sending this!

Forwarding full sashiko review in a reply format with my 
inline comments below, for sharing details of my view and
doing followup discussions via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260409142148.60652-4-sj@kernel.org
> # start of sashiko.dev inline review
> commit 55afcaa519ab8046d8aa94af44973c3cff0c2a26
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: introduce failed region quota charge ratio
> 
> DAMOS quota is charged to all DAMOS action application attempted memory,
> regardless of how much of the memory the action was successful and
> failed.  This makes understanding quota behavior without DAMOS stat but
> only with end level metrics (e.g., increased amount of free memory for
> DAMOS_PAGEOUT action) difficult.  Also, charging action-failed memory
> same as action-successful memory is somewhat unfair, as successful
> action application will induce more overhead in most cases.
> 
> Introduce DAMON core API for setting the charge ratio for such
> action-failed memory.  It allows API callers to specify the ratio in a
> flexible way, by setting the numerator and the denominator.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 31ba739d28e2f..1f171665509b8 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
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
> 
> Could this calculation lead to an integer overflow?
> 
> The mult_frac() macro evaluates the numerator multiplication internally
> using the type of the first argument, which is unsigned long. The sysfs
> interface in the subsequent patch ("mm/damon/sysfs-schemes: implement
> fail_charge_{num,denom} files") populates these values using kstrtouint,
> allowing inputs up to UINT_MAX.
> 
> If a user configures large values for fail_charge_num, could the
> multiplication silently overflow the 32-bit unsigned long result on 32-bit
> platforms, or on 64-bit platforms for sufficiently large memory regions?
> 
> This might produce a wrapped-around charged_sz and affect quota enforcement.

Sashiko asked same question in the previous version.  I decided to keep this as
is for code simplicity, as the issue is quite minor, unless other humans make
some voices.

> 
> > +}
> > +
> >  static bool damos_quota_is_full(struct damos_quota *quota,
> >  		unsigned long min_region_sz)
> >  {
> > @@ -2111,7 +2130,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  		ktime_get_coarse_ts64(&end);
> >  		quota->total_charged_ns += timespec64_to_ns(&end) -
> >  			timespec64_to_ns(&begin);
> > -		quota->charged_sz += sz;
> > +		damos_charge_quota(quota, sz, sz_applied);
> 
> Does discounting charged_sz for failed actions affect time quota enforcement?
> 
> DAMON converts the time quota (ms) into an effective size quota (esz) using
> throughput. If fail_charge_num is small or 0, the charged bytes accumulate
> very slowly, which could drive the throughput estimate to near zero.
> 
> This would cause esz to bottom out at min_region_sz. Since kdamond stops
> only when charged_sz >= esz, and charged_sz increases only by heavily
> discounted bytes, is it possible that charged_sz never reaches esz? This
> might cause kdamond to endlessly process the entire target memory space in a
> single cycle and consume unbounded CPU time.

Action failure is expected to be faster than successful action applying.  Hence
the denominator of the throughput, the total time took for the charging, should
also be reduced.  Users may set the ratio based on their expected overhead
difference between the time for failure and success of the actions.  So, this
is an intended behavior, not a bug.

> 
> Additionally, does the discounting affect region splitting earlier in
> damos_apply_scheme()?
> 
> The region is split using:
> 
>     sz = ALIGN_DOWN(quota->esz - quota->charged_sz, c->min_region_sz);
> 
> Here, esz and charged_sz track discounted bytes, but the resulting sz is
> passed to damon_split_region_at() to split the physical memory region.
> Could using a discounted byte limit as a physical byte size cause the action
> to be unnecessarily restricted to a tiny chunk, preventing the scheme from
> being applied to the full allowed physical area?

Yes.  And therefore the previous patch is made, though the current version of
the patch is completely wrong.

> 
> >  		if (damos_quota_is_full(quota, c->min_region_sz)) {
> >  			quota->charge_target_from = t;
> >  			quota->charge_addr_from = r->ar.end + 1;
> 
> As a separate note regarding a preceding patch ("mm/damon/core: merge
> quota-sliced regions back"), are regions split due to quota limits being
> skipped and orphaned during the target loop?
> 
> In damos_apply_target(), the loop uses damon_for_each_region_safe(r, next, t)
> which fetches next before executing the body. If damon_do_apply_schemes()
> splits r, damon_split_region_at() inserts the new remainder region
> immediately after r.
> 
> Because next was pre-fetched to the original next region, the newly inserted
> remainder appears to be bypassed by the iterator. This might prevent the
> remainder region from being processed by other schemes in the current cycle,
> and the intended merge-back logic might not execute for it.

Yes, as I mentioned to the earlier question just above.

> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260409142148.60652-4-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260409142148.60652-4-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
