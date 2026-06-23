Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCDD242D97
	for <damon@lists.linux.dev>; Tue, 23 Jun 2026 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174207; cv=none; b=HDDrlI977peXd8NNb+MVurE3fE6WmOwqPArI6y/EvlF094ZOEMkX6OiOdrqLh59oqcdrF17jenvW1xeuDLCwk4ITbOhxMeSFRxyWhXomTzsh1FKcokcTAZNvsnBnvD2OX/K/oPfaeMOZeMWU7IO3O2u94+aZiKpo5onuYwwQLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174207; c=relaxed/simple;
	bh=+7RUoZfgemk3EBcm1NS6Peh9pAOsCTQAi07EzGTGxww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EztIXwaGIl0rAiaxS64Jm/oz89bLko/75xw9mtHjb0NZ3JWMioQJhDiagUvj9+rSIOU2N9bh9F05APl9sdKCSCasA7dFwrbesi+5lIYJ8ff9CkPDVYw4urGIcXJwvtTS3EGqqbw7jdkSl3sPyo0eHlRiwreHJBE7s6DQC5vKsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ydg9Oc4A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ydg9Oc4A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB141F000E9;
	Tue, 23 Jun 2026 00:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782174201;
	bh=EcYUI71nDFOJP6eTeRXLhyFfnaZafEFTLQruZThxr7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ydg9Oc4A9lZuSiESDcAT7xb4JlS0N070ZQnIXWbxf8KWDs3FBPlqcY9r6kOuvvkCr
	 Hiam3TvKNZv+ERF/nTkxpY6wSqEST7e/fwGAUmzBFO8qhzmcR8uzHglhj/KAJxFK0Y
	 IcJ+A02E8540PE1l1rvYJnFqEJe4i+W0EuXLHBz9PR2zIh/c3rudeN22aH24C6UBt4
	 ceq+9sPKp/CBHtWeOTx87QtF+Em2tgi9V4iEEdsJYaCjwN4jzPMQa8wq9lEns0xKSv
	 JSuCEgNTWwE7m9dtX6OGojwr5IoBZgv3I0Npm8pO6FK5nsNl2ccBGXdz6WzT1OvRn4
	 WoIpP5dqaQFug==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3 04/18] mm/damon/core: handle unreset nr_accesses in damon_nr_accesses_mvsum()
Date: Mon, 22 Jun 2026 17:23:12 -0700
Message-ID: <20260623002313.35582-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622144211.CE27A1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Jun 2026 14:42:11 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] damon_nr_accesses_mvsum() incorrectly returns stale access data from two aggregation intervals ago during the aggregation reset gap.
> --
> 
> commit 079525184ff6b3e5e3e7c3387647af444428cb84
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: handle unreset nr_accesses in damon_nr_accesses_mvsum()
> 
> This commit addresses an issue in damon_nr_accesses_mvsum() where unreset
> nr_accesses can unnecessarily inflate the pseudo moving sum. It adds a check
> to return last_nr_accesses directly if the remaining window is full.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index bc40a6d10f277..8a7351b4a27c2 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -268,6 +268,9 @@ unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
> >  			ctx->passed_sample_intervals;
> >  	left_window_bp = mult_frac(left_window, 10000, window_len);
> >  
> > +	if (left_window_bp = 10000)
> > +		return r->last_nr_accesses;
> > +
> 
> [Severity: Medium]
> Will this regression return stale access data from two aggregation intervals
> ago?
> 
> If damon_set_attrs() is executed at the end of an aggregation window, it
> advances ctx->next_aggregation_sis but intentionally does not reset
> r->nr_accesses.
> 
> During this unreset gap, r->nr_accesses correctly retains the fully-aggregated
> data of the just-finished window, while r->last_nr_accesses holds the value
> from two windows ago.
> 
> Because next_aggregation_sis was advanced, left_window_bp evaluates to 10000
> in damon_nr_accesses_mvsum(). Does the new check fall back to the
> stale last_nr_accesses, skipping the most recent interval's data?

Too minor issue.  I will keep this as is, and work on further improvement as I
also mentioned on the commit message.  No blocker for this patch.


Thanks,
SJ

[...]
