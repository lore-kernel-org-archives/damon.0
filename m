Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD52571DF;
	Fri,  2 May 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746200991; cv=none; b=OTeEfGDmJyxjVvKVutY/2k5hiOAZg1a/oLkrGfFKNyK+Ssjz/spvoe78NThUvv6haYdGB+t66Ff+UuQXStz8ZYLxcqznFABsZ6vo7R+o1o0TGTxVnKdn8PWZVFQ06tVDnw0bKCBOV0Sc4damww8R+EUL2SILuROQwDccjDXiY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746200991; c=relaxed/simple;
	bh=nugAQl8X0Xn9dvegWvqV8CZq9+e3Xlp7ZHKgXTkmWsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FM0Cjp/x/N3Qdlao9PVQYlfcGHC45PFmGHsaYvqtB0gIaNzlwjqoqH7cq2HDc6Vf9aPD5/XvK8qKfgPhJ3AJUkN/2pxh5NU1PrsHP1BQ9dtccv5bgKbZmmJ/WGLxfAgdgLFku5kdfNGdF5HqVQ43PbbOlvMD3L5HmoMSDLiDw7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttOezoYp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttOezoYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26B6C4CEE4;
	Fri,  2 May 2025 15:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746200991;
	bh=nugAQl8X0Xn9dvegWvqV8CZq9+e3Xlp7ZHKgXTkmWsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ttOezoYpok+M3jGb5KMaW4nGBcY6w9V1odxe2yjfyWX6lGSJqh6PHecDmhccDj8da
	 mBu3w4TK+Idjia3I7rTiffLbPqHbw0NfrxIzxF6wYGVVOUGAPrJ18ZPknNF8nMBEN1
	 PEtCAESVT+27kXrGzK8f564beQlx22GSODwQqcln1Bs7AVYpakQUwGzUrGTmRwdq0P
	 UAeoAmOeVzH3q2U3CTVRK3g4NWYz0W1CDqBWO+VKiI0OxlBtq/ycQzHqZ16ab4ral/
	 n+h8msiCMn71MjdzwUf4c3Dnu/7nF+LrTIgWUa+qE3xG1dDZS80BQoPQB1T7Q3Qk58
	 oyO2IawvzQIKA==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	kernel_team@skhynix.com
Subject: Re: [PATCH 0/7] mm/damon: auto-tune DAMOS for NUMA setups including tiered memory
Date: Fri,  2 May 2025 08:49:49 -0700
Message-Id: <20250502154949.50992-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250502073854.1689-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yunjeong,

On Fri,  2 May 2025 16:38:48 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> Hi SeongJae, thanks for your helpful auto-tuning patchset, which optimizes 
> the ease of used of DAMON on tiered memory systems. I have tested demotion
> mechanism with a microbenchmark and would like to share the result.

Thank you for sharing your test result!

[...]
> Hardware. 
> - Node 0: 512GB DRAM
> - Node 1: 0GB (memoryless)
> - Node 2: 96GB CXL memory
> 
> Kernel
> - RFC patchset on top of v6.14-rc7 
> https://lore.kernel.org/damon/20250320053937.57734-1-sj@kernel.org/
> 
> Workload
> - Microbenchmark creates hot and cold regions based on the specified parameters.
>   $ ./hot_cold 1g 100g
> It repetitively performs memset on a 1GB hot region, but only performs memset
> once on a 100GB cold region. 
> 
> DAMON setup
> - My intention is to demote most of all regions of cold memory from node 0 to 
> node 2. So, damo start with below yaml configuration:
> ...
> # damo v2.7.2 from https://git.kernel.org/pub/scm/linux/kernel/git/sj/damo.git/
>    schemes:
>    - action: migrate_cold
>       target_nid: 2
> ...
>       apply_interval_us: 0
>       quotas:
>         time_ms: 0 s
>         sz_bytes: 0 GiB
>         reset_interval_ms: 6 s
>         goals:
>         - metric: node_mem_free_bp 
>           target_value: 99%
>           nid: 0
>           current_value: 1
>         effective_sz_bytes: 0 B
> ...

Sharing DAMON parameters you used can be helpful, thank you!  Can you further
share full parameters?  I'm especially interested in how the parameters for
monitoring targets and migrate_cold scheme's target access pattern, and if
there are other DAMON contexts or DAMOS schemes running together.

> 
> Results
> I've run the hot_cold benchmark for approximately 2 days, and have monitored 
> the memory usage of each node as follows:
> 
> $ numastat -c -p hot_cold
> Per-node process memory usage (in MBs)
> PID              Node 0 Node 1 Node 2 Node 3  Total
> ---------------  ------ ------ ------ ------ ------
> 2689746 (watch)       2      0      0      1      3
> 2690067 (hot_col 100122      0   3303      0 103426
> 3770656 (watch)       0      0      0      1      1
> 3770657 (sh)          2      0      0      0      2
> ---------------  ------ ------ ------ ------ ------
> Total            100127      0   3303      1 103432
> 
> I expected that most of cold data from node 0 would be demoted to node 2, but it isn't.
> In this situation, DAMON's variables are displayed as follows:
> 
> [2067202.863431] totalram 131938449 free 84504526 used 47433923 numerator 84504526
> [2067202.863446] goal->current_value: 6404
> [2067202.863452] score: 6468
> [2067202.863455] quota->esz: 1844674407370955
> 
> `score` 6468 means the goal hasn't been achieved yet, and the `quota->esz`, 
> which specifies the aggressiveness of the  demotion action, has reached 
> ULONG_MAX. However, the demotion has not occured.

Yes, as you intrpret, seems the auto-tuning is working as designed, but
migration is not successfully happened.  I'm curious if migration is tried but
failed.  DAMOS stats[1] may let us know that.  Can you check and share those?

> 
> [..snip..]
> 
> I think there may be some errors or misunderstanding in my experiment.
> I would be grateful for any insights or feedback you might have regarding these
> results.

I don't have clear idea at the moment, sorry.  It would be helpful if you could
share things I asked above.

Also, it seems you suspect the auto-tuning as one of root causes.  I'm curious
if you tried some different tests (e.g., same one without auto-tuning) and it
gave you some theories.  If so, could you please share those?

[1] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#statistics


Thanks,
SJ

[...]
