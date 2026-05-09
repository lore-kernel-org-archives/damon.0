Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15402D77E5
	for <damon@lists.linux.dev>; Sat,  9 May 2026 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778344755; cv=none; b=cTAYAQMsobGxHMHvV0jV/cyoJ+pHyTfjMB3PNV0+8my7ah6uZrjixFPaYZbSJhlwNlAx3O9+BdxxprHiBrIDhm8r1C4z81yTnI3RcMttvgIhlFHajwRcQhMEeUC5GHblK7awS+Q5r1YC0BT+KIulq+CKJ6chqSA5nArLQ8yMC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778344755; c=relaxed/simple;
	bh=FKd0CXJyl9QfJPa0aYz0nVfjWc/cyYUW7BZ587RmS00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaqhVC1A3jsTbQiRoMN20Hikk2om41R4SP1TMSl6cD7ivuZw9qqwylfczL/DuGgAyIPbksZk+oxTPHSP34Ubs8vEFUv9T9W9Lub+2j2ArL22rR6BpuFZWfxSMNBjm/GlHKHk55gXH+kyKZ/w2NzBxI1zMoliYo5IpY0bnMC9Fjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EhEgJCAq; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EhEgJCAq"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-132c3280e8fso273469c88.1
        for <damon@lists.linux.dev>; Sat, 09 May 2026 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778344753; x=1778949553; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Z2UMBx5dGhCxet+pSUCVtwvNzhJpnfXCgIbbDTxeL4=;
        b=EhEgJCAqcXbMhVWwCx2LY4Ag5ApfI/4H1PLsr+qMtxg42bzQi7f96PEILJyKJ5THGk
         Q+6JPAktn+FBmMycxjPdJKTEQb34OFImLtOFyY6Y30QJBFr782xLE4fEnUGZJL/rEZs0
         Qyj6HRrL3ZJ03h0IYTpjmKtta2sRhPetRD4nLzvsIynFa2EuIARo4DQsYpifxa79wNhE
         RRAcyuI/NKluMm98H6Gp6e+UiK7qUqQ8f2uwonQ9+X3fOimWAdOScljtCdAeK5SgGhBo
         OiFJ842lnZ1YoTj+NdYS1VTrGpfI2R0tbv6kB/LzKc94fWUtcXuAqktgcj2lEacGFEnh
         NAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778344753; x=1778949553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Z2UMBx5dGhCxet+pSUCVtwvNzhJpnfXCgIbbDTxeL4=;
        b=SMaNr6TKg6w8tO74ISPBx0swtjiHSNcg06S4shXnC/nEDmoIHl7EQSBfjBg3qBP2LM
         sPE7udnr6TUHNrcToM+CPR+v65inmS/9Vn/tDTfnxSKIhExVmiUWCbtvPjUCUupjI6IW
         oSloMZ0XKeB648vQ/LRXU59ndKFL/iJkVVov8ivioCgx+7W8FXvI1fXgKnX1JhkyyF0g
         MPgmL70RFtVSrnksVNigultf9SCcOKdvrHBu/cnFex8QxoBYzNmncBkyiRRVHsLanz7h
         Srg/xnOUFPO/VpIatVE85E5gIaiY2ldX2VkDLEnvW53rI55LG37wHNrkypZkaIXgwbrQ
         H2hQ==
X-Forwarded-Encrypted: i=1; AFNElJ8CHWoBIbw/d3F2xqhK9xWWQhxMiMgjnIf4m68Ofngm6DqIk5RffWpj9BnLjxcP7tC9SigsOA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6ItEyG+eyXcZs26EHCamqKAruRE39WAiTH/hWoypGd36wlTtJ
	dqi4DHHI3rTdrUHFm3mOFdKn14Miw/YQXBI2SeHEWBs2J/gCij1495qcrm4TM4NfRMU=
X-Gm-Gg: Acq92OEVS/3MqUcquRZECOLZrJMrlQG/49SKbKBuRgRvrPZjK+686FUg5IYGWHymIVZ
	Qgil5Q3F/Q1iv5phd31+ieDixCFmPIksWwFvXPr3ZayrlkRexk+mfvaVwgjpb39LaFCVVw6OIn1
	BZ2BCuShz5AHcr0yxzE/C3iT1RJKPYuv2g8nO+KlxrX0dDDhk0nSdStNpp5uhH9li958aYrk/lR
	CH5j0pvwHBCqBLvKw3Vc8X4DAtrYlXGT4KA3snzLzKvSH/YHGbVuKp1KFcdqy9NX+olRYz1onBm
	asJHR6rHErUXT358VAUIdHARN0QkA27rBYlJkWG2GKb8mgl7Mqy4Iuvad+CCqpGVWazNIkSvAbN
	sYh18odqm2UJWDktAHI+TgAG6lUryVQZpioLpPASSeltC13TYMiSzR6KH5Y7Ja7MVU3jAekJIcC
	Y5nqFBsV8ZoGdTRTZJ6xiy8RNC7D4O6ZbD2C5FfmmENA==
X-Received: by 2002:a05:7300:724b:b0:2f8:1f2b:bb5d with SMTP id 5a478bee46e88-2fb4dc64acfmr984629eec.25.1778344752833;
        Sat, 09 May 2026 09:39:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([205.220.129.38])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb4b7sm6994852eec.2.2026.05.09.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 09:39:12 -0700 (PDT)
Date: Sat, 9 May 2026 17:38:05 +0100
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
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
Subject: Re: [LSF/MM/BPF TOPIC] Private Memory Nodes - follow up
Message-ID: <af9i7dkNvGGxPHzu@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>

Just wanting to follow up post-conference with a few major take-aways
since I will be a bit sparse during May / Early June (so want to not
forget, and garner a bit of input on the notes).

If you just want the tl;dr:

   0) naming:  private -> managed

   1) remove global general "possible" and "online" node lists

   2) add consistency with "normal" nodes, by opting them all in
      to all the new things, and just making that the new normal.
      e.g.: node_is_private_managed -> node_is_lru_eligible

   3) Have __init add init time nodes to all the lists
      Otherwise service/owner must add/enable services.

   4) Make folio checks just way more explicit per service
      e.g.: folio_is_private_managed -> folio_is_ksm_eligible

   5) I still think w/o __GFP_PRIVATE this will still be too fragile,
      but we're going to give it a try.

   6) No callbacks in the MVP

   7) MVP will be, essentially, Buddy + MBind support

Otherwise, more notes below.

~Gregory

<wall of text>

0) Naming is hard.  Willy and Liam expressed concern over "private".

   We briefly discussed "Managed"

   This results in the following changes:

      - if (folio_is_zone_device(folio))
      + if (folio_is_managed(folio))

   and
   
      + if (node_is_managed(nid))

   and

      - N_MEMORY_PRIVATE
      + N_MEMORY_MANAGED

   I'm less enthused the last one, but i'm ok with it.


1) There is a desire to fix possible / online node masks to avoid
   bad patterns, and maybe to audit existing nodemask users.

   there's one UAPI issue with this, and that that these masks
   are exposed to userland by nature of existing node attributes
   (N_MEMORY, N_CPU, N_POSSIBLE, etc).

   I'm considering a name change from `possible` -> `init`, because
   that's mostly how it is used (initialize some set of per-node
   resources during __init, not at runtime).  Externally, this set
   would still be reported to uapi as possible.


2) There was concern about inconsistency towards nodes.

   Along the lines of #1 - I'm thinking about actually adding explicit
   service nodelists, which are populated at boot by __init, and by
   hotplug if it's a general purpose node.

   So we'd end up with things like:

       for_each_ksm_node
       for_each_lru_node
       for_each_x_node

   And we would retire such general defines like

       for_each_node
       for_each_online_node

   For any "normal" node, it lands in all the lists.

   For the buddy, we would have

       for_buddy_node

   For the default buddy-node list, and otherwise "managed" nodes would
   still be removed from the standard fallback lists.

   This means these nodes cannot be reached via nodemask arguments, and
   can only be reached by `alloc_pages_node(nid, ...)` nid argument.

                I *think* might resolve __GFP_PRIVATE.

      But it's still dependent on system-wide for_each good behavior.


3) How do private nodes get into the lists in the new system?

   For any private node, the registering driver (owner) and the managing
   service are responsible for adding/removing the nodes from the list.

   Example workflow:

     0) CXL driver hotplug: add_memory_driver_managed(..., nid, owner)
           a) owner=NULL means general purpose node
	   b) otherwise, reserve nid and (pgdat->owner = owner)

     1) hotplug memory onto the node
          a) if node is normal, add to all service lists
	  b) if node is "managed" (private), omit from all lists

     2) CXL driver registers node with specific services, e.g.:
          cram_register_node(..., nid, owner);

     3) Service sets node enabled in appropriate node list, and starts
        any appropriate services (kswapd, kcompactd, etc) for that node.

   In some cases, nodes would have individual mappings onto services
   (cram), in other cases the intent would be to have the memory
   otherwise treated as general-purpose, but with special access
   patterns (e.g. an LRU node not marked N_MEMORY).


4) There are still concerns about random hooks around the kernel.

   My thought is to make this less "random", and more a change
   in the way we think about folio operations / node operations
   for ALL nodes.

   ZONE_DEVICE has a bunch of implicit filtering due to not being
   on the LRU - but the intent is to allow flexible LRU membership.

   So what if we just made these checks much more explict overall

    if (folio_is_ksm_eligible(folio))      /* can be merged */
    if (folio_is_lru_eligible(folio))      /* managed by lru services */
    if (folio_is_demotion_eligible(folio)) /* demotion target */
    if (folio_is_mbind_eligible(folio))    /* can be an mbind target */

  Rather than rathole over what the set of bits should be, i think it's
  more important to determine what the actual operation here will be.

  right now I have this defined as essentially:

     folio_pgdat(folio)->private.ops.mask & NP_OPT_KSM

  But if we generalize to all nodes / all features, it's essentially
  a per-pgdat bitmask lookup:

    bool folio_is_ksm_eligible(folio)) {
        return test_bit(N_FEATURE_KSM, folio_pgdat(folio)->features);
    }

  With the bonus that all ZONE_DEVICE hooks can be sunk into these
  checks, so there are many places in mm/ where this becomes essentially
  a single-line change.


5) Lacking __GFP_PRIVATE, I have concern over fragility.

   Previously, __GFP_PRIVATE created a "default opt-out" mechanism.

   I *think* the above nodelist changes, specifically removing:

       for_each_node()
       for_each_online_node()
       for_each_node_with_cpus()

   The problem I foresee is with existing node_state masks, like

       node_state((node), N_POSSIBLE)
       node_state((node), N_CPU)

   This might be tractable, but it may also simply be too fragile.
   
   Right now only 3 or 4 locations use node_state() outside mm/, and
   I'm tempted to try to sink these into mm/internal.h instead of
   include/linux/nodemask.h.  If that becomes unpalletable, then I will
   lobby for __GFP_PRIVATE again (I may still anyway :P).



6) No callbacks by default, but nothing technically prevents it.

   I was already in the process of killing this.  I think mmu_notifier
   does *most* of what the callbacks where doing anyway, so we can
   probably collapse that.


7) David asked me to limit the MVP to Buddy + MBind support.

   There's some odd interactions with pagecache, so that might evolve
   too (may not be able to reliably fault a file directly onto a private
   node, tbd - mempolicy does not apply to page cache faults, so it's
   just unreliable).

</wall of text>

~Gregory
