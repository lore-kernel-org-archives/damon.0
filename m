Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD6917C8
	for <damon@lists.linux.dev>; Sun,  2 Oct 2022 07:24:36 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id bh13so7408795pgb.4
        for <damon@lists.linux.dev>; Sun, 02 Oct 2022 00:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=qTDu2p/E8FOZbr6OMVZQbKQy7u1n6/aKvowndFgNzb4=;
        b=Sdxx8Oqv7sqO6j12heacCNig4/d3/M4fgx6NR3rpi+f1/J39jRsoW8jbU49jgezPVR
         lmYDMZ3EArZbNnw5Wlfzltd2lqSKwhnTNbE7gpgpQHFa0k6946y4tLo9hMXpu94mno/P
         sEoC2ARiGZzMlUmjNN23rfy81L/k+OqsW+v8j8WxLeXTClkXS8mzQrR/ELm9CFqDOjyo
         xk6DaqufNBne8ooYygUatRCfcOWcsEi09+ji3YRgxBHbZZWKhXh8kqrL+eeVc68bVtp/
         JpPfmwjvtvK6oOfwj0BuG/Jq605GzhHvvglFQEmVBU3OrR6AKDMe1p3b4LhVr+S4WIvo
         1fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qTDu2p/E8FOZbr6OMVZQbKQy7u1n6/aKvowndFgNzb4=;
        b=F9lJw5tMDy6LMsxQ8ac+AHbvj1tArNSaw4+ieRVk6bhmPW+zZ+GKkMD2mM+PvtMYD5
         /Z6AgDtOqakE9IUMKyGrJFhP68ZY8NmI0Oe24dgMAAoGpEsyCxaeSTYSHoHNYH66onB9
         e36E905aRs1untGiV7dLAMHFYyRgHqryM1qjJ9SFt+qy27FWmihKbNvx1y4SBM8yCm1p
         hPLRmGZV7J4ONgHRznRR+V72ecAoz4C9PH00QLM8iPBlFgJyJZt5XY+juNJwo2fVT7Gx
         oZjkYtNgASkRha4HRAYlU56+FFDenuB2lOdaSCrUlKQFSvxqrYUnhDS/VHz0kRvOVVlV
         /fDw==
X-Gm-Message-State: ACrzQf3iLIuQSa3CFJcU8d0bXDud8rwtBjSusz6tn+8YScJ/Pm/yLmG8
	1bpBDmTxtV3bxPCpUpYzlnJYr9pmA69m0w==
X-Google-Smtp-Source: AMsMyM4+L7G8U7YFPkoNcYGzyymusS+TdtHtTkAxaUwUJNjBBfUNinrA36d5FTfWKcT3D4P60dd0iw==
X-Received: by 2002:a05:6a00:234a:b0:560:6d52:47d3 with SMTP id j10-20020a056a00234a00b005606d5247d3mr3508894pfj.32.1664695475803;
        Sun, 02 Oct 2022 00:24:35 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090a154500b0020a71ca2cb8sm2171025pja.56.2022.10.02.00.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 00:24:34 -0700 (PDT)
Date: Sun, 2 Oct 2022 16:24:29 +0900
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: sj@kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, damon@lists.linux.dev
Subject: Re: DAMON KUNIT test failure in latest mm-everything
Message-ID: <Yzk8rfGNTTiU3tH0@hyeyoo>
References: <YzkSd/oug4Gus2tJ@hyeyoo>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzkSd/oug4Gus2tJ@hyeyoo>

On Sun, Oct 02, 2022 at 01:24:23PM +0900, Hyeonggon Yoo wrote:
> Hi guys, yesterday I just built and booted latest mm-everything,
> and I got following report from KUNIT test.
> 
> Environment:
> - x86_64, gcc 11.2.0
> - mm-everything (tag: mm-everything-2022-10-01-01-55)
> - config attached
> 
> Report (stacktrace decoded):

FYI, below is the bad commit from git bisection ;)

Thanks!

065530b966a42d63f214ba40427dc8d00345f573 is the first bad commit
commit 065530b966a42d63f214ba40427dc8d00345f573
Author: SeongJae Park <sj@kernel.org>
Date:   Fri Sep 9 20:28:57 2022 +0000

mm/damon/core-test: test damon_set_regions

Preceding commit fixes a bug in 'damon_set_regions()', which allows holes
in the new monitoring target ranges.  This commit adds a kunit test case
for the problem to avoid any regression.
	
Link: https://lkml.kernel.org/r/20220909202901.57977-4-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Yun Levi <ppbuk5246@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

mm/damon/core-test.h | 23 +++++++++++++++++++++++
1 file changed, 23 insertions(+)


> [   37.158892]     ok 5 - damon_test_merge_two
> [   37.159934]     ok 6 - damon_test_merge_regions_of
> [   37.196173]     ok 7 - damon_test_split_regions_of
> [   37.198029]     ok 8 - damon_test_ops_registration
> [   37.199802] list_del corruption, ffff88811f1c21a0->next is NULL
> [   37.201069] ------------[ cut here ]------------
> [   37.201553] kernel BUG at lib/list_debug.c:49!
> [   37.202026] invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [   37.202632] CPU: 16 PID: 375 Comm: kunit_try_catch Tainted: G    B            N 6.0.0-rc3+ #1841
> [   37.203544] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> [   37.204680] RIP: 0010:__list_del_entry_valid.cold (lib/list_debug.c:49 (discriminator 3)) 
> [ 37.205642] Code: c7 c7 20 b9 51 83 e8 a3 08 fd ff 0f 0b 48 c7 c7 c0 b8 51 83 e8 95 08 fd ff 0f 0b 48 89 ee 48 c7 c7 80 ba 51 83 e8 84 08 fd ff <0f> 0b 4c 89 e1 4c 89 f6 48 c7 c7 80 bc 51 83 e8 70 08 fd ff 0f 0b
> All code
> ========
>    0:	c7 c7 20 b9 51 83    	mov    $0x8351b920,%edi
>    6:	e8 a3 08 fd ff       	call   0xfffffffffffd08ae
>    b:	0f 0b                	ud2    
>    d:	48 c7 c7 c0 b8 51 83 	mov    $0xffffffff8351b8c0,%rdi
>   14:	e8 95 08 fd ff       	call   0xfffffffffffd08ae
>   19:	0f 0b                	ud2    
>   1b:	48 89 ee             	mov    %rbp,%rsi
>   1e:	48 c7 c7 80 ba 51 83 	mov    $0xffffffff8351ba80,%rdi
>   25:	e8 84 08 fd ff       	call   0xfffffffffffd08ae
>   2a:*	0f 0b                	ud2    		<-- trapping instruction
>   2c:	4c 89 e1             	mov    %r12,%rcx
>   2f:	4c 89 f6             	mov    %r14,%rsi
>   32:	48 c7 c7 80 bc 51 83 	mov    $0xffffffff8351bc80,%rdi
>   39:	e8 70 08 fd ff       	call   0xfffffffffffd08ae
>   3e:	0f 0b                	ud2    
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2    
>    2:	4c 89 e1             	mov    %r12,%rcx
>    5:	4c 89 f6             	mov    %r14,%rsi
>    8:	48 c7 c7 80 bc 51 83 	mov    $0xffffffff8351bc80,%rdi
>    f:	e8 70 08 fd ff       	call   0xfffffffffffd0884
>   14:	0f 0b                	ud2    
> [   37.209099] RSP: 0018:ffff88811f9e7d48 EFLAGS: 00010286
> [   37.210008] RAX: 0000000000000033 RBX: ffff88811f1c2170 RCX: 0000000000000000
> [   37.211292] RDX: ffff888113d736c0 RSI: 0000000000000000 RDI: ffffed1023f3cf9b
> [   37.212637] RBP: ffff88811f1c21a0 R08: 0000000000000033 R09: ffff88811f9e7a47
> [   37.213961] R10: 0000000080000000 R11: 0000000000000001 R12: 0000000000000000
> [   37.215324] R13: 0000000000000000 R14: ffff88811f1c21a8 R15: 000000000000001c
> [   37.216678] FS:  0000000000000000(0000) GS:ffff8881e3600000(0000) knlGS:0000000000000000
> [   37.218165] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   37.219225] CR2: 00007fd98b8a3e40 CR3: 000000000442c000 CR4: 0000000000750ee0
> [   37.220622] PKRU: 55555554
> [   37.221132] Call Trace:
> [   37.221554]  <TASK>
> [   37.221927] damon_test_set_regions (./include/linux/list.h:134 ./include/linux/list.h:148 mm/damon/core.c:354 mm/damon/core.c:368 mm/damon/core-test.h:289) 
> [   37.222765] ? damon_set_regions (mm/damon/core-test.h:271) 
> [   37.223571] ? rcu_read_lock_sched_held (kernel/rcu/update.c:104 kernel/rcu/update.c:123) 
> [   37.224495] ? lock_acquire (kernel/locking/lockdep.c:5639) 
> [   37.225203] ? lock_release (kernel/locking/lockdep.c:115 kernel/locking/lockdep.c:5679) 
> [   37.225912] ? rcu_read_lock_sched_held (kernel/rcu/update.c:104 kernel/rcu/update.c:123) 
> [   37.226806] ? __kthread_parkme (./include/linux/instrumented.h:72 ./include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/kthread.c:270) 
> [   37.227587] ? lock_acquired (kernel/locking/lockdep.c:115 kernel/locking/lockdep.c:5913) 
> [   37.228357] ? lock_downgrade (kernel/locking/lockdep.c:5674) 
> [   37.229127] ? io_schedule_timeout (kernel/sched/core.c:6391) 
> [   37.229940] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4273) 
> [   37.230864] ? kunit_try_catch_throw (lib/kunit/try-catch.c:25) 
> [   37.231699] kunit_try_run_case (lib/kunit/test.c:382) 
> [   37.232492] ? kunit_catch_run_case (lib/kunit/test.c:367) 
> [   37.233310] ? kunit_try_catch_throw (lib/kunit/try-catch.c:25) 
> [   37.234099] kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:30) 
> [   37.235099] kthread (kernel/kthread.c:376) 
> [   37.235663] ? kthread_complete_and_exit (kernel/kthread.c:331) 
> [   37.236556] ret_from_fork (arch/x86/entry/entry_64.S:312) 
> [   37.237242]  </TASK>
> [   37.237662] Modules linked in:
> [   37.238298] ---[ end trace 0000000000000000 ]---
> [   37.239157] RIP: 0010:__list_del_entry_valid.cold (lib/list_debug.c:49 (discriminator 3)) 
> [ 37.240247] Code: c7 c7 20 b9 51 83 e8 a3 08 fd ff 0f 0b 48 c7 c7 c0 b8 51 83 e8 95 08 fd ff 0f 0b 48 89 ee 48 c7 c7 80 ba 51 83 e8 84 08 fd ff <0f> 0b 4c 89 e1 4c 89 f6 48 c7 c7 80 bc 51 83 e8 70 08 fd ff 0f 0b
> All code
> ========
>    0:	c7 c7 20 b9 51 83    	mov    $0x8351b920,%edi
>    6:	e8 a3 08 fd ff       	call   0xfffffffffffd08ae
>    b:	0f 0b                	ud2    
>    d:	48 c7 c7 c0 b8 51 83 	mov    $0xffffffff8351b8c0,%rdi
>   14:	e8 95 08 fd ff       	call   0xfffffffffffd08ae
>   19:	0f 0b                	ud2    
>   1b:	48 89 ee             	mov    %rbp,%rsi
>   1e:	48 c7 c7 80 ba 51 83 	mov    $0xffffffff8351ba80,%rdi
>   25:	e8 84 08 fd ff       	call   0xfffffffffffd08ae
>   2a:*	0f 0b                	ud2    		<-- trapping instruction
>   2c:	4c 89 e1             	mov    %r12,%rcx
>   2f:	4c 89 f6             	mov    %r14,%rsi
>   32:	48 c7 c7 80 bc 51 83 	mov    $0xffffffff8351bc80,%rdi
>   39:	e8 70 08 fd ff       	call   0xfffffffffffd08ae
>   3e:	0f 0b                	ud2    
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2    
>    2:	4c 89 e1             	mov    %r12,%rcx
>    5:	4c 89 f6             	mov    %r14,%rsi
>    8:	48 c7 c7 80 bc 51 83 	mov    $0xffffffff8351bc80,%rdi
>    f:	e8 70 08 fd ff       	call   0xfffffffffffd0884
>   14:	0f 0b                	ud2    
> [   37.243633] RSP: 0018:ffff88811f9e7d48 EFLAGS: 00010286
> [   37.244691] RAX: 0000000000000033 RBX: ffff88811f1c2170 RCX: 0000000000000000
> [   37.246006] RDX: ffff888113d736c0 RSI: 0000000000000000 RDI: ffffed1023f3cf9b
> [   37.247321] RBP: ffff88811f1c21a0 R08: 0000000000000033 R09: ffff88811f9e7a47
> [   37.248700] R10: 0000000080000000 R11: 0000000000000001 R12: 0000000000000000
> [   37.250023] R13: 0000000000000000 R14: ffff88811f1c21a8 R15: 000000000000001c
> [   37.251355] FS:  0000000000000000(0000) GS:ffff8881e3600000(0000) knlGS:0000000000000000
> [   37.252914] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   37.254000] CR2: 00007fd98b8a3e40 CR3: 000000000442c000 CR4: 0000000000750ee0
> [   37.255357] PKRU: 55555554
> 
> -- 
> Thanks,
> Hyeonggon
