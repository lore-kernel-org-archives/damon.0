Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F79BA21;
	Thu, 26 Mar 2026 00:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774485324; cv=none; b=tMRRpYt/i/IWg5sDUYo4JqjFm6+KBY+ZJ/D3bfI17Q+UYI782vf4FlF45SOsYnetrB+wAEMFBqVtrFSekFhgmlhUi8xaWTcjwjuY/v3nN/b/82KZYgX6iVuCq/GyqctRniTnDhnYhMaP9mOY+4UjbiRx/eIzZlg9ljP3qOXKXQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774485324; c=relaxed/simple;
	bh=JgRgmv19Ob1z5FWl2YmQ9MrKOZCFSCB4WRvOcKg/+90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h54YvOOuq/7yZqMhTB+TMFST3SktXXXKvJGaCyTd5lC/3iMrAyMsVb77YH3vaYZJZufYo1lm0g9TAGL6PBQNpR8B2hQYjN+n4PsPrx3QfUyZgqMRgTvaCLaO8ZQKnb66yAEc9tTEfCuKIo2m62KDqjNxMgcLHRcZzzhtKelPTdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLnwvxPg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLnwvxPg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE76AC4CEF7;
	Thu, 26 Mar 2026 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774485324;
	bh=JgRgmv19Ob1z5FWl2YmQ9MrKOZCFSCB4WRvOcKg/+90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLnwvxPgM6IFQbMezL9MtZrDzM1hsTBXxvfaI+sjUez3ue0H+ua8UG77/uPyY1Uf+
	 iFRLS6lpqX2hRyDdvECbFSfCFbByNU3SAMqmzR493pyBhuR+RShpC0IGCSdiMW8LVE
	 xiYytcRiQBY//nE6dA9uJ1o9RowTcM8AA3/sUFWEFeSH/q3fzSQntxW7fBVEO+3Yec
	 g2pz0AiRXp5FHCkzoZ6nfOsFW+sYgwFAlxc9FQZ6j2r8r/iO/hTIrchcsWrN2jrfmW
	 qrs/UuCYcNs9xARygbuqWqVVGLbccGLhkZMQ/KpunO5UKhTqEPm6Fqg801C87yyQS5
	 HYeZ8qPSg6TvA==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/core: validate goal nid before accessing node data
Date: Wed, 25 Mar 2026 17:35:14 -0700
Message-ID: <20260326003515.77311-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325155221.202700-1-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 25 Mar 2026 15:52:21 +0000 Josh Law <objecting@objecting.org> wrote:

No rush, Josh.  As I mentioned before, please give about a day after the last
comment on the previous version of the patch, before posting a new version.
That could help giving enough time for others to add their important findings.

> damos_get_node_mem_bp() and damos_get_node_memcg_used_bp() pass
> goal->nid directly to si_meminfo_node() and NODE_DATA() without
> checking that it refers to a valid, online NUMA node.  Since

s/online/memory/ ?

> goal->nid is set from userspace via sysfs with no validation, a
> negative or out-of-range value causes an out-of-bounds access in
> NODE_DATA(), and a valid but offline node gives undefined results.
> 
> Add bounds and node_state(N_MEMORY) checks before using the nid,
> consistent with damon_migrate_pages().
> 
> Fixes: 0e1c773b501f ("mm/damon/core: introduce damos quota goal metrics for memory node utilization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---

As I also previously mentioned, please add changelog here.

>  mm/damon/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 59b709f04975..112125b635d7 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2227,6 +2227,10 @@ static __kernel_ulong_t damos_get_node_mem_bp(
>  	struct sysinfo i;
>  	__kernel_ulong_t numerator;
>  
> +	if (goal->nid < 0 || goal->nid >= MAX_NUMNODES ||
> +	    !node_state(goal->nid, N_MEMORY))
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
> +	    !node_state(goal->nid, N_MEMORY))
> +		return 0;
> +
>  	memcg = mem_cgroup_get_from_id(goal->memcg_id);
>  	if (!memcg) {
>  		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> -- 
> 2.34.1

I will add more comments as a reply to sashiko comment.


Thanks,
SJ

[...]
