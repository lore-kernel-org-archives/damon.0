Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E538B983;
	Wed,  4 Feb 2026 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770190301; cv=none; b=Lk9iKO2tc6t9Q+1Pb+XcexriI5ZHhH3ju2sGKlHulOU49idfRudI8m8KAlflhhU5sUXGnATpnj4cneelYViUqQnCFtsX8nuXgjZh+32MWPnIV1Vw9FeKjSGbKITyzKrMQ9wKfIr7Ml+perdSbMVe/mT5UQlOMsPAnxkPx7MFlg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770190301; c=relaxed/simple;
	bh=h8IFr3hAC3Re7Gtgad9D9ErBYgAe1ei2FUSAKZYjjM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imJz0tyEA1/x78ACshNNWrbgL1IU7kFfwNwlfr6KQhNPYTfUsaE5id9RANiKjMNe2mpUsKN/BK4YFezi/QWZ+7o6JRBrOzO58g1E0icfOktu3QUSQLJ3kbrj1fGJFoEjDTq06wJy5a00nIs0xw1PoJaDcRf8ah/JkZ+xqzz9qso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLzhmU/v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLzhmU/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD87C4CEF7;
	Wed,  4 Feb 2026 07:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770190300;
	bh=h8IFr3hAC3Re7Gtgad9D9ErBYgAe1ei2FUSAKZYjjM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLzhmU/vh6ibnUoQIkKF4n1DxSPWw1DfbD9La3zxbhOgTEVxFcSZzvL6jb9IRp0kM
	 2gU/cVFQd5dF9sKT+eN4nY/uQxDplOAMY/y/Bvo8kSJAcUYSRvDeP7MBME4ILFTkkG
	 BRzmEJd9LlvViVTmsGOy1g6Pk793bzFKKR98yff9xyeZzSxLoOZuxIS/dj4XnB6srk
	 dYE4w4s7tnR0z16XGOhM6ldkBUCc8tbWnbAT1PYAsDm6ry/Qu7cior/cD2kRXQ0UJ5
	 cmyplZxx0R5cMCUiJx3ogXvtAsrOQzgeyrMRJo/XCKdxQix0X8ImvwhkvDdJCss5o6
	 G6OHWOgpc5Bsw==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/4] mm/damon: Support hot application detections
Date: Tue,  3 Feb 2026 23:31:32 -0800
Message-ID: <20260204073133.16471-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <56e9d735-d728-445d-9d5d-f044c9fe53b2@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 3 Feb 2026 16:03:04 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SeongJae!
> 
> On 2/3/2026 4:10 AM, SeongJae Park wrote:
> > Hello Asier,
> > 
> > 
> > Thank you for sharing this nice RFC patch series!
> > 
> > On Mon, 2 Feb 2026 14:56:45 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>
> >> Overview
> >> ----------
> >>
> >> This patch set introduces a new dynamic mechanism for detecting hot applications
> >> and hot regions in those applications.
> >>
> >> Motivation
> >> -----------
> >>
> >> Currently DAMON requires the system administrator to provide information about
> >> which application needs to be monitored and all the parameters. Ideally this
> >> should be done automatically, with minimal intervention from the system
> >> administrator.
> >>
> >>
> >> Since TLB is a bottleneck for many systems, a way to optimize TLB misses (or
> >> hits) is to use huge pages. Unfortunately, using "always" in THP leads to memory
> >> fragmentation and memory waste. For this reason, most application guides and
> >> system administrators suggest to disable THP.
> >>
> >> We would like to detect: 1. which applications are hot in the system and 2.
> >> which memory regions are hot in order to collapse those regions.
> >>
> >>
> >> Solution
> >> -----------
> >>
> >>      ┌────────────┐           ┌────────────┐
> >>      │Damon_module│           │Task_monitor│
> >>      └──────┬─────┘           └──────┬─────┘
> >>             │         start          │
> >>             │───────────────────────>│
> >>             │                        │
> >>             │                        │────┐
> >>             │                        │    │ calculate task load
> >>             │                        │<───┘
> >>             │                        │
> >>             │                        │────┐
> >>             │                        │    │ sort tasks
> >>             │                        │<───┘
> >>             │                        │
> >>             │                        │────┐
> >>             │                        │    │ start kdamond for top 3 tasks
> >>             │                        │<───┘
> >>      ┌──────┴─────┐           ┌──────┴─────┐
> >>      │Damon_module│           │Task_monitor│
> >>      └────────────┘           └────────────┘
> >>
> >>
> >> We calculate the task load base on the sum of all the utime for all the threads
> >> in a given task. Once we get total utime, we use the exponential load average
> >> provided by calc_load. The tasks that become cold, the kdamond will be stopped
> >> for them.
> > 
> > Sounds interesting, and this high level idea makes sense to me. :)
> > 
> > I'd like to further learn a few things.  Is there a reason to think the top 3
> > tasks are enough number of tasks?  Also, what if a region was hot and
> > successfully promoted to use huge pages, but later be cold?  Should we also
> > have a DAMOS scheme for splitting such no-more-hot huge pages?
> 
> No specific reason. This was just for the RFC. We could move this to a parameter
> somehow.

Makes sense.  Depending on the test results with 3 tasks default value, I think
we could just keep it a hard-coded default one.  If it turns out it is not
working good for different cases, we could make it a tunable parameter or
internally auto-tuned.

> 
> In case of a region turning cold, I haven't worked on it. In turning hot means
> that we collapse the hot region, we should do the opposite (split) in case the
> area turns cold. I haven't thought about it, but that a good catch. Thanks!

You're welcome!

> 
> >>
> >> In each kdamond, we start with a high min_access value. Our goal is to find the
> >> "maximum" min_access value at which point the DAMON action is applied. In each
> >> cycle, if no action is applied, we lower the min_access.
> > 
> > Sounds like a nice auto-tuning.  And we have DAMOS quota goal for that kind of
> > auto-tuning.  Have you considered using that?

Maybe you missed the above question?

> > 
> >>
> >> Regarding the action, we introduce a new action: DAMOS_COLLAPSE. This allows us
> >> collapse synchronously and avoid polluting khugepaged and other parts of the MM
> >> subsystem with DAMON stuff. DAMOS_HUGEPAGE eventually calls hugepage_madvise,
> >> which needs the correct vm_flags_t set.
> >>
> >> Benchmark
> >> -----------
> > 
> > Seems you forgot writing this section up.  Or, you don't have benchmark results
> > yet, but only mistakenly wrote the above section header?  Either is fine, as
> > this is just an RFC.  Nevertheless, test results and your expected use case of
> > this patch series will be very helpful.
> > 
> > 
> > Thanks,
> > SJ
> > 
> > [...]
> > 
> 
> Sure, will add the benchmark results in the next RFC version.

Looking forward!  I'm particularly interested in your expected or planned use
case, including why you implement the top n processes logic inside the kernel
instead of putting it on the user space.  I'm also interested in how well the
test setup is representing the realistic use case, and how good the results is.
That will help us deciding important things including whether this can be
merged, and if some corner cases handling should be made before or after
merging it, earlier.


Thanks,
SJ
