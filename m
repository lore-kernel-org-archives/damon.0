Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EDE3AB480
	for <damon@lists.linux.dev>; Thu,  4 Jun 2026 03:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780542656; cv=none; b=q5X4rp1AYiKZvH8fslc4Wuq7ZK0+gwxGAO89Ib3mplnciYNONVPskF3ZTgqA9H4QGNYB7fZRi2EcE0i81RXBlJEIG4RgWR37PQWXJuoHM/wEAiAP1ZyT6vhtbOs2wxU31+6JUx3f5Mt2URKyqcjGrhYJwZ8ckPBn3wv6zrFoHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780542656; c=relaxed/simple;
	bh=rbiAvfRs8t/VliXZbH3eKRZBWrz7y86VMSHsdyLINoc=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=m4HPVu2yrcSFu2w2S89ClC5wNQl2XdKiJLynV0mFzjSdKp4/uB9Djqz0+TzYn7eXerojcQ8lSbjiLxwwCa2db/UUT9K8a/swx3uz1vnDbiJt73TK1mQCOssBM13hXNpD+5igjXv7AYOKptjySYgREGRrW8BlO6+z+ZB5iuT5hqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gW8hh3Vhyz52SFw;
	Thu, 04 Jun 2026 11:10:44 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6543AYsC051407;
	Thu, 4 Jun 2026 11:10:34 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 4 Jun 2026 11:10:35 +0800 (CST)
X-Zmail-TransId: 2afb6a20ecab4ed-9e08f
X-Mailer: Zmail v1.0
Message-ID: <20260604111035154Lk-9ZgwKY4Nlk4zz30U1t@zte.com.cn>
In-Reply-To: <70377626-500d-46f2-a3f5-a0d2914ce365@kernel.org>
References: 20260527110147.17815-1-tao.wangtao@honor.com,70377626-500d-46f2-a3f5-a0d2914ce365@kernel.org
Date: Thu, 4 Jun 2026 11:10:35 +0800 (CST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <david@kernel.org>, <tao.wangtao@honor.com>
Cc: <tao.wangtao@honor.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>, <sj@kernel.org>,
        <kees@kernel.org>, <luizcap@redhat.com>,
        <zhangjiao2@cmss.chinamobile.com>, <kas@kernel.org>, <ljs@kernel.org>,
        <hpa@zytor.com>, <liam@infradead.org>, <vbabka@kernel.org>,
        <rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
        <jack@suse.cz>, <riel@surriel.com>, <harry@kernel.org>,
        <jannh@google.com>, <jgg@ziepe.ca>, <jhubbard@nvidia.com>,
        <peterx@redhat.com>, <ziy@nvidia.com>, <baolin.wang@linux.alibaba.com>,
        <npache@redhat.com>, <ryan.roberts@arm.com>, <dev.jain@arm.com>,
        <baohua@kernel.org>, <lance.yang@linux.dev>,
        <chengming.zhou@linux.dev>, <nao.horiguchi@gmail.com>,
        <matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>,
        <rakie.kim@sk.com>, <byungchul@sk.com>, <gourry@gourry.net>,
        <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
        <pfalcato@suse.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <damon@lists.linux.dev>,
        <shakeel.butt@linux.dev>, <ryncsn@gmail.com>, <dvander@google.com>,
        <wangzicheng@honor.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAwLzE1XSBtbTogaW50cm9kdWNlIEFOT05fVk1BX0xBWlkgZm9yIGRlZmVycmVkIGFub25fdm1hIGNyZWF0aW9u?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6543AYsC051407
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 04 Jun 2026 11:10:44 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A20ECB4.000/4gW8hh3Vhyz52SFw

> > 
> >  arch/arm64/Kconfig         |   1 +
> >  arch/x86/Kconfig           |   1 +
> >  fs/proc/page.c             |   6 +-
> >  include/linux/mm.h         |  38 ++
> >  include/linux/mm_types.h   |   9 +-
> >  include/linux/page-flags.h |  34 +-
> >  include/linux/pagemap.h    |   2 +-
> >  include/linux/rmap.h       | 165 ++++++++-
> >  mm/Kconfig                 |  22 ++
> >  mm/damon/ops-common.c      |   4 +-
> >  mm/debug.c                 |   2 +-
> >  mm/debug_vm_pgtable.c      |   2 +-
> >  mm/gup.c                   |   6 +-
> >  mm/huge_memory.c           |  16 +-
> >  mm/internal.h              | 171 +++++++++
> >  mm/khugepaged.c            |  13 +-
> >  mm/ksm.c                   |  43 ++-
> >  mm/memory-failure.c        |  11 +-
> >  mm/memory.c                |  19 +-
> >  mm/migrate.c               | 126 ++++---
> >  mm/mmap.c                  |  15 +-
> >  mm/mremap.c                |   4 +-
> >  mm/page_idle.c             |   2 +-
> >  mm/rmap.c                  | 690 ++++++++++++++++++++++++++++++++++---
> >  mm/vma.c                   |  76 ++--
> >  mm/vma.h                   |   4 +-
> >  mm/vma_exec.c              |   2 +-
> >  mm/vma_init.c              |   1 +
> >  28 files changed, 1279 insertions(+), 206 deletions(-)
> 
> Hi!
> 
> When I saw the diffsat I was concerned. Going through the patches made me ...
> more concerned :)
> 
> This is a lot of complexity. On top of something that is already so complicated
> that I fail to grasp most details without regularly taking a look at the nice
> figures Lorenzo created recently.
> 
> For example, I read above "since child VMAs do not need to allocate anon_vma"
> and wondered how that could be part of something that is just done lazily. Then
> I had to learn in the patches that there is some additional "Child VMAs
> are created as ANON_VMA_TREE_PARENT and do not allocate anon_vma" -- excuse me,
> what? :)
> 
> Reading about VMA refcounts made me shiver. Reading "Holding only
> folio_lock(folio) cannot guarantee that the split
> operation completes atomically." confused me. Learning that we have to invent
> interesting ways to make page migration mutually exclusive to free_pgtables()
> concerned me. Figuring out that there are arch-specific config options and
> runtime toggles is a clear warning sign.
> 
> Seeing test_folio_unmapped() was funny, though (why?! :)).
> 
> I think this patch set has a noble goal of reducing anon_vma overhead when anon
> pages are not shared during fork. However, using anon_vma for them actually
> makes the overall implementation (e.g., rmap walks, locking) more consistent and
> simpler.
> 
> Even if we could be convinced that most of this here is correct, how should we
> reasonably maintain this increasing level of complexity here?

Indeed, it's very complex, but having the changes of 15 patches scattered across
various subsystems is really frustrating for reviewers. It took me a whole day to
read through the entire patch set, which made an already complicated matter even
more complex (maintaining such complex code in the future will be a pain).

However, overall, I think the original intention behind Tao's patch is innovative
and valuable, and Tao could definitely make this patch set simpler and more
readable, because the core changes actually start from PATCH 10.

I believe that if Tao had done the following, things might have gone better and easier
for reviewing. In fact, I understand the motivation behind the patch is quite simple
at its core (just wanting to avoid allocating the anon_vma structure when a VMA hasn't
been truly forked, and instead put the VMA information directly into folio->mapping):

1) You could actually simplify your patch significantly — without adding a lot of wrappers
and helper functions that introduce extra review overhead — and keep only the most essential elements.

2) Provide complete test code (in tools/testing/selftest) that covers the affected functionality,
such as VMA, huge pages, KSM, etc.

3) Use the RFC tag to start a discussion.


I would be very glad to see if Tao could post a simpler v2 version that does not alter the rmap
core data structures too much and does not introduce excessive complexity, no matter whether
it can be merged finaly.
