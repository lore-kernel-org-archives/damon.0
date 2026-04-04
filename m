Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756870818;
	Sat,  4 Apr 2026 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775335599; cv=none; b=p6WOBVBBxVAorpt49jgyJ/nBIHacJ3bN9etZtnMmsblX8MH+Gu9+BkEYSKd1MnKBGnuRrg9Y2okN00dEwRBu9vtruqY86uvWRQ4kBIm3YtoHwH74LDzh21UA4W/dlmj082SRaBQKMT9wmzlWNmWcvUHMsPYz5HUBrs8pv1efetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775335599; c=relaxed/simple;
	bh=6GEw/iIRX2vINOzRBZ3YUzKWU86XOSxMizIY4SGJ5bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEvj9WKTsigT35TDkb7hQJ0FRLjKY7eG5UlShDwrFb82t4J5QEY5UPy7n2Uagd9aAyXk+3VCo2LaDtudcy3+ycA1EfSvBAQIqYa0rKfq7JGEydTQ4d1fwkxhrHcySMmAV9YWumxPmgOCO4ztjBIS9uR308h3KdyGhWDZ0k0uyqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jr6NkcAX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jr6NkcAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029FBC19421;
	Sat,  4 Apr 2026 20:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775335599;
	bh=6GEw/iIRX2vINOzRBZ3YUzKWU86XOSxMizIY4SGJ5bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jr6NkcAXjAPrvjLqWnxTPge4Drw898+ubhpIP31rdJX9Oo/nED0eLm8CFupNM3UNM
	 PhIumEKc8CZOUTA4Ev8KwpFeL23XrvCVas2sz7h3ZHajeDNPn4TyyQHyYMKyrtKQ7k
	 OkIyykgs1hvhXTqkaDfxF0INvNhTVjSlsIm1ExNuJSQRBFX5MvKOlSusQtsq7CZwEp
	 QdAVIc1U0t6nBwkMan5sflw25KOvOHYZF20RjLfrnmUjVp7iFDzLiBIROveHUZCQOw
	 zKdmnO5Wi+/2DXT+kAI2DZX+/DWdXUq6RmwMxg5aSyJlQALATAvYg2EcITxN0jmeNp
	 voViktedxF8cg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH 1/9] mm/damon/core: introduce failed region quota charge ratio
Date: Sat,  4 Apr 2026 13:46:30 -0700
Message-ID: <20260404204631.86853-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260404163943.89278-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sashiko found an issue that better to be fixed.  I will fix it in the next
revision.

Forwarding sashiko review in a reply format with my inline
comments below, for details of my view and doing discussions
via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260404163943.89278-2-sj@kernel.org
> # start of sashiko.dev inline review
> commit a0c4b65226ecf5534b53ebac64430db94a861d2c
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: introduce failed region quota charge ratio
> 
> This commit introduces a mechanism to specify how much of a DAMOS action's
> failed memory should be charged to the quota. It adds numerator and
> denominator parameters to allow flexible charge ratio configuration.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index f2cdb7c3f5e6c..df7b0340965f9 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> [ ... ]
> > @@ -276,6 +282,9 @@ struct damos_quota {
> >  	enum damos_quota_goal_tuner goal_tuner;
> >  	unsigned long esz;
> >  
> > +	unsigned int fail_charge_num;
> > +	unsigned int fail_charge_denom;
> 
> Is there a guarantee that fail_charge_num is less than or equal to
> fail_charge_denom?
> 
> If fail_charge_num is larger, the added charge will be greater than sz.
> When a region is split to exactly fit the remaining quota, could this make
> quota->charged_sz strictly greater than quota->esz?
> 
> If so, would the remaining quota calculation in the next iteration underflow
> and lead to corrupting the damon_region boundaries when splitting?

No.  Existing charged_sz vs esz comparison code allows charged_sz be larger
than esz, using '>=' operator.  And when the next charge window starts,
quota->charged_sz is reset to zero.  So I show no problem here.

> 
> > +
> >  	unsigned int weight_sz;
> >  	unsigned int weight_nr_accesses;
> >  	unsigned int weight_age;
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3bc7a2bbfe7de..f468c0257a3ec 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -2097,7 +2099,12 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  		ktime_get_coarse_ts64(&end);
> >  		quota->total_charged_ns += timespec64_to_ns(&end) -
> >  			timespec64_to_ns(&begin);
> > -		quota->charged_sz += sz;
> > +		if (quota->fail_charge_denom)
> > +			quota->charged_sz += sz_applied +
> > +				(sz - sz_applied) * quota->fail_charge_num /
> > +				quota->fail_charge_denom;
> 
> If memory management operations backing apply_scheme (like damon_pa_pageout)
> process whole folios, can sz_applied be strictly greater than the region's
> size sz (for example, when a 4KB region overlaps with a 2MB THP)?
> 
> Does this cause the unsigned subtraction (sz - sz_applied) to underflow
> into a very large positive value, exhausting the quota prematurely?

Good point.  The premature quota exhaustion should not be a critical issue, but
better to be avoided.  I will fix this in the next revision.

> 
> Could the multiplication (sz - sz_applied) * quota->fail_charge_num overflow
> before division?
> 
> On 32-bit architectures, or with a large fail_charge_num, could this wrap
> around and result in a much smaller charge than expected, allowing the scheme
> to bypass the quota limits?

I will use mult_frac() to avoid unnecessary overflow.

> 
> What happens if an action fails, and fail_charge_num is set to 0?
> 
> Does quota->charged_sz remain unchanged while the region is split to fit the
> remaining quota?
> 
> Since the remaining quota stays the same, could this cause the subsequent loop
> iterations to continuously split the remainder of the region into identical
> small chunks, allocating a massive number of damon_region structures?

That could happen, if that's what the user intend to.  That's no problem.

> 
> > +		else
> > +			quota->charged_sz += sz;
> >  		if (damos_quota_is_set(quota) &&
> >  				quota->charged_sz >= quota->esz) {
> >  			quota->charge_target_from = t;
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260404163943.89278-2-sj@kernel.org

Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260404163943.89278-2-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
