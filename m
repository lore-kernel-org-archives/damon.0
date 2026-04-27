Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06AA346AFD
	for <damon@lists.linux.dev>; Mon, 27 Apr 2026 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328892; cv=none; b=C3ytHQ4R/SBjZm2AL2qwKzmnl0CufSKag7xCmUHfnU1eLHLadfRUf8O0yfhGePZ3epAEpvXkTzuGGZNCCiySWq1q+ZJop8QCYFAM06xg0yWQwCx2XX77iKEpMET7lztAmAqJ+v0bOvq/kkambpUZjsKNsiMMeaEdwxLqs8NztcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328892; c=relaxed/simple;
	bh=OWUivCv4zEIft7NtrxbKIzy+5mPXal2rztDt74M075w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bg/Lthnw9rjxmK6WOi7RX75jS9bhcCIZuGqWGY/rD+5b+D2eOShGZHWilmwJCe7eWdMkavw7qQuZeXj/L607ctR9lh7jreA2XHvsheaQTPg9AyYq0dpDG+aPpTBH4VWhJnxKfGnp9A03GtG2wY8b72QUh2ZvxbCAG1UrUUloUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nM58YBxW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nM58YBxW"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so91822215e9.2
        for <damon@lists.linux.dev>; Mon, 27 Apr 2026 15:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777328889; x=1777933689; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9hfpEncvlzWZw9qEgc5pnCnun8WUnWYl5bmHD7iYIU=;
        b=nM58YBxWh9Rildnt7JATTMg50q4SzbmCi/ix6s6BmdhENtIta3lS8X/ub399+m3c/y
         CdoUxzQmuPbnhYOB/PV3+k3RhferVPiP70WHo/ZgVgfrBPpdeF3yivSURyZD3VP0VPqw
         qSKu0SPFhwd1NFWbRkDonyMJLEgZcSB74dEwuF6FUet/swEP2WFgUkinCR5tpj6SU9d5
         3EUBHtXi8kCU2rW8a59aAHnIqTetsZ41rXHnKFKdE2M1HnIrZgL8VCZIyaVBnl7WhdCF
         giUxlJNEWGq8Sv0r/NGs9rIiNZ39Bab9/+oWzxiJ7dszqF2iyzUZiRilWI2e8Lektn8Q
         t6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777328889; x=1777933689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9hfpEncvlzWZw9qEgc5pnCnun8WUnWYl5bmHD7iYIU=;
        b=Gibaq0Jia04Nf5x65idT1hKkah5/ZsWbXvHtzIE63E1cC60NkxxVd/tXEE2rmXQHCk
         bQP3NQRuJjEcdbgOD68kXO8LcrJukq+jtLwrrQ48MehTyHMGAqqbAWv1gqM4MTkycFxK
         fSaKmEc6hb89zFWywkqf3xbfxypp6MGkA0/rVoEfKp/iJN56vM5TNGWIMwpwHAYt/sAm
         wCIH5NRQxFPL0KtN/sIXajL0TTdblmYla6UjdgjYzznGLTnw0ml8JtxWxvwZmoGQueJK
         Fh+Me+2qZYWsx2vWr1a6TVMO1CwpRiHWxGr1alQKvj7U5xS0PrRYVtiE3hSctgChq5NO
         FptA==
X-Forwarded-Encrypted: i=1; AFNElJ/5+2mMUEtI8MhfmC63ca2bNvG/YlN5aYTSjU24TVy0uyaeJND6t/abEiRwZOvIMoN8Ue4d6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7ol1hRp6QbPtZOLPjstiKdPwkl1sq3Kf/1EJCasxtidi1E4GT
	JuYGbY/iBkbeJZ0Z9iaweLx3CivZEaohnT6ZBpEffnHp0wWNp9bknvg0Q5OZdroVACI=
X-Gm-Gg: AeBDievq6NhXB0LPpYElzCoIXcVygez3oshaJiFq3xz589KeI5UYvgTPspAaq3Z+6GF
	4Ith+zXJt+D0oMuhJ40PczpNR15VEEhzYTa/cwrwMfP+YdvgidZo9ToNbsT2Kv8JFFqavs6SQwp
	nNhck6IhlEoUdb3KLt3nACuf4Fhem7zh1ZXmb2CdO8HoWiNSSASV7Bq9xncja2M1NE8mo1yLJsI
	tDbvM0YyPlux+QhK4iyR3MeAdSZCdiHZrhzCeILFnLnofdjIkNZp9Haz1TgKJ58iF6rold2Q2ch
	jgnLp2P5P6Aez0oTZVaH4nLlKH8KV4lM6VukCJgEDVM9MZQYgua8yiVq3ufUecAvbf3iTKTsfbs
	jl9kKWDMFk3EIzsu9c/omS40p3WglbHlS5uO0giLyeTSUbLQe2+QbRaKFnpqXXTX1IdYX2FjQJy
	qj55ao3eG3D1gOEANREjoe8XrD6Yi/+w7LLhhSkkc=
X-Received: by 2002:a05:600c:46c5:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-48a77b22e28mr7190105e9.26.1777328888562;
        Mon, 27 Apr 2026 15:28:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2a00:23c8:67a7:3101::e3b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77afabcdsm15735785e9.8.2026.04.27.15.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 15:28:07 -0700 (PDT)
Date: Mon, 27 Apr 2026 23:28:04 +0100
From: Gregory Price <gourry@gourry.net>
To: Arun George <arun.george@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com,
	gost.dev@samsung.com, arungeorge05@gmail.com, cpgs@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <ae_i9IlIndumJWN3@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <CGME20260427123800epcas5p1e1a2fed257091b31e2e6c3a7d1b0c2b0@epcas5p1.samsung.com>
 <1983025922.01777297382206.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1983025922.01777297382206.JavaMail.epsvc@epcpadp2new>

On Mon, Apr 27, 2026 at 06:02:57PM +0530, Arun George wrote:
> 
> Appreciate the work as we also chase the same problem statement.
> A few queries please.
> 
> I see the current support relies on read-only mappings which might
> limit the performance. Any particular workload you are targeting with
> this (which can tolerate this latency)?
>
> Any deployments you think of where the goal is a capacity expansion
> with a compromise in performance?
>

Primary use cases for us are any workload that benefits from zswap -
which is many, many (many, many [many, many]) workloads.

That said, performance is quite irrelevant if you cannot guarantee
correctness.

In a scenario where a multi-threaded CPU can write many many GB/s to
a compressed device - I can't see a scenario where completely
uncontended writes to such a device can provide reliability.

I suppose you could increase the latency of a writable cacheline from
Xns to NXns - but you've only slowed the bear down.  Meanwhile, running
away from said bear includes trying to migrate stuff off the device...
presumably to swap - so your migration process has to have higher
throughput than whatever writes are coming in from the CPU.

Meanwhile - the system is clearly already pressured, and is likely to
continue demoting new data to the compressed tier.

So you end up, at best, in a footrace hoping the bear loses interest,
or at worst in a fight hoping to dodge its claws (generating poison on
some write that fails).

> On the device side, are you targeting beyond compressed RAM like
> devices such as memory with NAND etc.?
> 

For private nodes - I have been collecting use cases, but I haven't seen
a NAND proposal.  Unless someone is willing to demonstrate such a device
actually working without causing bus-lockup issues, most believe the
error-recovery overhead for NAND is too expensive to service cacheline
fetches.

> The TL;DR talked about mmap/mbind way of user space allocation from
> the private node. But the allocation is controlled by GFP flag
> N_MEMORY_PRIVATE. Does the user space path of allocation set this
> flag along the way?
> 

No.  Userspace does mbind() and it works - if the device's driver (or
service) has opted that node into allowing mempolicy syscalls.

The kernel injects the __GFP_PRIVATE for the relevant VMA in the vma
fault path if that VMA has a nodemask with a valid private node.

> And I believe the bear-proof cage might work in the normal scenarios,
> but may not work for all.

If it can't work for all workloads, then it's likely not general purpose
enough to find core kernel support and should seek to use the existing
interfaces (DAX and friends).

> We might not be able to rely on the control
> path (backpressure) fully. The control path could go slow, slower and
> even die as well. Should the device respond with something like
> 'bus error' if the host tries to write when it is not capable of
> taking any more writes?
> 

You need two controls over compressed RAM for it to be reliable:

  - Allocation control (acquiring new struct page to write to)
  - Write-control (preventing new writes to compressed pages)

Private nodes provide the allocation control.

A read-only mapping, and guarantee that only memory that can reach
the device is userland memory - is the only way to control the cpu
writes from the OS perspective.

(Bonus: page cache can't live here, because buffered I/O bypasses
 this by using direct writes from the kernel).

Slowing the bus down just puts you in competition with swap, and bus
error is basically equivalent to poison being reported at write time.

That's basically the whole story.

Loosening the write-protection can be seen as trading optimization
for risk - where the risk is hitting poison in userland-only memory.

In the next version of the RFC i'll demonstrate cram.c as a new swap
backend that allows for read-only mappings to be soft-faulted in,
migration on write, isolation to ANON memory, and some optional 
settings that allow a device or administrator a "writable budget" 
which allows some number of pages to be made writable without migration.

~Gregory
