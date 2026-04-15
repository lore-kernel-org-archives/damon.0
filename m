Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0B621FF2A
	for <damon@lists.linux.dev>; Wed, 15 Apr 2026 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266279; cv=none; b=p2YB6+RbOSJxUwn+6Nl7W6A9zYp2GetZ3xYfMOwft6P3EYZRN3bbmnG2C6Z+g6E3FKQE/fs1MgElM9ztftT2pr3Pj/6d6j6w/Akmn8YePPSuK4pzhNVfRtzsmQKghHNa0XzSEvYyNFDcfvYQ+poa5udXMf+ZS62CdPG3WH1mtlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266279; c=relaxed/simple;
	bh=uXC0m6A4XXgR4T+Bi/9ek7eOATVzudkV/e23KeHP81s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrfagSD7fRzlcqu8q36+nfDcSAfGNbP/2BM/LCNTqX7aiaevIRNJabKjRGsk3Dg0psW0G6Xr+5K6IECBc7wEamGAU8TmJPr/cGd50GWLyP0oudBWbdkyCNsvPgGqwCHH94RkEHdWL1sZ0iSmVQrYM0GoecO6wN1DuYC6viL8Vg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=A7SYOSnH; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="A7SYOSnH"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8d560ede296so810718285a.0
        for <damon@lists.linux.dev>; Wed, 15 Apr 2026 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776266277; x=1776871077; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dowXUfQQOnu7UlbiaKZmPHb5cgghiRsZLFzOWNbiThQ=;
        b=A7SYOSnHmhn5FWSGYxzyQBZACotUVJOVsvdCH6Z6D2oa6iLw2tnQvDilQ1Oj2LoUC+
         zsCpWnm7YYC2DRIkSSyzQ+8pSbznhx8ot3tt7hNCCYEgeFRiAzrO4iu4lZ9+nYrLegM9
         JN41wj5dRcBgTdrRAhWukQvXuePp6+BjooU1Wq7UGXaSihB4U5CvQHuEdaGC0Fk0O6D5
         roleFujD2jfdwe2vnNJmQ+ozUfJvdubx6pR/t94BYOc/hTy2DJ9UMH9V5aRupdB1+00o
         3GAN5gHA0d+MbY+WJ8yhQGvGkADxQ3dYBopfP6QjsVheJWXM7z+XPdVrL4ht07A0NVgs
         ANYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266277; x=1776871077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dowXUfQQOnu7UlbiaKZmPHb5cgghiRsZLFzOWNbiThQ=;
        b=rLmRhLhi6/2K5UpjCF9Pi+4Ouauxw8Dmb27kBzlkiyAEzWBj9VK9u22vpPpj1dXfVO
         zThMHtEQtMSnIstzHauL0g++weiHcPt0h1V20yvVKCnMt1SUHlkTHEcgUwV/uz3D1Q5b
         W07NQ/RF7DDfE9co5z5n0DXesXmicCCB6GTvGDQ0pjrgKxU2GAyHF0OH1b2waEYKekKD
         I1NLksGwYwlSRtG30KeKHojpB+1FL7AkZ7IXG74ymNq3XRVZyWS3jnSJvWAmDWLREUCy
         b2V2Jn5b3+fuLg/MA5hQNqBP6KFLjB21Y8h4jTui4qShwDzQb3VYW2+fpyCM8Pn/rWHt
         /LCw==
X-Forwarded-Encrypted: i=1; AFNElJ8rIstgbKFgU8JicNhWlxqLgfl6bj92ls694kJdrjmU7n2vHfNULmi2bceZr6gQsY2TehnoTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJh/0+/MygM5Tz/vDRlfJsX0qJxdOjFRKFRRFORt3kRJCl0QIl
	N3qNLuKHJtBh29/fDH+fkktyIQ6xMloZE7SEmZUXHrbmp5EpLyS66ON3dJgkkPqdnmg=
X-Gm-Gg: AeBDiev/FcbIjJVgUwYK4PK3uy1EVDG6vPfC+mMT/vhj344QhyGFl0c6eEFt31acxyq
	mP2f6WDODVXaYjcVB69Uv+cOqjPU6WWQUgy9IqQQaxl8yYHPFO71hsMs2OFGGNRmcVQ7HyvFbGq
	AuaGbyY+QOA3ce32SzSAE6YNwmvAAQhoWV0H/YMO8398K6CqUmiUdBpB/XgXirOe3UGO9RMlf/k
	Yu8jxgKFqdvT/WVlOrWU1YZwAzk5ZRHA7POsCyeCTdhMXV7ZtfQW2/+Ap8USljyJnLmguBMH6s5
	NFtcN5C5yKUhftABrz9RIyNadSgdmLH7OlayJXfJ15otXE8HnCbCoJOTO4ijWsxPvrqhtwT14hI
	6g50ydnrFgRGyKK7TNUI0EZY5ntZXAfc6KchLJoBH8rpVZ9tLYWGuV2xgslCIGPArpa/kJT+luM
	N6ixBXGUWuwJWmJO//b+e9iJQRcYzmHDNzpHuRvSwkbz/DWKM3
X-Received: by 2002:a05:620a:450e:b0:8ca:2e36:18b0 with SMTP id af79cd13be357-8ddcf1b8f1amr3209217385a.39.1776266276487;
        Wed, 15 Apr 2026 08:17:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2607:fb90:ea03:4042:f7e3:e9e9:9e22:5a8e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f243a20csm136694985a.23.2026.04.15.08.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:17:55 -0700 (PDT)
Date: Wed, 15 Apr 2026 11:17:50 -0400
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
Message-ID: <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
 <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
 <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F>
 <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>

On Wed, Apr 15, 2026 at 11:49:59AM +0200, David Hildenbrand (Arm) wrote:
> On 4/13/26 19:05, Gregory Price wrote:

As a preface - the current RFC was informed by ZONE_DEVICE patterns.

I think that was useful as a way to find existing friction points - but
ultimately wrong for this new interface.

I don't thinks an ops struct here is the right design, and I think there
are only a few patterns that actually make sense for device memory using
nodes this way.

So there's going to be a *major* contraction in the complexity of this
patch series (hopefully I'll have something next week), and much of what
you point out below is already in-flight.

> > On Mon, Apr 13, 2026 at 03:11:12PM +0200, David Hildenbrand (Arm) wrote:
> > 
> > This is because the virtio-net device / network stack does GFP_KERNEL
> > allocations and then pins them on the host to allow zero-copy - so all
> > of ZONE_NORMAL is a valid target.
> > 
> > (At least that's my best understanding of the entire setup).
> 
... snip ...
> 
> A related series proposed some  MEM_READ/WRITE backend requests [1]
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-09/msg02693.html
> 

Oh interesting, thank you for the reference here.

> 
> Something else people were discussing in the past was to physically
> limit the area where virtio queues could be placed.
>

That is functionally what I did - the idea was pretty simple, just have
a separate memfd/node dedicated for the queues:

guest_memory = memfd(MAP_PRIVATE)
net_memory = memfd(MAP_SHARED)

And boom, you get what you want.

So yeah "It works" - but there's likely other ways to do this too, and
as you note re: compatibility, i'm not sure virtio actually wants this,
but it's a nice proof-of-concept for a network device on the host that
carries its own memory.

I'll try post my hack as an example with the next RFC version, as I
think it's informative.

> > 
> > This partially answers your question about slub fallback allocations,
> > there are slab allocations like this that depend on fallbacks (more
> > below on this explicitly).
> 
> But that's a different "fallback" problem, no?
> 
> You want allocations that target the "special node" to fallback to
> *other* nodes, but not other allocations to fallback to *this special* node.
>
... snip - slight reordering to put thoughts together ...
> > 
> > __GFP_PRIVATE vs GFP_PRIVATE then is just a matter of use case.
> > 
> > For mbind() it probably makes sense we'd use GFP_PRIVATE - either it
> > succeeds or it OOMs.
> 
> Needs a second thought regarding fallback logic I raised above.
> 
> What I think would have to be audited is the usage of __GFP_THISNODE by
> kernel allocations, where we would not actually want to allocate from
> this private node.
> 

This is fair, and I a re-visit is absolutely warranted.

Re-examining the quick audit from my last response suggests - I should
never have seen leakage in those cases, but the fallbacks are needed.

So yes, this all requires a second look (and a third, and a ninth).

I'm not married to __GFP_PRIVATE, but it has been reliable for me.

> Maybe we could just outright refuse *any* non-user (movable) allocations
> that target the node, even with __GFP_THISNODE.
> 
> Because, why would we want kernel allocations to even end up on a
> private node that is supposed to only be consumed by user space? Or
> which use cases are there where we would want to place kernel
> allocations on there?
> 

As a start, maybe? But as a permanent invariant?  I would wonder whether
the decision here would lock us into a design.

But then - this is all kernel internal, so i think it would be feasible
to change this out from under users without backward compatibility pain.

So far I have done my best to avoid changing any userland interfaces in
a way that would fundamentally change the contracts.  If anything
private-node other than just the node's `has_memory_private` attribute
leaks into userland, someone messed up.

So... I think that's reasonable.

> 
> I assume you will be as LSF/MM? Would be good to discuss some of that in
> person.
>

Yes, looking forward to it :]


> > One note here though - OOM conditions and allocation failures are not
> > intuitive, especially when THP/non-order-0 allocations are involved.
> > 
> > But that might just mean this minimal setup should only allow order-0
> > allocations - which is fiiiiiiiiiiiiiine :P.
> 
> 
> Again, I am not sure about compaction and khugepaged. All we want to
> guarantee is that our memory does not leave the private node.
> 
> That doesn't require any __GFP_PRIVATE magic, just en-lighting these
> subsystems that private nodes must use __GFP_THISNODE and must not leak
> to other nodes.

This is where specific use-cases matter.

In the compressed memory example - the device doesn't care about memory
leaving - but it cares about memory arriving and *and being modified*.
(more on this in your next question)

So i'm not convinced *all possible devices* would always want to support
move_pages(), mbind(), and set_mempolicy().

But, I do want to give this serious thought, and I agree the absolute
minimal patch set could just be the fallback control mechanism and 
mm/ component filters/audit on __GFP_*.


> > If you want the mbind contract to stay intact:
> > 
> >    NP_OPS_MIGRATION (mbind can generate migrations)
> >    NP_OPS_MEMPOLICY (this just tells mempolicy.c to allow the node)
> 
> I'm missing why these are even opt-in. What's the problem with allowing
> mbind and mempolicy to use these nodes in some of your drivers?
> 

First:

In my latest working branch these two flags have been folded into just
_OPS_MEMPOLICY and any other migration interaction is just handled by
filtering with the GFP flag. 


on always allowing mbind and mempolicy vs opt-in
---

A proper compressed memory solution should not allow mbind/mempolicy.

Compressed memory is different from normal memory - as the kernel can
percieves free memory (many unused struct page in the buddy) when the
device knows there's none left (the physical capacity is actually full).

Any form of write to a compressed memory device is essentially a
dangerous condition (OOMs = poison, not oom_kill()).

So you need two controls:  Allocation and (userland) Write protection
I implemented via:
    - Demotion-only (allocations only happen in reclaim path)
    - Write-protecting the entire node

(I fully accept that a write-protection extension here might be a bridge
 to far, but please stick with me for the sake of exploration).


There's a serious argument to limit these devices to using an mbind
pattern, but I wanted to make a full-on attempt to integrate this device
into the demotion path as a transparent tier (kinda like zswap).

I could not square write-protection with mempolicy, so i had to make
them both optional and mutually exclusive.

If you limit the device to mbind interactions, you do limit what can
crash - but this forces userland software to be less portable by design:

  - am i running on a system where this device is present?
  - is that device exposing its memory on a node?
  - which node?
  - what memory can i put on that node? (can you prevent a process from
    putting libc on that node?)
  - how much compression ratio is left on the device?
  - can i safety write to this virtual address?
  - should i write-protect compressed VMAs? Can i handle those faults?
  - many more

That sounds a lot like re-implementing a bunch of mm/ in userland, and
that's exactly where we were at with DAX.  We know this pattern failed.

I'm trying to very much avoid repeating these mistakes, and so I'm very
much trying to find a good path forward here that results in transparent
usage of this memory.


> I also have some questions about longterm pinnings, but that's better
> discussed in person :)
>

The longterm pin extention came from auditing existing zone_device
filters.  

tl;dr: informative mechanism - but it probably should be dropped,
it makes no sense (it's device memory, pinnings mean nothing?).


> > 
> > The task dies and frees the pages back to the buddy - the question is
> > whether the 4-5 free_folio paths (put_folio, put_unref_folios, etc) can
> > all eat an ops.free_folio() callback to inform the driver the memory has
> > been freed.
> 
> Right, that's rather invasive.
> 

Yeah i'm trying to avoid it, and the answer may actually just exist in
the task-death and VMA cleanup path rather than the folio-free path.

From what i've seen of accelerator drivers that implement this, when you
inform the driver of a memory region with a task, the driver should have
a mechanism to take references on that VMA (or something like this) - so
that when the task dies the driver has a way to be notified of the VMA
being cleaned up.

This probably exists - I just haven't gotten there yet.

~Gregory
