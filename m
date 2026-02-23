Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8132566E9
	for <damon@lists.linux.dev>; Mon, 23 Feb 2026 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858509; cv=none; b=ch3i1qP8Tp5KAPalJ1+f9UTT1A73w6xJ+00WHSqQ0FZUeOlFsoRUngmFgfA9jvGaW1CJ+5zIlSkpHTg6/nJj4SX2VJuPYypmLMplnNbr7NDVhkX2SXpziN6ynPVjGZVUdUO32oteBlMxHQ9BAejhGnhvv+PPWZyO0E1ZqDIpMqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858509; c=relaxed/simple;
	bh=EwLgLwdt857/iVMGq6pQA6+6jmF6tAKLgAXdu3hsyrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8W62AazpGR9fwum0AeYy/aUgfvn4SK7cMV9uf08+kLSzDFuWy/Q6dYQQcxMkiMuadOze9apcUiPTZMtX1MNT8DTwX3qpQVPuzyqOj+m4G033xMBNH9R6Pk/tfqpWgDPUSmEq2anfN03/W8pdNgTW98NdfvUpHyfePFOjCU6pxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tcQTeDvj; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tcQTeDvj"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb3a8494c5so416117585a.2
        for <damon@lists.linux.dev>; Mon, 23 Feb 2026 06:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771858507; x=1772463307; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qpjmdBXuQUotNZnT57UveTMGt/2pk8eLf+dmkyC2/50=;
        b=tcQTeDvjGOyao6+gT5OKcir3sx+glOJd1EtRsol4OLzJkAd0mKeB/YV2ObNvc8YgoZ
         Fd96xK1qTKquvIsuVUY0NFh8fUA0ZpOK5RTv9A1S2DfX75A/c0LFEmYSJsB6gmXp89xx
         hvDSQot1QXFlBXqMmfEXlUcP/I0N5WSTMfKdXdb1L/Orgg3lCbMUinVs4n4+dw6fDmCk
         fT9Eat9Yvlbf9p92LNwdV4mKGKGbCEoztMBayC3gWrDYi7fXIttLBCXPAEo2EK7Cdnnp
         Ffe7mwEi7vaF5LWB0N7mzszmakDkIYg3Bxq8UtqHaKBLAr9Y8hdZxwnguT7otoeIidec
         rpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858507; x=1772463307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpjmdBXuQUotNZnT57UveTMGt/2pk8eLf+dmkyC2/50=;
        b=K+nJOuV449QMRSbe/2lAHXi6E7S5MOxBFHnBqpaCFn+zYEuLBCIVVMGTNIbPALKRvb
         5SFu5br7ogKaWhI5VBDfkJG776ppF6oaxWdfXaS+B+4DW7vGQsNOTGZcMXQaU8hxKjG3
         CAdW5jjwfEbyB+vDSGDX0G3OZIuwUpy9LQxcMbMqtfbGVG2yFIyllvS7Wp5N17pSvzv0
         hDLx3binH1LxWrCBUKgaEen4I9jYiMCM3guLa6nJobzfXxxa/N/PPSxE54trmE+3ocXX
         +3lckvlScLNebMTcj7zo98UPa43NwDXqQ8x9Df2YpR8ZJZoNR/EGC/NlRkvl/tZhpYDD
         jJXw==
X-Forwarded-Encrypted: i=1; AJvYcCVZtIGgGZtV5XXnSX+PLG8wsl8+sk1vroGe1PGPANEX3sIXWK+tHbZefhmoB2NS00F45/BeqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjDczVxwHqLRDyUnwVEq13loG0+evYICFYrq6syZdnrEkDGgwT
	5/4UYDW6ks0Xvxorvs+b++bhv/qjott1N3hTSnlzY+xbp+0tmnl/tYbUIgRswk/CJ3c=
X-Gm-Gg: AZuq6aK2jIiRgvP3i8PIcMY2p0PIubuoiJ21B8vZ557jzXkUtucz7BkyQZKvfeMdfoE
	Cpppnkfx/1WC8ZzFR9q2R0v1RVOfNl/niRviHh652hKkj4904PWfycuRfSWV73FNDNQRbmZfOnv
	MvVA1TCounjU3v+vtlkSsCqKD3tHeLKzHXHCmkiCbDmHTOI5q5hdfzni/EMML6xKPjLyxQr9hzQ
	cRlQggN6vYOBPORQBlaGEhpiP+nn0qrkYo7iP9irKuYqIKBXxMffsDz9qN6Hn4J/1TTgPZM8efe
	ua5t9cr7534HRFdk/CXC5uY0Q5ob2m6sDUjTdQ8KAK22iassMBB9X/TjpPKKgSzAflmHjJuhWCT
	r5aWZEx0svmL712xIf1QRKaPJ9017Cvq/8LVnrG5DouYhAklRwDkp+e6e+R3l0vkAZOxucm/9Rs
	zcHb2KQTawxMRYO2DElHT7OgIzWmOJM1CkMAuLbgU5kjWI3/dI4+I3XMUxjNIkHHzUG6WQf1LZ6
	b/Be4Ruvw==
X-Received: by 2002:a05:620a:1a18:b0:8cb:3288:6777 with SMTP id af79cd13be357-8cb8ca0e16fmr993255985a.28.1771858506861;
        Mon, 23 Feb 2026 06:55:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0ebcd0sm845419885a.28.2026.02.23.06.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:55:06 -0800 (PST)
Date: Mon, 23 Feb 2026 09:54:55 -0500
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
Message-ID: <aZxqP7J1kOClQUPQ@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <c10400db-2259-4465-a07e-19d0691101a4@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10400db-2259-4465-a07e-19d0691101a4@kernel.org>

On Mon, Feb 23, 2026 at 02:07:15PM +0100, David Hildenbrand (Arm) wrote:
> > 
> > Gregory Price (27):
> >    numa: introduce N_MEMORY_PRIVATE node state
> >    mm,cpuset: gate allocations from N_MEMORY_PRIVATE behind __GFP_PRIVATE
> >    mm/page_alloc: add numa_zone_allowed() and wire it up
> >    mm/page_alloc: Add private node handling to build_zonelists
> >    mm: introduce folio_is_private_managed() unified predicate
> >    mm/mlock: skip mlock for managed-memory folios
> >    mm/madvise: skip madvise for managed-memory folios
> >    mm/ksm: skip KSM for managed-memory folios
> >    mm/khugepaged: skip private node folios when trying to collapse.
> >    mm/swap: add free_folio callback for folio release cleanup
> >    mm/huge_memory.c: add private node folio split notification callback
> >    mm/migrate: NP_OPS_MIGRATION - support private node user migration
> >    mm/mempolicy: NP_OPS_MEMPOLICY - support private node mempolicy
> >    mm/memory-tiers: NP_OPS_DEMOTION - support private node demotion
> >    mm/mprotect: NP_OPS_PROTECT_WRITE - gate PTE/PMD write-upgrades
> 
> I'm concerned about adding more special-casing (similar to what we already
> added for ZONE_DEVICE) all over the place.
> 
> Like the whole folio_managed_() stuff in mprotect.c
> 
> Having that said, sounds like a reasonable topic to discuss.
> 

It's a valid concern - and is why I tried to re-use as many of the
zone_device hooks as possible.  It does not seem zone_device has quite
the same semantics for a case like this, so I had to make something new.

DEVICE_COHERENT injects a temporary swap entry to allow the device to do
a large atomic operation - then the page table is restored and the CPU
is free to change entries as it pleases.

Another option would be to add the hook to vma_wants_writenotify()
instead of the page table code - and mask MM_CP_TRY_CHANGE_WRITABLE.

This would require adding a vma flag - or maybe a count of protected /
device pages.

int mprotect_fixup() {
    ...
    if (vma_wants_manual_pte_write_upgrade(vma))
        mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
}

bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
{
    if (vma->managed_wrprotect)
        return true;
}

That would localize the change in folio_managed_fixup_migration_pte() :

static inline pte_t folio_managed_fixup_migration_pte(struct page *new,
                                                      pte_t pte,
                                                      pte_t old_pte,
                                                      struct vm_area_struct *vma)
{
    ...
    } else if (folio_managed_wrprotect(page_folio(new))) {
        pte = pte_wrprotect(pte);
+       atomic_inc(&vma->managed_wrprotect);
    }
    return pte;
}

This would cover both the huge_memory.c and mprotect, and maybe that's
just generally cleaner? I can try that to see if it actually works.

~Gregory
