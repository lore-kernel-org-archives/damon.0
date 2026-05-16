Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303D945BE3
	for <damon@lists.linux.dev>; Sat, 16 May 2026 00:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778890321; cv=none; b=Dx+rBIukxccEBomBBGdUTcCdQIt7kMtNGYpz8C0nSafefOn0fXnJMX1q7aiASXdEvTKkADiyRdakya2vv+cHabL1Xtf+RKDsXppR0qzjFVIGUs/PAb49Zts1V2oPTGXdRtsWrU1wjVAVR52CpLDRvHj864iuTQf6nZqoddNB1g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778890321; c=relaxed/simple;
	bh=swcwDs0/tm4p+GFvUAjlacr1X7RYPvB745Xh6ur86No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4A7Dp55E90Jafqiq4JyLlC0X6xztui1TY13kmt3jEgZpILX/DaLnviUTlyBsYVieVG3Q8N+8h7wpNRhHQ95j+3maTaZiq29qQZpcMDGfc9vIGZ4/E0gccZMYI7M7s680EKn8/8G53C1UsndgMW5qhffzBOE9TxNVF61E7h5nrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+GSmp9k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+GSmp9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82C1C2BCB0;
	Sat, 16 May 2026 00:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778890320;
	bh=swcwDs0/tm4p+GFvUAjlacr1X7RYPvB745Xh6ur86No=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+GSmp9k81SN6PsN9yJlRbRDdfqQCit/iiJ60r/rxvApoix4I1D+DFWViF0XREHC0
	 0HSTFRFmPi9W6yjX7nEsz1ZtetCy5FhF7L+ijThKXERT84oMmCAH6WNRk6gPTQgJtb
	 J1qq6PlODlHHEgt2syqnjxlXvTJ5oNiXquUAoOx3XmoDP8jUSvONkK2T050jWckvHH
	 rrKGRB9l/mKL1n5dz8wpaJQhddckGpEDbOWaqPDP4M4oBl1gIyqqaXZ89PkeliI7tP
	 yji7ykHvbFQslVQmidiWbuVro7aBovhScaIJhzcDmRPD53Ea9Hcgb9J5RJvMXbPxjd
	 mEBm/MBoCsahg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 03/28] mm/damon/core: introduce damon_filter
Date: Fri, 15 May 2026 17:11:51 -0700
Message-ID: <20260516001152.136957-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515011414.6BAA4C2BCB3@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 May 2026 01:14:13 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] Unsafe macro definitions for `damon_for_each_filter` and `damon_for_each_filter_safe`.
> - [Low] Typo in the kernel-doc block for `struct damon_filter`.
> --
> 
> commit 483481d8b5710ceb3aa6769a6360b2dc2305434c
> Author: SeongJae Park <sj@kernel.org>
> mm/damon/core: introduce damon_filter
> 
> This commit defines a new struct damon_filter and embeds it into
> struct damon_probe for monitoring purposes. It also implements essential
> handling and helpers such as filter allocation, addition, and freeing.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 3ba5a31b51769..9c2576f103767 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> [ ... ]
> > @@ -721,12 +721,38 @@ struct damon_intervals_goal {
> >  	unsigned long max_sample_us;
> >  };
> >  
> > +/**
> > + * enum damon_filter_type - Type of &struct damon_filter
> > + *
> > + * @DAMON_FILTER_TYPE_ANON:	Anonymous pages.
> > + */
> > +enum damon_filter_type {
> > +	DAMON_FILTER_TYPE_ANON,
> > +};
> > +
> > +/**
> > + * struct damon_filter - DAMON region filter for &struct damon_probe.
> > + *
> > + * @type:	Type of the region.
> > + * @matcing:	Whether this filter is for the type-matching ones.
> 
> This isn't a bug, but there's a typo in the kernel-doc block here.
> @matcing: should be @matching: to match the struct member name. This could
> trigger kernel-doc warnings during compilation.

Good eyes!  I will fix.

> 
> > + * @allow:	Whether the @type-@matching ones should pass this filter.
> > + * @list:	Siblings list.
> > + */
> > +struct damon_filter {
> > +	enum damon_filter_type type;
> > +	bool matching;
> > +	bool allow;
> > +	struct list_head list;
> > +};
> [ ... ]
> > @@ -880,6 +906,12 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
> >  	return r->ar.end - r->ar.start;
> >  }
> >  
> > +#define damon_for_each_filter(f, p) \
> > +	list_for_each_entry(f, &p->filters, list)
> > +
> > +#define damon_for_each_filter_safe(f, next, p) \
> > +	list_for_each_entry_safe(f, next, &p->filters, list)
> 
> Is it possible this could cause operator precedence issues if a complex
> expression or cast is passed for p?
> 
> It might be safer to wrap the macro argument p in parentheses, like
> &(p)->filters, to avoid potential evaluation errors and compilation
> failures in the future.

Nice suggestion, I will do so in the next revision.


Thanks,
SJ

[...]
