Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3F13BE620
	for <damon@lists.linux.dev>; Tue,  2 Jun 2026 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390677; cv=none; b=ONLYYobKOuyOtqmLOH5S9pQUBjgN+SDzeQ7RUapZieQXcdOe0cQqVb1yNxVKD1zax984iNkqyeZ0sBl2aAT6ZOXNl5E+Iu3dpeCIAtSGaAGwVOPyi1cRA8huT4+1ZUrgIY8habURBT5qaB6tbCX1FR8Q/BWlbRuYqEm8+/w/z9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390677; c=relaxed/simple;
	bh=02DEH1RNeabzh34kxStDmLoX6DGXErAolWL5BXl6jBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwoSRr615TZV38kw393DzQUyCr50r06y9Gw5x4A5C3DXgudUH/j3iEALgNvMSJ2WygkYSFDRlB7nbqJeEw6Hm+Y7WgHceWVoE+YDVVmr4yJLvjjeLj21wCryvvvyut0ancCavcB/YM53HOMpqOkII2FoKTLT5LV0nLiSORpjH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CWK1BUcJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CWK1BUcJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso12005205e9.1
        for <damon@lists.linux.dev>; Tue, 02 Jun 2026 01:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780390672; x=1780995472; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/m/AOq0MzWCa7qNuImbU6Sf3NfKogr80Anbl3dKp5VQ=;
        b=CWK1BUcJjfAQVTraoDg+ubk3rNgYJyn7G+OrZXGEqxsh8gVVm+zdc7YHMl3cZg8bn6
         cUMHl5qxNud3ndT+Fmu9z01+BCOrAiVmJWlcysmczh0OqiZP/MGsZaU4iqx9dKtq8aiB
         Zc0Tz9iqEpHpALzLgCfMpJjcg3p/cYTRKYFE9mu8CaXJRf3TjFwwC6ImrnL9BPp0Nr7R
         1FXj+U7zSRJEqKfu4B6J4UsSuD1hAehd8CdEaosI7xnxRI7AhiEcQGwVs4iYojGXMKmP
         Xd8EiVyjVKpzlKEzQyJcM6o3T5fzn5EuBhWySYTLed5+xtBC+pEvUmLwl8+x558r+RKw
         M+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780390672; x=1780995472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/m/AOq0MzWCa7qNuImbU6Sf3NfKogr80Anbl3dKp5VQ=;
        b=rCB0IRbsPST4vYJxkXEueNmzGPAEqckJ8fvvcCkzG0ynTVeAuUmA9pLcbHKQRLPljD
         TaG5H+VYi9z19VHTctsX/gIu7Ts9iT2psqd71PFRRx+K/9vVqHZ0aB2qPK3/PFVPBmbR
         uNRY+EzoODsz+g82HSX2P0ag3SR07CCKYaTS3Dnq+ADPog+rsXYTvhsguX5Oc0mmSbvx
         MwvOXQ7zgubNrDiEcP9dl7DGvlXsp7cWSv/BywbeBOaRn0prosG3QPTnga/bn44cu5pG
         dfG28PE2fTkwdmb4V5B3Mo2107g1vpI+DZucILpvl56r+LXMFaxDX92wXA8qEL6i2Hjt
         Przg==
X-Forwarded-Encrypted: i=1; AFNElJ/yYNtWSFSp09pJutBtNWWu3/J0o6cT5dS6mrGz2KEuz277jQz/9dWpRUcbIqGXtkNptBJi1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8xph9sOwmZEGtCfiX3QW4q4jq01n6cwb50+jyvdqtOJ6vv3cm
	Ye50G7Hyr6HF2vM+ZF9H8VQe8NiskcfNzQ3y/2HZtvQE60/TDl3M5DWs9c9SvqQJwiQ=
X-Gm-Gg: Acq92OEtS3LwG9S8I5TADc+0nySgEp+5Yclyrs82QKrvcUyUwlH0i9bG4XvogsDzRML
	HdpQGgf5LvYE0H5JLsSmmPCJmgzWj0HnVmJ4e7MP2TO/ANzKTkymIMZtcSjsXS9V3A1lkLBpO5l
	LW3cnPGStSUHu+vNDpQSNnIiIJdeH4Omm2x+L/9rz0549Mf3iQDb4BqZN4TDD9Ob8cu7y3z94t1
	TcosySydFU2syBGc72/Aw/xn4cpv4i1Fe2XvCGEaHdAnBIGZSGdhO8CswdZoqqRi+uS3xt2IH5k
	dkT13VkKFu4cCTkDi9TLlgT0/7kSG9AHnT+P0/FKMRdbSC5ewGnzb/H1SLkpiHsRppfFe+jFnOI
	/N/9dzQUh1Obm67KLPn8eRWAeAM4Q2pPdMLpnuopQRisxiFhMjBO+7U7m57hA7UWxP1+/4FM8cU
	aKvsi5sLI0xsIAfhAxEEZR/D6mSEmred+JAgVABHAfRQ==
X-Received: by 2002:a05:600c:a009:b0:490:ad8e:11bc with SMTP id 5b1f17b1804b1-490ad8e1279mr109459155e9.31.1780390672385;
        Tue, 02 Jun 2026 01:57:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::6:6dc9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354c682sm30647541f8f.23.2026.06.02.01.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 01:57:51 -0700 (PDT)
Date: Tue, 2 Jun 2026 09:57:48 +0100
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
Message-ID: <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah47NNhuiClgGCdn@parvat>

On Tue, Jun 02, 2026 at 12:16:50PM +1000, Balbir Singh wrote:
> On Sun, May 24, 2026 at 09:50:06PM -0400, Gregory Price wrote:
> > 
> > I'm debating on whether to include OPS_MEMPOLICY in the initial version
> > if only because it's not intuitive how it interacts with pagecache. That
> > needs more time to bake.
> >
> 
> It makes sense to look at it and then decide if it makes sense.
>

I am thinking i will ship without any OPS flags at all for now and the
have the introduction of ops as a separate series.

> > alloc_pages_node() is the kernel interface
> 
> I was think we wouldn't need explicit flags and that allocations would
> happen from user space using __GFP_THISNODE to the node or via a nodemask
> based on nodes of interest. Is there a reason to add this flag, a system
> might have more than one source of N_MEMORY_PRIVATE?
> 

There's a few things to unpack here.  I discussed this many times on
list and at LSF, but to reiterate.

1) __GFP_THISNODE is insufficient to enforce isolation and otherwise
   not particularly useful.  Additionally, from userland, it's not
   something you can actually set.

   for node in possible_nodes:
       alloc_pages_node(private_node, __GFP_THISNODE)

   In fact it's the opposite semantic of what we want.
   THISNODE says: "Do not fallback back to OTHER nodes".

   The semantic we want is "Do not allow allocations from private
   nodes UNLESS we specifically request" (__GFP_PRIVATE).

   __GFP_THISNODE does not actually buy you anything here, AND it's
   worse, in the scenario where a private node makes its way into the
   preferred slot (via possible_nodes or some other nodemask), the
   allocator cannot fall back to a node it can access.

   __GFP_THISNODE cannot be overloaded to do anything useful here.

2) We're trying not to expose *ANY* userland APIs for this, at all.

   The ultimate goal here should be one of two things:

   1) fd = open(/dev/xxx, ...);
      mem = mmap(fd, ...);
      mem[0] = 0xDEADBEEF; /* Fault device page into page table */

      In this case, the driver is responsible for doing the
      alloc_pages_node() call.

   or

   2) mem = mmap(NULL, ..., ANON);
      mbind(mem, ..., private_node);
      mem[0] = 0xDEADBEEF; /* Fault device page into page table */

      in this case mempolicy.c is responsible for doing the
      alloc_pages_node() call via the _mpol() alloc variants.

Addition OPT flags (reclaim, compaction, whatever), would
(optionally) allow mm/ to operate on the device memory with, for
example, mmu_notifier callbacks to tell the device to invalidate
whatever it's caching about that page.

This would all be relatively transparent the userland, all userland
"knows" is that it's getting memory from a device (/dev/xxx) or a
node it's otherwise aware of hosting device memory somehow.

~Gregory
