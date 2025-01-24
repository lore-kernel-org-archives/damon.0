Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF81B188717;
	Fri, 24 Jan 2025 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737684720; cv=none; b=IGsjWwZXZ9nKjPplok1h4z/vRJa4C5E1D+WRuMXKKjYmb9thoY+P6jN36ha2SxCiEZ3d4EqqptmLZL4hKsUSDhjXzGc7LZL3ClkfRalOWYc1fKL2b60NJKdZqdAnUZKgLt5yw5FQb4j6Xo2Huguf8uAjESJ8by744+lj8q7YI6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737684720; c=relaxed/simple;
	bh=UL21L0c+dIuur3OzbiNk8ygxxsYNbj8P41ADjWyOiLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qMIOnMMWMMKkJofnMqDyhJlwKGvHgGVgJJh/aGNVimHq/XQ2xkl/hdx8OivKakA5Hprp/7UNODi+dNj3DbAkV2pewe5TcBX3o6Tcdco5kE0UHCCDfNzxy3KxvhsygOXbq36VDoIHqenxD5IGBR/cpVUYbQgEBe8JmKHVzRRv8JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/vuYfXN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/vuYfXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3FDC4CED3;
	Fri, 24 Jan 2025 02:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737684720;
	bh=UL21L0c+dIuur3OzbiNk8ygxxsYNbj8P41ADjWyOiLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/vuYfXNc6R1WxK5bahUwlMscY+j4WeScpFxT0hU6xSeqdEgzKpJtt8fPSwIxPITa
	 wAcyEpAca/PuEaClVVs9Ld+l0/kBSGY4cg38bualfEO3fr9GAUkZCzJwHlCRYcSMH0
	 bybepOZbECyH37A0UM4c8RfzQfaQ+ogEC9r9jAHrnzuf5HF3AbjpvrxW/ZEu63GzMg
	 FwcYgbImpR4gJTJX0VyWJcNT/WkjY1p85mdgYMNTZ6JNbqnLl6t4sE8nQJTc8b2J15
	 nBjunkxebZwbwW8whNtGKiJXY+4hsCwtjVWyzTpJRdhznksXZGzzP9fFW0Do4Aik01
	 Rdd21114hlYoQ==
From: SeongJae Park <sj@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: SeongJae Park <sj@kernel.org>,
	lsf-pc@lists.linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Raghavendra K T <raghavendra.kt@amd.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Jiaming Yan <jiamingy@amazon.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Requirements for Access-aware MM of Future
Date: Thu, 23 Jan 2025 18:11:53 -0800
Message-Id: <20250124021153.103622-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <Z4XUoWlU-UgRik18@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Gregory,

On Mon, 13 Jan 2025 22:06:09 -0500 Gregory Price <gourry@gourry.net> wrote:

> On Wed, Jan 01, 2025 at 02:20:39PM -0800, SeongJae Park wrote:
> > Hi all,
> > 
> > 
> > I find a few interesting and promising projects that aim to do efficient access
> > pattern-aware memory management of near future, including below (alphabetically
> > sorted).
> > 
> > - Promotion of unmapped page cache folios
> >   (https://lore.kernel.org/20241210213744.2968-1-gourry@gourry.net)
> 
> 
> I'll break down a few observations I made while hacking on unmapped
> page cache promotion - and my concerns for a leveraging DAMON here.

Thank you for sharing this!

> 
> Additionally some other concerns I've seen raised about duplicating
> promotion logic across various kernel components.
> 
> 
> Latest RFC:
> https://lore.kernel.org/linux-mm/20250107000346.1338481-1-gourry@gourry.net/
> 
> Basic Premise:
>    Use folio_mark_accessed() as a measure of hotness for promotion.
>    Defer promotion to task_work due to locking complexities.
> 
> My major concerns / lessons learned from this exercise include:
> 
> 1) The cost of checking promotion candidacy can be problematic
> 
>    In my microbenchmark in the last RFC version, I showed that while
>    the performance upside (~22-25%) is substantial, there was a
>    non-trivial cost associated with injecting even a single global
>    boolean check in the file_read() path.  This was unexpected.
> 
>    I can probably optimize the disabled case with a likely() clause,
>    but I did not expect such sensitivity.  This tells me injecting
>    an unconditional call into DAMON may be too much overhead. 

I cannot agree more with you about the point that the mechanism for finding the
promotion/demotion (and any access-aware system operation) candidates should
induce only modest or at least controllable overhead.  Actually it was the one
of biggest motivations of DAMON design, and I haven't imagined adding
unconditional calls to DAMON here.

Nonetheless, injecting an unconditional call here should be avoided for not
only DAMON calls but any expensive calls?  I'm also not pretty sure what DAMON
call you are thinking about.

> 
>    I would need to explore this further - including whether it is
>    feasible to inject such a large dependency into swap.c

I understand DAMON is not small in terms of the code size, and has many
limitations that makes it unusable in many use cases.  But, again, I'm not
pretty sure what kind of DAMON usage in swap.c you're thinking about, and
therefore not easy to understyand what part of DAMON is considered as a large
dependency that concerns you.  It would be great if we can make more concrete
example as a result of this topic session at LSFMMBPF.

FYI, I also not having specific idea for helping unmapped pages promotion for
now.  That's my assignment that I will do by LSFMMBPF.  But, a few things that
I naively thinking DAMON might be able to help unmapped promotions are,

1. Using DAMON for profiling how much hot and cold unmapped pages are in which
   tier, and use the information for unmapped pages promotion optimization.
2. Using DAMOS to target-promote hot unmapped pages while using page
   faults-based promotion for mapped pages.
3. Using DAMOS to promote both mapped and unmapped hot pages.

For the first and second ideas, DAMON need to target unmapped pages.  I think
DAMOS filters can be extended for that, and I posted an RFC before:
https://lore.kernel.org/20241127205624.86986-1-sj@kernel.org

Using the RFC-applied kernel and a version of DAMON user-space tool that adds
the support, idea one could be done like below.

    $ sudo ./damo report access --snapshot_damos_filter reject none unmapped --style recency-sz-hist
    # damos filters (df): reject none unmapped
    <last accessed time (us)> <df-passed size>
    [-36.300 s, -32.670 s)   10.297 MiB |*                   |
    [-32.670 s, -29.040 s)   7.297 MiB  |*                   |
    [-29.040 s, -25.410 s)   0 B        |                    |
    [-25.410 s, -21.780 s)   0 B        |                    |
    [-21.780 s, -18.150 s)   0 B        |                    |
    [-18.150 s, -14.520 s)   0 B        |                    |
    [-14.520 s, -10.890 s)   0 B        |                    |
    [-10.890 s, -7.260 s)    0 B        |                    |
    [-7.260 s, -3.630 s)     3.088 GiB  |********************|
    [-3.630 s, -0 ns)        80.000 KiB |*                   |
    [-0 ns, --3630000000 ns) 16.000 KiB |*                   |

    <last accessed time (us)> <total size>
    [-36.300 s, -32.670 s)   24.493 GiB  |********************|
    [-32.670 s, -29.040 s)   5.869 GiB   |*****               |
    [-29.040 s, -25.410 s)   5.568 GiB   |*****               |
    [-25.410 s, -21.780 s)   0 B         |                    |
    [-21.780 s, -18.150 s)   5.899 GiB   |*****               |
    [-18.150 s, -14.520 s)   5.807 GiB   |*****               |
    [-14.520 s, -10.890 s)   0 B         |                    |
    [-10.890 s, -7.260 s)    0 B         |                    |
    [-7.260 s, -3.630 s)     12.231 GiB  |**********          |
    [-3.630 s, -0 ns)        356.000 KiB |*                   |
    [-0 ns, --3630000000 ns) 396.000 KiB |*                   |
    total size: 59.868 GiB

The above output was retrieved while a kernel build is running in background,
and says among 24.493 GiB cold memory that last accessed more than 32.67
seconds before, 10.297 MiB are unmapped pages.

For the third idea, whether and how to collaborate with page faults-based
promotion of mapped pages could be something to discuss.  Some ideas off the my
head is that we can simply make them exclusive, or use DAMOS for proactive
promotion under peaceful situation, but uses page faults based promotion for
more urgent situation, somewhat like kswapd and direct reclaims.

For all three ideas, DAMON will do the monitoring and promotions on DAMON
thread, so no change to swap.c or file io path would be required.

Again, these are just not-yet-settled brainstorming level ideas, and I will try
to make these more specific and settled by LSFMMBPF.  Please feel free to add
comments on this thread rather than waiting for LSFMMBPF, though!

> 
>    This may not affect all cases, but it does affect at least this one.
> 
> 2) The complexity of "when it is safe" to promote a folio is subtle
>    at best, and "actively hostile" at worst.
> 
>    I learned in v1 of the RFC that promotion inline with fma() is not
>    feasible due to a few contexts (task dying in particular) in which
>    migration is not safe.  I deferred to task work because I noticed
>    prior attempts (in development notes) had seen similar issues.
> 
>    Adding a folio reference and/or page flag to defer that migration to
>    another context (i.g. async kthread) solves this at the expensive of
>    implementation complexity. (leaked folios if done wrong)
> 
>    I'd have to look at whether it's worth the increased complexity to
>    aggregate this (particular) identification mechanism - but I think
>    there is clear value to aggregating promotion.
> 
>    I could see some value in pumping tracking bits into DAMON -

I agree to all the points and willing to make DAMON well serve the purpose.

>    but I
>    also see value is making tasks handle promotion as a form of fairness.

I agree that could be good in terms of fairness.  I want to learn more about
the significance of it, though.

> 
> 3) There were expressed opinions on runtime fairness WRT to promotion.
> 
>    There's two competing thoughts:
>    A) Making accessing tasks eat inline promotion cost captures that
>       cost in their runtime slice, promoting fairness in scheduling.
> 
>    B) Aggregating promotion to an external thread can reduce inline
>       faults and tail latencies, but may hides per-task cost. This
>       is a concern if one task drives all the promotions, effectingly
>       stealing an entire core by nature of the async design.
> 
>    I don't have a good answer to this, just an observation that charging
>    promotion time to the identifying task was a concern that was raised.

I think we might be able to pursue two ways in parallel?  Using asynchronous
external thread in more peaceful situation, and let tasks do inline promotion
with fairness under more urgent situation, like kswapd and direct reclaims.

DAMON may fit well for the proactive solutions under less urgent situation.
DAMON_RECLAIM was made in the direction, and working without significant issues
on products for years.

> 
> 
> 4) TPP and Unmapped Page Promotion may affect each other.
> 
>    There is a rate-limiting mechanism in the migration path that was
>    intended to prevent over-pressuring bandwidth with aggressive
>    migrations - prevent major memory stalls.
> 
>    By adding more pressure on this limit from an additional source,
>    we're obviously increasing the time it takes to converge.
> 
>    This is probably the greatest argument for creating a new, aggregated
>    promotion mechanism to serve all of these identification mechanism.
> 
>    This would make it easier for us to determine whether/what
>    identification mechanisms can be aggregated while enabling forward
>    progress on each of them separately.

I agree.  DAMON allows combining multiple different mechanisms with its core
logic, so I beleive it migt be a place that can aggregate the different
identification mechanisms.

DAMON's access monitoring results based system operations feature, namely
DAMOS, also has its own aggressiveness control logic, and resides in the core
layer, so could be used consistently with different promotion candidates
identification mechanisms.

> 
> 5) Scarce resources
> 
>    We need to be careful not to consume excessive amounts of resources
>    in an attempt to track all these identifying mechanisms.  Even 1 byte
>    per folio is 256MB on a 1TB machine.  This gets out of hand quick.
> 
>    With task-work, I was able to add no additional resource consumption,
>    but deferring to a fully async scenario and needing to track things
>    like last-accessing CPU, timestamps, and etc.
> 
>    We'll need to examine this closely if we decide to aggregate either
>    of these mechanisms.

Agreed again.  In case of DAMON, it tries to keep the resources in its own data
structure.  The resource consumption with the own data structure can also be
problematic, but it at least allows setting the upper-bound, regardless of the
system size.  So it is controllable and scalable.

I wish to continue more detailed discussions on LSFMMBPF and this thread!

Thank you again sharing your experiences and thoughts on this topic.  I show
those are making the discussion much more informative and helpful.


Thanks,
SJ

> 
> ~Gregory
