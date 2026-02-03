Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DA6E55C;
	Tue,  3 Feb 2026 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081028; cv=none; b=OM+P+8ZPkA3437sJIbl7aXI5Mq/0Y8Hj2CYGBbVJqQkdqtQDZymBxxNivTWUaIA7YjmZ/BBTPfYqBYiuCyKW95qTm+F8Bqecr4FoD2qbdfZhVNWwSMOZxhH9jF5TMnQlQDcZrEw6zEjxwRpKE8zhJBPGVqlVSQLqHpA26atufX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081028; c=relaxed/simple;
	bh=2RdGROADSPTSvf3X10eeb10ai2q30UTfJxWuJZcpIQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F19t7aDwePKbup8gUi9sdNfJj24gY/A8ReSWWX9/FpJZVTFfODDmyekt4OsAMcolGQcwbuNdN1dtfNl01FlADRZnorDCkc0VEqg+/su8wzl1GpfoDoLfOKoiPN3AqUNSpdzpTeNSoGi4CLF9FYunFO2R9aI3P+FN2hsdndqVOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+dANVh7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+dANVh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7DCC116C6;
	Tue,  3 Feb 2026 01:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770081028;
	bh=2RdGROADSPTSvf3X10eeb10ai2q30UTfJxWuJZcpIQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+dANVh79IpjEyJWVw4SFY4tpnPUi5xOFeNj1mlrutVwGsO3kpQU4Dwwu5YPe83s0
	 aWF4VkGemt44wPVPT1dqtfx5v48zlbW+F7e5EEMNk9JIhrohZ7BTh5VNtIZ/PKdKsm
	 Ogpgr3fgg6jfWs02boTMG39Sn7uCO7P4tL2Qqu1XzAIglQpHArKQuNloKOKRR1+tUZ
	 6YsllF7p9xoO0A9twY5PMtWIftKfhwKTUccK608QLpbYt5Rqst8tw/mkcxClKYgCjk
	 V2RyhlHNDnv17B/CrRjiNQOdO/7JcZqq3/la1xVetqfYw8XglJN/ZQOtd0++TFImja
	 /Aw7XNVQGivCg==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
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
Date: Mon,  2 Feb 2026 17:10:18 -0800
Message-ID: <20260203011020.67357-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202145650.1795854-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Asier,


Thank you for sharing this nice RFC patch series!

On Mon, 2 Feb 2026 14:56:45 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Overview
> ----------
> 
> This patch set introduces a new dynamic mechanism for detecting hot applications
> and hot regions in those applications.
> 
> Motivation
> -----------
> 
> Currently DAMON requires the system administrator to provide information about
> which application needs to be monitored and all the parameters. Ideally this
> should be done automatically, with minimal intervention from the system
> administrator.
> 
> 
> Since TLB is a bottleneck for many systems, a way to optimize TLB misses (or
> hits) is to use huge pages. Unfortunately, using "always" in THP leads to memory
> fragmentation and memory waste. For this reason, most application guides and
> system administrators suggest to disable THP.
> 
> We would like to detect: 1. which applications are hot in the system and 2.
> which memory regions are hot in order to collapse those regions.
> 
> 
> Solution
> -----------
> 
>      ┌────────────┐           ┌────────────┐
>      │Damon_module│           │Task_monitor│
>      └──────┬─────┘           └──────┬─────┘
>             │         start          │
>             │───────────────────────>│
>             │                        │
>             │                        │────┐
>             │                        │    │ calculate task load
>             │                        │<───┘
>             │                        │
>             │                        │────┐
>             │                        │    │ sort tasks
>             │                        │<───┘
>             │                        │
>             │                        │────┐
>             │                        │    │ start kdamond for top 3 tasks
>             │                        │<───┘
>      ┌──────┴─────┐           ┌──────┴─────┐
>      │Damon_module│           │Task_monitor│
>      └────────────┘           └────────────┘
> 
> 
> We calculate the task load base on the sum of all the utime for all the threads
> in a given task. Once we get total utime, we use the exponential load average
> provided by calc_load. The tasks that become cold, the kdamond will be stopped
> for them.

Sounds interesting, and this high level idea makes sense to me. :)

I'd like to further learn a few things.  Is there a reason to think the top 3
tasks are enough number of tasks?  Also, what if a region was hot and
successfully promoted to use huge pages, but later be cold?  Should we also
have a DAMOS scheme for splitting such no-more-hot huge pages?

> 
> In each kdamond, we start with a high min_access value. Our goal is to find the
> "maximum" min_access value at which point the DAMON action is applied. In each
> cycle, if no action is applied, we lower the min_access.

Sounds like a nice auto-tuning.  And we have DAMOS quota goal for that kind of
auto-tuning.  Have you considered using that?

> 
> Regarding the action, we introduce a new action: DAMOS_COLLAPSE. This allows us
> collapse synchronously and avoid polluting khugepaged and other parts of the MM
> subsystem with DAMON stuff. DAMOS_HUGEPAGE eventually calls hugepage_madvise,
> which needs the correct vm_flags_t set.
> 
> Benchmark
> -----------

Seems you forgot writing this section up.  Or, you don't have benchmark results
yet, but only mistakenly wrote the above section header?  Either is fine, as
this is just an RFC.  Nevertheless, test results and your expected use case of
this patch series will be very helpful.


Thanks,
SJ

[...]
