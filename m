Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C116F4B0482;
	Fri,  7 Aug 2026 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114178; cv=none; b=PTc4B7Yf0B8pCmCcljBXJE5UYWMp59fr1lLbsGg98Bf+1knyQRA3BdW1XMJvsIZ3upwt9XZrIUw2CPj9RmXrs1R8tn2rv2SGug02Ee/oLUw7UL5IWsq/zOLlt8G/lmh87YD5/K53To9Z5g7TJDV09OxPkk6j4AEcPa3N8Fjee7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114178; c=relaxed/simple;
	bh=6LGSSaQVTm/6nXJL4os6UHWjJj161viypdgGE7dI+tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtLTTtq/455k7OykPGAe29cvwcA669Rj935M8btFFTsqjQnb4J1byVUb/9YGL4SoMekNHmjxp3cXw6oJ1gp9jUPb4gI1DcP35PIiJ4o82k7VgMeATsLX13pgJ3B+sBF4A/ilN919OpOc1fhVs7o4WCM5L0xgIXB4gPwDOxnus+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTqOzsf5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTqOzsf5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466661F00A3E;
	Fri,  7 Aug 2026 14:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786114175;
	bh=jwq5RVip1jQ/5AZgGUaZVceDBX+AN4XH7cVI/yyrCl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nTqOzsf5hMQ4BsunwY5QQdA4aiUjCLRFMLlFzC5DzVxrCXVfW5+3/u00CIlaYDJ4o
	 gyRcecyNg0etVUfXgGE4gyipgSRhuSiu4h3KByzjwsddSGcotnyeLDZM/dIz+O2nD8
	 hHXpqFpA+z6ZimUVZvV8wVK4wLqxCq2o5jD9sEZEfE6xeDVUUfhETK2TSkXuR4RcbX
	 l5Xz+YLhjtlQQMdm7Vy58QPq8UCQOxmQ+FhsJW3yDxDO7IAGYFV/t0qWr+FnTLVAuC
	 qlPoww7P+NbDwBli2X2D6L1WlE1xYl6XV0mKqPDHo+btEfDtEQU8atn8bqrE/iIkoI
	 DNRs7BWUchdlA==
From: SJ Park <sj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: SJ Park <sj@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	oe-lkp@lists.linux.dev,
	lkp@intel.com,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	linux-arch@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [tip:locking/core] [futex]  b78b0b6582: kselftests.damon.sysfs_memcg_path_leak.sh.fail
Date: Fri,  7 Aug 2026 07:49:27 -0700
Message-ID: <20260807144928.912-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260807090139.GR776954@noisy.programming.kicks-ass.net>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Peter,


Thank you for sharing this.

On Fri, 7 Aug 2026 11:01:39 +0200 Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Aug 07, 2026 at 04:50:48PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "kselftests.damon.sysfs_memcg_path_leak.sh.fail" on:
> > 
> > commit: b78b0b65825275f58336a43611a700de174be8c3 ("futex: Use runtime constants for __futex_hash() hot path")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/core
> > 
> > 
> > in testcase: kselftests
> > version: kselftests-x86_64-f5098b6bae76-1_20260727
> > with following parameters:
> > 
> > 	group: damon
> > 
> > 
> > 
> > config: x86_64-rhel-9.4-kselftests
> > compiler: gcc-14
> > test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202608071053.6db6276e-lkp@intel.com
> > 
> > 
> > # timeout set to 300
> > # selftests: damon: sysfs_memcg_path_leak.sh
> > # unreferenced object 0xffff8881029e0ab8 (size 8):
> > #   comm "swapper/0", pid 1, jiffies 4294668108
> > #   hex dump (first 8 bytes):
> > #     00 00 d0 02 81 88 ff ff                          ........
> > #   backtrace (crc 6c1bc6d6):
> > #     __kmalloc_noprof+0x56b/0x830
> > #     futex_init+0x108/0x3c0
> > #     do_one_initcall+0xc3/0x4b0
> > #     do_initcalls+0x215/0x240
> > #     kernel_init_freeable+0x4a1/0x530
> > #     kernel_init+0x18/0x180
> > #     ret_from_fork+0x547/0x870
> > #     ret_from_fork_asm+0x1a/0x30
> > not ok 13 selftests: damon: sysfs_memcg_path_leak.sh # exit=1
> 
> I have no idea what DAMON does or what this selftest is on about. SJ?

The test does a simple DAMON operation and runs kmemleak to see if it caused a
leak.  It doesn't filter out leaks caused by something other than the DAMON
operation, though.  So the test can fail even if there is a leak outside of
DAMON.  This failure is the case.  I confirmed manual kmemleak run without any
DAMON operation reports the leak on the kernel that was built with the reported
commit [1] like below.

    # echo scan > /sys/kernel/debug/kmemleak
    # cat /sys/kernel/debug/kmemleak
    unreferenced object 0xffff888140f848d0 (size 16):
      comm "swapper/0", pid 1, jiffies 4294892369
      hex dump (first 16 bytes):
        00 00 fd 40 81 88 ff ff 00 00 25 80 81 88 ff ff  ...@......%.....
      backtrace (crc 1f413cd3):
        __kmalloc_noprof+0x446/0x590
        futex_init+0x99/0x230
        do_one_initcall+0x5c/0x300
        kernel_init_freeable+0x23f/0x2c0
        kernel_init+0x1a/0x130
        ret_from_fork+0x230/0x2f0
        ret_from_fork_asm+0x1a/0x30

So, the commit is not breaking DAMON.  But apparently it is leaking something.

Sorry for making the confusing noise.  I will update the test to not fail for
non-DAMON leak.

FYI, the 'decode_stacktrace.sh' output is like below:

    unreferenced object 0xffff888140f848d0 (size 16):
    comm "swapper/0", pid 1, jiffies 4294892369
    hex dump (first 16 bytes):
    00 00 fd 40 81 88 ff ff 00 00 25 80 81 88 ff ff  ...@......%.....
    backtrace (crc 1f413cd3):
    __kmalloc_noprof (include/linux/kmemleak.h:44 mm/slub.c:4625 mm/slub.c:4945 mm/slub.c:5361 mm/slub.c:5387)
    futex_init (include/linux/slab.h:973 include/linux/slab.h:1189 kernel/futex/core.c:2024)
    do_one_initcall (init/main.c:1347)
    kernel_init_freeable (init/main.c:1409 (discriminator 1) init/main.c:1425 (discriminator 1) init/main.c:1445 (discriminator 1) init/main.c:1658 (discriminator 1))
    kernel_init (init/main.c:1548)
    ret_from_fork (arch/x86/kernel/process.c:158)
    ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

[1] b78b0b658252 ("futex: Use runtime constants for __futex_hash() hot path")


Thanks,
SJ
