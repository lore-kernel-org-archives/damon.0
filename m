Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4093F166E
	for <damon@lists.linux.dev>; Thu, 18 Jun 2026 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781781220; cv=none; b=a86lQcnA/za8vw2qd73PX22lMHOkq1sBWavxPOSrFEtUVym+fjRJVAvBgQUJe5MXA55E+cz7GJ4CCLBJ3UuQW5NZqVtHWewJ1TTmIiuFmPbkgKzg55y6FCqdlwX+C1u0a7XuXMuLCNxI8tI4u8KTOrioKjlddKujCv/xgPG0Tlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781781220; c=relaxed/simple;
	bh=/ZthRalEH02k4ojVZ3SnfwbHBRAbkzip3FcZk3ai2ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ie01AaP5q31r2XYNFmbx6GekXX0l1f3wlSudExqUNd367SDeVZawPjzfN8F+vs/dF4WtFdJkF5zcOYDnn3YGLbcvMeWJ9HpEYKrR1s0vnHWHTJo3b46ZzaLwrrueIKXNlqJiDaIj3KVTxg/of8kkEjHktDkLwXd2eriGXW1IqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Cz1UNPry; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Cz1UNPry"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9157b949fc7so94285385a.3
        for <damon@lists.linux.dev>; Thu, 18 Jun 2026 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781781218; x=1782386018; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VDILEybOTlA7pWxB3ZppyNLc60d4wQCyVXPTTIKX4iY=;
        b=Cz1UNPryt7NXAziclm4t/mzpwpCGTrfev9KUR6WggjMKCfKRObbEI4GBEUjLgkQGy1
         lTdN7PypHBV5uBV1FkuJR2faD/lwKAwqBKH31GWSn1DE1hE7Jnu0YmXquk+p5t2Ji9og
         jbI1qdO0Fis379xv/0VNyVHN/cnbPFVzY9an1+jH5ehhsB6Y8dWNtyMQaRCChv8ru6Tc
         gKP1rERiTdsjHW0tgf1ResHP1RxXXqA0H2aDQWgTNABKHI3Nt4tdjUCe/ajz+nk2kG2I
         DAQm2A1cCqrkLIErC8RZ2jx35VoIqk6rrJ/p+H4YYj/okloSeXMmGm4ODYpy56PMjLaV
         Fdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781781218; x=1782386018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDILEybOTlA7pWxB3ZppyNLc60d4wQCyVXPTTIKX4iY=;
        b=cV4UHzH/nGqTxtSH3cxeyxoQD1SHL1Uua9iQLrvvl2E52fVJbtu05X0SY2J7CCtPYE
         OpOJ3bW0mgKVeqezrLqG6SuiVYcEVs8bWgMO2yhB10+fdvY7B5JZ3hQhzWrZ57GjqJOo
         4cQvWvy8LY89eVh2o42/3QvSkp3BWjF8gBXwYRHpH7+E0+mzWYQGUFhFrNUvMNdXPbUk
         gqJ7QWE2WiMPNiVa+XMCyZICpYt3WHn+P2pIkClsDJsIox4Y/dw/B4EXXoFf8UOjTc7a
         Mmkq3f9oI1C/8SWyFi303a2nl4Bzz69AmG3E0uJBwYwllJ81P9owD/tX+2HtC8QLw3k3
         1I6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+U5CUkGYLhOSr/olqkV61L450mnxChwRArXTyVIXESChrFkbofdLVPe9K8/oP3ClyscJkQOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6Cw8DRxv6q42wgYDQ8L3l+xBvYF9agfgfk5dYO/MSbvZjpwzB
	tdOZNoVt7alXUQymYQLQDSE8WFvpEE1RIxOZDZqCgUnwKX0sy0fL3fz9jLo67YqJ0/U=
X-Gm-Gg: Acq92OF0v6voihRwwoQ7ZezDTqJhW0DqlHIoYFEx03FKok/2QpfuJkPrM4jjhXMIQzE
	gnlwPhPhdm87NWhLRKrbQErnkmGWk/steON9oasZO42ICGChkhcYNaHPR3ad1KWcMvoUqEs55ar
	Nfr95IfwIixyiXWVYp8jiwskcvzIQXlft8IF4tIkd7QlvrZrTme41qGPF26f2FyPxHxqqajRGc9
	dzL4t3pPCb/BT72hG/NnkTEKtd7gWnVZPBAcoyRHC+4THDw6Rua3z1xtz5zT3EPVOFHS56oljiy
	9IA1OqJGAv3RHxoHnMvJDN4ZCgLM47PmxmEvZY+fgD4Y5tX905MELNUo5g/bBSJE7X4nvgUp4P1
	khRxkRL/wB+dDvGBPNSuTMZibhG4CH8d9PKby36r4q5C35Ay2fekZf87tgKB5mnwKBheYNyPC9T
	mEKP95BBmkOtG0t/Bj3LI2UdwDPsW/JkXoi+bmfuoWnPOwaExcVK7bOUk4s8NiOIn4PIz3
X-Received: by 2002:a05:620a:278a:b0:915:9fba:878f with SMTP id af79cd13be357-91f8ba807ffmr224910185a.5.1781781217669;
        Thu, 18 Jun 2026 04:13:37 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed7215sm1951269085a.7.2026.06.18.04.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 04:13:37 -0700 (PDT)
Date: Thu, 18 Jun 2026 07:13:32 -0400
From: Gregory Price <gourry@gourry.net>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Balbir Singh <balbirs@nvidia.com>,
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
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory
 Nodes (w/ Compressed RAM)
Message-ID: <ajPS3AKrZEbZbXBw@gourry-fedora-PF4VCD3F>
References: <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
 <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
 <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
 <d01fb1ed-2418-42ee-aea2-37f9a5c5729c@kernel.org>
 <ainFROZ3WrGioyuY@gourry-fedora-PF4VCD3F>
 <aiwl4kCG814dpX7L@gourry-fedora-PF4VCD3F>
 <9f1815b0-896b-44ab-9e6d-9316d8f11033@kernel.org>
 <fdbdc9f7-d142-4880-b429-065d5056cabb@kernel.org>
 <ajAcIwBAnqgEEWSD@gourry-fedora-PF4VCD3F>
 <90418cd3-751f-439d-83ed-a0c33517c3bd@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90418cd3-751f-439d-83ed-a0c33517c3bd@kernel.org>

On Thu, Jun 18, 2026 at 10:21:30AM +0200, Vlastimil Babka (SUSE) wrote:
> On 6/15/26 17:37, Gregory Price wrote:
> > 
> > One thought would be a way to switch what fallback list is used, and
> > then have specific fallback lists for certain contexts.
> > 
> > Right now there is a single example of this: __GFP_THISNODE
> >   |= __GFP_THISNODE   =>  NOFALLBACK
> >   &= ~__GFP_THISNODE  =>  FALLBACK
> > 
> > We could add an interface with the desired fallback list based as an
> > argument, and let get_page_from_freelist to prefer that over the default
> > global lists.
> 
> Does it mean a new argument in a number of functions in the page allocator,
> or can it be mapped to alloc_flags (at least internally?), because the
> number of possible fallback lists is small enough?
>

What I ended up with was adding a single page_alloc.c external interface
that allows you define the zonelist via an enum, and then an internal
selector resolution in prepare_alloc_pages() stored in alloc_context

eg:

static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
                int preferred_nid, nodemask_t *nodemask,
                struct alloc_context *ac, gfp_t *alloc_gfp,
                unsigned int *alloc_flags)
{       
        ac->highest_zoneidx = gfp_zone(gfp_mask);
        ac->zonelist = select_zonelist(preferred_nid, gfp_mask, ac->zlsel);
	... snip ...
}

struct folio *__folio_alloc_zonelist_noprof(gfp_t gfp, unsigned int order,
                int preferred_nid, nodemask_t *nodemask,
                enum alloc_zonelist zlsel);


The original __folio_alloc* functions just add a DEFAULT - which tells
select_zonelist() to base the decision on __GFP_THISNODE.


struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
                nodemask_t *nodemask)
{
        return __folio_alloc_core(gfp, order, preferred_nid, nodemask,
                                  ALLOC_ZONELIST_DEFAULT);
}
EXPORT_SYMBOL(__folio_alloc_noprof);


This does a few things
  - The isolation is structural, there is no way to accidentally
    allocate private memory without passing ALLOC_ZONELIST_PRIVATE

  - The isolation forces folios - there are no non-folio interfaces
    which allow zonelist selection

  - The zonelist selection is confined to this allocation context,
    so no inheritence is possible.



I tried to avoid using an ALLOC_ flag so we can avoid yet another flag
crunch, but there certainly are few enough zonelists that we could
encode it there and expose it.  I know Brendan was looking at plumbing
alloc flags out to an interface, so i'm open to that.

Externally the way I determine what zonelist to use is a lookup based on
reason - letting the node filter.  This is really only needed in a
couple spots:

mm/khugepaged.c:  enum alloc_zonelist zlsel = alloc_zonelist_for_node(node, NODE_ALLOC_RECLAIM);
mm/vmscan.c:      mtc->zlsel = alloc_zonelist_for_nodemask(mtc->nmask, NODE_ALLOC_TIERING);
mm/migrate.c:     .zlsel = alloc_zonelist_for_node(node, NODE_ALLOC_USER_MIGRATE),

static inline enum alloc_zonelist
alloc_zonelist_for_node(int nid, enum node_alloc_reason reason)
{
        bool ok;

        if (!node_state(nid, N_MEMORY_PRIVATE))
                return ALLOC_ZONELIST_DEFAULT;
        switch (reason) {
        case NODE_ALLOC_RECLAIM:
                ok = node_is_reclaimable(nid);
                break;
        case NODE_ALLOC_TIERING:
                ok = node_allows_tiering(nid);
                break;
        case NODE_ALLOC_USER_MIGRATE:
                ok = node_allows_user_migrate(nid);
                break;
        default:
                ok = false;
        }
        return ok ? ALLOC_ZONELIST_PRIVATE : ALLOC_ZONELIST_DEFAULT;
}

Otherwise... everything is now a mempolicy w/ MPOL_F_BIND and all the
handling goes through the normal fault-paths :]

static struct page *__alloc_pages_mpol(gfp_t gfp, unsigned int order,
                struct mempolicy *pol, pgoff_t ilx, int nid)
{
        nodemask_t *nodemask;
        struct page *page;
        enum alloc_zonelist zlsel = (pol->flags & MPOL_F_PRIVATE) ?
                ALLOC_ZONELIST_PRIVATE : ALLOC_ZONELIST_DEFAULT;
...
        if (pol->mode == MPOL_PREFERRED_MANY)
                return alloc_pages_preferred_many(gfp, order, nid, nodemask,
                                                  zlsel);
...
}


Switching to an alloc_flag would probably be trivially if that's really
wanted

~Gregory
