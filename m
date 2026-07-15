Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6991D480DD4;
	Wed, 15 Jul 2026 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128585; cv=none; b=YgFVyL23NkGac4U7GE4+oj9JIvrXS20FPFW+hUZ6wu4/iCG5RB5OaRI0uGsd3SW9UL9aJr7n4TxlLNlm7fEAywobtJD0DutA1OhPmaBKcr94JtmyRevbejXrC3uzUoC0snmmrCco2th//bAEdTyYYOPwhZqJhsSmjSCaekatyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128585; c=relaxed/simple;
	bh=WG6F1ahqrue8E83yL5xft9mnJdqZ3XrsvEdVj3MCOt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKF17gQ6SjMA0iXiDSSfuxQNjDgwkj1gnohYUB+8i345iSYzGt7N712x+406+BSnzWUzXvShO7Fq+6pqwnNXhcTzhuK1ItP+Rp6dW47G9pmIe/D69H7F5RcpwY5bARE3anyK5khoAao43TXAm5+BcTdU7aFPmd0/6SvxpWiISM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gt3pAoMz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gt3pAoMz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E781F00A3A;
	Wed, 15 Jul 2026 15:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784128584;
	bh=BeLeqX4S/oIXr8nGtsJdVw6xbF1CRTIIYfUu6zCUhBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gt3pAoMz8lHCKWZ+VgGJPcaDi7PHN+2loUx39QgMHbSKRSnpetDG5+p5TGrDTVQit
	 vBrobWIpNrrywx4HUVLIPfRROV/6Wm5EtC5CnNOFOFu9ZYro5WhMJyHOXCLJXSZXKz
	 7x3p1ziTJaICXVSbuNHyzmpoiPOuUY09yB+/4DgVhwcZinRkzsjWi3npb1tmOa28Nr
	 Uf2OTZa2u8xWmCofH2/bGAoEb793XMA0d/aIbJ6SXA46hh104mh83xMEmVmoIbECI4
	 Sh1l9CutFnTIQoCUB+/J29oyPoNpG9oVThMqghrcqLl84y/rR0/g9Xw+4QLZ+QvT5b
	 I30h2rC8xIZtg==
From: SJ Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SJ Park <sj@kernel.org>,
	sashiko-reviews@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [PATCH v1 3/3] mm/damon/sysfs: support hugepage_mem_bp quota goal metric
Date: Wed, 15 Jul 2026 08:16:15 -0700
Message-ID: <20260715151615.99767-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ad2caf50-0352-451e-bbfa-94df2280acc9@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 15 Jul 2026 17:47:38 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SJ,
> 
> On 6/17/2026 7:15 AM, SeongJae Park wrote:
> > On Tue, 16 Jun 2026 22:35:21 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >>
> >>
> >> On 6/16/2026 6:21 PM, sashiko-bot@kernel.org wrote:
> >>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> >>>
> >>> New issues:
> >>> - [Low] The new `DAMOS_QUOTA_HUGEPAGE_MEM_BP` metric is exposed via sysfs but lacks required documentation updates.
> >>>
> >>> Pre-existing issues:
> >>> - [Critical] Potential divide-by-zero in `damos_hugepage_mem_bp()` and `damos_get_in_active_mem_bp()` due to an unhandled zero denominator.
> >>> - [High] 32-bit integer overflow in `damos_hugepage_mem_bp()` and `damos_get_in_active_mem_bp()` when calculating memory ratios.
> >>> --
> >>>
> >>> commit be304699fb94d4d73bd979237fb4d7b08b7216f7
> >>> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>>
> >>> mm/damon/sysfs: support hugepage_mem_bp quota goal metric
> >>>
> >>> DAMOS has a new autotune policy metric: DAMOS_QUOTA_HUGEPAGE_MEM_BP.
> >>> This patch exposes DAMOS_QUOTA_HUGEPAGE_MEM_BP through sysfs.
> >>>
> >>>> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> >>>> index 329cfd0bbe9f3..4b5429a5b4158 100644
> >>>> --- a/mm/damon/sysfs-schemes.c
> >>>> +++ b/mm/damon/sysfs-schemes.c
> >>>> @@ -1267,6 +1267,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
> >>>>  		.metric = DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> >>>>  		.name = "node_eligible_mem_bp",
> >>>>  	},
> >>>> +	{
> >>>> +		.metric = DAMOS_QUOTA_HUGEPAGE_MEM_BP,
> >>>> +		.name = "hugepage_mem_bp",
> >>>> +	},
> >>>
> >>> [Severity: Critical]
> >>> This isn't a bug introduced by this patch, but exposing this metric directly
> >>> to userspace makes a potential divide-by-zero triggerable by users
> >>> configuring DAMON quotas.
> >>>
> >>> In mm/damon/core.c:damos_hugepage_mem_bp(), the denominator is computed as:
> >>>
> >>>     total = totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
> >>>
> >>> Due to per-CPU vmstat lag or an idle system, the free pages counter can equal
> >>> totalram_pages(), resulting in total being 0. This is then passed to
> >>> mult_frac():
> >>>
> >>>     return mult_frac(thp, 10000, total);
> >>>
> >>> This inherently computes thp / total, causing a strict division by zero and a
> >>> kernel panic. The same issue exists in damos_get_in_active_mem_bp() where
> >>> total = active + inactive, which can be 0 if the LRU lists are empty.
> >>>
> >>> Should a zero-check on total be added before performing the division?
> >> DAMON is enabled after the system is fully loaded. total will not be 0 by then.
> > 
> > Could you please further clarify what "system is fully loaded" means, reaards
> > to what Sashiko is claiming, particularly the per-CPU vmstat lag?
> > 
> > 
> > Thanks,
> > SJ
> > 
> > [...]
> > 
> 
> What I meant is the system already initialized after booting. The thing
> is that by the time the sysadmin sets up DAMON, vmstat should show at
> least some memory usage, not 0. That was my guess, but I may be wrong.

I think that's a fair argument.  And I also not quite sure.  But having zero
due to the races in per-CPU vmstat sounds possible in an extreme and weird lab
environments.

> 
> If my initial thought was wrong, I can just add a guard there.

So I'm not really sure if you're wrong.  But adding the guard would be simple.
I'd recommend just adding the guard instead of get wrestle on this thoery for
now.  Does that make sense?


Thanks,
SJ

[...]
