Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D861DB551
	for <damon@lists.linux.dev>; Mon, 25 May 2026 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673813; cv=none; b=AKyNxRP134YiRnUm4psIKWz/l/3BBM4u1by90jLPAjpbKD48yROHazjP9JQnvLoxy1ZRlIAOfsKVQEiqy3PfFdWBZYrp3ckx7q6dvUw2SpVQHVD52Q2Mwy72jFa5fTaAJtUW4bU6jWG8WClgMW9dgP639pwx639C+1JcnlH+vII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673813; c=relaxed/simple;
	bh=WItw+Ef2NecqHrR2z8eKezrYOTV9vVAproVcjHSpa8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVBeKoF7GslG+VkndsYRJWKF13ZUWHdW8Ijw2Mifrb1ewy52Fs8RDijboqKUA2OJRTX+30btryKTaIrw4oMax/kmn1oqJ9r+vtUTrBh28Bfp2jrx1hKS/C63eAvtK0XTkLfAQQL8P4P19YRnR8zAEJ9fzwncu7kmjU+Xli+vL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GLRLbitb; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GLRLbitb"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51306c9f2a8so109929771cf.1
        for <damon@lists.linux.dev>; Sun, 24 May 2026 18:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1779673810; x=1780278610; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HaMGwylp+AdTKGZZEDuVzWMLLa2CVFaFeY7VVe9bsb0=;
        b=GLRLbitbosVFu8KWErZ/3EgnieRfDwzMUPy2YNsGpIbqOWB4ZB9nexV1UoGWFyPqNj
         7gOarBfWF5Wacby4Fc7mAkj8ew1F+Z3z7WsyDEwZPatN/3s1FHf/+1gQbw11jSkwwo8u
         lLbGFpXxkPC1GJnqgPec1Vxtz1dUo3amHXToDDg6byj2GJIqOZ3mUsrXKAl6IVgDVmKd
         cy7UytUYcEiXdjh68zjp08fnebqNi3NUo177MD10hax2Gd56eOBWE/B+9GgNHq6SBkGT
         KRfxf6VJbPi31KJmWdaVb7ksFPThJYSx+3yCmR0FFm4rq488EzkDtCvotsgRUN5bw/j/
         t8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673810; x=1780278610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaMGwylp+AdTKGZZEDuVzWMLLa2CVFaFeY7VVe9bsb0=;
        b=isSHJ6dfeq/2/BDjGknIJtYi6tQYFUfxYm86Lq2VAb1pZj98dcwyVQ87jRsOBU4/mJ
         1ikFAKLWYZSx/NtCEAMFbJ3NxRgiBVqPqwqy1evx1teKQaRnGT0fwr6A+06DS86R0hMP
         KtjYtQlVHo/rFnUX1pw7Vkf0fszIhifAO8p1Fud1CkJvJD8X7xLH6adBoIKNLcrrg3Fr
         RsLcVGnEmmI6RDbYTX8gMFS9lk7TasvWrx0ghn7epzT8KWD5Yqs3FhnFAFoE6jkxtk6v
         gKl3Y+awPDAxJhx/taXrZ8H7paIybECPLxFIaOJxiLKSQ0eUnxuiRK6Eg4zHaa+WoMBs
         TIyg==
X-Forwarded-Encrypted: i=1; AFNElJ/t2pdjnptWNYHAReY0NCcps93xag6u3wCMjEJDqhToXnfoEBxCExCuRv7BGkqYUlBGtAIdbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzeh3kEbcU6uj9gWUPORsOpC230M1LWm11+cqlZDIvgskC2ZEmB
	kFGcwGrV/hw2rEMD3xXMfZC/hY+/G4dtRVXoXmVMVpQq2E0dSW0tUDO9iQFwR48JTGE=
X-Gm-Gg: Acq92OEJePw4E35hdipSLeJZ3yKiKKgRMo1ZgCutiK8JKGnw6vSdrRbx9Gf1MwBuX1k
	63SmcbEJBwKTxWHB+VlkJl1bezg5JeLIMOerACejNFdQ8Jmg12lZSBE5DD2L++pT+xvtvJ7j0IZ
	KKyuB1NzLU3JdGilFkqNggqJpGBo+2wTx/q+2NMf45i8PAbTUDbsToVCfpgWA1zb6F1SRwR6vDm
	sD9y8dMFS8x48rV0wYn8UynbstHkPRCXoKxYOLgIux/uU/FCi+tAt3m3X0HcdY5F9ttWRaWwTAy
	66Am096akDd8aWnGBlN+FNHJ2TxZnSy+tZdqu4ojC06tfzYJk9+qLGDQSChulf1qragxrEkBHXU
	oqVUCOUOLp9jPvbB4mBGf2d8BkP3mCkqFHrWCm4VdMuq7gT1D9AdHy+E/vEEVHV2dVWEiV0LUJ/
	oitPuXSB+1JKZvCkSigBakHggzCKGuEj8OgB6Qipukgmr6RIWVa50hLbmo2LbSdgrmmuQmvoxPa
	MrhPdOQiScM
X-Received: by 2002:a05:622a:480a:b0:516:e7d0:73ab with SMTP id d75a77b69052e-516e7d079c5mr94541371cf.40.1779673810351;
        Sun, 24 May 2026 18:50:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cb9f11sm88159681cf.23.2026.05.24.18.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 18:50:09 -0700 (PDT)
Date: Sun, 24 May 2026 21:50:06 -0400
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
Message-ID: <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag6XyvxR-NU5rGn-@parvat>

On Thu, May 21, 2026 at 04:23:28PM +1000, Balbir Singh wrote:
> On Sun, Feb 22, 2026 at 03:48:15AM -0500, Gregory Price wrote:
> > Topic type: MM
> > 
> > Presenter: Gregory Price <gourry@gourry.net>
> > 
> > This series introduces N_MEMORY_PRIVATE, a NUMA node state for memory
> > managed by the buddy allocator but excluded from normal allocations.
> > 
> > I present it with an end-to-end Compressed RAM service (mm/cram.c)
> > that would otherwise not be possible (or would be considerably more
> > difficult, be device-specific, and add to the ZONE_DEVICE boondoggle).
> > 
> 
> Do we have updates/notes from the meeting?
> 

I have been on leave since LSF, but I do have some notes posted:

https://lore.kernel.org/linux-mm/af9i7dkNvGGxPHzu@gourry-fedora-PF4VCD3F/
https://lore.kernel.org/linux-mm/agYJcRgOHho8upVv@gourry-fedora-PF4VCD3F/

I will be trying to post an updated set stripped down without the GFP
flag as a first pass w/o RFC tags and no UAPI implications so that
device folks can play with this upstream.

I'm debating on whether to include OPS_MEMPOLICY in the initial version
if only because it's not intuitive how it interacts with pagecache. That
needs more time to bake.

> > 
> > page = alloc_pages_node(nid, __GFP_PRIVATE, 0);
> 
> Do we want to provide kernel level control over allocation of private
> pages, I assumed that only user space applications? I would assume
> node affinity would be the way to do so, unless we have multiple
> 

alloc_pages_node() is the kernel interface

> > 
> > /* Ok but I want to do something useful with it */
> > static const struct node_private_ops ops = {
> >         .migrate_to     = my_migrate_to,
> >         .folio_migrate  = my_folio_migrate,
> >         .flags = NP_OPS_MIGRATION | NP_OPS_MEMPOLICY,
> > };
> > node_private_set_ops(nid, &ops);
> >
> 
> Could you explain this further? Why does OPS_MIGRATION
> and OPS_MEMPOLICY needs to be set explictly?
>

Both of these have been removed from the upcoming version, but in this
RFC version i was testing OPS_MIGRATION as an explicit flag that meant
"migrate.c can touch the folios" while OPS_MEMPOLICY meant "mempolicy.c
can touch the folios".

As it turns out, OPS_MIGRATION is not a useful filter, as it doesn't
actually filter anything (anything using OPS_MIGRATION would also need
its own filter flag, so better to just drop it and do per-server
opt-ins).

~Gregory
