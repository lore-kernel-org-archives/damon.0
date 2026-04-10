Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D0D3921CC;
	Fri, 10 Apr 2026 23:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865424; cv=none; b=j+t5QpD8iWOsQPZmQjnEHcCfg5ooTaxIzNI8+owK22ReUh9ggKWTxXpg4+mcTb5I9bVlZqPWtujHToSYqizoAyTJXF7D7x7XAamfuj32T8pslVFnf1v4Te5RldrC2klskzaYT/vMlkBohI4IL+QB8+e//APJhgprRydgFXHxDFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865424; c=relaxed/simple;
	bh=fC9m9hWBDRvcsGbkiKWjW38zCbWI8Pw4SpDiXRdNZNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsjfMKQZtNxOk2doRis/JBbLQ/hCwQmKt9TIqM6h04gatqltV2TlJ42cX7LeBIPYPFaI0BbBr1m68ifSjHVoCdu9Aew9FmvD7E8nDSRaH7xq8XmS1063buGHn5qwfVF2BKYLzq4+adGKMeGyudNLcHxmt17XPybFUUhTbJhU4sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMR7nVOa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMR7nVOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EB3C19421;
	Fri, 10 Apr 2026 23:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775865423;
	bh=fC9m9hWBDRvcsGbkiKWjW38zCbWI8Pw4SpDiXRdNZNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMR7nVOaLcyu76qAZGsocidiGrhC4s51MCUzYZ12sbxiMITE/RivK27TyYrkRnXeH
	 cncDVtNgDAEuU09utKGQWZ579oXiPu07utDkgqfsyOcia3/KjoflDf74AJ775Bdk9q
	 vJ/heVujY4VCVbCxaTfoD2NMvYuS/gTOsDyxGWvG1ZFj4xbEQcprBlZsn74/d+TqA4
	 9y6wgTMCU+dpRp8H41aJRN9CybGvNq0nSZnLRJlGUjzvIqbeDGy9XZWYwH79vGNGF7
	 zp9XZW0ueb9hY5BmaconF6bSt7cCOZUbJkYeoMsxv2EQNS0Px+fpfttmNLlrnZ7Ni5
	 63T31HqL4NPcA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v5 03/11] mm/damon/core: introduce failed region quota charge ratio
Date: Fri, 10 Apr 2026 16:56:56 -0700
Message-ID: <20260410235656.91023-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410142034.83798-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: sashiko asks same question to previous one, which I decided to ignore.
My opinion is not changed.

Forwarding sashiko review in a reply format with my inline
comments below, for details of my view and doing discussions
via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260410142034.83798-4-sj@kernel.org
> # start of sashiko.dev inline review
> commit f672ea44b246c3c6bb3fac52d693ca50e48cbbac
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: introduce failed region quota charge ratio
> 
> This commit introduces a DAMON core API for setting the charge ratio for
> action-failed memory. It allows API callers to specify the ratio flexibly by
> setting a numerator and denominator.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 97b375c720251..cb8f65db0f4b9 100644
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
> Can the mult_frac() calculation silently overflow on 32-bit architectures?
> 
> The sz_region parameter is an unsigned long. On 32-bit architectures, this
> means intermediate calculations in mult_frac() will be bounded to 32 bits.
> 
> If a user supplies large values (e.g., fail_charge_num = 1,000,000 and
> fail_charge_denom = 1,000,000), could the remainder multiplication exceed the
> 32-bit ULONG_MAX limit? This could under-charge the quota for failed regions,
> causing the DAMOS scheme to exceed its configured quota limits.
> 
> Additionally, can setting the failed region charge ratio to 0 (e.g.,
> fail_charge_num = 0) neutralize the DAMON time quota (ms) and cause kdamond to
> hog the CPU?
> 
> If actions consistently fail (e.g., sz_applied == 0), the total_charged_sz
> will remain 0, leading to an estimated throughput of 0. This results in the
> effective size quota (esz) being bounded to min_region_sz.
> 
> Since charged_sz remains 0, the check in damos_quota_is_full():
> 
>     return quota->esz - quota->charged_sz < min_region_sz;
> 
> would evaluate to min_region_sz - 0 < min_region_sz, which is never met.
> Does this cause DAMON to bypass the time limit and process the entire target
> address space without stopping?

Same question was asked to the previous version, and my opinion is also still
same.  I will keep this as is.

> 
> > +}
> > +
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260410142034.83798-4-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260410142034.83798-4-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
