Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6A239E7E
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785014950; cv=none; b=U4MGfgalCiRX/rzXyELHFLoxlpQA18HG5UL+1aXKqTFHOGp3EfrHsS+RWUVoj3fQ43F0Wk7aBJikxSI+KpXFDDAh+5univhEfGVzgv7rfvWLItRTtRS6OnAyPvgkvXnQaYfjabkOqO8lArQi4DT//ZTdPOALkNddLfTv7F38jS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785014950; c=relaxed/simple;
	bh=aCS07cP3/zh+gF3esoJ5sAO6i7fdlVR6N369rrKO6is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZKHS95qtnHbRaCyQhnAXsW9iutee2l71Auur//vL6Yhn5My8gPA5J35jwJqgRpnmV6vT8HBcLVWcnnVn2o87pxwBzW4EPl+wtBitP2ulG9unKG73kzozCLIvWoahWvKVypquhAdrSq6da7mjqBjtqXn6B5env7DZWr9vC4moE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/pUHpvr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/pUHpvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9BF1F000E9;
	Sat, 25 Jul 2026 21:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785014949;
	bh=6J8Oy3Pp1T0ZxWbCq0oxWx6NLH+eo/+y1osxd6oCNOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B/pUHpvrSavNocdYmjhC4AehApUa5JPBPKIjuK0rX5U7/8N15W0Xu3YUl5nrX+BzD
	 gfBMrZlGghnxGmBbxytwSUT/Q8xHe0M+sYsXZU/k9IAAXaIrSxj6jPz8rAaZ8j+I2r
	 BmV+Lgju+IKPcN+MdJbr3TN7IJqnsyT+LKWbB27Lx5lhaFqeLK5ZP9m1U4DTZ9Ggtl
	 XhiH7xFTxvxmk0boqWJc3ImKt6xKurtJJ7UOfrroGl03b0MuLFOth6K1+2QNB6GjL2
	 9MGxVVWjJbExmursH5lwPnW9yGPKQmAzZwKcEtbQNch+LXvYWqEhzVMf6AW3qSscCa
	 OtWQCpay/PFlg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 01/17] mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET
Date: Sat, 25 Jul 2026 14:28:58 -0700
Message-ID: <20260725212900.130853-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725211157.0B22D1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 25 Jul 2026 21:11:56 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The commit introduces `DAMON_FILTER_TYPE_PGIDLE_UNSET` but entirely omits its implementation in both the filter evaluation logic and the sysfs interface.
> --
> 
> --- Patch [1]: [RFC PATCH 01/17] mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET ---
> commit 227024f25ad71dec25a7b05a4270affaab5be023
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET
>     
> Introduce a new DAMON filter type, pgidle_unset.  It will match pages
> that have their PG_Idle flag unset, or the page table accessed bit set.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 0c8b7ddef9abb..a8bb9ee6979e3 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> [ ... ]
> > @@ -742,12 +742,14 @@ struct damon_intervals_goal {
> >  /**
> >   * enum damon_filter_type - Type of &struct damon_filter
> >   *
> > - * @DAMON_FILTER_TYPE_ANON:	Anonymous pages.
> > - * @DAMON_FILTER_TYPE_MEMCG:	Specific memcg's pages.
> > + * @DAMON_FILTER_TYPE_ANON:		Anonymous pages.
> > + * @DAMON_FILTER_TYPE_MEMCG:		Specific memcg's pages.
> > + * @DAMON_FILTER_TYPE_PGIDLE_UNSET:	Pgidle is unset.
> >   */
> >  enum damon_filter_type {
> >  	DAMON_FILTER_TYPE_ANON,
> >  	DAMON_FILTER_TYPE_MEMCG,
> > +	DAMON_FILTER_TYPE_PGIDLE_UNSET,
> 
> [Severity: Medium]
> Is the implementation for this new filter type missing from the filter
> evaluation logic?
> 
> Looking at damon_pa_filter_match() in mm/damon/paddr.c, the switch
> statement evaluates filters but lacks a case to process the newly
> introduced type:
> 
> mm/damon/paddr.c:damon_pa_filter_match() {
>         ...
>         switch (filter->type) {
>         case DAMON_FILTER_TYPE_ANON:
>         ...
> }
> 
> Will this cause the evaluation to fall through to a default case and behave
> incorrectly rather than matching the PG_Idle or accessed bit as intended?
> 
> Also, does this new type need to be mapped in the sysfs interface so userspace
> can configure it? The damon_sysfs_filter_type_names array in mm/damon/sysfs.c
> doesn't seem to include the new mapping:
> 
> mm/damon/sysfs.c: {
>         ...
>         static const struct damon_sysfs_filter_type_name
>         damon_sysfs_filter_type_names[] = {
>         ...
> }

That will be introduced in a later patch of this series.

> 
> >  };
> >  
> >  /**
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260725210225.129944-1-sj@kernel.org?part=1


Thanks,
SJ
