Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D792D6E72
	for <damon@lists.linux.dev>; Wed, 10 Jun 2026 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781129894; cv=none; b=bP/iSueayj/zqyRjQeQLDEAQEVTQdmmUSZUWAtQG6Rr7IVF7kvsdcTedJ4sioCbum6fQjrbpflMgG7I8wlSieOaMZxI7h8T4plVTFtnS0iExX6C4PhvIVnvXFb3La+U8rAL0G9IFHj/AkQ3QxkuElcu86drsooFK1Ajqjfkqf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781129894; c=relaxed/simple;
	bh=n6qQe/H8M9f/HunhZcM7AZ4l6+kkk/hPRfn60YC5VlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/KlT7JkrJ4+Lb400a4SwVAahi3zZMllcE+3UHyq3oPN6fqjH57wsQ8R/NM5pqbkT1GFkQPpPPDS/bkPQsv0MsUpmBSWJK9qOCW5PsplVDcDXvlBVcgOlMBzyd4NKR7N4AW5P0WfViZJsZAhAyTYWkPZYGgQVXZH0/9wHRr34mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Pq8ju4ve; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Pq8ju4ve"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9159da9bba5so529598385a.1
        for <damon@lists.linux.dev>; Wed, 10 Jun 2026 15:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781129892; x=1781734692; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1PbvrJxmu0Zl4ziOeo1RdvYlevUlgdJVEfHD2noTRQ=;
        b=Pq8ju4vexWJkFFmq8wN8SpQHQ0AMY3Qbg63D3ADj0Sn7DHxa5AyaySnXQKxk6GvOru
         LhTSnlESNjNxSP3E8lL86M/ZQbrwj4vhHWIAZ9bsHy7qr+SORU+FAF2zNPfUSBdDkLHt
         gtgDQLo3jNJ9yXpTdMVJwSNm/8RQaEeN0UIIkMclZ5ipi5DQ6WazRfIxY2c6VQWJgslG
         3GaoTf1i04TFmvCyion1eYH39I+7+50qnx8w3ReQIUN+RSJG4ZkP4ifiPpNzRXr9AWL1
         59uTSDJHdr+dXoB1H/yO5MF+85dBfjJWv49KMLQnyEFhXv1zUWMmiAtCpEWOQnIEikT2
         i3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781129892; x=1781734692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1PbvrJxmu0Zl4ziOeo1RdvYlevUlgdJVEfHD2noTRQ=;
        b=ZZX9sPOPYfaRj8slLNfSx+zUyTQytCfEuH18+PqxEQ30v2nAYbAPwMf7Qt6Pl5Z5Yj
         pQAXSTrvfXIuLe53Y1fjFefVbkrYDq7Z4J0Pxdcgfx8fUFHCePoaXi8H9Tw6/l2rBQj6
         COwhzdZ4DXd9Sk7W5UvsWvjSzD+l3A7+83hhGWzajs7DVRRiuWcj3o00Ug5PkJixOE1Y
         48+4cZ0Lg2SvmDaKDHxrRutEAtJSIGvdbe5dSrwHOsszueqqT4f0HxsfNl0pHdClKUKk
         IZeKPRX5HwUseABSFsDtJf8BH8XIJBNg4CIc5E1z3usuMkpqsPRm7wYj+WmFWq4Tx+5H
         Kb2w==
X-Forwarded-Encrypted: i=1; AFNElJ9A9U+6agBGNvdUM0hNBDQTEDdzM05g5TFbUOPxCMCV/1kJ7Nuk2FUbhHow+xwPGEU0xsjCDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwacP9c5aFthTPCTQ2UIRfMR5k8EWFZ+R7/CBy2AJNubiXr0dfN
	58hMWzfvdkhER3jIia6k2ch6CNvUnG/pKRLYIVND8KUG17/4rsxnnpaqEDF9h5VTMoY=
X-Gm-Gg: Acq92OEiuzsbI0RQIQ3jz4cH/olFwn2Z6GWPBe0YS8Zj2VjLAUte/MeHC1EgzoWz+uX
	Buf6tlt2PPom41ijKWGBgZCT/4C6KrvmbrnfMhZg5Cxvrv/aD3m/an6IYsscX7dLbwglYBZIRn6
	mytc2jN/xxVvOkhfffdi92qq72Fh5J0BwxKkSF8kfVHye6tgwFViLF7h50h1T66CyzJ0Mw97lxE
	D8oSzvMYFvER0iIuKxRv2sow53dpMCI/XsDvtaja9srzbN8GZVoSj/lONw5GEGFE8axLvHC8kbT
	avQRy2Ffi288szAoRtMYl0YQej7JsGAVtLWKw1YnyvYENMfXbEr+tr2k9xrG9fKfYUJzGkkSWyC
	CkbR0tGcrUdGDck1K7tizjtTtseNdvpgTM5hsEhQwueNVzsUCkJUzF4a6CYPCQ2SHiINjH4g5fw
	smG3CGoRD31ZoJm9mPoEoYT4t5Y/5csnNynUfYYpoVisc97UNldpqDcpneqb9YnWoDqcvCdWdY2
	6IZ1RLE/GJSK1T7dw==
X-Received: by 2002:a05:620a:2993:b0:8f1:5e8f:fff3 with SMTP id af79cd13be357-915a9cc266bmr4381110385a.26.1781129892358;
        Wed, 10 Jun 2026 15:18:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a243041sm2641676685a.18.2026.06.10.15.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:18:11 -0700 (PDT)
Date: Wed, 10 Jun 2026 18:18:08 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>, lsf-pc@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
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
Message-ID: <ainioCiFo0vI9ohY@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
 <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
 <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
 <d01fb1ed-2418-42ee-aea2-37f9a5c5729c@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d01fb1ed-2418-42ee-aea2-37f9a5c5729c@kernel.org>

On Wed, Jun 10, 2026 at 08:59:59PM +0200, David Hildenbrand (Arm) wrote:
> 
> At LSF/MM we talked about how GFP flags are bad and how deriving stuff from the
> context might be better. I think there was also talk about how the memalloc_*
> interface might be a better way forward. Maybe we would start giving the
> allocator more context ("we are allocating a folio").
> 
> The following is incomplete (esp. hugetlb stuff I assume), just as some idea:
> 

Ok, this was easier to test than I expected, and hugetlb is indeed a
stickler.  We can't get there 100% with just MEMALLOC_FOLIO, we still
need a MEMALLOC_PRIVATE - specifically because of users like hugetlb.

hugetlb uses __GFP_THISNODE to do its allocations, and all hugetlb
allocations are folio allocations - so the code you shared by itself
does not gate hugetlb from spilling into private nodes.

That means we still need something like this in hugetlb:

  if (node_is_private(nid))
      /* fail allocation */

HOWEVER... if you have MEMALLOC_PRIVATE - you make the allocation
failure a *page allocator* problem, and it serves exactly the same
purpose that __GFP_PRIVATE did.

the resulting code is two lines in my anondax driver:

    unsigned int priv_flags = memalloc_private_save();
    ret = do_anonymous_page_node(vmf, dev_dax->target_node);
    memalloc_private_restore(priv_flags);

No special hugetlb, slab, arch code handling - they all just fail
to allocate / fall back.  If they fail - it means that code is using
a bad nodemask and we need to go fix it (exactly what we want!)

I think additionally, we might be able to repurpose MEMALLOC_PRIVATE
flag for Brendan's needs as well [1].

Their goal (IIRC) was to have a pile of unmapped blocks that could
be opportunistically converted to normal memory, but otherwise left
unmapped and sitting in the buddy.

Same thing - different filter point (blocks vs nodes).

If you set MEMALLOC_PRIVATE - it makes private node allocations
possible, and "private block" access (without conversion) possible.

Otherwise private nodes are unreachable, and private blocks would be
treated like CMA (last-resort stealing, lazy-direct-mapping).

And they stack (private blocks on private nodes :V).

I don't have enough time looking at his proposal, but it seems like we
can kill two birds with one stone on this.

[1] https://lore.kernel.org/linux-mm/agYJcRgOHho8upVv@gourry-fedora-PF4VCD3F/

~Gregory
