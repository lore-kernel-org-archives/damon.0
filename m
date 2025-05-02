Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA884253341
	for <damon@lists.linux.dev>; Fri,  2 May 2025 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746171544; cv=none; b=EPbROr8YiPFQkuUwPLslDKXsii4/Bho1zFh7xiI5tVWN4XAZMsmmE1cW3Xoti3aWJNCicpLcV2hYVKMx317IDATObv8ZGEXf5gC9fLqhGiLfKT2Laqg6GuFCBmkfgpUsgVFksGpY596lrnVB0Xp5FHS7Neb/CMyhgpAqCh97c4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746171544; c=relaxed/simple;
	bh=3pBDy7MfZQMWmnIUBoKlhRRBMazmifBwlDpOHlp3bfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjbW0l1zznY5kns7gUTSY0OgwONpmTF2idE7Cj9s82g9MDB1tqrp9C3CEb9EQopALieYomX7ZerQ3cdPeSP1m15r5bM5nZ/XzLs1mumhkov3IKLcjIvZNhLKahbdld7SbC7Xu0y9zY5CvUv9Hz1f9YMd3N23pBaWpTsctvhR6jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-27-68147690cef5
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	kernel_team@skhynix.com
Subject: Re: [PATCH 0/7] mm/damon: auto-tune DAMOS for NUMA setups including tiered memory
Date: Fri,  2 May 2025 16:38:48 +0900
Message-ID: <20250502073854.1689-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250420194030.75838-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsXC9ZZnke7EMpEMgxsLWSzmrF/DZvHkQDuj
	xZP/v1kt9l0Eche2LWGxuLxrDpvFvTX/WS0Of33D5MDhsWlVJ5vHpk+T2D1OzPjN4vFi80xG
	j8V9k1k9zl2s8Pi8SS6APYrLJiU1J7MstUjfLoEro+HQM9aCVqmKyS862RoYLwp3MXJySAiY
	SDTcXsgEYx/onw5mswloSBw8dJIZxBYRUJQ49/giaxcjFwezwAdGid2dN9lBEsICURJ9i36y
	gtgsAqoSS45PAGrm4OAVMJdYs4AdYqamRMOle2AzOQWMJVp774DZQgI8Eq827GcEsXkFBCVO
	znzCAmIzC8hLNG+dzQyyS0JgA5tE84rXjBCDJCUOrrjBMoGRfxaSnllIehYwMq1iFMrMK8tN
	zMwx0cuozMus0EvOz93ECAzlZbV/oncwfroQfIhRgINRiYc3oEA4Q4g1say4MvcQowQHs5II
	b4wBUIg3JbGyKrUoP76oNCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVAPj3G+s
	qnd6d9+YF3SmdMcGj3u9Ltvj5q88891/zVQf6zbDTUxJaxtjn8oKrX3Vuefsh9MeM/wvhPpK
	cEicl/7OVnOi+MWhc1xPeePvL10d//zs7RxBfoW8jcUlPM88kkSfSPx6djhkAtP+ys+nAtxX
	TPHY59Vl5bPz+xYxoft/mtNLBffVM58zVWIpzkg01GIuKk4EAEF+ifRhAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsXCNUNWR3dCmUiGwYKPRhZz1q9hs3hyoJ3R
	4sn/36wW+y4CuYfnnmS1WNi2hMXi8q45bBb31vxntTj89Q2TA6fHplWdbB6bPk1i9zgx4zeL
	x4vNMxk9FvdNZvU4d7HCY/GLD0wenzfJBXBEcdmkpOZklqUW6dslcGU0HHrGWtAqVTH5RSdb
	A+NF4S5GTg4JAROJA/3TmUBsNgENiYOHTjKD2CICihLnHl9k7WLk4mAW+MAosbvzJjtIQlgg
	SqJv0U9WEJtFQFViyfEJQM0cHLwC5hJrFrBDzNSUaLh0D2wmp4CxRGvvHTBbSIBH4tWG/Ywg
	Nq+AoMTJmU9YQGxmAXmJ5q2zmScw8sxCkpqFJLWAkWkVo0hmXlluYmaOqV5xdkZlXmaFXnJ+
	7iZGYGAuq/0zcQfjl8vuhxgFOBiVeHgDCoQzhFgTy4orcw8xSnAwK4nwxhgAhXhTEiurUovy
	44tKc1KLDzFKc7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhhrU/dectgwlVte975ES2tr
	Zf0Te+M2y0dqdobstloZ1w6cVZlu53D90L7lNrP2LrWqUS5lPSKr4PFc7dANpmPihhsNfnTY
	N527ofLi+4ReTbcE5vuF3014G84ud4zxz/n49IX0gwu8J+4ulMyJtpD6MtXmxOIEZdO0n4fy
	Zqy3rO47f0DGQ1+JpTgj0VCLuag4EQDjrI1SSAIAAA==
X-CFilter-Loop: Reflected

Hi SeongJae, thanks for your helpful auto-tuning patchset, which optimizes 
the ease of used of DAMON on tiered memory systems. I have tested demotion
mechanism with a microbenchmark and would like to share the result.

On Sun, 20 Apr 2025 12:40:23 -0700 SeongJae Park <sj@kernel.org> wrote:
[..snip..]

> Utilizing DAMON for memory tiering usually requires manual tuning and/ 
> Evaluation Limitations
> ----------------------
> 
> As mentioned above, this evaluation shows only comparison of promotion
> mechanisms.  DAMON-based tiering is recommended to be used together with
> reclaim-based demotion as a faster backup under significant memory
> pressure, though.
> 
> >From some perspective, the modified version of Taobench may seems making
> the picture distorted too much.  It would be better to evaluate with
> more realistic workload, or more finely tuned micro benchmarks.
> 

Hardware. 
- Node 0: 512GB DRAM
- Node 1: 0GB (memoryless)
- Node 2: 96GB CXL memory

Kernel
- RFC patchset on top of v6.14-rc7 
https://lore.kernel.org/damon/20250320053937.57734-1-sj@kernel.org/

Workload
- Microbenchmark creates hot and cold regions based on the specified parameters.
  $ ./hot_cold 1g 100g
It repetitively performs memset on a 1GB hot region, but only performs memset
once on a 100GB cold region. 

DAMON setup
- My intention is to demote most of all regions of cold memory from node 0 to 
node 2. So, damo start with below yaml configuration:
...
# damo v2.7.2 from https://git.kernel.org/pub/scm/linux/kernel/git/sj/damo.git/
   schemes:
   - action: migrate_cold
      target_nid: 2
...
      apply_interval_us: 0
      quotas:
        time_ms: 0 s
        sz_bytes: 0 GiB
        reset_interval_ms: 6 s
        goals:
        - metric: node_mem_free_bp 
          target_value: 99%
          nid: 0
          current_value: 1
        effective_sz_bytes: 0 B
...

Results
I've run the hot_cold benchmark for approximately 2 days, and have monitored 
the memory usage of each node as follows:

$ numastat -c -p hot_cold
Per-node process memory usage (in MBs)
PID              Node 0 Node 1 Node 2 Node 3  Total
---------------  ------ ------ ------ ------ ------
2689746 (watch)       2      0      0      1      3
2690067 (hot_col 100122      0   3303      0 103426
3770656 (watch)       0      0      0      1      1
3770657 (sh)          2      0      0      0      2
---------------  ------ ------ ------ ------ ------
Total            100127      0   3303      1 103432

I expected that most of cold data from node 0 would be demoted to node 2, but it isn't.
In this situation, DAMON's variables are displayed as follows:

[2067202.863431] totalram 131938449 free 84504526 used 47433923 numerator 84504526
[2067202.863446] goal->current_value: 6404
[2067202.863452] score: 6468
[2067202.863455] quota->esz: 1844674407370955

`score` 6468 means the goal hasn't been achieved yet, and the `quota->esz`, 
which specifies the aggressiveness of the  demotion action, has reached 
ULONG_MAX. However, the demotion has not occured.

[..snip..]

I think there may be some errors or misunderstanding in my experiment.
I would be grateful for any insights or feedback you might have regarding these
results.

Best Regards,
Yunjeong

