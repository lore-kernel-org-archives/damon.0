Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30222A4D
	for <damon@lists.linux.dev>; Sun, 19 Feb 2023 20:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297BBC433D2;
	Sun, 19 Feb 2023 20:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676838700;
	bh=TmMatO5jW0UB6jUPsvjwyPrdcEJXebnMyipm8Ki+mkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QoQ5WptNN4PPOXSNeBORliFBCIwF20Aadd+IGPBlcMHpYbPXPV8svX5pdsJAh0oH4
	 FcUUWoDhzBOdDulK16zv40FdjBQiGpnizKWKjQOktSWRKpgEGy+YpJoijWRM0AaIK2
	 8N3agA7cVuE3HHfIlMAHp1n5XVXP76rRnL3/WbHQZGbahwo1ykKeHZLp9MMACqflXV
	 rYR3L86fppEocGYTNPFMIHFu7ofzEFburLevZ78LpM/1MOV2637nztj36hwtW2o8sM
	 3VOd48CpOTd+UBFnX8CyadMsHxV9LroTwAGvdV/vYyWmB8vHOddC20x51Sbv/53XHJ
	 Z9p59BjPzUlAw==
From: SeongJae Park <sj@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: SeongJae Park <sj@kernel.org>,
	lsf-pc@lists.linux-foundation.org,
	Linux MM <linux-mm@kvack.org>,
	Yu Zhao <yuzhao@google.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	damon@lists.linux.dev
Subject: Re: [LSF/MM/BPF TOPIC] Using hardware counters to determine hot/cold pages
Date: Sun, 19 Feb 2023 20:31:38 +0000
Message-Id: <20230219203138.4873-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87fsb1g23o.fsf@linux.ibm.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Aneesh,

On Sun, 19 Feb 2023 19:59:47 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> SeongJae Park <sj@kernel.org> writes:
> 
> > Hi Aneesh,
> >
> > On Fri, 17 Feb 2023 17:28:09 +0530 Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> wrote:
> >
> >> PowerPC architecture (POWER10) supports a Hot/Cold page tracking
> >> facility that provides access counter and access affinity details at
> >> configurable page size granularity [1]. I have been looking at using
> >> this counter in different areas of the kernel such as
> >> 
> >> 1) Page reclaim/demotion
> >> 2) THP utilization
> >> 3) Page promotion.
> >> 
> >> I have done some MGLRU integration and would like to discuss the
> >> observation with the rest of the community. It is still not clear what
> >> are the best ways to integrate these hardware counters in the Linux
> >> kernel.
> >
> > Sounds very interesting.  I think DAMON might be one another option, because it
> > is designed to be easy to extended with various source of access
> > information[1], and provides an abstraction layer for access temparature based
> > memory management[2], namely Data Access Monitoring-based Operation Schemes
> > (DAMOS).
> >
> >> Attached is the performance graph showing how the mongodb/ycsb
> >> benchmark performs when using hardware counters with MGLRU aging. An
> >> early RFC version of the code can be found at
> >> https://github.com/kvaneesh/linux/commit/b472e2c8080823bb4114c286270aea3e18ffe221
> >> . I also expect we can get some numbers w.r.t THP usage before the
> >> conference.
> >
> > I also have experimented a DAMON-based THP optimization[3], which shown
> > interesting results.
> >
> > Hope to discuss about this with you at LSF/MM.  FYI, I also proposed an LSF/MM
> > topic for DAMON[4].
> >
> > [1] https://docs.kernel.org/mm/damon/design.html#configurable-layers
> > [2] https://docs.kernel.org/mm/damon/api.html#c.damos
> > [3] https://www.amazon.science/publications/daos-data-access-aware-operating-system
> > [4] https://lore.kernel.org/damon/20230214003328.55285-1-sj@kernel.org/
> >
> >
> 
> The hardware counters that are supported in the case of POWER10 are
> based on physical addresses. The hardware facility will count the access
> across a physical address range and there is a counter for each page
> that gives the access count and also information about which node did
> access the page.
> 
> I haven't spent much time studying DAMON so I might be wrong here. The
> reason I avoided using DAMON for the POC was because my goal was to
> evaluate how the hardware counters measured against the pte reference
> bit and I was not sure I could evaluate that using the DAMON action
> facility.
> 
> I do agree that we could add a layer similar to DAMON_PADDR and expose
> the details to userspace. But I was not sure we can take action based on
> that. In most cases what I wanted was to move the coldest page in the
> Numa node to swap. So that is relative hotness rather than moving a page
> that got a hotness value less than 10 to swap even though we can figure
> out a way to make the latter similar to the former.

I think you could use DAMOS quota[1].  Under the quota, DAMOS prioritizes
regions based on the access pattern, and applies the action to higher-priority
regions, so you can do relative coldness-based reclamation, like DAMON_RECLAIM
does[2].

The interface might not very efficient for your specific case, though.  I want
to know such cases and improve the interface or implement new features.

[1] https://docs.kernel.org/mm/damon/api.html#c.damos_quota
[2] https://docs.kernel.org/admin-guide/mm/damon/reclaim.html#quota-sz

> 
> 
> I will look at DAMON and see if that is the best framework for things
> like this.

Great, please feel free to reach out to me if you have any question or need
help.


Thanks,
SJ

> 
> -aneesh
