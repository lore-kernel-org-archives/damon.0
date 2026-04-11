Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA0D1862;
	Sat, 11 Apr 2026 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775930762; cv=none; b=KOJwWGF6f6BeYWPUqctIuwm7PGLsp4eM9z9XKyDa1OGZvnZlfr4S9U4MoU1plE5zsOHA1bsN+euUgS5txHdiCr69rJNxP5hZWj/87ctZTkTBUDsO4C5ZQKhVtFS98XW/qTkeZ7CgXZpBmNcG1Ev1Q3CIaStPbj5hBsgBrT7IH2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775930762; c=relaxed/simple;
	bh=FT5470fpgMWYmiUdJN7K/tRS99P7K/kQlx5yLr3uiUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcs+ZY/tuEH00WAWepN5kY/UYS1kwVokItpH19ax9pICkKHv/xS8auRmIXBy9vNqFF7gM2ZEddAhR1R3/lBMRL6SAONsULcELlesulrNXfAT38gHMLYfTlqj0y3e1XkY+ngBIWyMNh6uqoOjSNBhPVqLIpmO8JT/AkxpmW5+WEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvAePOSa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvAePOSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEF0C2BCAF;
	Sat, 11 Apr 2026 18:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775930762;
	bh=FT5470fpgMWYmiUdJN7K/tRS99P7K/kQlx5yLr3uiUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvAePOSajJF1TiS2/hX5RCRKWZ3UQj7Krxe/PiLtBGhgTSYX8dGLuHkqd/EaFuDsr
	 7cdgBrGkU2ATWj23WrZlvBE1nPrrZD4BYHoMPtmMopRPeKO/Bt0vF/Q5Bmu7jizQ1Q
	 zfgQmNuORckDYMJFS8FTCG4CC08xHBh+Ek8nqb3DsJxsKWEfJhmzcNA574CyhWLSw1
	 Rx+7p54UNIrejfHuz6c+U+WG2me8TbfRkIVlOMRQ8pew4MUMmJ/5XszM1shtOP5Mng
	 6u6VRGscPpNODROlrA/ZgQUqosex25eo0av9z4jAz/1Dhs8eJKZ/T0n7/hpkbuHK4X
	 68iHa0ia7kPpg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v5.1 03/11] mm/damon/core: introduce failed region quota charge ratio
Date: Sat, 11 Apr 2026 11:05:49 -0700
Message-ID: <20260411180549.79857-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260411164908.77189-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: sashiko found no blocker for this patch.

Forwarding full sashiko review in a reply format with my inline comments below,
for sharing details of my view and doing followup discussions via mails if
needed.

> # review url: https://sashiko.dev/#/patchset/20260411164908.77189-4-sj@kernel.org
> # start of sashiko.dev inline review
> commit cb228850cc3bb33cac86cdc674c79e2557af28a8
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: introduce failed region quota charge ratio
> 
> This commit introduces a DAMON core API to set the charge ratio for
> action-failed memory. It allows API callers to specify the ratio flexibly
> using a numerator and denominator to avoid charging failed memory the same
> as successfully applied memory.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index d04a107df7cfa..3398faeaa4350 100644
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
> 
> Could the mult_frac() calculation silently overflow here?
> 
> The fail_charge_num and fail_charge_denom variables are user-controlled
> unsigned int parameters without bounds checking. The mult_frac(x, numer, denom)
> macro evaluates as quot * numer + (rem * numer) / denom, using the type of x,
> which is unsigned long in this case.
> 
> On a 32-bit architecture, if a user configures a fine-grained ratio like
> 1000000 / 1000000, the remainder could be up to 999999. The intermediate
> calculation for rem * numer would evaluate to nearly 10^12, which overflows
> the 32-bit limit.
> 
> Similarly, on 64-bit architectures, setting fail_charge_num to a very
> large value like UINT_MAX could cause the quot * numer operation to exceed
> the 64-bit limit for large memory regions.
> 
> If an overflow occurs, it would severely under-account the charged size,
> breaking the quota enforcement in damos_quota_is_full() and allowing the
> scheme to silently bypass its configured action limits.
> 
> Does this code need bounds checking for the numerator and denominator, or
> should it use a safer math helper to prevent the quota bypass?

Same sashiko question to the previous patch.  My answer is also same.  I will
keep this as is in favor of simplicity.

> 
> > +}
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260411164908.77189-4-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260411164908.77189-4-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
