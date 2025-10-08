Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3103427B33B;
	Wed,  8 Oct 2025 00:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881619; cv=none; b=OR/CuS7wg7RqWpYgg66ktlb22aZ3I1so8wUa286zNhIwFQgUBk8mS9EO7oLwc8yoySjBbNuxBKsWb5DSuVOjia0HSBg5HiNQdWzXx3qz/PQuQPGmxkVaZo8wm9cNB3BvvAwXG/93EYOgSUeEqkpMjqvk/Ao2DsR++u+rJ84hwe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881619; c=relaxed/simple;
	bh=XJBMwUPakCIENOJ5JGM6h6npOfSqG5BKOSRQWEqhaWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FaSbZink7KPqz1tYQZnUDlG1DN3nAFLCmG5fJ4+fLv1Y7LjdKdkGDUgn8ar2WwEXJbRFf21bkUgdcN2K49chGeX9bZIcY9c1hZrDH8LJ8HwaDO7iTNAY7iwlzhi2ol8pdcvRKCcOELzsDbOa/MdcVXILx/0gUyqxw13rOz7fqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkT/Y1g8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkT/Y1g8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7425BC4CEF1;
	Wed,  8 Oct 2025 00:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759881618;
	bh=XJBMwUPakCIENOJ5JGM6h6npOfSqG5BKOSRQWEqhaWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LkT/Y1g8sW+oeGcLJAYTuRKgha8oR+0vHhIYAkMnM/ilfxGTXWXxZ5EM23ntytBIz
	 vGe6WnBWm3S209VzN6FRC7thPPFPe6NsFMSmj8rF6dPa8xDX/pilKIa1WnoGBzHHfv
	 5Xw42YfvsCJkTLQvVhJeXM6cRl8j3ippxyUdrXkoCjt8TG+CWL42VX8ZnHBmb0Ue9u
	 qCQcTqRLI3gavlc4WWgcUdFMRjzNdHjxi+cyNb78GpNTPoBoE9eCYgF5aJ2wVZmeMB
	 7St8oTWhkrLjLh2n4ohruEHP2soTgKccT3fMOOzHMNH5KfHuSpRogI4ssf2n9GcG/z
	 rmOW68YW8kreA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 03/11] mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_USED_BP
Date: Tue,  7 Oct 2025 17:00:14 -0700
Message-Id: <20251008000014.2845-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250619220023.24023-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Jun 2025 15:00:15 -0700 SeongJae Park <sj@kernel.org> wrote:

> Implement the behavior of DAMOS_QUOTA_NODE_MEMCG_USED_BP.  It uses sum
> of active/inactive anon/file pages of a given cgroup on a given NUMA
> node as the value of the metric.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index d675dd932a23..1481b43f2710 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[...]
> +static unsigned long damos_get_node_memcg_used_bp(
> +		struct damos_quota_goal *goal)
> +{
> +	struct mem_cgroup *memcg;
> +	struct lruvec *lruvec;
> +	unsigned long used_pages;
> +	struct sysinfo i;
> +
> +	rcu_read_lock();
> +	memcg = mem_cgroup_from_id(goal->memcg_id);
> +	mem_cgroup_flush_stats(memcg);
> +	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(goal->nid));
> +	used_pages = lruvec_page_state(lruvec, NR_ACTIVE_ANON);
> +	used_pages += lruvec_page_state(lruvec, NR_INACTIVE_ANON);
> +	used_pages += lruvec_page_state(lruvec, NR_ACTIVE_FILE);
> +	used_pages += lruvec_page_state(lruvec, NR_INACTIVE_FILE);
> +	rcu_read_unlock();

mem_cgroup_flush_stats() calls css_rstat_flush() which may block.  But the
above diff is putting it inside an RCU read-side critical section.  Actually
only mem_cgroup_from_id() needs to be called inside an RCU read-side critical
section.  I will revise the next version to call rcu_read_unlock() right after
mem_cgroup_from_id().

Also, mem_cgroup_from_id() could return NULL if the memcg is removeed while
DAMON is running, but this diff is not checking the NULL return case.  I will
add the handling in the next version.

> +
> +	si_meminfo_node(&i, goal->nid);
> +	return used_pages * PAGE_SIZE * 10000 / i.totalram;

i.totalram is in number of pages unit, but the above code is assuming it is in
bytes unit.  This makes the result significantly wrong.  I will fix this in the
next version.


Thanks,
SJ

[...]
