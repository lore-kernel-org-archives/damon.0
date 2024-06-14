Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C499D145A11
	for <damon@lists.linux.dev>; Fri, 14 Jun 2024 03:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718334365; cv=none; b=XpeZp79ZaZuh89ZusiEcne+KSvMBYuYGKbck7chEj1HpySAo6MOs6+4g7YJbsbTOfXUcKI2sJBtT7fYJHANlLFkTniiiKpoZE9pih2YsTKy5eZU0WADQet8U4xDoSUGN9slK2Mg2pyVZAsyGUWI0fC8phX4JG+d+tigu1tcvKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718334365; c=relaxed/simple;
	bh=ijrLn2Ezx5U5mGDBHpfW9Z/myiPUI0c/wUdXZIc99C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dp1QVKVAZhcQs1UPFnheC+xRGoYXLbpShOkfI6VSeatGbNj+gAzSxcHXxzjwoJAU3KL/GTY9JfHWcW20JcV5DF8e6rgj+T+BhlPkQDdapkeGUTwILgfPU+otmMj3HAtlw3Ae/loDImq8aOPi6gHz+JGliZz40ULWA4TSTDivaoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-61-666bb3973391
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH v5 0/8] DAMON based tiered memory management for CXL memory
Date: Fri, 14 Jun 2024 12:05:51 +0900
Message-ID: <20240614030554.784-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240613174604.63629-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsXC9ZZnoe70zdlpBvc6LSwm9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6Mow0/GQtuK1csPHGNvYHxumQXIyeHhICJxJSmh2ww9v45u5lBbDYBNYkrLycx
	gdgiAooS5x5fZO1i5OJgFtjKInGj8wQjSEJYwF/i6ZU9YEUsAqoSD+bOYAexeQVMJfZMbGOB
	GKop8Xj7T7A4p4CxxPs3J8DqhQR4JF5t2M8IUS8ocXLmE7B6ZgF5ieats5lBlkkI/GeT+LFp
	GyPEIEmJgytusExg5J+FpGcWkp4FjEyrGIUy88pyEzNzTPQyKvMyK/SS83M3MQLjYFntn+gd
	jJ8uBB9iFOBgVOLh9XiWlSbEmlhWXJl7iFGCg1lJhHfWQqAQb0piZVVqUX58UWlOavEhRmkO
	FiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGRsdb/Mua+I/qPX0jfX6f3vE9/r8Tvku5bs9O
	kDqlydRoa+wTUNjvzCpzZ5rF6zJbPv05wcuqBGYzzlJmjRaLPnHzXtW+p4liv6ZOyxI5viX/
	jeLDG6GzTVfeYnqVGDTv6NTadsv59//+MF91gkf33JTcY4zB27YneCd1x5SfmKRdp+KzQJXl
	lxJLcUaioRZzUXEiAO8NfpR/AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXCNUNLT3f65uw0g4aVKhYTewws5qxfw2Zx
	/8Frdosn/3+zWjQ0PWKx+PzsNbNF55PvjBaH555ktbi8aw6bxb01/1ktjqw/y2Kx+ewZZovF
	y9UsDl17zmqxr+MBk8Xhr2+YLH5vW8HmIOix9PQbNo+ds+6ye7Tsu8XusWlVJ5vHpk+T2D1O
	zPjN4vFi80xGj40f/7N7fLvt4bH4xQcmj8+b5AK4o7hsUlJzMstSi/TtErgyjjb8ZCy4rVyx
	8MQ19gbG65JdjJwcEgImEvvn7GYGsdkE1CSuvJzEBGKLCChKnHt8kbWLkYuDWWAri8SNzhOM
	IAlhAX+Jp1f2gBWxCKhKPJg7gx3E5hUwldgzsY0FYqimxOPtP8HinALGEu/fnACrFxLgkXi1
	YT8jRL2gxMmZT8DqmQXkJZq3zmaewMgzC0lqFpLUAkamVYwimXlluYmZOaZ6xdkZlXmZFXrJ
	+bmbGIFRsKz2z8QdjF8uux9iFOBgVOLh9XiWlSbEmlhWXJl7iFGCg1lJhHfWQqAQb0piZVVq
	UX58UWlOavEhRmkOFiVxXq/w1AQhgfTEktTs1NSC1CKYLBMHp1QDo7Hsyr3RO4/+b14k+nCV
	11N2own3TbXuGfjN2J9WuWpdckwqf35YUc1s91tWck2Na76Eb/u0aYsJ2+XKFP6z70ymGudk
	3TDiSZr+Z+LWCY9DXgc7LNsTJbF69ZSd5isufdJyV/+y6XWWeeoDkxcHevbvYc+Y71u3vsM8
	WeKIX3vmHdu4vc1zJimxFGckGmoxFxUnAgCvQf2+fgIAAA==
X-CFilter-Loop: Reflected

Hi SeongJae,

On Thu, 13 Jun 2024 10:46:04 -0700 SeongJae Park <sj@kernel.org> wrote:
> Hi Honggyu,
> 
> On Thu, 13 Jun 2024 22:20:47 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> > posted at [1].
> > 
> > It says there is no implementation of the demote/promote DAMOS action
> > are made.  This patch series is about its implementation for physical
> > address space so that this scheme can be applied in system wide level.
> > 
> > Changes from RFC v4:
> > https://lore.kernel.org/20240512175447.75943-1-sj@kernel.org
> >   1. Add usage and design documents
> >   2. Rename alloc_demote_folio to alloc_migrate_folio
> >   3. Add evaluation results with "demotion_enabled" true
> >   4. Rebase based on v6.10-rc3
> 
> I left comments on the new patches for the documentation.
> 
> [...]
> > 
> > Evaluation Results
> > ==================
> > 
> > All the result values are normalized to DRAM-only execution time because
> > the workload cannot be faster than DRAM-only unless the workload hits
> > the peak bandwidth but our redis test doesn't go beyond the bandwidth
> > limit.
> > 
> > So the DRAM-only execution time is the ideal result without affected by
> > the gap between DRAM and CXL performance difference.  The NUMA node
> > environment is as follows.
> > 
> >   node0 - local DRAM, 512GB with a CPU socket (fast tier)
> >   node1 - disabled
> >   node2 - CXL DRAM, 96GB, no CPU attached (slow tier)
> > 
> > The following is the result of generating zipfian distribution to
> > redis-server and the numbers are averaged by 50 times of execution.
> > 
> >   1. YCSB zipfian distribution read only workload
> >   memory pressure with cold memory on node0 with 512GB of local DRAM.
> >   ====================+================================================+=========
> >                       |       cold memory occupied by mmap and memset  |
> >                       |   0G  440G  450G  460G  470G  480G  490G  500G |
> >   ====================+================================================+=========
> >   Execution time normalized to DRAM-only values                        | GEOMEAN
> >   --------------------+------------------------------------------------+---------
> >   DRAM-only           | 1.00     -     -     -     -     -     -     - | 1.00
> >   CXL-only            | 1.19     -     -     -     -     -     -     - | 1.19
> >   default             |    -  1.00  1.05  1.08  1.12  1.14  1.18  1.18 | 1.11
> >   DAMON tiered        |    -  1.03  1.03  1.03  1.03  1.03  1.07 *1.05 | 1.04
> >   DAMON lazy          |    -  1.04  1.03  1.04  1.05  1.06  1.06 *1.06 | 1.05
> >   ====================+================================================+=========
> >   CXL usage of redis-server in GB                                      | AVERAGE
> >   --------------------+------------------------------------------------+---------
> >   DRAM-only           |  0.0     -     -     -     -     -     -     - |  0.0
> >   CXL-only            | 51.4     -     -     -     -     -     -     - | 51.4
> >   default             |    -   0.6  10.6  20.5  30.5  40.5  47.6  50.4 | 28.7
> >   DAMON tiered        |    -   0.6   0.5   0.4   0.7   0.8   7.1   5.6 |  2.2
> >   DAMON lazy          |    -   0.5   3.0   4.5   5.4   6.4   9.4   9.1 |  5.5
> >   ====================+================================================+=========
> > 
> > Each test result is based on the exeuction environment as follows.
> 
> Nit.  s/exeuction/execution/

Thanks. Fixed it.

> [...]
> > In summary, the evaluation results show that DAMON memory management
> > with DAMOS_MIGRATE_{HOT,COLD} actions reduces the performance slowdown
> > compared to the "default" memory policy from 11% to 3~5% when the system
> > runs with high memory pressure on its fast tier DRAM nodes.
> > 
> > Having these DAMOS_MIGRATE_HOT and DAMOS_MIGRATE_COLD actions can make
> > tiered memory systems run more efficiently under high memory pressures.
> 
> Thank you very much for continuing this great work.
> 
> Other than trivial comments on documentation patches and the above typo, I have
> no particular concern on this patchset.  I'm looking forward to the next
> version.

I have addressed all your comments and resent v6 again. Please have a
look again.
https://lore.kernel.org/20240614030010.751-1-honggyu.kim@sk.com

Thanks very much for your review!

Thanks,
Honggyu

> 
> Thanks,
> SJ
> [...]
