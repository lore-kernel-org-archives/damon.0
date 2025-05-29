Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434C719CD07
	for <damon@lists.linux.dev>; Thu, 29 May 2025 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748503308; cv=none; b=tVBwWNTG4X4cSOK6OFFKIxe4dsoNVTu6P3HO/ARrNb8wdDQRYg1bsOpekwAEjPxf+JLmQqgf6LZ377hpGD1edZe0Nn/y4tECcWOjYcH9/rnZOWt6BKPvbe3pnOtoikba9dfRzUaQOhw56fpTHRMthi/zvny5rUANHMVR72avyZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748503308; c=relaxed/simple;
	bh=4r8s018V6hpEZ8hKjDggDlJrjQWWMqz83TXHccd+u2Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BV4sdjjvDW4WLmwzHWWKKXnoBD8M/buAPD2jxUamgqt0/iOuEc+HhfDb+g54RwHMAq6i3TUBvYrLpM1GryVPRLdHIi5/ZFBIQckDQt7shci2sNXhopNH9jZozK7aEZXTeyDjJtQmfjjpAHki0YtcUFXm1xlvCgzVYf52JFJAsAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-6a-68380b04bd67
Message-ID: <82ea9158-c71e-4c11-a46d-397e9ec9349b@sk.com>
Date: Thu, 29 May 2025 16:21:39 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, Jonathan Corbet <corbet@lwn.net>,
 damon@lists.linux.dev, kernel-team@meta.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm/damon: introduce DAMON_STAT for simple and
 practical access monitoring
Content-Language: ko
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20250526210936.2744-1-sj@kernel.org>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250526210936.2744-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsXC9ZZnkS4Lt0WGwYlzUhZz1q9hs3hyoJ3R
	4sn/36wW+y4CuQvblrBYXN41h83i3pr/rBaHv75hcuDw2LSqk81j06dJ7B4nZvxm8XixeSaj
	x+K+yawe5y5WeHzeJBfAHsVlk5Kak1mWWqRvl8CVMf/obuaCv2oVyxf/ZWlgbJbvYuTkkBAw
	kZiw5DgzjH2+9y47iM0rYCmx7PZV1i5GDg4WAVWJdztcIcKCEidnPmEBsUUF5CXu35oBVs4s
	sJtRYmKrLogtLJAi8Wz5DUaIuIjE7M42ZpAxIgI+Ei3LE0HCQgKGErN+7mEFsdkE1CSuvJzE
	BGJzChhJfN7XygTRaibRtbULaoy8xPa3c4DGcAFdeYJN4uWbVhaIkyUlDq64wTKBUXAWkvNm
	IVk9C8msWUhmLWBkWcUolJlXlpuYmWOil1GZl1mhl5yfu4kRGCfLav9E72D8dCH4EKMAB6MS
	D+8JRvMMIdbEsuLK3EOMEhzMSiK8TfZmGUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJ
	pCeWpGanphakFsFkmTg4pRoY09NsPCpSuB9NnCEj0c8T6Jz83Uvpx9710gt7Yp7KvFg4v7zA
	esqfGX/7f6w9HcBffqz0ynxB7QlX1TrDXoVzLrNSN+UUbxHgXVAWu/1v+N+MV65BV5SXdLzJ
	Dm1v1TSc/Mrl57xPNf7HDrEf4v8yWe8R/7EUM8ntt9S5ppafyeLS7VhRt2+uEktxRqKhFnNR
	cSIALASJrI8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCNUNLT5eF2yLDYP9yPos569ewWTw50M5o
	8eT/b1aLfReB3MNzT7JaLGxbwmJxedccNot7a/6zWhz++obJgdNj06pONo9Nnyaxe5yY8ZvF
	48XmmYwei/sms3qcu1jhsfjFByaPz5vkAjiiuGxSUnMyy1KL9O0SuDLmH93NXPBXrWL54r8s
	DYzN8l2MnBwSAiYS53vvsoPYvAKWEstuX2XtYuTgYBFQlXi3wxUiLChxcuYTFhBbVEBe4v6t
	GWDlzAK7GSUmtuqC2MICKRLPlt9ghIiLSMzubGMGGSMi4CPRsjwRJCwkYCgx6+ceVhCbTUBN
	4srLSUwgNqeAkcTnfa1MEK1mEl1bu6DGyEtsfzuHeQIj3ywkV8xCsmEWkpZZSFoWMLKsYhTJ
	zCvLTczMMdUrzs6ozMus0EvOz93ECAz6ZbV/Ju5g/HLZ/RCjAAejEg/vCUbzDCHWxLLiytxD
	jBIczEoivE32ZhlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb3CUxOEBNITS1KzU1MLUotgskwc
	nFINjPvnbQ6vu8EvJ2WUyu1fkL0iqULqfKA8X9RRB3PR7mbeu8cEjwQrnanwYQgLD92b+3Xt
	9VPfqmMNrUJmcLmKGVrdP1efyDJtNXvD2hS11euMEhbExTK9ub++LV+nUGFL/5e3Ruu3iX7Z
	1HD3yf1ekfl3hcK3Fb798i++evJKrsMf3a8sUHMLVmIpzkg01GIuKk4EAEBzpEJ2AgAA
X-CFilter-Loop: Reflected

Hi SeongJae,

Thanks for your work.

On 5/27/2025 6:09 AM, SeongJae Park wrote:
> DAMON-based access monitoring is not simple due to required DAMON
> control and results visualizations.  Introduce a static kernel module
> for making it simple.  The module can be enabled without manual setup
> and provides access pattern metrics that easy to fetch and understand
> the practical access pattern information, namely estimated memory
> bandwidth and memory idle time percentiles.
> 
> Background and Problems
> =======================
> 
> DAMON can be used for monitoring data access patterns of the system and
> workloads.  Specifically, users can start DAMON to monitor access events
> on specific address space with fine controls including address ranges to
> monitor and time intervals between samplings and aggregations.  The
> resulting access information snapshot contains access frequency
> (nr_accesses) and how long the frequency was kept (age) for each byte.
> 
> The monitoring usage is not simple and practical enough for production
> usage.  Users should first start DAMON with a number of parameters, and
> wait until DAMON's monitoring results capture a reasonable amount of the
> time data (age).  In production, such manual start and wait is
> impractical to capture useful information from a high number of machines
> in a timely manner.
> 
> The monitoring result is also too detailed to be used on production
> environments.  The raw results are hard to be aggregated and/or compared
> for production environments having a large scale of time, space and
> machines fleet.
> 
> Users have to implement and use their own automation of DAMON control
> and results processing.  It is repetitive and challenging since there is
> no good reference or guideline for such automation.
> 
> Solution: DAMON_STAT
> ====================
> 
> Implement such automation in kernel space as a static kernel module,
> namely DAMON_STAT.  It can be enabled at build, boot, or run time via
> its build configuration or module parameter.  It monitors the entire
> physical address space with monitoring intervals that auto-tuned for a
> reasonable amount of access observations and minimum overhead.  It
> converts the raw monitoring results into simpler metrics that can easily
> be aggregated and compared, namely estimated memory bandwidth and idle
> time percentiles.  Refer to the commit messages of the second and the
> third patches of this patch series for more details about the metrics.

I see the description looks good but it'd be useful if you could share some
execution commands and expected output examples that some newbies can get better
ideas.

I honestly do not have a clear idea how I can use this kind of static kernel
modules as general users although I have developed some features of DAMON.

So could you please help?

Thanks,
Honggyu

> 
> Discussions
> ===========
> 
> The module aims to be useful on production environments constructed with
> a large number of machines that run a long time.  The auto-tuned
> monitoring intervals ensure a reasonable quality of the outputs.  The
> auto-tuning also ensures its overhead be reasonable and low enough to be
> enabled always on the production.  The simplified monitoring results
> metrics can be useful for showing both coldness (idle time percentiles)
> and hotness (memory bandwidth) of the system's access pattern.  We
> expect the information can be useful for assessing system memory
> utilization and inspiring optimizations or investigations on both kernel
> and user space memory management logics for large scale fleets.
> 
> We hence expect the module is good enough to be just used in most
> environments.  For special cases that require a custom access monitoring
> automation, users will still benefit by using DAMON_STAT as a reference
> or a guideline for their specialized automation.
> 
> Revision History
> ================
> 
> Changes from RFC
> (https://lore.kernel.org/20250519164415.43935-1-sj@kernel.org)
> - Add an admin-guide documentation
> - Wordsmith commit messages
> - Rebase to latest mm-new
> 
> SeongJae Park (4):
>    mm/damon: introduce DAMON_STAT module
>    mm/damon/stat: calculate and expose estimated memory bandwidth
>    mm/damon/stat: calculate and expose idle time percentiles
>    Docs/admin-guide/mm/damon: add DAMON_STAT usage document
> 
>   Documentation/admin-guide/mm/damon/index.rst |   1 +
>   Documentation/admin-guide/mm/damon/stat.rst  |  69 ++++++
>   mm/damon/Kconfig                             |  16 ++
>   mm/damon/Makefile                            |   1 +
>   mm/damon/stat.c                              | 245 +++++++++++++++++++
>   5 files changed, 332 insertions(+)
>   create mode 100644 Documentation/admin-guide/mm/damon/stat.rst
>   create mode 100644 mm/damon/stat.c
> 
> 
> base-commit: 90887f57d7a67917136e7c70d26fb3f2fcdc6f53

