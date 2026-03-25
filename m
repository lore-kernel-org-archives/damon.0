Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448EF2DCBF4;
	Wed, 25 Mar 2026 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449433; cv=none; b=Xz/NY60ucUWJF/u3/bDnozN4rZIrc3JLxKmCFIYttHBvnqJK5tnq8fC4LtcdYdblTgCI7KVu44qR1kOB3ccuuHKAJWewQocW0to6II+FqPtKJK0HBf3+mhHEIXgkgr5aLdX3ZgSrhcUbrHyXgv0DSqYaN/lz/Kppe+cal4ybPCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449433; c=relaxed/simple;
	bh=kzxr6iziOgx3cpwmvkHK71eb5tyyGmHmzoyABIfFnL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkNDCK6SYgPCe4Cq6YwTfeuL4eDXQ5OZndX/yHoJtsR48ag7bHcv9R1ok2Fc0ezQjpgvDzl9XwEjOo/lxFC+ng0HKyaBdVFED5GGGreFT1apANKMxIHGqkCXaU7pPUXU7ktVbC060XOWZixjVUOcqYRPeVZLIIdye7hrBDJAa1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYB0tzi9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYB0tzi9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E8DC19423;
	Wed, 25 Mar 2026 14:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774449432;
	bh=kzxr6iziOgx3cpwmvkHK71eb5tyyGmHmzoyABIfFnL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYB0tzi9A9EK0nHYa8snPTfbcS2M4dvd/Ebaes8OjbTE8Va/XhL6aWUGDlKKtyMc5
	 jf/N2QSDbliXmUy/uvlQ/VtHICjCcxMk7ON4IuZRuvNW2oq7Ai9m0wQFPiCNXxmMFH
	 PjwgaGdMrgYgaDVcyLyhd/ihWHECpfIhUN3XPuUSqc8Fj1d2PX2kASOqQ5DUrB9B9x
	 x/WDCdAmfsfDPV/inMhkqZ606+ml67MGvyq6wjTAMyqZ/cK+nCda6xSUObxA7jNgqV
	 AUDUrQDzKZpftNi7pEMhA2uXAYW5j1/zXF93MU3h6i2rOllPwnfvORg9Mlf3/3dSS1
	 9BEiH58rt0hcA==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: validate goal nid before accessing node data
Date: Wed, 25 Mar 2026 07:37:02 -0700
Message-ID: <20260325143703.87583-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325073034.140353-1-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 25 Mar 2026 07:30:34 +0000 Josh Law <objecting@objecting.org> wrote:

> damos_get_node_mem_bp() and damos_get_node_memcg_used_bp() pass
> goal->nid directly to si_meminfo_node() and NODE_DATA() without
> checking that it refers to a valid, online NUMA node.  Since
> goal->nid is set from userspace via sysfs with no validation, a
> negative or out-of-range value causes an out-of-bounds access in
> NODE_DATA(), and a valid but offline node gives undefined results.

Nice catch!

> 
> Add bounds and node_online() checks before using the nid.
> 
> Fixes: 0e1c773b501f ("mm/damon/core: introduce damos quota goal metrics for memory node utilization")

Let's add Cc: stable.

> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  mm/damon/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 59b709f04975..6ee421141996 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2227,6 +2227,10 @@ static __kernel_ulong_t damos_get_node_mem_bp(
>  	struct sysinfo i;
>  	__kernel_ulong_t numerator;
>  
> +	if (goal->nid < 0 || goal->nid >= MAX_NUMNODES ||
> +	    !node_online(goal->nid))

Like damon_migrate_pages(), how about using node_state(goal->nid, N_MEMORY)
insted of node_online()?

> +		return 0;
> +
>  	si_meminfo_node(&i, goal->nid);
>  	if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
>  		numerator = i.totalram - i.freeram;
> @@ -2243,6 +2247,10 @@ static unsigned long damos_get_node_memcg_used_bp(
>  	unsigned long used_pages, numerator;
>  	struct sysinfo i;
>  
> +	if (goal->nid < 0 || goal->nid >= MAX_NUMNODES ||
> +	    !node_online(goal->nid))

Ditto.

> +		return 0;
> +
>  	memcg = mem_cgroup_get_from_id(goal->memcg_id);
>  	if (!memcg) {
>  		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> -- 
> 2.34.1


Thanks,
SJ
