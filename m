Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25108283FD4
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932994; cv=none; b=d6njjjulOc0YGIyx0EPXD6SDqL/dM3Yujopm+7pB6I17IX7YhtEtmg0XdaahHyzxkk/VM7ySXnprVGEd8drKKsBzA/5bBrv6Ul5JJPfRi9+i9TyxfveUYPlesGUAodqRqpYGc72yEO6ZTwaSVDfrb12gNHBss004bPR8QD3PhHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932994; c=relaxed/simple;
	bh=w8KECUgZU784nrWzd9pPxP9fep5qk5sRDHZVbyBswlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVZR920/apassDAEMIGzjjxynsO2S6b+jK29t3fJzm9hnCm7iCZsFu5XLZAnhsHZuO68dmlbRUmhZvRqDG/rCsH61n9MoiOi9gJDwFUNIY7BcmCb4KYvX2186oNxkrqfyHarl8Tj+aawtlimwoeMwtKD4+kEFvG+3e94O39WT4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KJ8Okfa8; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KJ8Okfa8"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb4136d865so146463885a.1
        for <damon@lists.linux.dev>; Thu, 19 Mar 2026 08:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1773932992; x=1774537792; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fU4+lilPbMb3EqzTb9SzQ9ED33oth0C4b6/QPTs5sDk=;
        b=KJ8Okfa85oZ0fRMRHp0bgd+PONyFk+7gc/85E8QxA8AOizV6T4vXzQ9//ZKMeIQYic
         MsqlLlYa8kA+QUeKjm9ztkzQPJdyJ5j6oN4uWcWRDDgUsxe0Ioj82jwh929oVWas11s9
         ECdBRJmym2XXbiXQQGOqOu3u21BUKeRBZS6KKvF1kbRsu3XtM0vARwPfesRtsq367VAH
         3Wq8GuYus6DHVe7B9wC46flKb4FSBUz0U7wHL2Jn4VK/kLKoiloXWvAWPdQnyotAcg2q
         V0Ab/F+5A/xt495S32ZMg1TvSD9GEMlrP1f5/ASMlHAs1sqz7Rtxv7uJ1J7/D+Bbn8qb
         7NNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773932992; x=1774537792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fU4+lilPbMb3EqzTb9SzQ9ED33oth0C4b6/QPTs5sDk=;
        b=M5vhMbTN6Qf29uPEcS2lMaI+qALL0pVBOF6aMi3TKfPjNyHj6EiE/NGrGEqzxTs8Rh
         5ki4loloskyJWRTYPDnehW0ZNGv7kMSHeKPshaIICFr2JPL0sr8vMqAkNNE+zYq1V+vS
         btoWHgsNjn4tvT7exhkPpUVh1LXXWmljtiMLNwGiBjVtx3jPgx+pfKA8Kpj0ApnkhMgg
         jj/xbYVB+K0epcz/64iRd4hbOXPReyl1SJhvuuzf4sHC4BV/g+h4FzBdnfuRQz/0rFIC
         lNmi2hnJPDSF+l6WJ6HFKwl+QLRebeSKU9ZHAq2EX2efyWpBG/4vAPQhkydb8hVPv0lV
         Cvdg==
X-Forwarded-Encrypted: i=1; AJvYcCWb/5aNBqDFN5Qp84/lTuL9qlxoIBD9YYdUU5tTS/b/HNnQ0Qh2F2pi/VX9RPWWKf1pfdCB2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWjo8hsHbwQqgZVI4g1fDAr4r2C0D+1XuzlxclIYQVesiagStb
	rk7/H70ttEAK0lXCfkXjqlpigqL4UrsBkvtWvCsdQffTIoz/Q89Jsfco56hCFVq/Cdo=
X-Gm-Gg: ATEYQzyGeTqkzgug620WENbK50qK4IPe1kBRbmIGAQSjvxvGCRK3etG94HW0A6GCj/j
	9PWY/I0VcIHEe+D+MLi9C13bQ53WANzV+7PMWIWkhNvlFlqTKnmx8oQ+vt8XhBSFDdFZ2p+oDn9
	t09OthynmynCLWEcRacWu+UO1K4fwgaUHsqpSf/jZPq93wOVSG0DPAtt9kM7RpiqtvCqn5j1oM3
	l+OKyGlFg6lXssZ9oOikV4inxeB2f16YvsckhixtA9yDFOjYsW81ah2WghRkBSk52QgQWDtJLE4
	x0LygbYt+RYtP7Twm452dr1qsJ2afU9qJhU9mMA1k7bZ9pj4XrAoqfP0pW+RhxsLQAr/9nbe2+S
	wl6QVK2PVx7xm8IELRBMUKB2C4R0lzTjvqG7QCVD+vglXeuHEyu2VPv7j2smp/YYeLNjNHmZfmv
	urh6JQ5XR3lj0iRilogkS9e78lU4hs6m47Q6J4sd7+G59RMu8x5Zv6K424powzTIe7La0EdKgHM
	h+ZSVJL6w==
X-Received: by 2002:a05:620a:4050:b0:8cd:af31:b421 with SMTP id af79cd13be357-8cfad2c5236mr1047066785a.34.1773932991754;
        Thu, 19 Mar 2026 08:09:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfad1b1154sm524775785a.35.2026.03.19.08.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:09:51 -0700 (PDT)
Date: Thu, 19 Mar 2026 11:09:47 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, osalvador@suse.de,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com,
	sj@kernel.org, baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>

On Tue, Mar 17, 2026 at 02:25:29PM +0100, David Hildenbrand (Arm) wrote:
> On 2/22/26 09:48, Gregory Price wrote:
> > Topic type: MM
> 
> Hi Gregory,
> 
> stumbling over this again, some questions whereby I'll just ignore the
> compressed RAM bits for now and focus on use cases where promotion etc
> are not relevant :)

A more concrete example up your alley:

I've since been playing with a virtio-net private node.

Normally cloud-hypervisor VMs with virtio-net can't be subject to KSM
because the entire boot region gets marked shared.  If virtio-net has
its own private node / region separate from the boot region, the boot
region is now free to be subject to KSM.

I may have that up as an example sometime before LSF, but i need to
clean up some networking stack hacks i've made to make it work.

> > 
> > N_MEMORY_PRIVATE is all about isolating NUMA nodes and then punching
> > explicit holes in that isolation to do useful things we couldn't do
> > before without re-implementing entire portions of mm/ in a driver.
> 
> Just to clarify: we don't currently have any mechanism to expose, say,
> SPM/PMEM/whatsoever to the buddy allocator through the dax/kmem driver
> and *not* have random allocations end up on it, correct?
>
> Assume we online the memory to ZONE_MOVABLE, still other (fallback)
> allocations might end up on that memory.
> 

Correct, when you hotplug memory into a node, it's a free for all.
Fallbacks are going to happen.

I see you saw below that one of the extensions is removing the nodes
from the fallback list.  That is part one, but it's insufficient to
prevent complete leakage (someone might iterate over the nodes-possible
list and try migrating memory).

> How would we currently handle something like that? (do we have drivers
> for that? I'd assume that drivers would only migrate some user memory to
> ZONE_DEVICE memory.)
> 
> Assuming we don't have such a mechanism, I assume that part of your
> proposal would be very interesting: online the memory to a
> "special"/"restricted" (you call it private) NUMA node, whereby all
> memory of that NUMA node will only be consumable through
> mbind() and friends.
> 

Basically the only isolation mechanism we have today is ZONE_DEVICE.

Either via mbind and friends, or even just the driver itself managing it
directly via alloc_pages_node() and exposing some userland interface.

You can imagine a network driver providing an ioctl for a shared buffer
or a driver exposing a mmap'able file descriptor as the trivial case.

> Any other allocations (including automatic page migration etc) would not
> end up on that memory.

One of the complications of exposing this memory via mbind is that
mempolicy.c has a lot of migration mechanics, just to name two:

  - migrate on mbind
  - cpuset rebinds

So for a completely solution you need to support migration if you
support mempolicy.  But with the callbacks, you can control how/when
migration occurs.

tl;dr: many of mm/'s services are actually predicated on migration
support, so you have to manage that somehow.

> 
> Thinking of some "terribly slow" or "terribly fast" memory that we don't
> want to involve in automatic memory tiering, being able to just let
> selected workloads consume that memory sounds very helpful.
> 
> 
> (wondering if there could be some way allocations might get migrated out
> of the node, for example, during memory offlining etc, which might also
> not be desirable)
> 

in the NP_OPS_MIGRATION patch, this gets covered.

I'm not sure the NP_OPS_* pattern is what we actually want, it's just
what i came up with to make it clear what's being enabled.

Basically without NP_OPS_MIGRATION, this memory is completely
non-migratable.  The driver managing it therefore needs to control the
lifetime, and if hotplug is requested - kill anyone using it (which by
definition should not the kernel) and either release the pages or take
them so they can be released while hotplug is spinning.

> I am not sure if __GFP_PRIVATE etc is really required for that. But some
> mechanism to make that work seems extremely helpful.
> 
> Because ...
> 
> > /* And now I can use mempolicy with my memory */
> > buf = mmap(...);
> > mbind(buf, len, mode, private_node, ...);
> > buf[0] = 0xdeadbeef;  /* Faults onto private node */
> 
> ... just being able to consume that memory through mbind() and having
> guarantees sounds extremely helpful.
> 

Yes! :]

> > 
> >   - Filter allocation requests on __GFP_PRIVATE
> >     	numa_zone_allowed() excludes them otherwise. 
> 
> I think we discussed that in the past, but why can't we find a way that
> only people requesting __GFP_THISNODE could allocate that memory, for
> example? I guess we'd have to remove it from all "default NUMA bitmaps"
> somehow.
>

I experimented with this.  There were two concerns:

1) as you note, removing it from the default bitmaps, which is actually
   hard.  You can't remove it from the possible-node bitmap, so that
   just seemed non-tractable.

2) __GFP_THISNODE actually means (among other things) "don't fallback".
   And, in fact, there are some hotplug-time allocations that occur in
   SLAB (pglist_data) that target the private node that *must* fallback
   to successfully allocate for successful kernel operation.

So separating PRIVATE from THISNODE and allowing some use of fallback
mechanics resolves some problems here.

I think #2 is a solvable problem, but #1 i don't think can be addressed.
I need to investigate the slab interactions a little more.

> >   - Use standard struct page / folio.  No ZONE_DEVICE, no pgmap,
> >     no struct page metadata limitations.
> 
> Good.

Note: I've actually since explored merging this with pgmap, and
rebranding it as node-scope pgmap.

In that sense, you could think of this as NODE_DEVICE instead of
NODE_PRIVATE - but maybe I'm inviting too much baggage :]

> > 
> > Re-use of ZONE_DEVICE Hooks
> > ===
> 
> I think all of that might not be required for the simplistic use case I
> mentioned above (fast/slow memory only to be consumed by selected user
> space that opts in through mbind() and friends).
> 
> Or are there other use cases for these callbacks
> 

Many `folio_is_zone_device()` hooks result in the operations being
a no-op / failing.  We need all those same hooks.

Some hooks I added - such as migration hooks, are combined with the
zone_device hooks via i helper to demonstrate the pattern is the same
when the memory is opted into migration.

I do not think all of these hooks are required, I would think of this
more as an exploration of the whole space, and then we can throw what
does not have an active use case.

For the compressed ram component I've been designing, the needs are:

- Migration
- Reclaim
- Demotion
- Write Protect (maybe, possibly optional)

But you could argue another user might want the same device to have:
- Migration
- Mempolicy

Where they manage things from userland, rather than via reclaim.

The flexibility is kind of the point :]

> [...]
> > 
> > 
> > Flag-gated behavior (NP_OPS_*) controls:
> > ===
> > 
> > We use OPS flags to denote what mm/ services we want to allow on our
> > private node.   I've plumbed these through so far:
> > 
> >   NP_OPS_MIGRATION       - Node supports migration
> >   NP_OPS_MEMPOLICY       - Node supports mempolicy actions
> >   NP_OPS_DEMOTION        - Node appears in demotion target lists
> >   NP_OPS_PROTECT_WRITE   - Node memory is read-only (wrprotect)
> >   NP_OPS_RECLAIM         - Node supports reclaim
> >   NP_OPS_NUMA_BALANCING  - Node supports numa balancing
> >   NP_OPS_COMPACTION      - Node supports compaction
> >   NP_OPS_LONGTERM_PIN    - Node supports longterm pinning
> >   NP_OPS_OOM_ELIGIBLE	 - (MIGRATION | DEMOTION), node is reachable
> >                            as normal system ram storage, so it should
> > 			   be considered in OOM pressure calculations.
> 
> I have to think about all that, and whether that would be required as a
> first step. I'd assume in a simplistic use case mentioned above we might
> only forbid the memory to be used as a fallback for any oom etc.
> 
> Whether reclaim (e.g., swapout) makes sense is a good question.
> 

I would simply state: "That depends on the memory device"

Which is kind of the point.  The ability to isolate and poke holes in
that isolation explictly, while using the same mm/ code, creates a new
design space we haven't had before.

---

I think it would be fair to say all of these would not be required for
an MVP interface, and should require a use case to merge.  But the code
is here because I wanted to explore just how far it can go.

In fact, I believe I have gotten to the point where I could add:

  NP_OPS_FALLBACK_NODE  - re-add the node to the fallback list
                          do not require __GFP_PRIVATE for allocation

Which would require all of the other bits to be turned on.

The result of this is essentially a numa node with otherwise normal
memory, but for which a driver gets callbacks on certain operations
(migration, free, etc).  That ALSO seems useful.

It's... an interesting result of the whole exploration.

~Gregory
