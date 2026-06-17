Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635763D47C8
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705033; cv=none; b=oAUmaWfRQ8+4cfVyOVgY9uVEUgkMbTrVpOA/u2ie+NaNGfjqkxArZipn8eH4W/OMcZQEJGb7cNRaKh/xzP+TdPLeVLd1sEzg4mWVnBpaEeDaLYErR7oP+AqgKImYW4mhyVxS3ahupdxik+2jmS5zQd0O/SvM0fzzkkxRJhMCZng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705033; c=relaxed/simple;
	bh=95TSTVQlWc9XEmLQ5CRQKISimsK3+z9mzOJYVfT8u2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiJRDw+wcAifpKCGK/r199tqZ/oCTQafPpugzSeE1gWPyX+KleCNBilglxo7pGnKCeLBVN+UuBMzftK2q6raVF7oU4dW16cxF6tD0tMaI9uUzbqVsLhRseHiuoDMcVegfhCtpRKCVCXNseJEbFGF8LgkV7fdAjK7+UEr5dG3mTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=brERPCnY; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="brERPCnY"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5176bbb9384so63785581cf.1
        for <damon@lists.linux.dev>; Wed, 17 Jun 2026 07:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781705031; x=1782309831; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=21pxQXdsUMGW+bGknxxPyRxRyaJDV62jMRhp5DnWHkk=;
        b=brERPCnYhVmO81hGAIP8A8nhoS4TzxDsGUFHeCOe2nzFiVacZq04V/7W+c34ztneJ5
         JwSRIw4+E32ws2ryeCgYAFd8mMaBSAt69+JVtmg+e6BO03aoDU54ykfQoBfo4p6UVout
         +bztLRRDTLDo2s5EFlHmqHMv76zY0XmYUmqx+GBlzlcLKSNcdLOUsNYMikVakOqRatU1
         adEJNenSIj0PqjBP3hVkHe4JAPhpjBou6mtvkDQezNCFqI+Bx3irmnvWzdhXuxd2Q6EM
         Q1RYqIeB8OI8f4aOJrc000d0HC0imKUFxsSlvx0z60L5zRM09qgk4nMZzGUyciJ7zOXx
         /vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781705031; x=1782309831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21pxQXdsUMGW+bGknxxPyRxRyaJDV62jMRhp5DnWHkk=;
        b=p0ClkZ332DG7Qh5XDmbTPVGQLJLjq0MVzhiImLzwrPBeZsXb40k9Pofajef6HrzBnn
         OpPn4xBBDOHpFzG+eIAb4lKyETNZAAah43YnmQP55h/zpuAKDRuNb5QnQ3LYUCD5JQ8d
         4NzX0RVBCOAWL3MCvgCcBSLyg1pwGAmZtTiJREB2fqTjkwVEGxivtRsuNH+NlTsHTWoo
         TeFVLiWM60UGA03R2oXUSIdzbJxFXmzzzkzSbjxwhE1ax0hlHWJ2slt0mOpSK8UR5n8w
         qCWeKJD/NXLwXCufzOkgSkpLsJLLyGglUQ05aQPzeStqRW3MBXnRowEveow7XWtZvA4S
         jT1A==
X-Forwarded-Encrypted: i=1; AFNElJ8YQZX36CXXVY3bD6T2rDItftIwU4vkkqMW2qCsTwCCDfo/7XwxUBuEL0b3l4nbXYNKt7EqeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHhqnlwuKzi48DOYUXJgCj8lvv9RyHY2/NQRyFhA2FKfWQVWjz
	l58W7GeRvKctwhz23xkge4nLhwKwo0w3RjlVDJ/DBJ5omd13GGzSBU7j4dOfQBJmTVs=
X-Gm-Gg: Acq92OErrrzKTSqzx1xDJjV27CqlNU4xK6L+Sge+AwCGXyRv5p+5VFkgVBnjlhYzBGO
	RR8Dmxhv8zH9q/vJiF0e4vwA2kHKvE7jc1dtf+wLjIhMnC4UZJ8BWwCv6RJ/02HI7tebtZ8GhUV
	7M40dxMwbD+T3tc1JKVUuCiQx9crooD+o5esEoM6XM2dO9t+O3XOPS5yO1ljlANStNacR3o8sSR
	KKTrmSy8jHVwd7sDnc9UMzakywanuXHl8afWwjOs/daL11RILNo8D3XmfPhvjWwbvGQE31d/JXa
	2bj6PRRK49R5CICPeeSR3xW/vD2hmUxaYgZ0dp6Bq7xpUvZXnndValetPdEazNbXN7ZCgnQX2D6
	cSPfIGt9qUzt7ZEVpK8rO7zGIC0FH8yg+no4PXZScQTISAQADzMt/3HSoR2F0UMiPrO6jA3G5NA
	wcPAHOn9VhMyB3Uiq79rnS
X-Received: by 2002:a05:622a:4a89:b0:517:82a1:adf1 with SMTP id d75a77b69052e-519a8de2756mr65756641cf.15.1781705031230;
        Wed, 17 Jun 2026 07:03:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::3:ce0d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51955b271fbsm134106091cf.22.2026.06.17.07.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 07:03:50 -0700 (PDT)
Date: Wed, 17 Jun 2026 10:03:46 -0400
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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
Message-ID: <ajKpQgfimm-ztnHv@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
 <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
 <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
 <ajIb4DJdLGPbMB4V@parvat>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajIb4DJdLGPbMB4V@parvat>

On Wed, Jun 17, 2026 at 02:02:47PM +1000, Balbir Singh wrote:
> On Wed, Jun 10, 2026 at 12:37:34PM -0400, Gregory Price wrote:
> > On Wed, Jun 10, 2026 at 05:00:33PM +0200, David Hildenbrand (Arm) wrote:
> > > On 6/10/26 12:41, Gregory Price wrote:
> > > > On Wed, Jun 03, 2026 at 03:00:01PM +1000, Balbir Singh wrote:
> > > > 
> > 
> > For mm/slub.c we can choose to do one of thwo things
> > 
> >   1) 100% refuse slab allocations on private nodes, i.e.:
> > 
> >      kmalloc_node(..., private_nid, __GFP_THISNODE)
> > 
> >      And will fail (return NULL).
> > 
> 
> Doesn't this iterate through N_MEMORY only? N_MEMORY_PRIVATE should not
> be in the regular for_each(...) loops
> 

If a node is in neither FALLBACK nor NOFALLBACK - it is *completely*
unreachable in the current page allocator.

Next RFC I've reduced this to create a ZONELIST_PRIVATE separate from
the ZONELIST_FALLBACK and ZONELIST_NOFALLBACK, and an explicit folio
allocation interface that selects which fallback list to use.

the feedback in the past week has been helpful in honing in on a
solution that I think is generalizable.  Have just been taking the time
to test various behaviors to make sure I haven't been regressing any
userland API/ABIs (mbind, mempolicy, etc).

~Gregory
