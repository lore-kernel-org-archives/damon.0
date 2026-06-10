Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F3403123
	for <damon@lists.linux.dev>; Wed, 10 Jun 2026 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088129; cv=none; b=KCUmNf3g3zqLAMJVOlLEVZo7IXCnFqn41U1h9Ccx4SF1amt8Q6NapQu9b8Enb5flfN4wsoUiUjLV4cK8bMwKbtqTBF39rR0nLuldLikhRYSIdnZZuFg72QFF+fiJOqvuYEkpV/Ky4cV5ZIPT+Vz3VhedCjzgtNuyZZbvPTsZ7cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088129; c=relaxed/simple;
	bh=rLAKx7oZEBl4l8VQ6/vsIVEV/nqRO6+w6w+1NuugFRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIz9OG+NQpQ8bxTmEdPJTXgmQdvqhAtQQ4tTnSxrIgRVkZN1KgPBGKLjv5dsm8XTaS2YFvGhFBIaAPzJggDMYOC36Jtb02jO1QKppxlqOOm1MKg4szLeDugOtJNH8kBJYRc17HI4HR5qKMiTtupffoXDA3OhlNF3jZdyXOUBWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BPiVZ/Zc; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BPiVZ/Zc"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ce9ddeddefso71210636d6.0
        for <damon@lists.linux.dev>; Wed, 10 Jun 2026 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781088121; x=1781692921; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pgx1xgYrFcSjqIUoyhFqGxYUzhtvYzBpQalCqkbKQaU=;
        b=BPiVZ/ZcsPpZMH/Byx7bgY6XETr4CxpBcZb/WcryIGZWO3OUE1JmmHkWJeNTMD91/7
         u3tRGqggQXJif+IYT7WJaIoMspm4F61Y493NWdOA0zaxzpz9BaTHw1aO3SFse8fsIzIY
         lrTF6kXjWvwlA9q+sld7jsSC8t3bNvYTcAbb+bl5D0CcBRrST756DFOf89LKSGuyhYSV
         QKmg78aIl/8LPIpdHjKtQnQuiRWzi17HTvQARoh/wrmZ9y/j5SWkITBlCoLbQ42E73dl
         lkmLALGKfZ08yuLkgPcd5Gm52gSgB93bDbjr0s4eyzYiLBbL/0KJugPR9b+wjjTdl9aQ
         OKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781088121; x=1781692921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgx1xgYrFcSjqIUoyhFqGxYUzhtvYzBpQalCqkbKQaU=;
        b=b6MEy0dBZo4b53wuiJfwGW7lefqkBTvXSBBdqPELaGe6SI8rCyQWgDq7nMLEP39BiW
         C24148Bpd9B7M9qNZI7v+jWN+KeQgBlMJVJaEcxDuXDX2MSXj8lJx0ju+CWPfWnM7YCK
         V0/zqnhoXipTLk56g8/RRFWSROI+5fWMCHC8tLztv9aXWo25EzrBKqvGW1aw2Q4gDFd6
         8y/PpPOz0tc1v4coc78xNROB2M30LeEAdT0dJmZ9yRL58VSgu5uJ4yGpbGAbQBJTXxOQ
         uDr9tLKvYQKS/5EvwGdSRQWj3olXFgpWcHvnkpvxN52Q+mfG/1zh85qLjK6kjy7jGeFu
         ZEZw==
X-Forwarded-Encrypted: i=1; AFNElJ8Rs1LzeV/PaWrrIhvqZKybPKWFymgjBd0vk/WkE6dYVY0EMbVVR65g8TAWLaLDho1Zt8/rFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJYtNDk7mYReS7x93p/rJ+1/2fVpFAIRpd8CEbhYp7V8WlhrEi
	MClJAAPZqzNT0+iWQnjmcjAYRXiqawpLwMqClvDYde2614UH3uWaiyblA+Wd1iL+qKo=
X-Gm-Gg: Acq92OGMtO4oRjfXCpvPsDkqOMwto1lLuxUh+idQD0vyrjYYNCgxpI0daGc85+yi+OD
	10SLp1quUKH8J0fehYuLzjCFJyLs7V8NLgV26/bxRhdbedjttkidXW/ed/RmKLfCgiTDq4VkxKG
	9sjkCYTNtOpLREyH2SmuDIQIw3qUFyefIPSACNOG3B4BFsrfHOJ+fWgwlbfu3Q38bxDFuCk+Q1h
	tIer3Jk/G0BtNfPHR8qE/JMUokhw7yRQZpDrs8QoVC0A871Ov9i33yrdzGG7UxMlvBHTDxs0Qi/
	e3eYCn0ciYB6g2H/a4m+RXq4zJdiOvA+adUC+YHOpYyqOrP8ecp8OMuiHiGnkkv3p/SyYP55gew
	d+qzbbdpko/UST88TqBCZc1Hs2iF9rvBI3MEWspXaTxzew/N4Uikyln7yc4FkM8npSSJIU9lgtA
	BhZRDntubC3JM9LKuWmLaQr5rr62dzH02+gJvMsZmIaBXc3ogIsqyIZsr1UlcNflJfzrRyVL2K9
	4HQvosZx0wlcYOS3Q==
X-Received: by 2002:a05:6214:c68:b0:8b5:6654:7556 with SMTP id 6a1803df08f44-8cee63e377emr394580386d6.42.1781088120984;
        Wed, 10 Jun 2026 03:42:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd06e4d6sm231860136d6.36.2026.06.10.03.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 03:41:59 -0700 (PDT)
Date: Wed, 10 Jun 2026 06:41:57 -0400
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
Message-ID: <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah-0CyZurn5D1ezY@parvat>

On Wed, Jun 03, 2026 at 03:00:01PM +1000, Balbir Singh wrote:
> > 
> >    __GFP_THISNODE cannot be overloaded to do anything useful here.
> 
> Let me clarify, I meant to say, let's use a nodemask for allocation
> and __GFP_THISNODE gets us to the node we desire, if that is the only
> node. My earlier comment might not have been clear.
> 

I've been tested an stripped back patch set where I drop all FALLBACK
entries for private nodes (including for itself) and only keep the
NOFALLBACK entry for private nodes.

This effectively isolates the nodes for any allocation without
__GFP_THISNODE.

This also precludes these nodes from ever using non-mbind mempolicies,
which I think is a completely reasonable compromise and something I was
already expecting we would do.

Notably: slub.c injects __GFP_THISNODE internally on behalf of kmalloc,
which causes spillage into private nodes because slub allows private
nodes in its mask.  I think this is fixable.

I have to inspect some other __GFP_THISNODE users (hugetlb, some arch
code, etc), but it seems like fully dropping the FALLBACK entries and
requiring __GFP_THISNODE might be sufficient.

~Gregory
