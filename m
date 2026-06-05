Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381943B27C4;
	Fri,  5 Jun 2026 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623262; cv=none; b=C4EBE7s/15i/6Spnb/k6/MxfxDl8i7Wh1lsBI+YBcKM+A64ioEHUnhlncRdrtXx0/7hLPE+z9ofPWUr9SMg65UfnRBp5GzM738/ptWGbPYXG8uQsue7iIHt42bA2RB2lwqG3Rl8Z6fN4ianoKNhNVdpgWzIEz+RscrbS9Ri7wTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623262; c=relaxed/simple;
	bh=55bvBzhNn+t7ORA2TCEsKsq3Jcj0FG9K8yizxxVJU88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZ0i6YdnCiztdEzkNbIRTI7qWiCnnU/yuTvrOkQY6EZdm6f4qpwmCH83sVoW6rFSXZI8KlcOeHVrhZW38tUNZlkfFlGPhRcxn2/HyIoWLkrnOwFPNBOVieQ9ZBLW1z5vGSmKSAt1vp+jDJAEcr9hzhSBaWGU/wF8ejHijyLSUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAKRgs+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAKRgs+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDA21F00893;
	Fri,  5 Jun 2026 01:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623254;
	bh=G3ZSWOHSrBK5V4kJO2JQzcyduOQ7iEIJclYsKR3PoQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OAKRgs+dhu4ExCzmHxD960saOAhddzjGQJmDPutx9P1MroRUv35qlcocTJF357pla
	 1zbxnVsplUKi8xthxyLy9mE3ymXmgs7xsCUlTI2Sx7tdkVF8I8Zmt5n/j6HGdd5Ia2
	 H9lCWjC3jYQU+pt6a9sKm+G0P46bTjMBElPeqtatYwafTsh7V74qLt8E6NSYZre0Rj
	 JHmfFcr0otCSKHRBFl54Ro70iEwrwFjTHr1FuGsPVZssMoUyCWDUetVsmQ28HySFPm
	 bqE3LHtDU7pKye7ibP+ix8p5joPnMBiqa0QEzQX7LkTrn4/V7NS0Jb5dRya5WZtGIi
	 6wo367gIlGaZA==
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
Subject: Re: [RFC PATCH v3 0/4] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Thu,  4 Jun 2026 18:34:05 -0700
Message-ID: <20260605013406.83441-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604150338.501128-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Asier,


Thank you for revisioning this great patch!

On Thu, 4 Jun 2026 15:03:33 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Overview
> ========
> 
> This patch set introduces a new autotuning which allows to collapse
> hot regions into hugepages.
> 
> Motivation
> ==========
> 
> Since TLB is a bottleneck for many systems[1], a way to optimize TLB
> misses (or hits) is to use huge pages. Unfortunately, using "always"
> in THP leads to memory fragmentation and memory waste. For this reason,
> most application guides and system administrators suggest to disable THP.
> 
> Currently DAMON has DAMOS_HUGEPAGE, DAMOS_NONHUGEPAGE and DAMOS_COLLAPSE.
> However, there is no way to tune the settings. It will collapse all the
> hot regions that meet the access pattern. If the server is a bare metal
> database or big data server, this will also lead to eventual fragmentation.
> 
> Additionally, currently THP is set globally. Ideally, there should be a
> way to control which tasks can use huge pages.

We can do process level control using prctl(PR_SET_THP_DISABLE) [1], isn't it?
I think the last above sentence is better to be reworded or simply dropped.

> 
> Solution
> ========
> 
> DAMON has now a way to autotune some of the variables and adjust quotas
> automatically, so that DAMON is fired only under the right circumstances.
> It would be nice to have something similar, but for huge pages.
> 
> A new autotuning quota goal[2], damos_get_used_hugepage_mem_bp, is
> introduced, which checks the huge page consumption to total anonymous

In the previous revision I suggested to
s/damos_get_used_hugepage_mem_bp/damos_hugepage_mem_bp/ and you agreed.  Seems
it was forgotten?

> memory consumption. This new quota mechanism reuses current autotuning
> architecture.
> 
> A new module is introduced to demonstrate the use of huge pages

Let's clarify it is a  sample module.  That is,
s/A new module/A new sample module/ ?

> collapse autotuning. The goal is to collapse hot regions of a given
> process into huge pages. The module launches a kdamond thread for a
> certain task provided by the user through monitored_pid module argument.

Following other vaddr based sample modues' pattern, what about
s/monitored_pid/target_pid/ ?

As I also commented on the third patch of this series, apparently it is not
following the sample modules' pattern but that for non-sample modules.  Could
you please rewrite in a more simple way?

> Hugepage goal autotuning will automatically adjust the aggressiveness
> of hot region collapses.
> 
> This module also has a user autotuning knob which allows the user to
> adjust the aggressiveness of page collapsing.
> 
> Benchmarks
> ==========
> 
> Huge page collapse autotuning was tested in a physicial machine with
> MariaDB 10.5.29 and sysbench as the benchmark framework.
> 
> The hugepage module was set up in the following way:
> 
> # echo 1000 > min_age
> # echo 1000 > quota_percentage_hugepage
> # echo $(pidof mariadbd) > monitored_pid
> # echo on > enabled
> 
> The goal was to achieve 5% of the total memory used as hugepage.

Any reason to set it 5% ?

> 
> The table below shows the memory consumption over time. Gaps in the
> timestamp means that no changes in the hugepage consumption happened
> over that period of time.
> 
> +-----------+----------------+----------------+----------------------+
> | timestamp | total mem used | huge page used | percentage hugepage  |
> +-----------+----------------+----------------+----------------------+
> | 0         | 4721188        | 0              | 0%                   |
> | 28        | 4216848        | 4              | 0%                   |
> | 37        | 4189912        | 38912          | 1%                   |
> | 39        | 4195188        | 47104          | 1%                   |
> | 55        | 4111612        | 51200          | 1%                   |
> | 59        | 4137012        | 53248          | 1%                   |
> | 60        | 4137052        | 55296          | 1%                   |
> | 61        | 4156832        | 57344          | 1%                   |
> | 62        | 4136920        | 59392          | 1%                   |
> | 64        | 4109872        | 61440          | 1%                   |
> | 65        | 4119108        | 63488          | 2%                   |
> | 66        | 4145532        | 65536          | 2%                   |
> | 67        | 4134544        | 67584          | 2%                   |
> | 68        | 4158244        | 126976         | 3%                   |
> | 69        | 4124276        | 204800         | 5%                   |
> | 70        | 4100680        | 333824         | 8%                   |
> | 71        | 4095540        | 462848         | 11%                  |
> +-----------+----------------+----------------+----------------------+

What is the timestamp unit?  Second?

What is the mem used unit?  Byytes?  Kiloboytes?

I also remember you mentioned you will compare the numbers for more setups
including module disabled case (baseline) and THP disabled case.  I think "THP
disabled" case was my typo.  Maybe I wanted to say "THP enabled" case.

Is that still on your TODO list?

Given this series is adding relatively small change (assuming the sample module
will be simplified), I wouldn't strictly request all such tests.  I'm just
curious about your plan.

> 
> Performance:
> Baseline -> 18,162.45 transactions per second
> Hugepage autotune -> 18,211.82 transactions per second

So, 2.7% improvement!  I think it is not bad for this simple approach.

Could you further elaborate how the performance is measured?  From when the
transactions per second measurement is started, and when it was stopped?  Are
the numbers average?  Mean?  Or something else?

> 
> 
> Eventually, the amount of huge pages reached 20%. This is consistent
> with how quota goals autotuning work. We are more aggresive when the
> quota is less than 10%, and less aggresive when the quota is higher.
> At some point, the aggressiveness just fades and no more collapses
> occur.

Could you share more hugepage utilization change for long term that captures it
converges to 20% but after that doesn't increase more?

Also, have you tried temporal quota tuner?

> 
> TODO
> ====
> - Support page splitting for cold hugepages.

This is a future work out of the scope of this series, right?  I think that is
better to be clarified.  In the previous revision, I was reading this as a TODO
for a future revision of this patch series.

Also, do you have specific changes you want to make to this series before it is
merged, or dropping the RFC tag?

> 
> Patches Sequence
> ================
> Patch 1 -> Introduce DAMOS_QUOTA_HUGEPAGE and autotuning
> Patch 2 -> damon_modules_new_vaddr_ctx_target
> Patch 3 -> Module that demonstrates how to use DAMOS_QUOTA_HUGEPAGE
>            and the new VADDR ctx creation
> Patch 4 -> Documentation

As I commented to each patch, patch 1 looks good except a few trivial things.
Patch 2 seems unnecessary.  I hope patch 3 to be much simplified and wrote
again following the sample modules' pattern.  Patch 4 seems too much for a
sample module.

> 
> Changes from previous versions
> ==============================
> RFC 2[3] -> RFC 3
>   - Module moved to samples
>   - Change autotune to monitor total memory and hugepage
>   - Added performnace benchmarks to the cover letter
>   - Bail out gracefully when trying to start disable
>     the module after the monitored task exited. This 
>     issue was discovered by sashiko [4]
>   - Fixed typos and added quota_sz to the documentation
>     discovered by sashiko [5]
> RFC 1[6] -> RFC 2
>   - Rebased into mm-new
>   - Use DAMOS_COLLAPSE instead of DAMOS_HUGEPAGE
>   - Fixed an issue that returned silently an error when the PID
>     didn't exist in the system.[7]

Thank you for continuing this great work, Asier.

> 
> [1] https://dl.acm.org/doi/pdf/10.1145/3307650.3322227
> [2] https://lore.kernel.org/e67f05ad-dbb9-45e6-ba30-b167a99ac67d@huawei-partners.com
> [3] https://lore.kernel.org/20260522145518.158910-1-gutierrez.asier@huawei-partners.com
> [4] https://lore.kernel.org/20260522171210.900B11F00A3D@smtp.kernel.org
> [5] https://lore.kernel.org/20260522171633.AAF5B1F000E9@smtp.kernel.org
> [6] https://lore.kernel.org/20260430134139.2446417-1-gutierrez.asier@huawei-partners.com
> [7] https://lore.kernel.org/all/20260430154338.E22E6C2BCB3@smtp.kernel.org/


Thanks,
SJ

[...]
