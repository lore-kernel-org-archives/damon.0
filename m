Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221A23E0088
	for <damon@lists.linux.dev>; Thu,  4 Jun 2026 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562198; cv=none; b=LzEmflmFSFh53wbX1Qfroyf3yEpsy4vB5BZrbReXB4MC+p6Tl4BD38/mMD03pQc35UP6TN7L7DBU16uSG1Z5fhpr01GJW1M7XKsCbJNMJFbZOMdE0Id38f1JKmIVuwdDvUwvgae4gJsFDVUV96VuIlrbiPUBMbpwbt77ghYYlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562198; c=relaxed/simple;
	bh=Y+OOrVjaPDaCY8wbBYPbbEO/xIu0Sw/Crs4VhELjjn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7a+T0ck9CD7ihMOwfc6o9cdU200IVejwywONU/Hqrzdc2mt3e0mSr1LOH1gDvjNT76DFxsof9CevsHui789AwVVZQWQ0xNJJ5f4bQDDCgyuk+qJBOvWpCQm+DEIX9hi4p6OwlgIOQ+wiWThFWsp+wmgKfwhhTYKx8MlfnFT7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ihBZJnZc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ihBZJnZc"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so331996f8f.2
        for <damon@lists.linux.dev>; Thu, 04 Jun 2026 01:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780562193; x=1781166993; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOxxBGCqGPcmxW8c5748w9UZojPmDniQUCAc18TCQK8=;
        b=ihBZJnZcYPTxdbssqJF/rjWXmq9lTBLPEJVHzS/9g4t74IiOvvS2IxBvxa0cgG/92k
         14Brvbl5NMusXp2z6JOndLJIRrno2K/NByflxaZ/rG1juS3V3BkM13Vjn8Hwocs9fubp
         URsTiTMQCwYH7j6waEO08mOXmtt+17xwWVEZX6gRBvEXKAL3v4L0OnioEAjj4kjUl5Oh
         Fg772Mi1T3sqaHPj6E789X/oXUz/VeuNRBA8M2CR0G/ydXWJ6TOSjQIZtWkiniAzfIa3
         NoFV8I+3L4Bb/mE4tIJG3UokLmF0iCphVEpGeAdaA4BD0nzcFlkRunNITrMXnXin0gVo
         fXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780562193; x=1781166993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOxxBGCqGPcmxW8c5748w9UZojPmDniQUCAc18TCQK8=;
        b=dZzhSaZBz43CS9xqWyh37Zk8JQQnkGYE0JXPQ2kXGkSyuDYQPMXwoYYhr7q+9ZmCBb
         jXD2TFbG7MWsqFegu3iJ0lMtDxn0lT+rjazFlG12Wqp3cazLsP57KzYcjgYOF+ceY/E1
         uCsLJopRJkcWrBOAUwy65GS/GCS6kcEEAZpRETEDgbSalDbufAdwxrvUNdtl+RWEN1yn
         5+VQz15hEHmC5LYwF95pkWaSqmnbt8XqjrUpEwS8gdFGKFyf579vyRzIKKcqYqvrHBan
         fCsQKQIEX/RlLblFy93DAMVr6VfhyZyoXnj9TyBUmmBqSQyQ3ThRJuWAt4Px0fKENfLU
         IHNw==
X-Forwarded-Encrypted: i=1; AFNElJ+1NqZNebq3VW+PnQGOsdCZVieWysZSv2O1DiN/6Oe6A7yGai6dv5Y5qhwR4pow0tjb8F7fbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBXGdDbcQXLFoMtB+5L68wyotONXSt3FpxSAeLeFuH8W0tYBwi
	lALFi30HVuvTs/55wf3BuPOnBmCDQKwCu/TqkkVcNFMCqPod6g0+QapzBqopG2iFrcM=
X-Gm-Gg: Acq92OEdbxCCh0jrBLKSEXfUzVA0DMh9kHAbbXiJ3fGti0EzztZr8vo5THjiIKBO2E0
	7x/DO4Y6YXUoQsBql0pAjfc+nZXPl82owDYUuphgwzupYG75KvdwWKvUUvMx2iDK8/SdpvX7RXc
	OovPXL2OGbnTdFkz14AJmxiv9IpceyYOoo9ajw9L5HTm25Dw77jagNH7XBRu8QWn36yYvABlbB/
	9NNUIv05zMtmDPuxR6ZVSoD6AwcYfqo2A3XPYOjpRLj0wRmauqIDmwETIU2jCUnoAwLi6n6BwJu
	oWJjD/WIry5EcLtk/1J+mt88C+XTHPjOX6gGrrg9EEomwrax2NW4/XXjYDNBnYapo+OJCd5ipCw
	ZaLune39LJMtInmpVls0L3u8Tun/zuRfp68g7TkesNO0ySjetRcDest6Ae/1S89da1iIv3uToXB
	FdikNX64rAp0lkSjssT0XhK48MtIk3VCNLpJVt8kqRvA==
X-Received: by 2002:a05:6000:4a02:b0:43d:50c:6f33 with SMTP id ffacd0b85a97d-4602194fc19mr9571400f8f.26.1780562192938;
        Thu, 04 Jun 2026 01:36:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::7:a76c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda363bsm1765818f8f.31.2026.06.04.01.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:36:32 -0700 (PDT)
Date: Thu, 4 Jun 2026 09:36:29 +0100
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
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
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aiE5DZC8Io4SNI3H@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <ah_RcTU8SpQG7hab@gourry-fedora-PF4VCD3F>
 <aiDVMgu0viTIml8H@parvat>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiDVMgu0viTIml8H@parvat>

On Thu, Jun 04, 2026 at 11:43:14AM +1000, Balbir Singh wrote:
> On Wed, Jun 03, 2026 at 08:02:09AM +0100, Gregory Price wrote:
> > 
> > Here is how the page allocator fallback lists and nodemasks interact:
> > 
> >    Fallbacks A:  A B 
> >    Fallbacks B:  B A
> >    Fallbacks C:  C A B   (Private)
> >    Fallbacks D:  D B A   (Private)
> > 
> 
> Do we want regular memory (N_MEMORY) in the fallback list of device private nodes?
> The assumption is that we have ATS translation enabled? Assumiung A and
> B are N_MEMORY here or am I misreading your illustraion?
>

If we don't have __GFP_PRIVATE, then probably not.  This is a holdover
from the current __GFP_PRIVATE branch so that if the preferred_nid=
value is a private node (which is a hint, but not a hard control),
there's a way for that allocation to land *somewhere*.

__GFP_PRIVATE would say "Only allow access to private nodes if this
flag is provided - otherwise treat that as unreachable and fall back".

(__GFP_PRIVATE | __GFP_THISNODE) then does exactly what you expect (only
allocate from specifically this private node and don't fall back).

This has the added benefit of not causing OOM on allocation failure.

Some would consider such a request a bug (i.e. that caller has a bad
mask), but I find the premise of that statement to be flawwed if only
because we do not have good controls over what ends up in a nodemask due
to the existence of things like possible_nodes.


> > If we wanted to change this behavior, realistically we'd be looking for
> > a way to add specific nodes to certain fallback lists - rather than
> > modify the nodemask interaction in some way.
> 
> Yes, that is what we did with CDM, control the fallback for
> N_MEMORY_PRIVATE, but there is a design decision to be made here.
>

Agreed, but also one which can be deferred and played with since it's
all kernel-internal.  None of this should have UAPI implications, and we
need need to accept that we're going to get it wrong on the first try.

> > 2) full mempolicy support doesn't really make sense
> > 
> >    task mempolicy PROBABLY should never really touch private nodes,
> >    while VMA policy certainly can.  Assuming we're able to support
> >    multi-private-node masks, none of the non-bind mempolicies even
> >    make sense for most private nodes (interleave? weighted interleave?)
> > 
> 
> Yes, mostly, but is that baked into the design? If so, why?
>

"Baked in" in this case would mean:

  set_mempolicy(..., private_node) -> -EINVAL
  mbind(..., private_node)         -> Success

With appropriate documentation.

This can be changed later if a reasonable design was agreed upon.

> > 4) File VMA interactions don't entirely make sense with mbind
> > 
> >    In theory you might want:
> > 
> >    fd = open("somefile", ...);
> >    mem = mmap(fd, ...);
> >    mbind(mem, ..., private_node);
> >    for page in mem:
> >       mem[page_off] /* fault file into private memory */
> > 
> >    In reality: This does not work the way you want.
> 
> Why not? Just curious about what you found?
> 

Because pagecache pages are associated with potentially many VMAs.

The fault can be a soft fault or a hard fault.  On soft fault - the page
was already present, and will simply fault into VMA without being
migrated.

You can imagine the following

Process A:
    fd = open("somefile", ...);
    mem = mmap(fd, ...);
    mbind(mem, ..., private_node_A);
    for page in mem:
       mem[page_off] /* fault file into private memory */

Process B:
    fd = open("somefile", ...);
    mem = mmap(fd, ...);
    mbind(mem, ..., private_node_B);
    for page in mem:
       mem[page_off] /* fault file into private memory */

If process A runs first, and assuming VMA mempolicy is respected for
file backed allocation (note: it's not, see below) - then the second
process will think the memory now lives on node B when it's already
living on node A (pages are not migrated on fault).

filemap page cache means file-backed pages are global resources.

Re file-backed VMAs - see filemap_alloc_folio_noprof in mm/filemap.c

struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
{
        int n;
        struct folio *folio;

        if (cpuset_do_page_mem_spread()) {
                unsigned int cpuset_mems_cookie;
                do {
                        cpuset_mems_cookie = read_mems_allowed_begin();
                        n = cpuset_mem_spread_node();
                        folio = __folio_alloc_node_noprof(gfp, order, n);
                } while (!folio && read_mems_allowed_retry(cpuset_mems_cookie));

                return folio;
        }
        return folio_alloc_noprof(gfp, order);
}

We'd have to hang a mempolicy off of the file and use fctl or something
like this if we want a file to have a node preference.

> > 
> >    I went digging and we need a few mild extensions to allow
> >    migration on mbind to work for pagecache pages, and the fault
> >    path does not necessarily respect the vma mempolicy always.
> > 
> >    You also start getting into the question of "what happens when
> >    the node is out of memory and you don't have reclaim support?".
> 
> Yes, we should discuss reclaim support, I think we should allow for
> reclaim. It allows you to overcommit private memory the way we can
> with regular memory.
> 

Reclaim support is feasible, but again - crawl, walk, run.

If we get the base private node infrastructure in place, we can break
things like mempolicy and reclaim support into different work streams
to enable support for these features.

Different private node users will be interested in different
combinations of mm/ service support.

For example:  compressed memory as a swap backend DOES NOT want explicit
reclaim support - it will need to manage its own shrinker.  This comes
from requirements associated with that specific use case (which I do not
want to get into here).

That is why this series introduced the concept of NP_OPS_* - so that the
owner (driver) of a private node (such as a CXL-enabled accelerator
driver) can tell mm/ what services it should enable for that node.

> > 
> > For all these reasons, I think the be mbind/mempolicy support with
> > private nodes needs to be brought in with follow up work - not
> > introduced as part of the baseline set.
> > 
> 
> I am not opposed to the follow up work, but I feel mbind() should
> be the fundamental work and user space API.
>

This is informed by a single use case / device.

There are users / devices that don't want any UAPI for their memory,
but simply wish to re-utilize some subsection of mm/ (page_alloc,
reclaim, etc).

> > 
> > I am arguing for #1 - the community has argued for #2 and "fixing
> > existing nodemask users".  I think we can ship #2 and pivot to #1 if we
> > find fixing existing users is infeasible or too much of a maintenance
> > burden.
> 
> Again happy to discuss this, I'd like to make sure we agree on the
> design. I am wondering if there is any experimental data to choose
> between 1 and 2.
> 

I am trying to test whether, lacking __GFP_PRIVATE, any normal runtime
operations access private nodes removed from fallback lists are reached
via something like the possible / online nodemask.

I remember, maybe a year ago, there were per-node allocations happening
during hotplug and that's why I originally proposed __GFP_PRIVATE, but
I'm trying to re-collect that data now.

~Gregory
