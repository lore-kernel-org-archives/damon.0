Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652942D94AC;
	Thu, 18 Sep 2025 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185574; cv=none; b=TVqCJjwK9uXHYUpfyqELX3Ace+B2N9Y390YZ0f4nwsXNmn0YYT44K0a08XEF7hYhN1wRCk6TJDJA3ULP6brsc9bW4sJr6CBvxHzp3xoCbjMXzLadelXhYS5E0+ScGzNn+2x7hnq54weZhLpH2weErTqp0+tZOBLy1Cv1bbvcoTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185574; c=relaxed/simple;
	bh=0M5LM0c8y+CtEFZ3d/JKxqrH2sSLDWz7njz6l7NWh3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C3zSwlo7ELnpHIByVWlK3QHTqz6GVd0wZvDzmcxPaAG6SpT4iqej19RVEBbAEd3uM2KNcMO+LOcxBhxguSVxHVcrCHEMOzzfFqlhDsmpvqc/SaWK7ftV7/3piz6yYWMCrNZXy6P9l6EMAkP80S60Sh1NzD91Ft7K6VajtqPoz1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6gVLpCg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6gVLpCg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4713C4CEE7;
	Thu, 18 Sep 2025 08:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758185573;
	bh=0M5LM0c8y+CtEFZ3d/JKxqrH2sSLDWz7njz6l7NWh3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L6gVLpCg20pntw8sER7to9BKLjByFOwJnBTdxoN1T2Nvcbz8fq7Ju1lIAkqTPUOSO
	 YZXp4QQ3kEwz7QrGlrnQyZNRb86q4vx52YoPJVuLZQtzuiSLMRz+XDIxGGhRKG6irT
	 3YV+snln4FfLqXfNwJxhET5ShiuMIWgfPwtiwP46GSExOtVQOyHBBtW562UVPtnnVo
	 ctWKTbHRQsbSE91E3bPJLo8aCOaRP4oqcwMDv9s9I3rws2dUNGEJnjap8uPCiGOEVu
	 VGWs0m1ik01YGI1UOH4hKSb/jLQe5k7qXGm4m34I1iJ7kfTL2AH3Nfilxk+2V+WTmV
	 vkEx37E9NEnVA==
From: SeongJae Park <sj@kernel.org>
To: Xinyu Zheng <zhengxinyu6@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zouyipeng@huawei.com,
	Hugh Dickins <hughd@google.com>
Subject: Re: [BUG REPORT] mm/damon: softlockup when kdamond walk page with cpu hotplug
Date: Thu, 18 Sep 2025 01:52:49 -0700
Message-Id: <20250918085249.58966-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250918030029.2652607-1-zhengxinyu6@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Thu, 18 Sep 2025 03:00:29 +0000 Xinyu Zheng <zhengxinyu6@huawei.com> wrote:

> A softlockup issue was found with stress test:

Thank you for sharing this great report!

> 
> watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [migration/0:957]
> CPU: 0 PID: 957 Comm: migration/0 Kdump: loaded Tainted:
> Stopper: multi_cpu_stop+0x0/0x1e8 <- __stop_cpus.constprop.0+0x5c/0xb0
> pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> pc : rcu_momentary_dyntick_idle+0x4c/0xa0
> lr : multi_cpu_stop+0x10c/0x1e8
> sp : ffff800086013d60
> x29: ffff800086013d60 x28: 0000000000000001 x27: 0000000000000000
> x26: 0000000000000000 x25: 00000000ffffffff x24: 0000000000000000
> x23: 0000000000000001 x22: ffffab8f02977e00 x21: ffff8000b44ebb84
> x20: ffff8000b44ebb60 x19: 0000000000000001 x18: 0000000000000000
> x17: 000000040044ffff x16: 004000b5b5503510 x15: 0000000000000800
> x14: ffff081003921440 x13: ffff5c907c75d000 x12: a34000013454d99d
> x11: 0000000000000000 x10: 0000000000000f90 x9 : ffffab8f01b657bc
> x8 : ffff081005e060f0 x7 : ffff081f7fd7b610 x6 : 0000009e0bb34c91
> x5 : 00000000480fd060 x4 : ffff081f7fd7b508 x3 : ffff5c907c75d000
> x2 : ffff800086013d60 x1 : 00000000b8ccb304 x0 : 00000000b8ccb30c
> Call trace:
>  rcu_momentary_dyntick_idle+0x4c/0xa0
>  multi_cpu_stop+0x10c/0x1e8
>  cpu_stopper_thread+0xdc/0x1c0
>  smpboot_thread_fn+0x140/0x190
>  kthread+0xec/0x100
>  ret_from_fork+0x10/0x20
> 
> watchdog: BUG: soft lockup - CPU#18 stuck for 26s! [kdamond.0:408949]
> CPU: 18 PID: 408949 Comm: kdamond.0 Kdump: loaded Tainted:
> pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> pc : damon_mkold_pmd_entry+0x138/0x1d8
> lr : damon_mkold_pmd_entry+0x68/0x1d8
> sp : ffff8000c384bb00
> x29: ffff8000c384bb10 x28: 0000ffff6e2a4a9b x27: 0000ffff6e2a4a9b
> x26: ffff080090fdeb88 x25: 0000ffff6e2a4a9b x24: ffffab8f029a9020
> x23: ffff08013eb8dfe8 x22: 0000ffff6e2a4a9c x21: 0000ffff6e2a4a9b
> x20: ffff8000c384bd08 x19: 0000000000000000 x18: 0000000000000014
> x17: 00000000f90a2272 x16: 0000000004c87773 x15: 000000004524349f
> x14: 00000000ee10aa21 x13: 0000000000000000 x12: ffffab8f02af4818
> x11: 0000ffff7e7fffff x10: 0000ffff62700000 x9 : ffffab8f01d2f628
> x8 : ffff0800879fbc0c x7 : ffff0800879fbc00 x6 : ffff0800c41c7d88
> x5 : 0000000000000171 x4 : ffff08100aab0000 x3 : 00003081088800c0
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  damon_mkold_pmd_entry+0x138/0x1d8
>  walk_pmd_range.isra.0+0x1ac/0x3a8
>  walk_pud_range+0x120/0x190
>  walk_pgd_range+0x170/0x1b8
>  __walk_page_range+0x184/0x198
>  walk_page_range+0x124/0x1f0
>  damon_va_prepare_access_checks+0xb4/0x1b8
>  kdamond_fn+0x11c/0x690
>  kthread+0xec/0x100
>  ret_from_fork+0x10/0x20
> 
> The stress test enable numa balance and kdamond, operation 
> involves CPU hotplug and page fault with migration.
> 
> CPU0				 CPU18                      events
> ===============================	 ======================     ===============
> page_fault(user task invoke)
> migrate_pages(pmd page migrate)
> __schedule
> 				 kdamond_fn
> 				 walk_pmd_range
> 				 damon_mkold_pmd_entry      <= cpu hotplug
> stop_machine_cpuslocked	         // infinite loop
> queue_stop_cpus_work		 // waiting CPU 0 user task
> multi_cpu_stop(migration/0)	 // to be scheduled
> // infinite loop waiting for
> // cpu 18 ACK
> 
> Detail explanation:
> 1. When shutdown one cpu, a state machine in multi_cpu_stop() 
> will wait for other cpu's migration thread reach to same state. 
> In this case, all cpus are doing migration except cpu 18.
> 2. A user task which is bind on cpu 0 is allocating page and 
> invoke page fault to migrate page. Kdamond is looping between 
> damon_mkold_pmd_entry () and walk_pmd_range(),

damon_mkold_pmd_entry() calls pte_offset_map_lock().  If the call returns an
error, damon_mkold_pmd_entry() sets walk->action as ACTION_AGAIN, to retry.  If
the pte_offset_map_lock() continues fails, infinite loop can happen.  I
understand the loop you mentioned above is this case.

The error handling (retrying) was introduced by commit 7780d04046a2
("mm/pagewalkers: ACTION_AGAIN if pte_offset_map_lock() fails").  According to
the commit message, it is assumed to be safe to retry pte_offset_map_lock()
inside walk_page_range(), but it is not for this corner case.  And the commit
introduced the error handling pattern in not only DAMON but also a few other
pte_offset_map_lock() callers, so I think same issue can happen on those, too?

So for the long term, I'm wondering if we should update pte_offset_map_lock()
or whole pte_offset_map_lock() error handling inside walk_page_range()
callbacks to deal with this corner case.  Or, other involved parts like CPU
hotplugging handling?

> since target page 
> is a migration entry. Kdamond can end the loop until user task is 
> scheduled on CPU 0. But CPU 0 is running migration/0.
> 3. CONFIG_PREEMPT_NONE is enable. So all cpu are in a infinite loop.
> 
> I found a similar softlockup issue which is also invoked by a memory 
> operation with cpu hotplug. To fix that issue, add a cond_resched() 
> to avoid block migration task.
> https://lore.kernel.org/all/20250211081819.33307-1-chenridong@huaweicloud.com/#t
> 
> May I ask if there is any solution we can fix this issue? Such as add a 
> cond_sched() in kdamond process.

I think adding cond_resched() on the error handling part of
damon_mkold_pmd_entry() is doable.  Since DAMON is a best-effort approach, just
returning without setting ACTION_AGAIN would also be ok for DAMON.  It will
simply make the behavior same to that before the commit 7780d04046a2
("mm/pagewalkers: ACTION_AGAIN if pte_offset_map_lock() fails").

If this is a real issue making your products bleeding, please feel free to send
such a fix for DAMON (I'd prefer the second approach - just return without
setting ACTION_AGAIN) as a hotfix.

Nonetheless, for long term, as I mentioned above, I'm wondering if we should
update pte_offset_map_lock() internal, or add similar error handling
modification on every similar pte_offset_map_lock() error handling.

> Or is there any chance to do some yield 
> in stop machine process? Probably next time there is another different case 
> running with cpu hotplug can cause the same softlockup. 

I'm not familiar with stop machine process, so I have no good idea here but
this might also be an option?

> 
> Xinyu Zheng


Thanks,
SJ
