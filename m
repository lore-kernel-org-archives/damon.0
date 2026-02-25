Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414DC3203A0
	for <damon@lists.linux.dev>; Wed, 25 Feb 2026 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030614; cv=none; b=rZuhLmkP8iBdGQXBnBZ+lGdgDDdEZyEYNjDWZh7aumi6qzoB2dCCO2tWSWkuGcYNWWHcDqx1cWOY1FjpJgbLOpI3T/WSgq/56/B/bwjm7U8ZZgaw5+G63fDoNqWMELMxVxmZnIUVXI+c4VbHO0vfTAPX08lqg3mngK6VYSEODVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030614; c=relaxed/simple;
	bh=JHk303on0tH87FgVMmdu//2A2EJ68pOsAbk2jtfSs8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJkKL6ZxTpeGmpXUieFBAC81YHJtBZp5Rg5TqmD1lR7QAqQ2znXsMqoBB7DZOxOItZwra0r2MSGe0jV+WJptIVI6S2gfjxue5MK8x2Z09PfyMM/6mPusN2Yx/BwsQFt0Sfsad6fvu+lLQgBEksfkzeQufjHeIUtbf3WJuqoQPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ouoO8oNa; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ouoO8oNa"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506c02ec1b3so9813301cf.0
        for <damon@lists.linux.dev>; Wed, 25 Feb 2026 06:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772030612; x=1772635412; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=foY2Y5omQw20sTq6/J6XKrTrTufvDv+fOLstkti1G50=;
        b=ouoO8oNa9J0XHA5kt1q35xfMfI3qxn7GJxfSXeISi3sNRYFHLqI4x2ebp/jqftUb7W
         NxS0DAB+FEUjLnHLAy2SAONBnAY16exYG74UC4kl9x7DNQucAB5f03vKzT4vm1h/GVj2
         gtBthbWPLKr3y01GxSmoGksBLRQDQ0aT6ffWFascGnxhGbY248rMR8+f5tAuK5FapFDl
         gbgueXU2n/HepaWhGF8zsArEZJsR9R0s8DCgZaC3xkRMCN7KF5l3nex2t4LGRDjyqVcF
         u7Ly8+NRlZizx/un046Rpi9i01TeHGnFxVZ/EgCfpfJcdW8Q3og0fAxK5R05F0dqj72c
         6Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772030612; x=1772635412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foY2Y5omQw20sTq6/J6XKrTrTufvDv+fOLstkti1G50=;
        b=JOCTymZ2L5WbjWlFvajh39BKEoLWK6o7uiLiWtDUehlewz8nupkZibLlD8g4hAukFo
         u/JB7Td+QRgmCbUgsAb48QsAl7R5OqL1yb3APJLitZoFkmzKov8UT3f3btiGNUcJuDMs
         pXaIOCfYomQLHICVWh8vWBAz6z4tMF6/eE7EHshZt6viP39INLZkw7y9pFN7VCLqgmhK
         szq7HdQcxvbUV1ocSh8O+n2fvzvU1Tt76DtVVTObbqKcTHrIY8kJaU6ZKj8NuoKlOM5U
         ofITw2RTZWdfg+0p5SRL9p15FvdIarM9SQJfEzYKfhzpSopliflp6I06RrG0zGSQNEaV
         oiAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeZquLIqra6agL3rdOztgAJqIrYQ/2UYNA7gaPrS6M0VWiHI7lJ4lRcTYpvul6lwgi6I5RTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvbJ5A5LtZWQ54ImEK+nbGHBLMI4ehab5lQmMwHbom038txQpF
	EiADEPiQeMFQGl/I36FV1ugnSe1oPkL/UWIJhK9BLYI/q3QZYa8Uo5bUpr7AVXH23fw=
X-Gm-Gg: ATEYQzwPe8DTxQ7CjYTGBOtmZhi8QVQmePXggGPJ7El03Nwlo3aUEx2SCKa48OBXIFG
	HCJdfIP6iUrKr773VppD4ch3LLrhANCTKeTluhzV7iZYImNkDAGmRXQdM3IGRdAabhhXST/FWme
	vMWNtxXyh7stLpwSPHAzrETDwQernFdQVWRLYRJ/6chgNUu3h3JZVs7yk6IEbH+UcO83BA+NCPx
	zk08DmteUJw7Jz+QiBh5BocFlT5REw/8j7zJTrhY8kcQpwQptWPpTzmbDrzW9Tk3fLi7MdJaJKd
	LzaoJHa3C8iKXg3dWadF3SeYAiRq30W7EhEGy4LXrQRhkm9JoAWv7jB/mB8feinLkr0Ja+2LISh
	9HrhsVRx10U9qNw6VV04q6ew9Pk9609UEaszC83MfyfNLnmjBP+/9UKcdZce16y3Me7iRyWiEre
	TKnvw6rNPAe8h4GawRkdzEICkZjj9ad/J8kPZR6iqebyR52cIkH1G8iInciPP4RPkZIAh0t6IRj
	HWG8qROAJtVJbDFNlQA
X-Received: by 2002:a05:622a:1453:b0:4f1:e79a:1e0 with SMTP id d75a77b69052e-5073659bc05mr41895291cf.20.1772030611934;
        Wed, 25 Feb 2026 06:43:31 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d510a7asm123124661cf.1.2026.02.25.06.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 06:43:31 -0800 (PST)
Date: Wed, 25 Feb 2026 09:43:27 -0500
From: Gregory Price <gourry@gourry.net>
To: Alejandro Lucero Palau <alucerop@amd.com>
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
Message-ID: <aZ8KjxdPS077aFcq@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <b704b05e-3e65-4a73-84c0-21557b0cc38f@amd.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b704b05e-3e65-4a73-84c0-21557b0cc38f@amd.com>

On Wed, Feb 25, 2026 at 12:40:09PM +0000, Alejandro Lucero Palau wrote:
> 
> > /* This is my memory. There are many like it, but this one is mine. */
> > rc = add_private_memory_driver_managed(nid, start, size, name, flags,
> >                                         online_type, private_context);
> > 
> > page = alloc_pages_node(nid, __GFP_PRIVATE, 0);
> 
> 
> Hi Gregory,
> 
> 
> I can see the nid param is just a "preferred nid" with alloc pages. Using
> __GFP_PRIVATE will restrict the allocation to private nodes but I think the
> idea here is:
> 
> 
> 1) I own this node
> 
> 2) Do not give me memory from another private node but from mine.
> 
> 
> Should not this be ensure somehow?
> 

A right I set up GFP_PRIVATE for this

#define GFP_PRIVATE     (__GFP_PRIVATE | __GFP_THISNODE)

If your service hides the interface to get to this node behind something
it controls, and it doesn't enable things like reclaim/compaction etc,
then it's responsible for dealing with an out-of-memory situation.

__THISNODE was insufficient alone to allow isolation since it is used in
a variety of scenarios around the kernel.  v2 or v3 explored that.

~Gregory
