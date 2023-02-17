Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245447F
	for <damon@lists.linux.dev>; Fri, 17 Feb 2023 16:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42453C433EF;
	Fri, 17 Feb 2023 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676652133;
	bh=+AJKibGK9BJvV9tIaXAU01+FWkGgsnwl76p6VJ4u4EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b1H/cyPd0a67aKzTPaQu5l18UvDGZ2ttRFTAKwGK5B5g1v3m17Jkex4Qt3NSP/qgR
	 YEhi33ddiVUOZYRIZJho9WIQFl9T5iMoCUi915Hjb5svollMorMXw2ZcJcpweuhzW4
	 ijNm7wkYeTUGPihvXeL8+XEvX6D++1+O6+3Tf1wzr8nbWXL25High8V4hJ1ECAm4ac
	 ThixtqrrGMiYVBJCPF+9AfsSgESPby6S6l/ignhbH54tvl/7IMJsGspRggE3v9yWYu
	 xXvOaOpfPQ9YRZcGOLDfLn+PbrSN/T9qJpFSLKJwuqk38YehQOI09bKc77Ksj31R6c
	 EilgeSL9yEIEA==
From: SeongJae Park <sj@kernel.org>
To: Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc: lsf-pc@lists.linux-foundation.org,
	Linux MM <linux-mm@kvack.org>,
	Yu Zhao <yuzhao@google.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	damon@lists.linux.dev
Subject: Re: [LSF/MM/BPF TOPIC] Using hardware counters to determine hot/cold pages
Date: Fri, 17 Feb 2023 16:42:11 +0000
Message-Id: <20230217164211.59619-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6bbf2c47-05ab-b78c-3165-2eff18962d6d@linux.ibm.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Aneesh,

On Fri, 17 Feb 2023 17:28:09 +0530 Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> wrote:

> PowerPC architecture (POWER10) supports a Hot/Cold page tracking
> facility that provides access counter and access affinity details at
> configurable page size granularity [1]. I have been looking at using
> this counter in different areas of the kernel such as
> 
> 1) Page reclaim/demotion
> 2) THP utilization
> 3) Page promotion.
> 
> I have done some MGLRU integration and would like to discuss the
> observation with the rest of the community. It is still not clear what
> are the best ways to integrate these hardware counters in the Linux
> kernel.

Sounds very interesting.  I think DAMON might be one another option, because it
is designed to be easy to extended with various source of access
information[1], and provides an abstraction layer for access temparature based
memory management[2], namely Data Access Monitoring-based Operation Schemes
(DAMOS).

> Attached is the performance graph showing how the mongodb/ycsb
> benchmark performs when using hardware counters with MGLRU aging. An
> early RFC version of the code can be found at
> https://github.com/kvaneesh/linux/commit/b472e2c8080823bb4114c286270aea3e18ffe221
> . I also expect we can get some numbers w.r.t THP usage before the
> conference.

I also have experimented a DAMON-based THP optimization[3], which shown
interesting results.

Hope to discuss about this with you at LSF/MM.  FYI, I also proposed an LSF/MM
topic for DAMON[4].

[1] https://docs.kernel.org/mm/damon/design.html#configurable-layers
[2] https://docs.kernel.org/mm/damon/api.html#c.damos
[3] https://www.amazon.science/publications/daos-data-access-aware-operating-system
[4] https://lore.kernel.org/damon/20230214003328.55285-1-sj@kernel.org/


Thanks,
SJ

> 
> 
> X axis is the amount of memory that I am removing from the system so
> that I can force more memory reclaims. The total memory available is
> 50GB/single NUMA node/64 CPUs,40GB database with 40GB cache
> configuration.
> 
> 
> [1]
> https://hc32.hotchips.org/assets/program/conference/day1/HotChips2020_Server_Processors_IBM_Starke_POWER10_v33.pdf
> 
