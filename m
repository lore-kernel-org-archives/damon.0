Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86EB35F616;
	Tue,  7 Apr 2026 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577074; cv=none; b=kkZWuksTIbYBPOmVtQdo2/Jk7EwIHhoeTxxoDYEeVoLGZphGvoXSeag43r3UZsPVvp/M4/Ucb7a2u2Dd2+ErfIT7fpWaDogJPvH4qxu1MOu2DR7hlsxP/BS3yyXecnHOZ3VIMQHw22uOUEyh2/slYchF4eiml0Yn6tXiK3OEp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577074; c=relaxed/simple;
	bh=PVB4oUNgvplVh0sIGtSAENl6g2YTWKTdP79gh7Iu9MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9b8Ef9k6PtidD43aHgEzFMU+L21as+Zo4uXoPvQQtmDBTjvAARu8vTUABrxJScr4GI6ICdB3oKVnm8bpxvj/MEh+4cp9FPtU0vMX89ILTXtExGdDyl5MhTjOhvO1MjvnQNhWxpwI9QnqIHZ4nhW8OFbZHksfBoPMAn1tCN/TI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZC7Jh9Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZC7Jh9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9F1C116C6;
	Tue,  7 Apr 2026 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775577072;
	bh=PVB4oUNgvplVh0sIGtSAENl6g2YTWKTdP79gh7Iu9MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZC7Jh9Z2fhH5MT81IG8BgioiW8NAjCj+YxlgMIis1KBye0qobofQtyEJ1f1m2WFW
	 Vb/6Y23No4Cj+UyhgnTAOyZ7qleIrHa2B9+PpVVX5qWOlH+5UprHT4W7kdsyqG2YNf
	 3e4+Nj2S+QgNhZyyjoJHJCRAPlXacBOtF1T3GxWU/4hXde3XXks8EVI3wBuwG2xvWg
	 rCngPYOyBtoMn9hqKarg+xkfgF85v0dp3gPJ+cxOYtgOkLH61DVPUidhVw5sY9vGk/
	 bIZ+ngZit2BfycvFCt3VKus/v32eosGgSNak3qNlfFS4Pf+dmgQJ8YIdL9wdhIrRBN
	 ZQINORuobxLMA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v3 02/10] mm/damon/core: introduce failed region quota charge ratio
Date: Tue,  7 Apr 2026 08:51:10 -0700
Message-ID: <20260407155110.51749-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407010536.83603-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: sashiko made a good finding that better to be addressed.  I will
address it in the next revision.  sashiko also made two findings but I will
ignore those.

Forwarding full sashiko review in a reply format with my inline comments below,
for sharing details of my view and doing followup discussions via mails if
needed.

> # review url: https://sashiko.dev/#/patchset/20260407010536.83603-3-sj@kernel.org
> # start of sashiko.dev inline review
> commit 09593130776383947d3d32b60b59b00c4bc2e692
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: introduce failed region quota charge ratio
> 
> This patch introduces a configuration to charge a different quota ratio
> for memory regions where DAMOS actions failed. It aims to improve fairness
> in quota accounting between successful and failed actions.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index c29f70bcce894..2a09d6bdf5f3e 100644
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
> > +}
> 
> Can this cause an integer overflow on 32-bit architectures?
> 
> The fail_charge_num and fail_charge_denom are unsigned int and can be set
> to arbitrary values by userspace.
> 
> If a user configures a large numerator (e.g., close to UINT_MAX), the
> multiplications inside mult_frac() could overflow the 32-bit unsigned long
> boundary on 32-bit architectures, leading to an incorrectly truncated value
> being added to quota->charged_sz.

sashiko is asking a same question again.  As I replied on the previous version
thread, I will keep this as is for simplicity of the code, unless a human
argues differently.

> 
> [ ... ]
> > @@ -2105,7 +2124,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  		ktime_get_coarse_ts64(&end);
> >  		quota->total_charged_ns += timespec64_to_ns(&end) -
> >  			timespec64_to_ns(&begin);
> > -		quota->charged_sz += sz;
> > +		damos_charge_quota(quota, sz, sz_applied);
> 
> Could this permanently disable a scheme if actions completely fail during the
> first time window?
> 
> If fail_charge_num is 0 and all actions fail across all regions in the first
> charge window, quota->charged_sz evaluates to 0.
> 
> At the end of the window, total_charged_sz becomes 0, while total_charged_ns
> records the actual time spent attempting. The calculated throughput
> becomes 0, which sets the effective size quota (esz) to 0 for the
> next window.
> 
> With esz = 0, damos_quota_is_full() always evaluates to true, causing DAMON
> to skip applying the scheme to any regions.  Since no regions are processed,
> total_charged_ns and total_charged_sz never increase again, permanently
> bricking the scheme.

sashiko is asking a same question again.  As I replied to the previous
question, this is not cuased by this patch.  So I'm working separately for the
issue.  I recently posted the fix:
https://lore.kernel.org/20260407003153.79589-1-sj@kernel.org

> 
> Does this code create an infinite region splitting loop if an action fails
> near the quota limit?
> 
> In damos_apply_scheme(), if the current region size exceeds the remaining
> quota, it splits the region into sz and the remainder:
> 
>     sz = ALIGN_DOWN(quota->esz - quota->charged_sz, c->min_region_sz);
>     damon_split_region_at(t, r, sz);
> 
> If the action on the split region fails, and fail_charge_num is less than
> fail_charge_denom, charged_sz increases by less than sz (or by 0).
> Because charged_sz did not increase fully, the remaining quota remains at
> least min_region_sz, so damos_quota_is_full() evaluates to false.
> 
> When the scheme loop proceeds to the remainder of the region, it will split
> it again by the same sz.  Could this repeat until the entire target memory
> is shattered into tiny regions, causing a massive increase in allocations
> and a kernel lockup?

Good finding.  Yes, this can increase number of region splits on the code path.
I think it should be safe from lockup, since each DAMOS action implementation
uses cond_resched().  But the increased number of regions makes me worried.  I
think we should merge the splitted region back, after DAMOS action is applied.
I will add the change in the next revision.

> 
> >  		if (damos_quota_is_full(quota, c->min_region_sz)) {
> >  			quota->charge_target_from = t;
> >  			quota->charge_addr_from = r->ar.end + 1;
> >  		}
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260407010536.83603-3-sj@kernel.org


Thanks,
SJ
