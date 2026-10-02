Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8E44F548
	for <damon@lists.linux.dev>; Fri,  2 Oct 2026 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790930092; cv=none; b=p27TkmlxdSgb9olc2iN7dPkaJ8Vl1uR2uPjpLBec737v0kAD/kiR2CuqbtK4iM3+3DVLDJYSIjKMCEwMiK5ZGm+vXW663JGYAVphVH6jE6jQ7ipSTY7096lgO9GWs7VU4+2ElJErVm34M/zYHGLwft6INGYFoUX5qRio3CQq518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790930092; c=relaxed/simple;
	bh=PnBOOjxmH48Ze9ahY0RZYp79Tw3zERpxWIuhr3OZynU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfQnkZ/EwGjR871jaCX/yzGamHAqIf0waRmeZPygij/GrdAAIlY8b0OAwnPo+hHmFgT8jKdscEZysSI1z3AQ6Df/VLLiSkQ+Nr1i+3/Pf0c7bZXtQC1zY8ywZaOPTLKAOFWnVTb97OHx2QAsBqhFSotsJHB5Fdfj94M1OjgmZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv4vzbvV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv4vzbvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1421F000FF;
	Fri,  2 Oct 2026 08:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790930089;
	bh=4EHJY59R/xxtEX7P0jjIWGvuIK9J9GBSBGYtNgFqsW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nv4vzbvVAgZeTUioT9ozsi9C/Ev98nWp4+uwFrQD4RFFu7tAogmcKbjQEz7mxQl7N
	 ZYbTGN4/eLEGP7ZbkOWMNbLFWEjW6v10iW0V762e3l4c01Xsemn4Cj139BQYx94EaN
	 mPanir7SxA2OqZS9ExX0e+P64Umof5vLqgQ2DSIvfI0rFI3pURJntBuE2oexfjApkD
	 JEOFou+S/oz2CRFfBAeZHDWaYA+vgU9VxQ/DmEC7g3IVmDQG/I7ckdEiYMba2Cc2bS
	 BEfwJ1iuLfJtwCEKX/NLefmHNNRvf9p6uaJaeciHFtpI45PkH7tvWUMx1ZtUtpvEOX
	 uUvHbOWk6W5bA==
From: SJ Park <sj@kernel.org>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
Date: Fri,  2 Oct 2026 01:34:43 -0700
Message-ID: <20261002083444.40553-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAAiJnjpweWDACdt3HKtup=8Byp00ePakcHJWEY=WdGT7MT6yxA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 1 Oct 2026 19:54:09 +0300 Anton Gavriliuk <antosha20xx@gmail.com> wrote:

> > That said, I'm personally curious if such fast migration is really needed in
> > the real world workload.  I assume the real production workload would have
> > stable access pattern but only occasionally get access pattern changes.
> > Sometimes temporal and rapid access pattern change could also be made.  But for
> > such temporal pattern change, doing migration would only be costy, since the
> > data that suddenly hot could be soon be cold.  And reliability is important in
> > production.  Hence I was thinking slowly making the balance is better than too
> > quickly and reactively making migrations that will turn out to be no really
> > needed.
> 
> > That said, if you want to test faster migration speed, the multiple kdamonds
> > usage could be one way to test.  If it turns out it is really needed and
> > splitting address ranges has problems, we can consider adding DAMOS feature for
> > utilizing multiple CPUs for faster migrations.
> 
> 
> I agree with you!, but now it looks that demotion is too slow.
> The server is completely idle, only I play with memory tiering.
> 
> As CPU-less NUMA nodes I use Intel Optane PMEM configured as DAX devices,
> 
> [root@localhost anton]# ndctl list
> [
>   {
>     "dev":"namespace1.0",
>     "mode":"devdax",
>     "map":"dev",
>     "size":3183575302144,
>     "uuid":"865e9ee4-6334-4094-ac56-8b452bf4f53f",
>     "chardev":"dax1.0",
>     "align":2097152
>   },
>   {
>     "dev":"namespace0.0",
>     "mode":"devdax",
>     "map":"dev",
>     "size":3183575302144,
>     "uuid":"ce77e90e-31bd-4057-8076-1f5d4374e9a2",
>     "chardev":"dax0.0",
>     "align":2097152
>   }
> ]
> [root@localhost anton]#
> 
> and then configured as system ram by next command,
> 
> daxctl reconfigure-device --mode=system-ram all
> 
> The problem is during demotion (to keep 25% free in the fast tier),
> kdamond.0 utilizes single CPU core ~100%, but writing to the slower
> tier (System PMM Write) ~1.4 GB/s what is much slower than defined
> limit 8 GB/s.

The defined limit is only upper limit, so real speed could be slower than that.
FWIW, the example memory tiering script [1] uses 200 MiB/second as the
upperlimit.  It was set by my gut feeling, not by some good data, though.

I personally feel like ~1.4 GB/s is still a good speed for long-running
production workloads, though I don't have a data to support that.  Do you have
some data or reason to pursue 8 GB/s ?

> 
> 
> top - 16:26:06 up 12 min,  2 users,  load average: 0.81, 0.75, 0.54
> Tasks: 765 total, 2 running, 763 sleep, 0 d-sleep, 0 stopped, 0 zombie
> %Cpu(s):  0.0 us,  1.8 sy,  0.0 ni, 98.2 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> MiB Mem : 6839822.+total, 6439081.+free, 415816.0 used,    465.2 buff/cache
> MiB Swap:   8192.0 total,   8192.0 free,      0.0 used. 6424006.+avail Mem
> 
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>    3227 root      20   0       0      0      0 R  99.8   0.0   1:28.92 kdamond.0
>    2771 root      20   0 6932852  10260   5608 S   0.7   0.0   0:02.95
> pcm-memory
>    1593 root      20   0   17088   8352   7140 S   0.3   0.0   0:00.99
> systemd-logind
>    2263 root      20   0  300.4g 294.4g   6108 S   0.3   4.4   4:42.72
> valkey-server
>    3327 root      20   0   10916   6064   3764 R   0.3   0.0   0:00.16 top
>       1 root      20   0   25356  15232  10456 S   0.0   0.0   0:02.13 systemd
>       2 root      20   0       0      0      0 S   0.0   0.0   0:00.02 kthreadd
> 
> 
> 
> |---------------------------------------||---------------------------------------|
> |--            System DRAM Read Throughput(MB/s):        751.95
>         --|
> |--           System DRAM Write Throughput(MB/s):        742.58
>         --|
> |--             System PMM Read Throughput(MB/s):        693.12
>         --|
> |--            System PMM Write Throughput(MB/s):       1387.47
>         --|
> |--                 System Read Throughput(MB/s):       1445.08
>         --|
> |--                System Write Throughput(MB/s):       2130.05
>         --|
> |--               System Memory Throughput(MB/s):       3575.12
>         --|
> |---------------------------------------||---------------------------------------|
> 
> 
> 
> Samples: 111K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
> 51312892466 lost: 0/0 drop
> Overhead  Shared Object                      Symbol
>   47.50%  [kernel]                           [k] migrate_folio_unmap
>   16.11%  [kernel]                           [k] clear_highpages_kasan_tagged
>   14.93%  [kernel]                           [k] copy_mc_fragile
>    1.63%  [kernel]                           [k] smp_call_function_many_cond
>    1.44%  [kernel]                           [k] page_vma_mapped_walk
>    0.97%  [kernel]                           [k] folio_migrate_flags
>    0.87%  [kernel]                           [k] try_to_migrate_one
>    0.66%  [kernel]                           [k] rmqueue_bulk
>    0.61%  [kernel]                           [k]
> __list_del_entry_valid_or_report
>    0.59%  [kernel]                           [k] remove_migration_pte
>    0.50%  [kernel]                           [k] rmap_walk_anon
>    0.45%  [kernel]                           [k] __free_one_page
>    0.44%  [kernel]                           [k] migrate_folio_move
>    0.44%  [kernel]                           [k] folio_add_anon_rmap_ptes
>    0.40%  [kernel]                           [k] lru_gen_add_folio
>    0.40%  [kernel]                           [k] __mod_memcg_lruvec_state
>    0.39%  [kernel]                           [k] mod_node_page_state
>    0.35%  [kernel]                           [k] migrate_pages_batch
>    0.33%  [kernel]                           [k] _raw_spin_lock
>    0.33%  [kernel]                           [k] up_read
> 
> 
> 
> Samples: 222K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
> 64449579226
> migrate_folio_unmap  /proc/kcore [Percent: local period]
> Percent │       movq   %r13,0x20(%rsp)
>    0.01 │       movq   %rdx,%r13
>         │       movq   %r14,0x28(%rsp)
>         │       movl   %r9d,%r14d
>    0.00 │       movq   %r15,0x30(%rsp)
>    0.01 │       movq   %r8,%r15
>         │     → callq  *%rax
>    0.16 │       testq  %rax,%rax
>         │     ↓ je     2e3
>    0.01 │       movq   %rbp,0x10(%rsp)
>    0.01 │       movq   %rax,%rbp
>    0.04 │       movq   %rax,(%r15)
>    0.00 │       movq   $0x0,0x28(%rax)
>   99.27 │       lock
>         │       btsq   $0x0,(%rbx)
>    0.01 │     ↓ jb     26b
>    0.11 │ 67:   movq   (%rbx),%rdx
>    0.01 │       testq  $0x2,(%rbx)
>    0.01 │     ↓ je     e2
>         │       cmpl   $0x2,%r14d
>         │     ↓ je     d2
>         │       movq   0x40(%rsp),%r8
>         │       movq   %rbx,%rdi
>         │       movl   $0x1,%ecx
>         │       xorl   %edx,%edx
> 
> I also tried without "--damos_filter reject young" and "--damos_filter
> allow young", but got the same single CPU ~100% utilization and
> demotion poor performance.

Thank you for doing these great profiling and sharing the results, Anton.
Apparently the bottleneck is not in DAMON specific code including the filtering
part.  Instead, the bottleneck is in the migration code, which is out of DAMON,
according to my understanding of the profiling result.  You could also confirm
this by measuring the migration speed using move_pages() like system call,
which also use the migration code.

You may need to optimize the migration code, or make DAMON uses multiple CPUs
if faster speed is really what needed.  I'd suggest using the address range
split approach that I suggested in the previous reply.  If it becomes clear the
faster migration is really needed, we could start thinking about making DAMOS
use multiple CPUs without the address range split.

[1] https://github.com/damonitor/damo/blob/next/scripts/mem_tier.sh


Thanks,
SJ

[...]
