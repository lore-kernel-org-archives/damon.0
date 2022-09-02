Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068DEA0
	for <damon@lists.linux.dev>; Fri,  2 Sep 2022 01:18:28 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id u6so793269eda.12
        for <damon@lists.linux.dev>; Thu, 01 Sep 2022 18:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vubaGOA7KAPskf9TWeTqLDaT3GTBzASXB3ONje3ZhBQ=;
        b=e0XDxZD4BlDqW2yW2GdtDuadr5wMVeqgtWyK7SjJ89u1AF49qE5j3GpVJns1IOt8QV
         Cl2N0D2I8pJeMrg67NariRniZVkO6LA2yFzMF1ojRACDYcVZIvYDzMNdO+rPQlb6ggbP
         s96+VQpkVBkxE/kZo9KUt8lZAT1JKxCG7e9+0e3fz6DFRCps7SFuIkHZlbMzKB+BMSQt
         zrZZKxE9k4FbnJxTdj4Mf1pH3hAKJAWwQ/kVSYlY0ucHkLXT2J8dqKZh3+SxIzz8omFZ
         Pg/pqFsj2tF7cqgjrlxW6PEOUbpj/MWGkLKfeeMk0HMlcvQROXwKmZ3q+SY1+VW2wWmQ
         Bdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vubaGOA7KAPskf9TWeTqLDaT3GTBzASXB3ONje3ZhBQ=;
        b=Kx5Cpimgh1yvK5Hg2avb4/b+IqAU0q6h8sCjmOEHoBRdzN8df5ObypY6PjAK5NiPHT
         LiWdhFddZ8Y4JGfnGAlexsQXSOMg50gYPsjzM4m9MbG0LruXdKVhM/l1cK4BeSUESB72
         lvSLdb2qK2WuxVoCdcCUfIMI7VWKoEEmNGDNMDJwjC23qqWa/tVmgCdxvr1YUvJ2HcgE
         skDbewOQJxy1laTG86Knrh1K/iqTnfhw1mt3VZOgGxFA9e3RivGTrFLdT1rYAYszjXBj
         6W1DzE1CSkRoQFsgKsVBYyutSgVsj3Kwi/x11mGk1wMP0itjQ4/6RvR6UWxuns6pbo7v
         kudg==
X-Gm-Message-State: ACgBeo1/q+u2l6JDG7XY4Bitbgn+Ql/mC/XJZc6ZfqGcsaZ8QiurABA3
	VQpfr6V53ku0nFPDn6EqFw8BSgi+krsp3+EJxV8=
X-Google-Smtp-Source: AA6agR645HOEPE/gqaaVEnxnhpjUlnfl7tSda4XCFDPjOInVU7DSeqWhDlV+YM7dCxScZqQhB2VGwElrij+dAGvWvdw=
X-Received: by 2002:aa7:df8c:0:b0:448:a9a0:5fd8 with SMTP id
 b12-20020aa7df8c000000b00448a9a05fd8mr14996981edy.244.1662081506225; Thu, 01
 Sep 2022 18:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAGsJ_4w=NKr-NOg2TLycx=ka1OpzmzC2dpq0Z1EUXaXDMM8uVQ@mail.gmail.com>
 <20220901221114.81601-1-sj@kernel.org>
In-Reply-To: <20220901221114.81601-1-sj@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 2 Sep 2022 13:18:15 +1200
Message-ID: <CAGsJ_4zgQ87vfBN795Yxa4R25kQwHm9H1Kxi3RetpfTu9bzSew@mail.gmail.com>
Subject: Re: [PATCH 7/8] mm/damon: introduce DAMON-based LRU-lists Sorting
To: SeongJae Park <sj@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 2, 2022 at 10:11 AM SeongJae Park <sj@kernel.org> wrote:
>
> On Fri, 2 Sep 2022 09:40:10 +1200 Barry Song <21cnbao@gmail.com> wrote:
>
> > On Fri, Sep 2, 2022 at 5:11 AM SeongJae Park <sj@kernel.org> wrote:
> > >
> > > Hi Barry,
> > >
> > >
> > > On Thu, 1 Sep 2022 14:21:21 +1200 Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > > On Thu, Sep 1, 2022 at 2:03 PM Barry Song <21cnbao@gmail.com> wrote:
> > > > >
> > > > > On Tue, Jun 14, 2022 at 10:01 AM SeongJae Park <sj@kernel.org> wrote:
> > > > > >
> > > > > > Users can do data access-aware LRU-lists sorting using 'LRU_PRIO' and
> > > > > > 'LRU_DEPRIO' DAMOS actions.  However, finding best parameters including
> > > > > > the hotness/coldness thresholds, CPU quota, and watermarks could be
> > > > > > challenging for some users.  To make the scheme easy to be used without
> > > > > > complex tuning for common situations, this commit implements a static
> > > > > > kernel module called 'DAMON_LRU_SORT' using the 'LRU_PRIO' and
> > > > > > 'LRU_DEPRIO' DAMOS actions.
> > > > > >
> > > > > > It proactively sorts LRU-lists using DAMON with conservatively chosen
> > > > > > default values of the parameters.  That is, the module under its default
> > > > > > parameters will make no harm for common situations but provide some
> > > > > > level of efficiency improvements for systems having clear hot/cold
> > > > > > access pattern under a level of memory pressure while consuming only a
> > > > > > limited small portion of CPU time.
> > > > >
> > > >
> > > > Hi SeongJae,
> > > > While I believe DAMON pro-active reclamation and LRU-SORT can benefit the system
> > > > by either swapping out cold pages earlier and sorting LRU lists before
> > > > system has high
> > > > memory pressure, I am still not convinced the improvement really comes from the
> > > > identification of cold and hot pages by DAMON.
> > > >
> > > > My guess is that even if we randomly pick some regions in memory and do the same
> > > > thing in the kernel, we can also see the improvement.
> > > >
> > > > As we actually depend on two facts to benefit from DAMON
> > > > 1. locality
> > > > while virtual address might have some locality, physical address seems
> > > > not. for example,
> > > > address A might be mapped by facebook, address A + 4096 could be
> > > > mapped by youtube.
> > > > There is nothing which can stop contiguous physical addresses from
> > > > being mapped by
> > > > completely irrelevant applications. so regions based on paddr seems pointless.
> > > >
> > > > 2. accuration
> > > > As I have reported it is very hard for damon to accurately track
> > > > virtual address since
> > > > virtual space is so huge:
> > > > https://lore.kernel.org/lkml/CAGsJ_4x_k9009HwpTswEq1ut_co8XYdpZ9k0BVW=0=HRiifxkA@mail.gmail.com/
> > > > I believe it is also true for paddr since paddr has much worse
> > > > locality than vaddr.
> > > > so we probably need a lot of regions, ideally, one region for each page.
> > > >
> > > > To me, it seems neither of these two facts are true.  So I am more
> > > > willing to believe
> > > > that the benefits come from areas  picked randomly.
> > > >
> > > > Am I missing something?
> > >
> > > Thank you for the questions.
> > >
> > > As you mentioned, DAMON assumes spatial and temporal locality, to trade
> > > accuracy for lower overhead[1].  That is, DAMON believes some memory regions
> > > would have pages that accessed in similar frequency for similar time duration.
> > > Therefore if the access pattern of the system is really chaotic, that is, if
> > > every adjacent page have very different access frequency or the access
> > > frequency changes very frequently, DAMON's accuracy would be bad.  But, would
> > > such access pattern really common in the real world?  Given the Pareto
> > > principle[2], I think that's not always true.  After all, many of kernel
> > > mechanisms including the pseudo-LRU-based reclamation and the readahead assumes
> > > some locality and makes good effect.
> >
> > + yu zhao
> >
> > I do believe we have some locality in virtual addresses as they are in
> > the same application.
> > that is why we can "exploit locality in rmap" here:
> > https://lore.kernel.org/linux-mm/20220815071332.627393-8-yuzhao@google.com/
> >
> > But for paddr, i doubt it is true as processes use page faults to get
> > pages from buddy
> > mainly in low order like zero.
>
> Well, what I can tell for now is that it would depend on the specific system
> and workload, but I found some production systems that have such kind of
> physical address space locality.
>

yep. I guess for mmu-less systems, spatial locality is more likely to be true.
for mmu system, workload using 2MB or 1GB THP won't show locality in
physical address as well. but THP_SWP will swap them as a whole, so it
seems locality inside a THP

> >
> > >
> > > If your system has too low locality and therefore DAMON doesn't provide good
> > > enough accuracy, you could increase the accuracy by setting the upperbound of
> > > the monitoring overhead higher.  For DAMOS schemes like DAMON_RECLAIM or
> > > DAMON_LRU_SORT, you could also increase the minimum age of the target access
> > > pattern.  If the access pattern is really chaotic, DAMON wouldn't show the
> > > regions having the specific access pattern for long time.  Actually, definition
> > > of the age and use of it means you believe the system's access pattern is not
> > > that chaotic but has at least temporal locality.
> > >
> > > It's true that DAMON doesn't monitor access pattern in page granularity, and
> > > therefore it could report some cold pages as hot, and vice versa.  However, I'd
> > > say the benefit of making right decision for huge number of pages outweighs the
> > > risk of making wrong decision for few pages in many cases.
> > >
> > > After all, it shows some benefit on my test environments and some production
> > > systems.  I haven't compared that against random pageout or random lru sorting,
> > > though.
> > >
> > > Nevertheless, DAMON has so many rooms for improvement, including the accuracy.
> > > I want to improve the accuracy while keeping the overhead low.  Also, I know
> > > that there are people who willing to do page-granularity monitoring though it
> > > could incur high monitoring overhead.  As a part of the DAMON accuracy
> > > improvement plan, to use that as a comparison target, and to convince such
> > > people, I added the page granularity monitoring feature of DAMON to my todo
> > > list.  I haven't had a time for prioritizing that yet, though, as I haven't
> > > heard some clear voice of users for that.  I hope the DAMON Beer/Coffee/Tea
> > > Chat Series to be a place to hear such voices.
> >
> > is it possible for us to leverage the idea from  "mm: multi-gen LRU:
> > support page table walks"
> >
> > https://lore.kernel.org/linux-mm/20220815071332.627393-9-yuzhao@google.com/
> >
> > we pro-actively scan the virtual address space of those processes
> > which have been really
> > executed then get LRU sorted earlier?
>
> I didn't read MGLRU patchset thoroughly, but, maybe?
>
>
> Thanks,
> SJ
>
> >
> > >
> > > [1] https://docs.kernel.org/mm/damon/design.html#address-space-independent-core-mechanisms
> > > [2] https://en.wikipedia.org/wiki/Pareto_principle
> > >
> > >
> > > Thanks,
> > > SJ
> >
> > Thanks
> > Barry
