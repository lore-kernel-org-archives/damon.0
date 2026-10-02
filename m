Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0C48551E
	for <damon@lists.linux.dev>; Fri,  2 Oct 2026 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938942; cv=none; b=LJekFzsASOa/15JZYh0rsWvMVSxUmpyksL8Jz9m9tKpyznuQSN18oBVGo5NB5Gt2sAgOjkU0svvWrQegIgZd3iZoMiwXVCLialQ2kGBPFmRgHZVA1x4KPVHZ0ZANre9OEf7XPIqih53Uvxma733Z3a8kVsxWUflbz8TMpMQPuwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938942; c=relaxed/simple;
	bh=6EThGy01LMFzNYJD3pUB8qP8oNQuRK7i/xyYkKNoMYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqdtE95sZPKMeeu2QOk7HsqYwSkP4p4Qo4dGX3VlkBayeF/ogjfre7LtxSmw4CrzjqsEG2S/lYPd4WLzaSdjMZtDNMhslI/8cvFzkOemCOQfIouMBUETMry+dAcRn576YZydXsVmb58qMPPHPJhwNYQO3vGp6DPa66axODBapUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRHwbbkZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRHwbbkZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B67C1F000FF;
	Fri,  2 Oct 2026 11:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790938941;
	bh=H9W7FpKL9ZSbaxZmuYSUwikibkXM1IkY7AqER1hQdfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HRHwbbkZXCs0NVImnHjbDMwKga5HBHkIE023y5wK61dCyGlztW+KePWN394e2C9xk
	 b7aBw+wM9rBFEouBAxkufYozgXw2FYQ+P3tK2RlfIf4AUBsSTM75fYL02qz/zTgQST
	 6L47u6V+TB01a252TDKlKEWfwoUzzrMsjFxnTMiV55xTv3XMB/Vu1g8x+A33ouZgQ8
	 etj1Yssa8Y66h4H2MZXNr+xeO3rSAU9FYV5JSrSmQlStujDmiMHtd7xrGnoh6GwhHk
	 npvMZmey4oMGAClGdgUMIA1Qn2GR1PMJLibh/IiOloX1p2M1cgWb0vuKR7WVHeFoSy
	 OsoVn1pPCFWXw==
From: SJ Park <sj@kernel.org>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
Date: Fri,  2 Oct 2026 04:02:15 -0700
Message-ID: <20261002110216.41169-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAAiJnjpBdRQnmsm8zB-Bh7taeBkOPadhQWOk6-a2dfTxYVMiZw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 2 Oct 2026 13:02:13 +0300 Anton Gavriliuk <antosha20xx@gmail.com> wrote:

> Peak sequential write to slower tier ~12 GB/s.
> I set the upper limit 8 GB/s just to keep those PMEM modules not overloaded.
> 
> For Memory Tiering with OLTP-like workloads needs to be
> promoted/demoted, 1.4 GB/s is OK.
> But for bandwidth intensive workloads such as analytics, AI, VDI,...
> 1.4 GB/s is too slow.

I think the factor deciding how fast migration should be is not bandwidth
intensiveness but how quickly access pattern changes.  That is, migration speed
should be fast enough to get costs from migration itself be paid back, and get
additional benefits.  That depends on the speed of the workloads' access
pattern change, and the amount of data of the changed pattern.  For example,
let's suppose 10 GiB data of a workload becomes hot, but will be cold again
after 10 seconds.  If we can migrate it to upper tier in one second, it will
get benefit from continued access for remaining 9 seconds.  If it takes 10
seconds to migrate, the benefit from the migration will be much lower.  It
might even lower than the migration work cost.

> 
> On the server where I test Memory Tiering, Intel CPU 8280L installed.
> Despite being already 7 years old, any single CPU core has 13-14 GB/s
> bandwidth access to local memory.

That maese sense to me.  Kernel level page migration requires not only the
content writes.  It also need to do additional works.  It should allocate pages
in destination node that the content will be copied to.  It should update
mappings and related metadata.  It should also handle possible races.  Hence
page migration is much more expensive and slow than pure I/O.

> 
> So from my point of view - even if we increase the number of cores
> keeping in mind 1.4 GB/s per core, we need so many cores to perform
> 10's GB/s demote/promote.

I agree.

> Firstly we need to improve demote/promote
> bandwidth for single CPU core, from 1.4 GB/s to at least 9-10 GB/s.

I agree there could be workloads that could get benefit from faster migration.
And IIRC, there were a few people working on making migration faster and
lightweight.  I'm not an expert in the domain and not involved to such works
for now, though.  Nonetheless, having concrete data showing why 9-10 GB/s is
the right speed would be nice.

> 
> > You could also confirm
> > this by measuring the migration speed using move_pages() like system call,
> > which also use the migration code.
> 
> I'm not a developer and I need to spend more time thinking about how
> to do that, but I tried,
> 
> I used migratepages command, which is probably use migrate_pages()
> instead of move_pages(), but I got the same poor bandwidth and stack
> as with DAMON/DAMOS Memory Tiering,
> 
> top - 12:43:59 up 13 min,  2 users,  load average: 0.65, 0.88, 0.76
> Tasks: 757 total, 2 running, 755 sleep, 0 d-sleep, 0 stopped, 0 zombie
> %Cpu(s):  0.0 us,  1.8 sy,  0.0 ni, 98.2 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> MiB Mem : 6839822.+total, 6438483.+free, 416313.2 used,    669.8 buff/cache
> MiB Swap:   8192.0 total,   8192.0 free,      0.0 used. 6423508.+avail Mem
> 
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>    2935 root      20   0    2644   1764   1644 R  99.7   0.0   0:42.19
> migratepages
>    2941 root      20   0   10884   6192   3916 R   0.7   0.0   0:00.04 top
>    1238 systemd+  20   0   15860   6996   5952 S   0.3   0.0   0:00.37
> systemd-oomd
>    1928 root      20   0  666268  24448  23440 S   0.3   0.0   0:00.34 rsyslogd
>       1 root      20   0   25840  15532  10492 S   0.0   0.0   0:02.15 systemd
>       2 root      20   0       0      0      0 S   0.0   0.0   0:00.02 kthreadd
>       3 root      20   0       0      0      0 S   0.0   0.0   0:00.00
> pool_workqueue_release
>       4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
> kworker/R-rcu_gp
> 
> 
> |---------------------------------------||---------------------------------------|
> |--            System DRAM Read Throughput(MB/s):        759.41
>         --|
> |--           System DRAM Write Throughput(MB/s):        751.36
>         --|
> |--             System PMM Read Throughput(MB/s):        701.24
>         --|
> |--            System PMM Write Throughput(MB/s):       1402.15
>         --|
> |--                 System Read Throughput(MB/s):       1460.65
>         --|
> |--                System Write Throughput(MB/s):       2153.50
>         --|
> |--               System Memory Throughput(MB/s):       3614.15
>         --|
> |---------------------------------------||---------------------------------------|
> 
> 
> Samples: 92K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
> 48280162400 lost: 0/0 drop:
> Overhead  Shared Object                      Symbol
>   49.82%  [kernel]                           [k] migrate_folio_unmap
>   16.52%  [kernel]                           [k] clear_highpages_kasan_tagged
>   13.56%  [kernel]                           [k] copy_mc_fragile
>    1.80%  [kernel]                           [k] smp_call_function_many_cond
>    1.06%  [kernel]                           [k] page_vma_mapped_walk
>    0.95%  [kernel]                           [k] try_to_migrate_one
>    0.94%  [kernel]                           [k] folio_migrate_flags
>    0.71%  [kernel]                           [k] rmqueue_bulk
>    0.61%  [kernel]                           [k] remove_migration_pte
>    0.54%  [kernel]                           [k] __free_one_page
>    0.50%  [kernel]                           [k] migrate_folio_move
>    0.48%  [kernel]                           [k] folio_batch_move_lru
>    0.47%  [kernel]                           [k]
> __list_del_entry_valid_or_report
> 
> 
> Samples: 37K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
> 33608407521
> migrate_folio_unmap  /proc/kcore [Percent: local period]
> Percent │       movq   %r13,0x20(%rsp)
>    0.02 │       movq   %rdx,%r13
>         │       movq   %r14,0x28(%rsp)
>         │       movl   %r9d,%r14d
>         │       movq   %r15,0x30(%rsp)
>    0.01 │       movq   %r8,%r15
>         │     → callq  *%rax
>    0.04 │       testq  %rax,%rax
>         │     ↓ je     2e3
>    0.01 │       movq   %rbp,0x10(%rsp)
>         │       movq   %rax,%rbp
>    0.03 │       movq   %rax,(%r15)
>         │       movq   $0x0,0x28(%rax)
>   99.52 │       lock
>         │       btsq   $0x0,(%rbx)
>    0.01 │     ↓ jb     26b
>    0.13 │ 67:   movq   (%rbx),%rdx
>    0.01 │       testq  $0x2,(%rbx)
>    0.01 │     ↓ je     e2
>         │       cmpl   $0x2,%r14d
>         │     ↓ je     d2
>         │       movq   0x40(%rsp),%r8
>         │       movq   %rbx,%rdi
>         │       movl   $0x1,%ecx
>         │       xorl   %edx,%edx
> 
> Lastly I used migratepages between two fast tiers (numa nodes 0 & 1)
> and got 1.5 GB/s.
> All this is too slow for the coming CXL era.

Thank you for testing this and sharing the results.  This confirms my previous
theory is not wrong.

> 
> Anyway, I'm ready to proceed in assisting you in checking/testing if
> you are also interested.

I think my thoery (bottleneck is in migration, not DAMON) is already proven.
We also confirmed DAMON and DAMOS are working as expected so far.  So I find no
more thing to test for now.  If you have more ideas to test, I will be more
than happy to help.


Thanks,
SJ

[...]
