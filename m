Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE34014AB
	for <damon@lists.linux.dev>; Mon, 15 Jun 2026 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537834; cv=none; b=i0tK9BX6LelPT2rKMVqnu8c26pC6N/1RNMYaxfbQopa/DskVRP61dbQ4gorHD1CgRummWrt9E7XpFJ11BA7Kr7exDy5j/aw9WDF0rSYGa9p8yzHCQ1BMyACuqoUbRM1Eldmj33ReNQn2UH8qOsWjtBxDLaCquPpRABhNHtUcxHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537834; c=relaxed/simple;
	bh=gDF7opo+wStJ7Wpr6WBsmAfccg6GFU4nXrKDloElyKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKOUqNdXgEubd+xm5YBk3XQEeUB9OneAmzeDXeyvwWgm5CnWerMoSuuBiWrKVUZi2/+fDXo/fRDwuv1P6KnhkIUd4L8pN3oNHrQjp/dnG3tvmkeKehzvwITRa/Bz/R5hJ7vqyMhDIPZtQnEbG2ZlrkFuf5z35wi5grR6ARa5nBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=PJ4tHdky; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="PJ4tHdky"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-517863a2edfso27912531cf.1
        for <damon@lists.linux.dev>; Mon, 15 Jun 2026 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781537832; x=1782142632; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FjNePvEWoA1YkOvHP4nURdQdbVRIT8G3obtM70Agu6M=;
        b=PJ4tHdkyZ1pG7jABNfWjNLv8fSvId0bubRvOFoi9cKDzZ+/r5ZLTR6MDTR9yN15/Dz
         ukzKpKyC4knuERBlUqlxs3y0jtyyHzGAvezxMazvsAwiEVabUVqBbJIQ5o8TyItXSVed
         v2R387TLiOl1cbpYn962Imw3UrEYeGWXzW/GhR9yOydNi/IuinCNXxNfLsmydoXUGeJ5
         9k0DplcgAfn/R5HDvh2av+1jjSWmyfj27razpTAn6CTA6b6otPAXNh1+k8rtv5lYyXVb
         An4srVPS5MauF1kQH5aFMkTpsIVU6OoDwRlcA6IYFCrxsGwRoGf5fWj4jf+iqd9uv6Hg
         JdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781537832; x=1782142632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjNePvEWoA1YkOvHP4nURdQdbVRIT8G3obtM70Agu6M=;
        b=TyaRse59cizgGJZNom9pAwq93wQYVFQzPkITE9O/mgm8s8XLnG9s4/ID7WdjgqesXr
         EuTKf1vQStJcwnQnQNZylyeXWFlPpjtXENkDx6iewE/sFEuEglpEeIfg0/USkbk3kQpA
         K+SuBDkY6hrISy4qP/yubIy92ERK8GqCh3npW5UeSXg1dUGteaPsWflVI8B85owrlQ/x
         dcKXv9FPvGFtfkwMUpu3N5qCJqYQt70ZXCEy2F1d6sQ4/OBChtZl+BLfWl6o9WqQ8aCm
         rjaZIxIi7bk2vbCUUWSNStVQbrIeh6Vo5rh8njc1m0n+6hNfQkoDO+k0JRrfJuP6sxha
         vsSA==
X-Forwarded-Encrypted: i=1; AFNElJ+uI2LALi4Qqz++7dtO1yuDwae0AcVeaOSVBF7HzF4xhV/H828kKOG++GIZeLJlVigbZWKU5g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzg4ZbkgfCSMnqgVRqyoVIqh1x3WxxNZEk45yo1NfIOFWZSE+B6
	wq+A9j7c482JhQgPzuryogh1kueKEsim4eMG9ii0ovlM1We5rjmfyqZGQMa3xqrUpPw=
X-Gm-Gg: Acq92OHBfOgF7Y3Cj98wWR9bXSzQydHDD5Blbc4FD18ZgBDWP+ebpACCqxBsWkBbEGq
	xThXyEgQ7aw8oVIQbLOZKo4lE8h1RdnKHrz6VD7gB1B4X86eFt/xeSW0WG8PSMrbTYiTUCWcoA2
	2v5B2x/bkSR2OFRcZVYIfUrTH2r2ZOhQ1Cyhe6JltqJjmSYORpy+gWG0qPvu5/ZHg793e0pm7qe
	EN25Y5eTbgkl25RoykaAFB5nkm9ympg85SIqCNYtOyx/vl1Q/eoqVuvfN/X8V5FS999KQpkqlA6
	m3KIuU5DgVg/hB4QVC/Lr3FHKEumv+GxGlGxy9i7hc0HOzg376hLhSnhsUGH+ed2hXF7uCwSkRL
	OeVuXTjY5Ji8kGVZkZ9pMfRZztt84EioW+FZlZkiqwSph1SXmxbmYgfAZuOHVgVfKE7kb9Y5qrl
	leYbw+1r6rE92IQ4b+ag==
X-Received: by 2002:a05:622a:1191:b0:517:5b2c:6aae with SMTP id d75a77b69052e-517fe1de684mr210273141cf.13.1781537831809;
        Mon, 15 Jun 2026 08:37:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::5f73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb815976sm110238541cf.25.2026.06.15.08.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:37:11 -0700 (PDT)
Date: Mon, 15 Jun 2026 11:37:07 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
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
Message-ID: <ajAcIwBAnqgEEWSD@gourry-fedora-PF4VCD3F>
References: <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
 <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
 <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
 <d01fb1ed-2418-42ee-aea2-37f9a5c5729c@kernel.org>
 <ainFROZ3WrGioyuY@gourry-fedora-PF4VCD3F>
 <aiwl4kCG814dpX7L@gourry-fedora-PF4VCD3F>
 <9f1815b0-896b-44ab-9e6d-9316d8f11033@kernel.org>
 <fdbdc9f7-d142-4880-b429-065d5056cabb@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdbdc9f7-d142-4880-b429-065d5056cabb@kernel.org>

On Mon, Jun 15, 2026 at 05:18:55PM +0200, David Hildenbrand (Arm) wrote:
> On 6/15/26 16:38, Vlastimil Babka (SUSE) wrote:
> > 
> > I think the memalloc approach is dangerous due to unexpected nesting. There
> > might be nested page allocations in page allocation itself (due to some
> > debugging option). But also interrupts do not change what "current" points
> > to. Suddenly those could start requesting folios and/or private nodes and be
> > surprised, I'm afraid.
> 
> Yeah, we'd need some way to distinguish the main allocation from these other
> (nested) allocations.
>
> 
> > 
> > The memalloc scopes only work well when they restrict the context wrt
> > reclaim, and allocations in IRQ have to be already restricted heavily
> > (atomic) so further memalloc restrictions don't do anything in practice. But
> > to make them change other aspects of the allocations like this won't work.
> 
> I was assuming that memalloc_pin_save() would already violate that, but really
> it only restricts where movable allocations land, and that doesn't matter for
> other kernel allocations.
> 
> Do you see any other way to make something like an allocation context work, and
> avoid introducing more GFP flags?
>

One thought would be a way to switch what fallback list is used, and
then have specific fallback lists for certain contexts.

Right now there is a single example of this: __GFP_THISNODE
  |= __GFP_THISNODE   =>  NOFALLBACK
  &= ~__GFP_THISNODE  =>  FALLBACK

We could add an interface with the desired fallback list based as an
argument, and let get_page_from_freelist to prefer that over the default
global lists.

Omit all special nodes from FALLBACK/NOFALLBACK and make the special
contexts provide the fallback-base that should be used.

On my current branch i think that would include modifying, in totality:

   alloc_folio_mpol()
   alloc_demotion_folio()
   alloc_migration_target()

And i'm pretty sure that all just nests nicely.

We might not even need memalloc... hmmm

~Gregory
