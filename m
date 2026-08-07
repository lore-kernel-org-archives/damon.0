Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C8A369D7D;
	Fri,  7 Aug 2026 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124236; cv=none; b=OsYGT7v2VZSG44gggLSNI1R/yjwchoqFrNZ1/eXFxWoQvdTzVJWyDJ4QZ2qn14yhdNXxBXt+CR+K1j8WTzDuVTkfQ9TPYNhTTW9owge6WVGZVtz05oQer9ltIzqyMNL7RWUr5RacbBJMCf0uHdJl2t0zPeCBh9doPlf6yKEZo14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124236; c=relaxed/simple;
	bh=I/MwN7d8rcGjAynfp3Yh2FrK05ByPnLtMo82uZX3gO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnbOImkr34ESzP/XzF36VOvZULDOE+5WbwWN+ym8aw8JvM9oLpoAmwHNlrhxw0i8Fj+YTB3Leic9FfPwPudvAMB+8N9/L7BY4Mnc1z0zMy889r0IxAB2CJNPbNvHvtmrj5ttd5YZwvGQcHoJlyrm+KX4Bb6H1XsakI3LEoaBk4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=u1YBCUje; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="u1YBCUje"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF4151516;
	Fri,  7 Aug 2026 10:37:05 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70A853F86F;
	Fri,  7 Aug 2026 10:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786124229; bh=I/MwN7d8rcGjAynfp3Yh2FrK05ByPnLtMo82uZX3gO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1YBCUjeDCzJTEobFx+MVNk1Pj6AQM5/5FIGH2K6tYWuBOhiTQQ0znASS67jRUmmo
	 5CjbLkLy668QaGbK1Nsa39Di2KcW87JsWQZ+KZqBRQDOAg4tyJTKY2Q1Va1m1mY6yO
	 pF0DAysKHKvSk6j7OlKxaGWU1vgslfWlOBRTRhFo=
Date: Fri, 7 Aug 2026 18:37:06 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: SJ Park <sj@kernel.org>, kernel test robot <oliver.sang@intel.com>,
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [tip:locking/core] [futex]  b78b0b6582:
 kselftests.damon.sysfs_memcg_path_leak.sh.fail
Message-ID: <anYXwp8peHu8jm-H@arm.com>
References: <20260807090139.GR776954@noisy.programming.kicks-ass.net>
 <20260807144928.912-1-sj@kernel.org>
 <20260807152353.GP687043@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807152353.GP687043@noisy.programming.kicks-ass.net>

On Fri, Aug 07, 2026 at 05:23:53PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 07, 2026 at 07:49:27AM -0700, SJ Park wrote:
> > > > kernel test robot noticed "kselftests.damon.sysfs_memcg_path_leak.sh.fail" on:
> > > > 
> > > > commit: b78b0b65825275f58336a43611a700de174be8c3 ("futex: Use runtime constants for __futex_hash() hot path")
> > > > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/core
> 
> > The test does a simple DAMON operation and runs kmemleak to see if it caused a
> > leak.  It doesn't filter out leaks caused by something other than the DAMON
> > operation, though.  So the test can fail even if there is a leak outside of
> > DAMON.  This failure is the case.  I confirmed manual kmemleak run without any
> > DAMON operation reports the leak on the kernel that was built with the reported
> > commit [1] like below.
> 
> > So, the commit is not breaking DAMON.  But apparently it is leaking something.
> 
> Well, its doing a __init allocation and never freeing it because well,
> futexes cannot be unloaded or anything.
> 
> Catalin, this seems rather daft, but what do I know. Is the below the
> right way to tell it to STFU?
> 
> ---
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index ad917ff83854..afdbaf754fb7 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -45,6 +45,7 @@
>  #include <linux/rseq.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> +#include <linux/kmemleak.h>
>  
>  #include <vdso/futex.h>
>  
> @@ -2058,6 +2059,7 @@ static int __init futex_init(void)
>  	order = get_order(size);
>  
>  	__futex_queues = kcalloc(nr_node_ids, sizeof(*__futex_queues), GFP_KERNEL);
> +	kmemleak_not_leak(__futex_queues);
>  
>  	runtime_const_init(shift, __futex_shift);
>  	runtime_const_init(mask,  __futex_mask);

This would do. Kmemleak is not that advanced to track the
runtime_const_init() pointers.

-- 
Catalin
