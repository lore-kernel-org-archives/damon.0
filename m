Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F9B387360
	for <damon@lists.linux.dev>; Wed, 25 Feb 2026 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772063908; cv=none; b=MIGnQc39vlXJgZAVzeJHpdeEcAhqedMh3J0YVmReodBsRierAm/zxgb4n1FA+htxXbsehcS/pXo2HkKlAgJVr43SgSZXT0qMxSKIndii33GoWRQWFp0/q30zIBdbjAOv8LCz8sj8QqdfJCY81DL3sSHqyTDjKS+3gOE8dvVkE2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772063908; c=relaxed/simple;
	bh=vMJ146Y/EPWV062fRB1P7stJ5n4Sr6xxBlqgn9/6cfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJmbad2PNkehlTLaz3e9a3NpTgluzL1wYHJdvC2fJEvwEW5iT3GzjivdJdlvlemZY2epB5xwGrKTwFKgeGnLSNL4KrG6FPm1rFghnczn+vYg5VuzMKtI4QIhuw9z5h2ipMC4NjrYhJjxYPRDVfJvBsYyPqlROUmQ4hrwfExkZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=X/WWHA7p; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="X/WWHA7p"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c6f21c2d81so17823085a.2
        for <damon@lists.linux.dev>; Wed, 25 Feb 2026 15:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772063906; x=1772668706; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QQWBXTWhdLgoq7OluVHAAR5bDFt9biBm7m+9/q6MXhA=;
        b=X/WWHA7pR6CLQMYQhhTfXmLJTe2AGgj9mh0IquFVoYxTJmEQri+OSeyJpUknQiwc63
         /5TnMWqpKFEBHtSumR2l26wi8ap7KysG/kXsioNWAoCuIxSGqOFEdNSmRpo8Lv6PGG2k
         y4mV/pTyfekeuJzst5Il0se1Q4Hg4k60/Zb+gkqRiBbs+lt9oc3hPrFMib4ZDG3AR8aU
         aE4ZTn0Yrm0szAH0TNQOZiELzP9iwlNQtnfoLynWB6IZOivBR18EqeUfDNLlcfNUF1DO
         BtbyDmg6633giqnjZthTYWjlJ9b3FoBcl1+MuuvMWnl55HhkP1BFx+rBtd0TRMTkX++y
         LtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772063906; x=1772668706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQWBXTWhdLgoq7OluVHAAR5bDFt9biBm7m+9/q6MXhA=;
        b=lshxvUItJ8GmIaG0QWI6ikIflQbB+QUlX4et+bWLJZ7iJtWB0VS0SHvF1avgOMugs4
         eZ7AiiGDWdErqsVw9reODVKha2UeEtOLpQa4JTbisrO0Gpk88z1P84sjZvglA3Udfdtq
         RbmWlWRJEt0DGDQZ43GvKz7CXScC7XsF/Oa39A6Px/YOJqfDQRHzQG1cFddV2ThZBJLa
         tfPPQrVa0XZq2nbKm6+O8fEXQYlSlUL1caVQJFp275uookL7MOdx7o/pG2iOEHPmNY+I
         0o9wGeKXpGq4unhMqVy8PZc8+IzzdVegYCavqRpxmQT75cbu5UmEum/CmzboGZYZ0Yew
         215g==
X-Forwarded-Encrypted: i=1; AJvYcCWMUYR8dMCzFh1BTk0ND1lrJVwXB3X9lAj5qpzQ885j3vVrStEsfj0FOhhWqop9YIa0+G6DPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJnQGKUUnaZW5SZ0VKwtP0lIb9ZNsLIwSIx8RaDGWEnoauUaLy
	RJux8zc7UDedGkePTap4Qr2HFiXLYtk32mwYpkqnvyvchLkIO+0lL0b729b3GPqYXTE=
X-Gm-Gg: ATEYQzxz7dGrImXAM+0CisrBFs/n71G57QuKwd1ko6GrmtZ7iXL8L/GTkVLSx3ucgrW
	4Jju8cBDg8c/2xrXRgF6AXq/eZJ+Cbim5lAMszRKlCiWxMB4pj2JMafF/uwoM+7TXEPD+afg6LW
	P5ffDhWYxAQKTKlc7ASjDr63xOPHgNspWEPdbiyFCDPHUjkP0CQiDtmlfKP7frdjaOlbtzoC/pO
	h3af8+8Eepxp2f4vd2abXeN004pyJcOarK2tN8vvf0/V+frpJvEOoyss69uPkKzj0f8q8QEw6Xz
	2xNni0ytXoi5NxIFcZxMFUZc1OOhCH7X+op9fQHAkzsu6NCBtqrTLO1xqieAYtxmUMsvJUwVTKV
	DJq85oi0OYgy32DweSpGJYnXYvUpui9s/Olb+PQv5sRf58J4b82xwQ/3z071HFPx0euwwjwM4gM
	SddMM8HTniKF1MwJIO0Rwkga+H5Jqbx5oJyZLPCFU6eYQH74N3YvyEkOgIAVZ06stk/0nqUDUSB
	hYDo+/7Lw==
X-Received: by 2002:a05:622a:314:b0:4ff:8da6:2289 with SMTP id d75a77b69052e-50745f165famr3302881cf.27.1772063905968;
        Wed, 25 Feb 2026 15:58:25 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ab3f52sm5660571cf.22.2026.02.25.15.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 15:58:25 -0800 (PST)
Date: Wed, 25 Feb 2026 18:58:21 -0500
From: Gregory Price <gourry@gourry.net>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>, lsf-pc@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
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
Message-ID: <aZ-MnVVNGG_cOvxE@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <fzy6f6dpv3oq3ksr2mkst7pz3daeb3buhuvdvcw4633pcl7h6u@mxjgiwpg5acv>
 <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
 <aZ92AvAg5boiSVw1@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ92AvAg5boiSVw1@lstrano-desk.jf.intel.com>

On Wed, Feb 25, 2026 at 02:21:54PM -0800, Matthew Brost wrote:
> On Tue, Feb 24, 2026 at 10:17:38AM -0500, Gregory Price wrote:
> > 
> > The idea that drm/ is going to switch to private nodes is outside the
> > realm of reality, but part of that is because of years of infrastructure
> > built on the assumption that re-using mm/ is infeasible.
> 
> I was about to chime in with essentially the same comment about DRM.
> Switching over to core-managed MM is a massive shift and is likely
> infeasible, or so extreme that we’d end up throwing away any the
> existing driver and starting from scratch. At least for Xe, our MM code
> is baked into all meaningful components of the driver. It’s also a
> unified driver that has to work on iGPU, dGPU over PCIe, dGPU over a
> coherent bus once we get there, devices with GPU pagefaults, and devices
> without GPU pagefaults. It also has to support both 3D and compute
> user-space stacks, etc. So requirements of what it needs to support is
> quite large.
>
> IIRC, Christian once mentioned that AMD was exploring using NUMA and
> udma-buf rather than DRM GEMs for MM on coherent-bus devices. I would
> think AMDGPU has nearly all the same requirements as Xe, aside from
> supporting both 3D and compute stacks, since AMDKFD currently handles
> compute. It might be worth getting Christian’s input on this RFC as he
> likely has better insight then myself on DRM's future here.
> 

I also think the usage patterns don't quite match (today).

GPUs seem to care very much about specific size allocations, contiguity,
how users get swapped in/out, how reclaim occurs, specific shutdown
procedures - etc.

A private node service just wants to be the arbiter of who can access
the memory, but it may not really care to have extremely deep control
over the actual management of said memory.

Maybe there is a world where GPUs trend in that direction, but it's
certainly not where they are today.

But trying to generalize DRM's infrastructure seems bad.  At best we
end up with two mm/ implementations - not good at all.


I do think this fundamentally changes how NUMA gets used by userspace,
but I think userspace should stop reasoning about nodes for memory
placement beyond simple cpu-socket-dram mappings </opinion>.

(using mm/mempolicy.c just makes your code less portable by design)

---

As a side note, This infrastructure is not just limited to devices,
and I probably should have pointed this out in the cover.

We could create service-dedicated memory pools directly from DRAM.

Something I was exploring this week:  Private-CMA

Hack off a chunk of DRAM at boot, hand it to a driver to hotplug as a
private node in ZONE_NORMAL with MIGRATE_CMA, and add that node as a
valid demotion target.

You get:

1) A node of general purpose memory full of (reasonably) cold data
2) Tracked by CMA
3) The CMA is dedicated to a single service
4) And the memory can be pinned for DMA

Right now CMA is somewhat of a free-for-all and if you have multiple CMA
users you can end up in situations where even CMA fragments.

Splitting up users might be nice - but you need some kind of delimiting
mechanism for that.  A node seems just about right.

~Gregory

