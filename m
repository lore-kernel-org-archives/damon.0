Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90639233939;
	Sat, 23 May 2026 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779556640; cv=none; b=m3PHM+YgdWfDj1mMXE+iWJIIh2OCCvZKHxjvUmy+xIIBO8Ohq5CH/DfIOEQVt3ZUqeTvzJhLO31OgIiA5ZXAnvf/kBoXx54X9DxRG2MbBsyKTNApSzZwzZqOqZTMMOlYeUvhF8z8INNWeDnQz2uPb0E/IP0oiziVbste7uXiOJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779556640; c=relaxed/simple;
	bh=PJtibFyI5/1YLOE3kAvsQZXw+G9mG9uDxCvvezitOpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJ5P2LLJ8/wD8WP801qb3gIqIZgwtogQ351UcAhMO5nx6ArIRdROQ/WXOrxejWEh3kLSP+hc61GoHMPJ0P8iuDOWM9zQGceQIN6YwXeTgHN+7ukY/4NPXQtRDPl1MEJCSGiLL24i/XXF4jMuyzixT9YksUH1bdfEYe9V6OS6WX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQmb0Gmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQmb0Gmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1971F000E9;
	Sat, 23 May 2026 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779556639;
	bh=OXIP3uevryXlgmeqtC306B6tRAZiG3v9yrRQuwLGRPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZQmb0Gmxnfh5Ma1pZDTnnBiQZia86MlVzRVFyjwlqmdy+NpBiXz8F+9cYNI+PUHjz
	 ydDHlJcJ969gaivVO7pn44LYI3chi238Wl7UJlmYY4U5AII/+7ljjp9OZakDT4NfWU
	 hhyfhx30yen89U8doweD7NI2xc5BOQCpbnQzkg0VAT9r/csBO+Fkmghs86vAQiaqlI
	 ioPyUhcYs06N++M4pvrIrCdBF0vscGw67JvFIH/xf0Fe6+xl2DhuWuRUZ1+Kr+NRT8
	 1OP2UIbK1cFrVM/+uWV+8oTNz9dey3pvCpfpA3IbNMwYRe4dFS4umcmHzwz+CAZxSv
	 Ieos+MWTHJmLw==
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
Subject: Re: [RFC PATCH v2 0/4] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Sat, 23 May 2026 10:17:10 -0700
Message-ID: <20260523171710.88918-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522145518.158910-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 May 2026 14:55:14 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Overview
> ========
> 
> This patch set introduces a new autotuning which allows to collapse
> hot regions into hugepages.
[...]
> Solution
> ========
> 
> DAMON has now a way to autotune some of the variables and adjust quotas
> automatically, so that DAMON is fired only under the right circumstances.
> It would be nice to have something similar, but for huge pages.

Agree.

> 
> A new autotuning quota goal[2], damos_get_used_hugepage_mem_bp,

Is the name correct?  I think 'get_used_' may better to be dropped.

> is
> introduced, which checks the huge page consumption to total anonymous
> memory consumption. This new quota mechanism reuses current autotuning
> architecture.
> 
> A new module is introduced to demonstrate the use of huge pages
> collapse autotuning. The goal is to collapse hot regions of a given
> process into huge pages. The module launches a kdamond thread for a 
> certain task provided by the user through monitored_pid module argument.
> Hugepage goal autotuning will automatically adjust the aggressiveness
> of hot region collapses.

Having a module for the demonstration purpose sounds good.  But, for the
demonstration purpose, as I previousoly commented, making it as a sample module
(put under /samples/damon/) or just drop when you drop RFC tag would be better.

Let me know if this module is aimed to be as is even after you drop RFC tag.

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
> The goal was to achieve 10% of the total memory used as hugepage.
> 
> The table below shows the memory consumption over time. Gaps in the
> timestamp means that no changes in the hugepage consumption happened
> over that period of time.
> 
> +-----------+----------------+---------------+----------------------+
> | timestamp | anon_memory_mb | huge_pages_mb | percentage hugepage  |
> +-----------+----------------+---------------+----------------------+
> | 0         | 2159.761719    | 0             | 0%                   |
> | 28        | 2177.574219    | 4             | 0%                   |
[...]
> | 283       | 2224.601563    | 434           | 20%                  |
> | 284       | 2224.632813    | 450           | 20%                  |
> +-----------+----------------+---------------+----------------------+

Thank you for sharing the test.  What about the performance?  Could you also do
comparison of the numbers against the module disabled case, and THP disabled
case?

> 
> Eventually, the amount of huge pages reached 20%. This is consistent
> with how quota goals autotuning work. We are more aggresive when the
> quota is less than 10%, and less aggresive when the quota is higher.
> At some point, the aggressiveness just fades and no more collapses
> occur.

You are correct.  If the behavior disturbs your test, please note that we
introduced 'temporal' quota tuner [1] to make it easier.  It is merged into
7.1-rc1.

> 
> TODO
> ====
> - Support page splitting for cold hugepages.

Sounds good!  By using two DAMOS schemes that doing collapsing and splitting, I
think we can make more complete access-aware THP system.

> 
> Patches Sequence
> ================
> Patch 1 -> damon_modules_new_vaddr_ctx_target
> Patch 2 -> Introduce DAMOS_QUOTA_HUGEPAGE and autotuning
> Patch 3 -> Module that demonstrates how to use DAMOS_QUOTA_HUGEPAGE
>            and the new VADDR ctx creation
> Patch 4 -> Documentation

Patch 1 is only for Patch 3, right?  Let's put it just before patch 3.

[1] https://lkml.kernel.org/r/20260310010529.91162-2-sj@kernel.org


Thanks,
SJ

[...]
