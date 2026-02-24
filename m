Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869D13A0B04
	for <damon@lists.linux.dev>; Tue, 24 Feb 2026 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946265; cv=none; b=aZBHtcq1mQe2WeRhrs6Opv1bAC+uS/zRxBFHCCTzHUaslP0IgJNQw9vamFk2De9RTNtaBQQ5k4YS74+EbFsF89FAqiAfKdvjCiKCGDlYN+cZvsFIsVsBIQl5lDOQQb71oly+Fv7DxM4O6Bipveh3U2eagzQS7VTCdFjE1Mkyi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946265; c=relaxed/simple;
	bh=ELsd3S77OXxXj0E/Fd+wSUabtmOlxKB+PX+ESQ3/Qu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4Z5lhUfIpBadPgfQAtdOF9LGEKooY4Fsad+fMb5/TlSAYW5q/7OeIi26l2vvexIzNmuren/4NOB6S2eJkNH66l0yW7SqNOaPZ3wprMBTXf6eNJVy15AfBIylrDrudObGVCUYVWOB9s/14+5KN8EjApb99R7XfhMjIp9C06tzHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gFJIVsjv; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gFJIVsjv"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5fa26e497abso4307921137.3
        for <damon@lists.linux.dev>; Tue, 24 Feb 2026 07:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771946262; x=1772551062; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PRR0UdatcxmbKbTIzPfU9KNK92IFjxE56yfQbHXA4Ic=;
        b=gFJIVsjv9hwAru9u2c75cQbZqKOt0px8zvEhrSlWlL6CF3nG7LF2IWvmZXHmU3Gwql
         AyyQVmb6hA+kE2MOqC5EqCaB28UQVNK36vgLfdClrumj2nNWQik+EmMAo3/DKTstrOno
         0hyM37rmkh/8QBX4Fq03joDf+N+cxHc+d4mcLe88sYQvlVfqG7rRgb7jZClmGuc329cK
         4jCFPchWx7l7K+KhuxXkhhzQlesJncUdQQg8DSrPdTUtv3ZYAoZ8QBz+tgfmXAq6yn1x
         LuK9ruaZBapWsDMRs55Z8boziwMYQp7VeIyu6TqoicOAatLF/TrVJJ6WqdXaXQveQQvv
         NzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771946262; x=1772551062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRR0UdatcxmbKbTIzPfU9KNK92IFjxE56yfQbHXA4Ic=;
        b=ZVmFpLCT7ml+JmxUO3pAYcz4SPMNvho1VKnpCb63cf4P3hLkz/L3DsU06AaBSptyAk
         u6m2nRjgKKqtJ6FLc656D1mWULuJwsFZioVhIxjLThCoMkQxngj/xoFu9CJCDvFmBSgC
         tD4KVSiKg63o3Rnu1o0J/amKzHRuUXth+N2M6U7yx0TH13zcpnoHdsR5qgCDPDfP/Q9k
         a11oS7CPtlESerHYtakSjqzcObIxottOk6jSWo2rJAxF/xPNMu6XxoNkUd2XRL2eulXd
         oGH/67c9VWZTs76waruPT4wQAOMxFIQQpgCHbQU8D2568/3l8D02Rl+EXsVi2zi4kX9B
         hvfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNUP2mzvLCbxZqhGJ+HPh2LbJcVKi31LWf0Q7UWzHqGgIyBj+RbiCNQQd0lB4d2EWiNL/alQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpjbEBfFxkYhmXJKDSoCYZuSLE6gy2DCssDes9iBwZZClqFVjq
	6HjtM7praYm4bSoWX26l5n5KS2hnmSULHrW711L3e0vcEdyBnGUPS9HqSwloVabYpZw=
X-Gm-Gg: ATEYQzxVPDN8usJWr+Ok1biiKlERY3WxjPOH0RuADl6WVpxhY0Oeio3wEgVeZOXd92Z
	NfxVIXAuJ3zECQC4vqTP6o2oHqxI/JXLFkmp8ewUrSJUHdgWF3tRkhMWjLoE8tUa/wyl432kWqc
	bNEEm7TrMRRFhVqXRPRhDvm38zSKHYvRtWh0bQ2ozGWvc6SpArb9RouLNciNbsfqKCIhWpElwwX
	jFFGBA1OMUoHNqKuFBFd3G3Jgdy/LGx5HQ3eI6GEXCX/f5YFvnuFrcMds5QQFSj8APkvHqfZ9BJ
	B2NtLzO5bMndDo2n6CrR7is+mDBpwTx/Xz45iaByVN+jcYO3vuRKq9K7/JIFbeWzmpMFoi6ooDP
	kD0FUFik5ijyW6tC7MMBfxF+9+yrcXYJed+q670W9Sm42zFZqu4p3LnBPn2DXGJqw1ag/ftgbnx
	um+09IvPXeurO9Hu7JMq4JVDty1z+6Sv0syZhxVqkyrxe/9p0seASOAjozX1HkptmPGfYaf9ybi
	RvFPI11Dw==
X-Received: by 2002:a05:6102:160e:b0:5ee:9f7e:b3c7 with SMTP id ada2fe7eead31-5feb2ee49bfmr6174895137.13.1771946262205;
        Tue, 24 Feb 2026 07:17:42 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c6911dfsm94624986d6.2.2026.02.24.07.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 07:17:41 -0800 (PST)
Date: Tue, 24 Feb 2026 10:17:38 -0500
From: Gregory Price <gourry@gourry.net>
To: Alistair Popple <apopple@nvidia.com>
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
	ying.huang@linux.alibaba.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, mhiramat@kernel.org,
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
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <fzy6f6dpv3oq3ksr2mkst7pz3daeb3buhuvdvcw4633pcl7h6u@mxjgiwpg5acv>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fzy6f6dpv3oq3ksr2mkst7pz3daeb3buhuvdvcw4633pcl7h6u@mxjgiwpg5acv>

On Tue, Feb 24, 2026 at 05:19:11PM +1100, Alistair Popple wrote:
> On 2026-02-22 at 19:48 +1100, Gregory Price <gourry@gourry.net> wrote...
> 
> Based on our discussion at LPC I believe one of the primary motivators here was
> to re-use the existing mm buddy allocator rather than writing your own. I remain
> to be convinced that alone is justification enough for doing all this - DRM for
> example already has quite a nice standalone buddy allocator (drm_buddy.c) that
> could presumably be used, or adapted for use, by any device driver.
>
> The interesting part of this series (which I have skimmed but not read in
> detail) is how device memory gets exposed to userspace - this is something that
> existing ZONE_DEVICE implementations don't address, instead leaving it up to
> drivers and associated userspace stacks to deal with allocation, migration, etc.
> 

I agree that buddy-access alone is insufficient justification, it
started off that way - but if you want mempolicy/NUMA UAPI access,
it turns into "Re-use all of MM" - and that means using the buddy.

I also expected ZONE_DEVICE vs NODE_DATA to be the primary discussion,

I raise replacing it as a thought experiment, but not the proposal.

The idea that drm/ is going to switch to private nodes is outside the
realm of reality, but part of that is because of years of infrastructure
built on the assumption that re-using mm/ is infeasible.

But, lets talk about DEVICE_COHERENT

---

DEVICE_COHERENT is the odd-man out among ZONE_DEVICE modes. The others
use softleaf entries and don't allow direct mappings.

(DEVICE_PRIVATE sort of does if you squint, but you can also view that
 a bit like PROT_NONE or read-only controls to force migrations).

If you take DEVICE_COHERENT and:

- Move pgmap out of the struct page (page_ext, NODE_DATA, etc) to free
  the LRU list_head
- Put pages in the buddy (free lists, watermarks, managed_pages) or add
  pgmap->device_alloc() at every allocation callsite / buddy hook
- Add LRU support (aging, reclaim, compaction)
- Add isolated gating (new GFP flag and adjusted zonelist filtering)
- Add new dev_pagemap_ops callbacks for the various mm/ features
- Audit evey folio_is_zone_device() to distinguish zone device modes

... you've built N_MEMORY_PRIVATE inside ZONE_DEVICE. Except now
page_zone(page) returns ZONE_DEVICE - so you inherit the wrong
defaults at every existing ZONE_DEVICE check. 

Skip-sites become things to opt-out of instead of opting into.

You just end up with

if (folio_is_zone_device(folio))
    if (folio_is_my_special_zone_device())
    else ....

and this just generalizes to

if (folio_is_private_managed(folio))
    folio_managed_my_hooked_operation()

So you get the same code, but have added more complexity to ZONE_DEVICE.

I don't think that's needed if we just recognize ZONE is the wrong
abstraction to be operating on.

Honestly, even ZONE_MOVABLE becomes pointless with N_MEMORY_PRIVATE
if you disallow longterm pinning - because the managing service handles
allocations (it has to inject GFP_PRIVATE to get access) or selectively
enables the mm/ services it knows are safe (mempolicy).

Even if you allow longterm pinning, if your service controls what does
the pinning it can still be reclaimable - just manually (killing
processes) instead of letting hotplug do it via migration.

If your service only allocates movable pages - your ZONE_NORMAL is
effectively ZONE_MOVABLE.  

In some cases we use ZONE_MOVABLE to prevent the kernel from allocating
memory onto devices (like CXL).  This means struct page is forced to
take up DRAM or use memmap_on_memory - meaning you lose high-value
capacity or sacrifice contiguity (less huge page support).

This entire problem can evaporate if you can just use ZONE_NORMAL.

There are a lot of benefits to just re-using the buddy like this.

Zones are the wrong abstraction and cause more problems.

> >   free_folio           - mirrors ZONE_DEVICE's
> >   folio_split          - mirrors ZONE_DEVICE's
> >   migrate_to           - ... same as ZONE_DEVICE
> >   handle_fault         - mirrors the ZONE_DEVICE ...
> >   memory_failure       - parallels memory_failure_dev_pagemap(),
> 
> One does not have to squint too hard to see that the above is not so different
> from what ZONE_DEVICE provides today via dev_pagemap_ops(). So I think I think
> it would be worth outlining why the existing ZONE_DEVICE mechanism can't be
> extended to provide these kind of services.
> 
> This seems to add a bunch of code just to use NODE_DATA instead of page->pgmap,
> without really explaining why just extending dev_pagemap_ops wouldn't work. The
> obvious reason is that if you want to support things like reclaim, compaction,
> etc. these pages need to be on the LRU, which is a little bit hard when that
> field is also used by the pgmap pointer for ZONE_DEVICE pages.
> 

You don't have to squint because it was deliberate :]

The callback similarity is the feature - they're the same logical
operations.  The difference is the direction of the defaults.

Extending ZONE_DEVICE into these areas requires the same set of hooks,
plus distinguishing "old ZONE_DEVICE" from "new ZONE_DEVICE".

Where there are new injection sites, it's because ZONE_DEVICE opts
out of ever touching that code in some other silently implied way.

For example, reclaim/compaction doesn't run because ZONE_DEVICE doesn't
add to managed_pages (among other reasons).

You'd have to go figure out how to hack those things into ZONE_DEVICE 
*and then* opt every *other* ZONE_DEVICE mode *back out*.

So you still end up with something like this anyway:

static inline bool folio_managed_handle_fault(struct folio *folio,
                                              struct vm_fault *vmf,
                                              enum pgtable_level level,
                                              vm_fault_t *ret)
{
        /* Zone device pages use swap entries; handled in do_swap_page */
        if (folio_is_zone_device(folio))
                return false;

        if (folio_is_private_node(folio))
		...
        return false;
}


> example page_ext could be used.  Or I hear struct page may go away in place of
> folios any day now, so maybe that gives us space for both :-)
> 

If NUMA is the interface we want, then NODE_DATA is the right direction
regardless of struct page's future or what zone it lives in.

There's no reason to keep per-page pgmap w/ device-to-node mappings.

You can have one driver manage multiple devices with the same numa node
if it uses the same owner context (PFN already differentiates devices).

The existing code allows for this.

> The above also looks pretty similar to the existing ZONE_DEVICE methods for
> doing this which is another reason to argue for just building up the feature set
> of the existing boondoggle rather than adding another thingymebob.
>
> It seems the key thing we are looking for is:
> 
> 1) A userspace API to allocate/manage device memory (ie. move_pages(), mbind(),
> etc.)
> 
> 2) Allowing reclaim/LRU list processing of device memory.
> 
> From my perspective both of these are interesting and I look forward to the
> discussion (hopefully I can make it to LSFMM). Mostly I'm interested in the
> implementation as this does on the surface seem to sprinkle around and duplicate
> a lot of hooks similar to what ZONE_DEVICE already provides.
> 

On (1): ZONE_DEVICE NUMA UAPI is harder than it looks from the surface

Much of the kernel mm/ infrastructure is written on top of the buddy and
expects N_MEMORY to be the sole arbiter of "Where to Acquire Pages".

Mempolicy depends on:
   - Buddy support or a new alloc hook around the buddy

   - Migration support (mbind() after allocation migrates)
     - Migration also deeply assumes buddy and LRU support

   - Changing validations on node states
     - mempolicy checks N_MEMORY membership, so you have to hack
       N_MEMORY onto ZONE_DEVICE
       (or teach it about a new node state... N_MEMORY_PRIVATE)


Getting mempolicy to work with N_MEMORY_PRIVATE amounts to adding 2
lines of code in vma_alloc_folio_noprof:

struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
                                     struct vm_area_struct *vma,
				     unsigned long addr)
{
        if (pol->flags & MPOL_F_PRIVATE)
                gfp |= __GFP_PRIVATE;

        folio = folio_alloc_mpol_noprof(gfp, order, pol, ilx, numa_node_id());
	/* Woo! I faulted a DEVICE PAGE! */
}

But this requires the pages to be managed by the buddy.

The rest of the mempolicy support is around keeping sane nodemasks when
things like cpuset.mems rebinds occur and validating you don't end up
with private nodes that don't support mempolicy in your nodemask.

You have to do all of this anyway, but with the added bonus of fighting
with the overloaded nature of ZONE_DEVICE at every step.

==========

On (2): Assume you solve LRU. 

Zone Device has no free lists, managed_pages, or watermarks.

kswapd can't run, compaction has no targets, vmscan's pressure model
doesn't function.  These all come for free when the pages are
buddy-managed on a real zone.  Why re-invent the wheel?

==========

So you really have two options here:

a) Put pages in the buddy, or

b) Add pgmap->device_alloc() callbacks at every allocation site that
   could target a node:
     - vma_alloc_folio
     - alloc_migration_target
     - alloc_demote_folio
     - alloc_pages_node
     - alloc_contig_pages
     - list goes on

Or more likely - hooking get_page_from_freelist.  Which at that
point... just use the buddy?  You're already deep in the hot path.

> 
> For basic allocation I agree this is the case. But there's no reason some device
> allocator library couldn't be written. Or in fact as pointed out above reuse the
> already existing one in drm_buddy.c.  So would be interested to hear arguments
> for why allocation has to be done by the mm allocator and/or why an allocation
> library wouldn't work here given DRM already has them.
> 

Using the buddy underpins the rest of mm/ services we want to re-use.

That's basically it.  Otherwise you have to inject hooks into every
surface that touches the buddy...

... or in the buddy (get_page_from_freelist), at which point why not
just use the buddy?

~Gregory
