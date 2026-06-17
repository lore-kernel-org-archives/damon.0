Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581A165F16;
	Wed, 17 Jun 2026 04:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781669387; cv=none; b=IiosB8x2T51q1S6hBS6SA0aX74Rl7MDEg+2zobJZSDVgnkdQYLw3st3OkagXHHXXrztrWV6+ybj+hehe45nq+M2CNCjXCiBUK/QrihgbQ0O56NAt9NOiZThOvWtkLmas/FjS5Ewe8b5vczRdh9NzNl846hgegtxWxRl9kGw27To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781669387; c=relaxed/simple;
	bh=Y70/qMc4N5TJjSi7pPN/aBwIegR+EMi4eyHKH1pnSSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBi60++WMpxnUViDNv48zbzqmG//0yYt5bWcLvzpDk6umuV/B17xRF6CqtmZogKEbgRkCxujjnkSFXyo5f91Y2tP9s52hv9fjxtGZ12YvbcgVKzDORpst16gzemlHXpsZSFoQaXpOCu3zIX1hckE7WNVJ+JTT1XENZvh3yeknHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbtndDhK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbtndDhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021EA1F000E9;
	Wed, 17 Jun 2026 04:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781669386;
	bh=hIYdb4x1bYhjBBCqfOz6SMCoFnhz3pHfuPe7DmSe1hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TbtndDhKhHKvWV5snZtKla3iu64kyGdPkqMtintGva4mF7shgbjwDr9wVfewDsnnz
	 4OT8IfE3NSD5zlZ/y44vSg7tuuhom13bWTd1N5LFrJbNyT2oMr/teqXOIHsd1y9pEn
	 2jRtvQdTh+kw6fPi7Vk2Ma1XPRnFNi00u3+Xa+JEHkQ1YT9+j6TxrFWW/jcKcZxGEK
	 +ZvccEWr6xXqFvuMhVWNrivDl7uJ9Xiq0Yuf24UAz6ChEkv84UQbWD+xxBkOTg1QTb
	 vAdZwhr6uLVLEkZkRuQ9S14jm3RYSGwwBRTqx6S+enWs7rLcHA8kkwkFyjPBO2Il19
	 j/DFthDMe6pbw==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	sashiko-reviews@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [PATCH v1 2/3] mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
Date: Tue, 16 Jun 2026 21:09:37 -0700
Message-ID: <20260617040938.98762-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <308b6783-a1cc-4f57-94d2-7421fd4362e9@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Jun 2026 22:27:41 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 6/16/2026 6:21 PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > - [Medium] The `DAMOS_QUOTA_USER_INPUT` goal tuner feedback mechanism is statically stuck because `current_value` is never dynamically updated.
> > - [Medium] The scheme applies the DAMOS_COLLAPSE action to all regions including completely cold ones, contradicting the patch description.
> > - [Low] The module cannot be compiled due to a naming mismatch between the Kconfig symbol and the Makefile variable.
> > --
> > 
> > commit 7e15caa860a55beb8439fc6bb5f299c5c42fb138
> > Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> > 
> > mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
> > 
> > This patch introduces a new DAMON module (SAMPLE_DAMON_HPAGE)
> > which collapses hot regions into huge pages. The module monitors
> > a specific task using DAMON-based sampling and applies collapsing
> > based on memory usage.
> > 
> >> diff --git a/samples/damon/Makefile b/samples/damon/Makefile
> >> index 72f68cbf422aa..a348dc74ddcb1 100644
> >> --- a/samples/damon/Makefile
> >> +++ b/samples/damon/Makefile
> >> @@ -3,3 +3,4 @@
> >>  obj-$(CONFIG_SAMPLE_DAMON_WSSE) += wsse.o
> >>  obj-$(CONFIG_SAMPLE_DAMON_PRCL) += prcl.o
> >>  obj-$(CONFIG_SAMPLE_DAMON_MTIER) += mtier.o
> >> +obj-$(CONFIG_SAMPLE_DAMON_HUGEPAGE) += hpage.o
> > 
> > [Severity: Low]
> > Does this prevent the module from building? 
> > 
> > The Kconfig file defines the configuration option as SAMPLE_DAMON_HPAGE, 
> > but the Makefile evaluates CONFIG_SAMPLE_DAMON_HUGEPAGE. This mismatch 
> > means the build system might silently skip compiling hpage.o.
> Yes, my bad when moving around code from different branches. Will
> be fixed in v2.
> >> diff --git a/samples/damon/hpage.c b/samples/damon/hpage.c
> >> new file mode 100644
> >> index 0000000000000..ebbe5e1be1a1d
> >> --- /dev/null
> >> +++ b/samples/damon/hpage.c
> > 
> > [ ... ]
> > 
> >> +	scheme = damon_new_scheme(&(struct damos_access_pattern) {
> >> +				.min_sz_region = HPAGE_PMD_SIZE,
> >> +				.max_sz_region = ULONG_MAX,
> >> +				.min_nr_accesses = 0,
> >> +				.max_nr_accesses = UINT_MAX,
> > 
> > [Severity: Medium]
> > Will this apply the collapse action to completely cold regions? 
> > 
> > The commit message states this module collapses "hot regions", but setting 
> > min_nr_accesses to 0 instructs DAMON to apply the action to all regions 
> > that meet the age threshold, including those with no accesses at all. 
> > 
> > Should this be set to a value strictly greater than 0 to only target 
> > heavily accessed regions?
> Good catch. I will update it to 1.

I was assuming you intentionally set it to 0, since quota's access hotness
based prioritization will anyway cut out cold regions.  But if it was not the
intention, please feel free to update.

> > [ ... ]
> > 
> >> +	if (quota_autotune_feedback) {
> >> +		goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, 10000);
> >> +		if (!goal) {
> >> +			damon_destroy_ctx(ctx);
> >> +			return -ENOMEM;
> >> +		}
> >> +		goal->current_value = quota_autotune_feedback;
> >> +		damos_add_quota_goal(&scheme->quota, goal);
> >> +	}
> > 
> > [Severity: Medium]
> > Is there a missing mechanism to dynamically update this feedback value?
> > 
> > Since the module parameter is assigned to current_value exactly once at 
> > startup, without a dynamic update path while running, the auto-tuner will 
> > receive a constant error value. 
> > 
> > Won't this continuously push the quota aggressiveness in one direction 
> > until it hits the limits, rather than forming a proper feedback loop?
> > 
> This is a sample module. There is no commit mechanism as in the usual
> DAMON modules. It should be set up before enabling the module.

It means the user feedback is not really working.

> 
> I will document this behaviour in the documentation.

I'd suggest to just drop this unused and untested feature.


Thanks,
SJ

[...]
