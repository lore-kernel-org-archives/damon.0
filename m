Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39796390608;
	Fri,  7 Aug 2026 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117752; cv=none; b=PG6Ju0HC4XG1/oEOe88C7/wyh7R2SIMl1gSQndH9zu5wN7TZk+WAxYWRSp510uOdINevAna6w6VFGV1q8upzj7Wx3csc0Xg61mGuJMkJm8gjbtM/Ci7uGVH5BDVQqwEnM3ai+zOsuIzrPp+inxMz298dDEyHVT/l6a5bR6osDLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117752; c=relaxed/simple;
	bh=fMSgboVdYV7z+T9qRV59oj5n9h+rJo1oWCe2+FVeQ/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1FUwddszvq+cC0FyDds4rATm39oUHy+i//805zCxGXB4UHL+jXt22ZXHE130a0RN+tUOKKVLm/Ju8lXaPQfV+NxHeZ/wqhXDAiuH9ul4eOqr5vlG52xY8cPZ1zu4ml2bcme41VUv8PzlVMTxU5N+2LV6ri/MX9IVVQfiOyqzE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o7naiOAI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o7naiOAI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eZga+eI6aUkCLElI07Q6wToT2ypfdPDWVV61ZIVWY/E=; b=o7naiOAIhfMJYDWq6oP6aOWY1C
	GwjZ9YTvlYkXo9rdOY5bFiQc5ZkcgzB9bbnJsYyxTBWgCAFNjnw4glmbSHfsf7G5Y5lucQfWmT8Os
	VxU2pePiqpURMgUrycaw2tac+14+rd3j9jbICofW6P7fRtUIHo4eXauafqApk5xqsZpb8wMC0bWye
	G2NH4gHi7XcwIi4D1D4AztA4F+ou1hxqzdQUV2PRgM8SVCBS4nDMDy2ii6cbGhDj0w2XGVNreGJ43
	Aog6TCLbt+wOrzAqgo99t/QmDWW9hEc40Q6NGC6yYEo/dFRm0Pr+SbKwQCc6vyf5sB9xvHvSU4nRE
	mOFGnfuA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsMQO-0000000ADeH-1d37;
	Fri, 07 Aug 2026 15:23:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 71C1330045A; Fri, 07 Aug 2026 17:23:53 +0200 (CEST)
Date: Fri, 7 Aug 2026 17:23:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: SJ Park <sj@kernel.org>, catalin.marinas@arm.com
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [tip:locking/core] [futex]  b78b0b6582:
 kselftests.damon.sysfs_memcg_path_leak.sh.fail
Message-ID: <20260807152353.GP687043@noisy.programming.kicks-ass.net>
References: <20260807090139.GR776954@noisy.programming.kicks-ass.net>
 <20260807144928.912-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807144928.912-1-sj@kernel.org>

On Fri, Aug 07, 2026 at 07:49:27AM -0700, SJ Park wrote:

> > > kernel test robot noticed "kselftests.damon.sysfs_memcg_path_leak.sh.fail" on:
> > > 
> > > commit: b78b0b65825275f58336a43611a700de174be8c3 ("futex: Use runtime constants for __futex_hash() hot path")
> > > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/core

> The test does a simple DAMON operation and runs kmemleak to see if it caused a
> leak.  It doesn't filter out leaks caused by something other than the DAMON
> operation, though.  So the test can fail even if there is a leak outside of
> DAMON.  This failure is the case.  I confirmed manual kmemleak run without any
> DAMON operation reports the leak on the kernel that was built with the reported
> commit [1] like below.

> So, the commit is not breaking DAMON.  But apparently it is leaking something.

Well, its doing a __init allocation and never freeing it because well,
futexes cannot be unloaded or anything.

Catalin, this seems rather daft, but what do I know. Is the below the
right way to tell it to STFU?

---
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index ad917ff83854..afdbaf754fb7 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -45,6 +45,7 @@
 #include <linux/rseq.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/kmemleak.h>
 
 #include <vdso/futex.h>
 
@@ -2058,6 +2059,7 @@ static int __init futex_init(void)
 	order = get_order(size);
 
 	__futex_queues = kcalloc(nr_node_ids, sizeof(*__futex_queues), GFP_KERNEL);
+	kmemleak_not_leak(__futex_queues);
 
 	runtime_const_init(shift, __futex_shift);
 	runtime_const_init(mask,  __futex_mask);
