Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B828360EC9
	for <damon@lists.linux.dev>; Wed, 22 Jul 2026 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723338; cv=none; b=EgNDZbLzis2MjTsXydtCG1id4GtiuEpN5tpAVnvb/tZc3/r3FOTjPHwX9gbRHEKJHb2RrmVvuUkqXlXv1uIx8d7y32aAPwbc2HtwGCLo68rq7PJ45ykZ9D9KowkNWUbWTo4kceKkFBHmElBB5yDAlt7g7oan8SupyidLVWCOrsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723338; c=relaxed/simple;
	bh=iQpjr5fJ0FGJnIGe3ONTjxP/7vJYxnkvS87QkOPQeac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBbaZJU/9kub6gTS3l69h+pGRHPlhtXColPnwfq7wT0HCxEO6Lt2H+HcCyZjkTgMExGWJnc5ZQXKO3+YitRS9dT0iGMutDs5PpqAKuLxHXdWXdtKPorUk/lcJl2bCi12cUyfl2cmAsauVvElfpSJJAesdIGFheAtPZ1LDOkpbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=miuKpD9C; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="miuKpD9C"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c1372f84dso87378221cf.2
        for <damon@lists.linux.dev>; Wed, 22 Jul 2026 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784723335; x=1785328135; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xIVz1DID8CeKWsK6GdOZ3gM4R5/BpOF1rbBDSWQ/gXQ=;
        b=miuKpD9CAtx5+/pLTT9ZsFN5oiyKfNi9HIRPtQZfJyd2TcdMdFW8t+GF77dT+R8Frv
         lno3HxUlCPn/qkpmboDQZCWNcPKDtY140P79zFehnNuv3vqyvm8Y2dyaXfUsa4Rejg5h
         WuADxZbtfFR9PaQTYXGscRtpmZ03UG6vMZdG0b8tkwVTtys9URGUFtdq22qQRnSEf/6c
         LUzzUJLf5IU6lJQj8RvjSnGdwondgduk8q1lgIAJBzx6tdOcciRwEMwMThceYnUdZyp+
         aCMvN/+nyeu/BEeX3l0bJ3Gj2JUlJE0+2H/NTq8fl+bC1JbV7a6EyUq3mh6xmi8+xd+Y
         ahmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784723335; x=1785328135;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xIVz1DID8CeKWsK6GdOZ3gM4R5/BpOF1rbBDSWQ/gXQ=;
        b=g7lhVVNqFZetNqmDyHsRtu38KRhRTnevGZ9fw408uy54uXBViAwcybLsqz8lFBHXRv
         EFtSTwcRgTPko+Mo1bwoHeA/CDabcrl08HLOx1vm+NvHeL37ItPfPc1jJVaugfcL9vbt
         EPhZTBve41Xc8z/rXMpW7oue/IMS+oAKRhTyrbO3W1x0mk2597JkzGJ+UcI9xQg/vmt2
         vs9bErp4G6EWQTQgwS7wdoQU6DSk9lpy+d52Z5u3EG86w7tNNrg0MicyJjr0PaGuw+NP
         cVqGB8dDkoQN49l8OP/wB7+RdSlH/W/Yzt1GAxDmL3l4n+ZZ5ruiMeZm8wMAFBnqA1fb
         JbbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqmvvRNByVssf5UUai+VFVPZDRrA3vKE6K+96jv5O5FpwmHyyVX2h/kRZoTDjyavWiMAmdGDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNjRGNXe2CfEVI/KxpBFPOPLWOPMh0xc7q8c1Jnz6e8APW5sPE
	0IwPo0olXf2PMDxLyJU6GzWKTJ0VTfj6lFC0ogHjSqNwjplVB2e8iOgYkTC7i8Z9VwY=
X-Gm-Gg: AR+sD11BkBS+F2rMk9OTw3YsJxc1YRIx5Iaxs7DQdbYWsa1BtOvEdBaCsnWT3m7lkY1
	P7jL88i385RsQI/SNdh8cepQyJA86m9IWRLX67V+OxTxvM0/ojEOa4yXdGCxMwBmDTaKA8glAfm
	aNjVrB+lCfYGKj3/obzFaZ+Cgvr/wVnFrdxLrG0yO8kqHMi+LKdb8y0yzRIlFHTThalO1RLe7O4
	cRAeum5QSOoNpTI6TZWUjh7bopOK7Bt1GuZBPWmye/8BZ4BlM6EIb/cAxlh7YMipqqL7/KWpLm4
	bNoXLP2lWCpP1oUTK3Qm75+QA/zQRh9BGsnLGU71egUEJVWIU9WYTnx+W4mVcs7Gzal6fTqyZ2y
	W4DtHu6CurCSIosoZ6FXs1SkNyz5nhssKt3e4PU42GE+Bs6Ji/9kv7y/9f9pnNMci4/1VD1mkAJ
	hoeFrnNibWkyMEKfLhD2sotR0lJQCumn2jkioFBIghRXj7MKAy5Zc16sB51Q==
X-Received: by 2002:ac8:5ad6:0:b0:51b:efbb:fbf with SMTP id d75a77b69052e-5213aa6e321mr250430031cf.18.1784723334838;
        Wed, 22 Jul 2026 05:28:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d3b3f66dsm13968621cf.27.2026.07.22.05.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 05:28:54 -0700 (PDT)
Date: Wed, 22 Jul 2026 08:28:48 -0400
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com, 
	brendan.jackman@linux.dev, yuzenghui@huawei.com, apopple@nvidia.com, alucerop@amd.com, 
	matthew.brost@intel.com, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, djbw@kernel.org, 
	vishal.l.verma@intel.com, dave.jiang@intel.com, alison.schofield@intel.com, 
	osandov@osandov.com, jannh@google.com, pfalcato@suse.de, jackmanb@google.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org, 
	mkoutny@suse.com, sj@kernel.org, jgg@ziepe.ca, jhubbard@nvidia.com, 
	peterx@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev, usama.arif@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v5 00/36] Private Memory NUMA Nodes
Message-ID: <amC0vzXEEnZaWim0@gourry-fedora-PF4VCD3F>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <6a7aaac3-e70d-4063-9c84-e643db1488e0@nvidia.com>
 <al-2D_7NcwMxqmsM@gourry-fedora-PF4VCD3F>
 <1d8b6857-de1e-4807-8201-4f6a49a3b8f7@nvidia.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d8b6857-de1e-4807-8201-4f6a49a3b8f7@nvidia.com>

On Wed, Jul 22, 2026 at 06:29:53PM +1000, Balbir Singh wrote:
> On 7/22/26 4:16 AM, Gregory Price wrote:
> > 
> > User-numa
> > 
> >    Some devices don't want the user to have control over placement.
> >    I have been working on compressed memory, for example, which only
> >    ever wants to be used as a reclaim-demotion target.
> >    
> >    (The reasoning for this is another thread, i plan on publishing
> >     my research on this this year)
> > 
> 
> I don't fully understand, how do we allocate memory on these devices then? Is
> the driver expected to allocate and map via vm_insert_page()?
>

It depends on your use case, but yes that's one possibility.

In another use case, you could enable (CAP_RECLAIM | CAP_DEMOTION) and
pages are allocated via alloc_demotion_target() in the reclaim path.

For general "device hosted memory", you can do a variety of things:

Direct alloc 
    ioctl(...) ->  explicit alloc call
    mmap(/dev/my_device) + mm_fault handler

Or a kernel-internal mempolicy
    ioctl(...) ->  set kernel-internal mempolicy on a vma
    mmap(/dev/my_device) + kernel-internal only mempolicy on the vma

The KVM guest_memfd patch included at the end of the series uses the
kernel-internal mempolicy mechanism:
https://lore.kernel.org/linux-mm/al-pkvmgIxGu3LzM@gourry-fedora-PF4VCD3F/T/#me04a7e3556677babd82bfe3947b1a83b7f0017e1

This pattern is needed because the memory is never mapped into userland,
so userland actually *can't* set a mempolicy on this memory itself.

and then of course: CAP_USER_NUMA + mbind/set_mempolicy directly

This is kind of the point - the source of the memory has some control
over how it can be used.

> > Hot-unplug:
> > 
> >    Some devices can't necessarily handle unexpected migration, and
> >    hot-unplug is fundamentally a migration.  So the HOTUNPLUG cap
> >    actually means "hot-unplug can execute migrations".
> > 
> >    If the entire device has pre-drained the memory (all memory is free)
> >    then unplug works - it's just not very hot (no migrations) :]
> > 
> >    Maybe a naming issue?
> > 
> 
> Yes, I would prefer MIGRATION in the name, HOTUNPLUG made me wonder how these
> devices come online and because it is a device, it can go offline while the
> system is still online
> 

There's a difference between device hotplug and memory hotplug.  The
kernel's memory hotunplug system can at best be described as "best
effort", and if hotplugged as ZONE_NORMAL (on a non-private node) you're
unlikely to ever be able to hotunplug.

It's possible that this CAP bit should just go away and if the device
doesn't want its memory to be run migratable then it needs to hold extra
references on the folios.  That's probably reasonable and looks a lot
like a long term pin.

(note: I have to respin for Sashiko fixes, i'm likely going to drop most
of the CAP bits except USER_NUMA in v6 and have them come in with
specific use cases).

~Gregory
