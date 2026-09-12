Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBF7377ABA
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242134; cv=none; b=oHmOkfRCG8KNfIuVSmg83gyH31UGfwLuMCvfQb9/OteonZbMcH9H6KpomnypmtEwaIIZfaOzH+23rrZ1069bl5aUCu7/Iq7JKQvH0NsHuFhSkBP6YxpOycBimNGB+9DmkPvVZne1jsPP6b4poSkWuohzLWzwcHIDDf7Q16BGRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242134; c=relaxed/simple;
	bh=M7KW4SCqY7IDYJJQn2x6X11f48Ctt5+IYnviTwh6ilc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQ8LPnAXgpPjoUGMkU90W4We9q403u5vMovtXIXZcu7m50m6PLOrx9sZdhuxWUp+wcR3xKyIjdmuPmMlBv6Mc2q2pTVVy21uiW0b9oip6gXPNWDypAGZ/BS4xOfbcbSihnwTifyOuLX2mLrOqucYpR/adY0L0c6EDa8BJUZeFh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyhErNf1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyhErNf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670241F00893;
	Sat, 12 Sep 2026 19:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789242133;
	bh=F6CE+U19JPtibu7jCwMQAuIhZVSpgnJl+59G2aOD/Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DyhErNf1wCdmnknb3wzSI/gNo7b50qXdCdn1Em/iiIWEWfuYvC/BNDIENUCUYfLlC
	 iIUDqe1L7wwVb5FPVHhIvtrNZg8BHVwakKLiZt00pfunaIzpyKc5AWqvfwQKmqANeq
	 6NLBMakJWW5XLhVPPzujAV2MjS1sG/I7ESzVxfi62T+9PUM0zFHa1D6bciHZjwXubg
	 rAKzpLNoOmAYPQuiVoLgpNdUjYIx1ZERF73CffVz8rDOnUPMfbhCg4fBZx/1F0IpEN
	 mWfi1r2Cut95Y4jdrs7LrmhSU651YxkE8WzacM9X8Dgs04bZqEpFEhNcGlm0T7a50B
	 D6iCn4Jn45qzQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 4/8] mm/damon/core: disallow max < min damos filter range arguments commit
Date: Sat, 12 Sep 2026 12:42:04 -0700
Message-ID: <20260912194206.139467-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912192942.AAD411F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 12 Sep 2026 19:29:42 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The newly introduced validation in `damos_commit_filter_arg()` returns `-EINVAL` on failure, but callers `damos_commit_core_filters` and `damos_commit_ops_filters` ignore this return value for new filters, adding uninitialized memory to active DAMON context.
> - [High] `damos_commit_filter()` mutates the target filter's state (type, matching, allow) before validating its arguments, leaving the live filter in a corrupted state if validation subsequently fails.
> --
> 
> commit b7aac655c61845e48301bed4669cfcf294cf84cb
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: disallow max < min damos filter range arguments commit
> 
> This commit adds validation to damos_commit_filter_arg() to reject invalid
> ranges where max is less than min. It returns -EINVAL when an invalid range
> is provided, avoiding duplicated validation across different DAMON API callers.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3ad1fb2f21f3f..3dec1a8f7ed3a 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1325,15 +1325,21 @@ static int damos_commit_filter_arg(
> >  		dst->memcg_id = src->memcg_id;
> >  		break;
> >  	case DAMOS_FILTER_TYPE_ADDR:
> > +		if (src->addr_range.end < src->addr_range.start)
> > +			return -EINVAL;
> 
> [Severity: High]
> Does this code leave the target filter in a corrupted state on error?
> 
> Looking at damos_commit_filter(), the state is mutated before the newly
> introduced validation has a chance to execute:
> 
> mm/damon/core.c:damos_commit_filter() {
> 	dst->type = src->type;
> 	dst->matching = src->matching;
> 	dst->allow = src->allow;
> 	return damos_commit_filter_arg(dst, src);
> }
> 
> If damos_commit_filter_arg() returns -EINVAL here, dst->type, dst->matching,
> and dst->allow have already been modified. If an existing ops filter receives
> an invalid range update, its type will be updated but its union arguments will
> belong to the previous type. When the filter executes, it might misinterpret
> the old union memory according to the new type, causing unintended matching
> behavior.

Yes, and the caller will destroy it, so no issue.

> 
> 
> [Severity: High]
> Can this validation error cause uninitialized memory to be added to the active
> DAMON context?
> 
> Looking at damos_commit_core_filters() and damos_commit_ops_filters(), the
> return value of damos_commit_filter_arg() is ignored when creating new filters:
> 
> mm/damon/core.c:damos_commit_core_filters() {
> ...
> 		new_filter = damos_new_filter(
> 				src_filter->type, src_filter->matching,
> 				src_filter->allow);
> 		if (!new_filter)
> 			return -ENOMEM;
> 		damos_commit_filter_arg(new_filter, src_filter);
> 		damos_add_filter(dst, new_filter);
> 	}
> 
> Because damos_new_filter() allocates memory without zero-initializing the union
> arguments, returning -EINVAL from damos_commit_filter_arg() means the union
> payload (like addr_range or sz_range) is left uninitialized. The callers ignore
> this error and add the filter to the system anyway, which could result in
> using kmalloc garbage and triggering undefined matching behavior.
> 
> Additionally, damos_commit_ops_filters() ignores the return value of
> damos_commit_filter() for existing ops filters:
> 
> mm/damon/core.c:damos_commit_ops_filters() {
> ...
> 	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
> 		src_filter = damos_nth_ops_filter(i++, src);
> 		if (src_filter)
> 			damos_commit_filter(dst_filter, src_filter);
> ...
> 
> If an existing ops filter receives an invalid update, the validation error
> is swallowed entirely.

Good findings, I will fix this in the next spin.

> 
> >  		dst->addr_range = src->addr_range;
> >  		break;
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260912191807.138502-1-sj@kernel.org?part=4


Thanks,
SJ
