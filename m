Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E0B2F42
	for <damon@lists.linux.dev>; Wed,  7 Sep 2022 20:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F69C433C1;
	Wed,  7 Sep 2022 20:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662584353;
	bh=FniondtFbpoxyTfBIT/tD9EaOffiZzbj+1i6uXyMxKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AMug+Taf20KbZ8zIj/PQfrkYE8FfrIMY8WMjII3yQUm0cPgAuy8hk+xQnzsiM52qV
	 DXpqiSjYvWK1tzW8Y0q19Tn4gDBPbAodLlmF2dfNmnyXssKSOt5CuzcLe/ZBkqXfyX
	 gcji/ukWAB/IstDYNQCtfr7j2+fzjdJPGhjJtguAeOYlE4cHfTR8TAP/jv414jx8xG
	 7zdxa/bSlZrTRuL0rBQJTCS3HrGItneKuIuHKO08hWAclQUacwdBwoldEJOEDnWOUB
	 JT+5Y/GZfww+TsV3oUD13RME09kRA/jLjR0+YUy1Qn6j3tnGiwZqlpRLomUpZbJ8k+
	 vEZ7HQjbFXJLA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xhao@linux.alibaba.com
Subject: Re: [PATCH] mm/damon: Remove duplicate get_monitoring_region() definitions
Date: Wed,  7 Sep 2022 20:59:11 +0000
Message-Id: <20220907205911.62483-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220907172712.61006-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 7 Sep 2022 17:27:12 +0000 SeongJae Park <sj@kernel.org> wrote:

[...]
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index b1335de200e7..01938f33038d 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -172,3 +172,31 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> > 
> >  	return hotness;
> >  }
> > +
> > +static inline int walk_system_ram(struct resource *res, void *arg)
> > +{
> > +	struct damon_addr_range *a = arg;
> > +
> > +	if (a->end - a->start < resource_size(res)) {
> > +		a->start = res->start;
> > +		a->end = res->end;
> > +	}
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Find biggest 'System RAM' resource and store its start and end address in
> > + * @start and @end, respectively.  If no System RAM is found, returns false.
> > + */
> > +bool get_monitoring_region(unsigned long *start, unsigned long *end)
> > +{
> > +	struct damon_addr_range arg = {};
> > +
> > +	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
> > +	if (arg.end <= arg.start)
> > +		return false;
> > +
> > +	*start = arg.start;
> > +	*end = arg.end;
> > +	return true;
> > +}
> 
> 'ops-common.c' is for code that common in monitoring operations
> implementations.  I'd prefer to have yet another source file for the DAMON
> modules including reclaim and lru_sort, say, 'modules-common.c'.

Or, putting it in damon/core.c might make more sense.


Thanks,
SJ

[...]
