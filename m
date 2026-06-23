Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D53D29BD8C
	for <damon@lists.linux.dev>; Tue, 23 Jun 2026 00:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174278; cv=none; b=qylKE0ofA2TKN+uevWj59Xk62DqurrF6bE//K75EoiE14xBpmJz/SxMxssygG+ajRL5u6jHd1/UsupF3oFqsZAIsWYm00FH+YiCMOuOyj6ViWFwoVaI3u6iUw1swZyPP9IDwj4B0W36bhWiEVcY4T15goL8oqL/jBF6/maQbUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174278; c=relaxed/simple;
	bh=oTubEDyw3zfxFxHQODk1Q0JGdtean+Bo0FKJIZNJJPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEovO6VeYJAb/I//PD+1/K3f98O/e6fmPhWAm8Npe8+j7FlPX0LEdDERI+9o7AcTDdVq0VKVsrBplfB3YosgvxvrwghYmQ2YitAetyutdPN7V7gRYkKdXxL2jWzafQUa/bOiLgAXBas9GqAN1XIlZ7uTgJRdSt2lNStJ/dtNGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N138Z4S8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N138Z4S8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67E41F000E9;
	Tue, 23 Jun 2026 00:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782174274;
	bh=bOFJQD1dhpFI3lsA/ZPxIbXaSL8yGZl/JsBTjKsEOVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N138Z4S8gn3f1UhIOPXMitUg92VF2Mqs8gcCfdDQQZhs1KnpecseeKLitUX6GyJnf
	 h9DcE5e75u4wMoz95W8GL3YW1KlKlFWzEi0lfEcCx7h+bSF3ewaM3HGBqmcDSg3U8O
	 CALiad6gizYZVIN+2dx3JKWeR3yZmyym/0+kIrgXpA4PaKe2XkGk6c0QjNsqvU10z5
	 LeVBO2Tc3+zLLVCE+cZumbWjwf5h+/YE3nyBlDfvt+wfL1exAPkftVjpc63vpe7wdC
	 9EwMn3Y23XBZ1WUHjW5KDBrRPxllN1w3UWtzfupAJmFA1WmdRP29p6LLk1X717yh/Y
	 Ef/j9iAkBMYsA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3 05/18] mm/damon/core: use damon_nr_accesses_mvsum() in __damos_valid_target()
Date: Mon, 22 Jun 2026 17:24:24 -0700
Message-ID: <20260623002424.35704-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622143724.A7CCA1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Jun 2026 14:37:24 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] 32-bit integer overflow in damon_nr_accesses_mvsum() leads to incorrect region access frequency scores.
> --
> 
> commit 31c0062dc1352032d1779ac0035b6e2cd5a7461a
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: use damon_nr_accesses_mvsum() in __damos_valid_target()
> 
> This commit changes __damos_valid_target() to use damon_nr_accesses_mvsum()
> instead of reading the nr_accesses_bp field directly. This provides a more
> error-tolerant moving sum access score for DAMOS scheme logic.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 8a7351b4a27c2..b9d47599f5cbc 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2128,10 +2128,11 @@ static void kdamond_tune_intervals(struct damon_ctx *c)
> >  	damon_set_attrs(c, &new_attrs);
> >  }
> >  
> > -static bool __damos_valid_target(struct damon_region *r, struct damos *s)
> > +static bool __damos_valid_target(struct damon_region *r, struct damos *s,
> > +		struct damon_ctx *c)
> >  {
> >  	unsigned long sz;
> > -	unsigned int nr_accesses = r->nr_accesses_bp / 10000;
> > +	unsigned int nr_accesses = damon_nr_accesses_mvsum(r, c);
> 
> [Severity: High]
> Does this introduction of damon_nr_accesses_mvsum() expose an integer overflow
> on 32-bit systems?

Known low priority issue.  Not a blocker for this patch.


Thanks,
SJ

[...]
