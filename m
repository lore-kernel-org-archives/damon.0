Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37EA33A9F9
	for <damon@lists.linux.dev>; Fri, 19 Dec 2025 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766144806; cv=none; b=bwjQJbvvbnGFlcvQ2zvCYozjr00I7vozAbNEsUvN+vJH4/49TsmDJBC8YxODLzhUaTOwlld6FsMtkDZ3Ppq+eX49X5ii1RnFU3QttHlh+v/9M/0JrkJ34U9Ar9IDRkCuXsVa9uygxJ+n3jPXfSMgquXQA1XGnNu8Tul3AanKbnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766144806; c=relaxed/simple;
	bh=ZMIY8bvpAjYIhNLbORbK74fYFOO6FDDan9bMjBbDML8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhNJOg6t401wyGtdDZ0MKnoMAfXYcETqFmNnx4OGI8EmTM0/M6mqhAPNAGAzLodRKeqHl38sQSDh2l0F1JhsSTYTWduluy3a5sO7jNAXc6V2NSAgqWNzAXypkqUrJo+5oINUW+3xz9idgXmbNQ8ENdee93j0nH5iQJn62i9+plE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dETzg5j3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dETzg5j3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380C5C4CEF1;
	Fri, 19 Dec 2025 11:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766144805;
	bh=ZMIY8bvpAjYIhNLbORbK74fYFOO6FDDan9bMjBbDML8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dETzg5j31g043NXtaTvY6nlXP+kWJJme+5yA3MJx9PHC3Z5sdLJJz5nShg8YmxH3e
	 5kIbk4xdU9H14nPUvieVZekusoB8RbaKbI5ZBpQPK4SkF6y1MFDZ6jBfGAhSZBN5ZO
	 sms3XtIeFwh+QBCpoK+AgpGu5kv6irIZOTGiDgTl49GJJimpTLOD19j1sJwXtbCJM4
	 5dcuFovc9TBKgu/KpH04pZt4T4mgwMIOwsqi9IMyXfIqWqEkEAdsgW02uvD1Tc/Mns
	 b5Wg5Vz3/p5Es7/CbIVMgmeK+Bu+z1NXpbjC6U9rZvHEjdi5jFDdNPoDE5ZOqNifI6
	 0IG872Xai0aIg==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH 0/2] mm/damon: export symbols and introduce prdm module
Date: Fri, 19 Dec 2025 03:46:32 -0800
Message-ID: <20251219114633.41156-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2c8dd0de-e650-4a74-b1f7-61ed81c03d26@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 18 Dec 2025 21:46:37 +0800 Enze Li <lienze@kylinos.cn> wrote:

> On 2025/12/16 07:16, SeongJae Park wrote:
> > Hello Enze,
> > 
> > On Mon, 15 Dec 2025 22:20:55 +0800 Enze Li <lienze@kylinos.cn> wrote:
> > 
> >> This patchset makes DAMON's advanced memory management accessible to a
> >> broader range of users through two complementary enhancements.  First,
> >> it exports the necessary DAMON core symbols to enable building loadable
> >> kernel modules.  Building on this foundation, it then introduces the
> >> 'prdm' module, which extends the concept from the DAMON sample code
> >> (prcl.c) into a production-ready, user-friendly tool.
> >>
> >> The key strength of this module is its out-of-the-box simplicity: by
> >> simply specifying the PIDs of target processes and enabling the module,
> >> users can concurrently monitor memory access patterns across multiple
> >> processes and trigger proactive reclamation automatically.  This
> >> significantly lowers the barrier to using DAMON, allowing system
> >> administrators and regular users without deep kernel expertise to easily
> >> apply sophisticated memory optimization.
> > 
> > I agree your points about the problems and the direction for improving the
> > situation.
> 
> Thank you, SJ!  Glad we are on the same page. :)
> 
> > However, we have a module for such use case, namely DAMON_RECLAIM.
> > It was designed for a reason that very same to what you described above.  One
> > key difference between DAMON_RECLAIM and prdm is, to my understanding,
> > DAMON_RECLAIM works for the physical address space, while prdm works for
> > virtual address spaces.
> 
> Yes, I have studied the implementation and architecture of this module
> quite thoroughly.  However, there are certain limitations when
> considering it for production use.

To my understanding, DAMON_RECLAIM is being used in multiple real world
products.  I understand you are saying there could be limitations for some
different production uses, and I agree.

> To my knowledge, few would perform
> indiscriminate page reclamation across the entire system.  In most
> practical scenarios, people prefer to protect critical processes from
> being swapped out, while applying page migration and reclamation only to
> less critical or performance-insensitive processes.

Thank you for kindly explaining above.  I agree such protection of critical
processes could be useful and required.  Nonetheless, to me, it sounds like you
could also do such protection using DAMOS_FILTER_TYPE_MEMCG.  Actually the
feature was developed for such use cases, and I recently met some people who
willing to use DAMON on their products in a way very similar to what you
described.  I suggested them to try DAMOS_FILTER_TYPE_MEMCG.  Have you
considered using DAMOS_FILTER_TYPE_MEMCG?

> 
> As we all know, frequent page migration inevitably introduces some
> latency to process response times.  Therefore, the ability to target
> large, inactive memory consumers for reclamation addresses a strong,
> genuine demand from real production environments.
> 
> > Is the virtual address spaces proactive reclamation is
> > what you really need?  If so, could you please further describe your expected
> > or planned usage of it?
> 
> Consider the following scenario: a host machine runs three virtual
> machines -- Machine A, Machine B, and Machine C.  It is known that
> Machine A handles massive traffic, while Machines B and C have
> relatively light workloads.  When memory pressure arises, besides
> releasing caches, the system can utilize prdm to perform precise page
> migration targeting Machines B and C, ensuring memory usage remains
> within a safe margin.
> 
> The data below, collected from a test environment, demonstrates the
> effectiveness of prdm.  After enabling prdm to monitor the two
> lower-activity VMs (2316, 2284), I observed that the DAMON-based prdm
> successfully migrated 5.5 GB of pages to the swap partition.
> 
>  PID USER  PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> 2253 qemu  20   0 11.251g 3.822g  32.7m S 4.989 12.28   0:48.75
> qemu-system-x86
> 2316 qemu  20   0 12.191g 1.524g  34.3m S 5.322 4.893   0:49.05
> qemu-system-x86
> 2284 qemu  20   0 12.092g 1.184g  32.5m S 5.987 3.803   0:48.10
> qemu-system-x86
> 
> root@localhost /s/m/p/parameters# free -h
>        total        used        free      shared  buff/cache   available
> Mem:    31Gi        12Gi        15Gi       5.5Mi       3.2Gi        18Gi
> Swap:   31Gi       5.5Gi        25Gi

Thank you for sharing this nice explanation use case.  I think this all make
sense.

> 
> > 
> > If the virtual address spaces proactive reclamation is really what you need, I
> > think extending DAMON_RECLAIM for the purpose might be doable and even simpler
> > than introducing a new module.  How about doing so?
> 
> Before developing prdm, I had considered implementing the same
> functionality based on DAMON_RECLAIM.  However, I gradually realized
> this would make DAMON_RECLAIM overly complex and less
> user-friendly—especially given its existing module-specific exported
> interfaces, which could confuse users.  This approach would create
> significant barriers to promoting wider DAMON adoption.  Consequently,
> building upon the prcl sample became the preferred choice.

I agree DAMON_RECLAIM already have no small number of parameters, and adding
more may make it look even more complex.  But, users may use only parameters
that really need to be set for their real use case.

For example, if we implement virtual address spaces mode in DAMON_RECLAIM, I
think we can simply add target_pid parameter that works very same to that of
prdm.  If it is unset, DAMON_RECLAIM works in the physical address mode.  If it
is set, it works in the virtual address mode.  Adding just one more parameter
that doesn't break old usage doesn't seem that complex change to me, at least
in terms of the user experience.

As I mentioned above, yet another example would be using
DAMOS_FILTER_TYPE_MEMCG.  For this, we may be able to add a parameter for
describing the memcg of critical processes.  Again, adding just one more
parameter that doesn't affect old usages doesn't seem too complex changes to
me, at least in terms of the user experience.

Meanwhile, I agree adding a new simpler module could make it easy for new
users.  But, I concern if having two modules for DAMON-based reclamation will
make users get difficulty at finding the correct one for their usage, since
they may now need to compare two modules.

For the above reasons, I still feel extending DAMON_RECLAIM is a better
approach in terms of user experience.

I'm not saying DAMON_RECLAIM's user interface is perfect.  Especially its
documentation may have many rooms to improve.

And I'm not very sure if the virtual address spaces reclamation is somewhat
need to be supported from modules rather than using DAMON sysfs interface or
DAMON user-space tool.  I implemented DAMON modules including DAMON_RECLAIM,
DAMON_LRU_SORT and DAMON_STAT for users who willing to enable those always, and
therefore want to avoid runtime controls.  That is, users can use those modules
by modifying the kernel command line options.  My expectation for DAMON modules
may not well documented.  If so, it's my bad.  I will try to recheck the
documentation and make that more clearly documented.

For virtual address spaces reclamation, however, runtime control is essential
since you don't know the pid of the processes before the runtime.  In the case,
I think using DAMON sysfs interface or DAMON user-space tool could be a better
approach.  Have you considered using those?

> 
> > 
> > And, even more importantly, why it should be a loadable module rather than a
> > static module?  Do you have a specific use case that requires it to be a
> > loadable module?
> 
> Yes, loadability is crucial for operational flexibility in practical
> production environments.  Beyond some obvious advantages, I would like
> to highlight a key scenario: system administrators can load the prdm
> module upon detecting memory pressure and unload it immediately after
> reclamation is complete, thereby eliminating any overhead during normal
> operation.

I agree always having prdm in kernel is an overhead.  But, I think the
overhead is not meaningfully big.  Also, as I mentioned above, my intended use
cases of DAMON modules is for cases that willing to simply always use the
modules.  If runtime controls are essential, I think using DAMON sysfs
interface or DAMON user-space tool is a better choice.

Someone might argue DAMON sysfs interface is unnecessarily big compared to
prdm.  But, I have to ask again in the case.  Does the overhead really
meaningfully big for a real world use case?

> Furthermore, it supports zero-downtime updates, meaning that
> improvements targeting prdm can be deployed via a simple module reload,
> avoiding costly system reboots.

So I'm not really convinced at needs of prdm module at the moment.  But I agree
your above point is a good example advantage of loadable modules.  Also there
were private requests to support loadable DAMON modules.  No one among those
were for real production use case, and I understand you are also doing this
work for imaginable use cases, not your real products.  Please correct me if
I'm wrong.  But as the request is repeated, if you willing to convert existing
DAMON modules to support loadable modules build and expose required DAMON
functions for that, at least I wouldn't oppose.

> 
> Finally, I would like to add that designing prdm with an extremely
> simple workflow -- load the module, set the target PIDs, and enable the
> switch -- will contribute to the promotion of DAMON, allowing a broader
> user base to benefit from the DAMON system.

That workflow is definitely much easier than directly using DAMON sysfs
interface.  But, for the reason we have DAMON user-space tool.  Using it, the
workflow can also be as simple as prdm, like below.

   # damo start $TARGET_PID --damos_action pageout --damos_access_rate 0% 0% --damos_age 2m max


Thanks,
SJ

[...]
