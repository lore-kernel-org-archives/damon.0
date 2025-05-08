Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B75918A6A5
	for <damon@lists.linux.dev>; Thu,  8 May 2025 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746696524; cv=none; b=P/ejFyzIwm+enGyJb3mlZRuDd5aUOZWns2NvCA1OcJVRx8ZzC2F0ZOrweFp9tY/JIn+2xrDlfzVGBLS2w8pg7dgPT9D+2w7dAfiPrKNwO4Z2KUIaVVM7LqM544cOW5Z5aH4lSxJFAZdF4fpiZj4DqAjFlTwENkGnKxyvBvDeCqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746696524; c=relaxed/simple;
	bh=axGDd6NciBI/jAaAl45il0X/JkW81/8FOGRE1k08GHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlsXOxdINzRVrS+luThA4Bi5E2XpEdtVWait190L8AQnmYj6qqWYB4xWpULvreZIL3DdMnCR14DiAyED8EE4ciNR5QtpI+0vN0FuLljT/KfrgumsBz+uvHw6P4zrTt8iAnzIzlq+mubyrmshcwzxzoAjwCj/FU8W2jufJCfc/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-03-681c7943decd
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	kernel_team@skhynix.com
Subject: Re: [PATCH 0/7] mm/damon: auto-tune DAMOS for NUMA setups including tiered memory
Date: Thu,  8 May 2025 18:28:27 +0900
Message-ID: <20250508092833.800-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250502154949.50992-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsXC9ZZnoa5zpUyGwYYlyhZz1q9hs3hyoJ3R
	4sn/36wW+y4CuQvblrBYXN41h83i3pr/rBaHv75hcuDw2LSqk81j06dJ7B4nZvxm8XixeSaj
	x+K+yawe5y5WeHzeJBfAHsVlk5Kak1mWWqRvl8CV8aDvB1PBWs2Kpw1zWRsYd8h1MXJySAiY
	SLxaOosRxj507T07iM0moCFx8NBJZhBbREBR4tzji6xdjFwczAJtTBLLLjxnAkkIC0RJ9C36
	yQpiswioSty4uAcszitgJrGgay07xFBNiYZL94DiHBycAsYSk6eogISFBHgkXm3YzwhRLihx
	cuYTFhCbWUBeonnrbGaQXRICe9gktj5ewwwxR1Li4IobLBMY+Wch6ZmFpGcBI9MqRqHMvLLc
	xMwcE72MyrzMCr3k/NxNjMBQXlb7J3oH46cLwYcYBTgYlXh4HbylM4RYE8uKK3MPMUpwMCuJ
	8BY1AoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxESSE8sSc1OTS1ILYLJMnFwSjUweltL
	G+m+7LZOaJ0YELHC/POa94lP42Kn8T6/2X6459XmIP+vfMWL+Kom3ppxZ674xEcGi0zNDupp
	Jsxd4xbzQuS/N+/X1zH+Lgy2m86GZDTm3F+qpxYm1rJ0OcPMnpeVM9h9b6jNnm97uHnj+2wm
	Ey3OQzHrV60tzvl1wO285cZuP407miovlViKMxINtZiLihMB9UdXMWECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsXCNUNWR9e5UibDYNpKMYs569ewWTw50M5o
	8eT/b1aLz89eM1vsuwgUOzz3JKvFwrYlLBaXd81hs7i35j+rxeGvb5gcuDw2repk89j0aRK7
	x4kZv1k8XmyeyeixuG8yq8e5ixUe3257eCx+8YHJ4/MmuQDOKC6blNSczLLUIn27BK6MB30/
	mArWalY8bZjL2sC4Q66LkZNDQsBE4tC19+wgNpuAhsTBQyeZQWwRAUWJc48vsnYxcnEwC7Qx
	SSy78JwJJCEsECXRt+gnK4jNIqAqcePiHrA4r4CZxIKutewQQzUlGi7dA4pzcHAKGEtMnqIC
	EhYS4JF4tWE/I0S5oMTJmU9YQGxmAXmJ5q2zmScw8sxCkpqFJLWAkWkVo0hmXlluYmaOqV5x
	dkZlXmaFXnJ+7iZGYKguq/0zcQfjl8vuhxgFOBiVeHgdvKUzhFgTy4orcw8xSnAwK4nwFjUC
	hXhTEiurUovy44tKc1KLDzFKc7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhjL7nPqNjyb
	GBV4+N9Ck4Nbp3X8/dBpbCloteGB/9SjJaUqnpc52rPXP8m8Onm25Lv86AX2AZs29q3bJvNU
	SP4fO3eXqMq5xIj8KXGpOWo5FdeudG1fVjNv22FpPZNZl6QOLbvtvYU/fI/V40l7kw1Wun09
	W3/9fJHT05aZLhWMvkl/WiY37LdSYinOSDTUYi4qTgQAEPHsl1ECAAA=
X-CFilter-Loop: Reflected

Hi Seongjae, I'm sorry for the delayed response due to the holidays.

On Fri,  2 May 2025 08:49:49 -0700 SeongJae Park <sj@kernel.org> wrote:
> Hi Yunjeong,
> 
> On Fri,  2 May 2025 16:38:48 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> 
> > Hi SeongJae, thanks for your helpful auto-tuning patchset, which optimizes 
> > the ease of used of DAMON on tiered memory systems. I have tested demotion
> > mechanism with a microbenchmark and would like to share the result.
> 
> Thank you for sharing your test result!
> 
> [...]
> > Hardware. 
> > - Node 0: 512GB DRAM
> > - Node 1: 0GB (memoryless)
> > - Node 2: 96GB CXL memory
> > 
> > Kernel
> > - RFC patchset on top of v6.14-rc7 
> > https://lore.kernel.org/damon/20250320053937.57734-1-sj@kernel.org/
> > 
> > Workload
> > - Microbenchmark creates hot and cold regions based on the specified parameters.
> >   $ ./hot_cold 1g 100g
> > It repetitively performs memset on a 1GB hot region, but only performs memset
> > once on a 100GB cold region. 
> > 
> > DAMON setup
> > - My intention is to demote most of all regions of cold memory from node 0 to 
> > node 2. So, damo start with below yaml configuration:
> > ...
> > # damo v2.7.2 from https://git.kernel.org/pub/scm/linux/kernel/git/sj/damo.git/
> >    schemes:
> >    - action: migrate_cold
> >       target_nid: 2
> > ...
> >       apply_interval_us: 0
> >       quotas:
> >         time_ms: 0 s
> >         sz_bytes: 0 GiB
> >         reset_interval_ms: 6 s
> >         goals:
> >         - metric: node_mem_free_bp 
> >           target_value: 99%
> >           nid: 0
> >           current_value: 1
> >         effective_sz_bytes: 0 B
> > ...
> 
> Sharing DAMON parameters you used can be helpful, thank you!  Can you further
> share full parameters?  I'm especially interested in how the parameters for
> monitoring targets and migrate_cold scheme's target access pattern, and if
> there are other DAMON contexts or DAMOS schemes running together.
> 

Actually, I realized that the 'regions' field in my YAML configuration is 
incorrect. I've been using a configuration file that was create on another 
server, not the testing server. As a result, the scheme is applied to wrong
region, causing the results to appear confusing. I've  fixed the issue and
confirmed that the demotion occured successfully. I'm sorry for any confusion
this may have caused.

After fixing it up, Honggyu and I tested this patch again. I would like to
share two issues: 1) slow start of action, 2) action does not stop even when 
target is acheived. Below are the test configurations:

Hardware
- node 0: 64GB DRAM
- node 1: 0GB (memoryless)
- node 2: 96GB CXL memory

Kernel
- This patchset on top of v6.15-rc4

Workload: microbenchmark that `mmap` and `memset` once for size GB
$ ./mmap 50

DAMON setup: just one contexts and schemes.
    ...
    schemes:
    - action: migrate_cold
      target_nid: 2
      access_pattern:
        sz_bytes:
          min: 4.000 KiB
          max: max
        nr_accesses:
          min: 0 %
          max: 0 %
        age:
          min: 10 s
          max: max
      apply_interval_us: 0
      quotas:
        time_ms: 0 s
        sz_bytes: 0 GiB
        reset_interval_ms: 20 s
        goals:
        - metric: node_mem_free_bp
          target_value: 50%
          nid: 0
          current_value: 1
     ...

Two issues mentioned above are both caused by the calculation logic of 
`quota->esz`, which grows too slowly and increases gradually.

Slow start: 50GB of data is allocated on node 0, and the demotion first occurs
after about 15 minutes. This is because `quota->esz` is growing slowly even
when the `current` is lower than the `target`. 

Not stop: the `target` is to maintain 50% free space on node 0, which we expect
to be about 32GB. However, it demoted more than intended, maintaing about 90%
free space as follows:

  Per-node process memory usage (in MBs)
  PID           Node 0 Node 1 Node 2 Total
  ------------  ------ ------ ------ -----
  1182 (watch)       2      0      0     2
  1198 (mmap)     7015      0  44187 51201
  ------------  ------ ------ ------ -----
  Total           7017      0  44187 51204

This is becuase the `esz` decreased slowly after acheiving the `target`.
In the end, the demotion occured more excessively than intended.

We believe that the defference between `target` and `current` increases, the
`esz` should be raised more rapidly to increase the aggressiveness of action.
In the current implementation, the `esz` remains low even when the `current` is
below the `target`, leading to a slow start issue. Also, there is a not-stop
issue where high `esz` persist (decreasing slowly) even when an over_achieved
state. 

> 
> Yes, as you intrpret, seems the auto-tuning is working as designed, but
> migration is not successfully happened.  I'm curious if migration is tried but
> failed.  DAMOS stats[1] may let us know that.  Can you check and share those?
> 

Thank you for providing the DAMOS stats information. I will use it when
analyzing with DAMON. I would appreciate any feedback you might have on the new
results.

Best Regards,
Yunjeong

[..snip..]
