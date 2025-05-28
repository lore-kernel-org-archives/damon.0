Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C721FF32;
	Wed, 28 May 2025 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748470186; cv=none; b=TT4uQYerMVmTrjFQIAIHaORxKbDSk26g/j4CFJbYyt7gL7v9S3YkBNtFyu4vj2r7Krlj0azS69YmvQbcJzYdD/GdTrS+6ZuNg7t5VN7ivt5r+aElg8WW4ptAX65yi69bxvgibG5op2gF4AwXUHGifF3MhKQGIzQy3CHw5fPJriU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748470186; c=relaxed/simple;
	bh=n46FXXFYxUar6By9Qp5cWormoFxrDOYWHPfPPSfPcHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KGjBJm4lMhqB/Cd0+vTfsi2JgdPG0sZQtk7V4RJ/h/9r5AYLRC+euC2iaQqfxTHhMXkIfwk6gXuaEPohhXFQ1aHcCB7wbZE9/q9llPINdiSDrmMAwoAsuI3sSVrOKXeo/GvhzJIzBcMduA8Xu+v9ldIg79qnmVmVT1U/ZxgMeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqzlQIMI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqzlQIMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC9DC4CEE3;
	Wed, 28 May 2025 22:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748470185;
	bh=n46FXXFYxUar6By9Qp5cWormoFxrDOYWHPfPPSfPcHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FqzlQIMIU5uJ6vkK3AJRW3tNLUxxwp34FMFZaZUVyD19bE09e4OAPqxqwgGhoYRuQ
	 HZYPmQEAWVfo63FgqJ+Bro1Jdj1onIt5Nvalp40bMq84vIWL0FOdvvlGpBNMvvz7Ov
	 GLVQNdi7NDY+deDfKiq6siu1smYYCALPUZACuQo07DxOX5zZyr1xvRnnkgnIQxNoz5
	 kHyrlIwR3wC96LVrFxTZ8usSCpTQnPqiVh7jN2fYeTtB+KuMGKZfObkzwlUT6Z9ifD
	 lsWD+kaybyFFzXdfdWeVylx0B7i78JDm6GaPDywMqs1Db4Z6CWKnAu0Bby4gs0HS76
	 xOpw0o9Di+SaQ==
From: SeongJae Park <sj@kernel.org>
To: wangchuanguo <wangchuanguo@inspur.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	Jagdish Gediya <jvgediya.oss@gmail.com>
Subject: Re: [PATCH 1/2] mm: migrate: restore the nmask after successfully allocating on the  target node
Date: Wed, 28 May 2025 15:09:42 -0700
Message-Id: <20250528220942.55350-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528111038.18378-2-wangchuanguo@inspur.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Jagdish, since seems the behavior that this patch tries to change is
apparently made by Jagdish's commit 320080272892 ("mm/demotion: demote pages
according to allocation fallback order").

On Wed, 28 May 2025 19:10:37 +0800 wangchuanguo <wangchuanguo@inspur.com> wrote:

> If memory is successfully allocated on the target node and the
> function directly returns without value restore for nmask,
> non-first migration operations in migrate_pages() by again label
> may ignore the nmask settings,

Nice finding!

> thereby allowing new memory
> allocations for migration on any node.

But, isn't the consequence of this behavior is the opposite?  That is, I think
this behavior restricts to use only the specified node (mtc->nid) in the case,
ignoring more allowed fallback nodes (mtc->nmask)?

Anyway, to me, this seems not an intended behavior but a bug.  Cc-ing Jagdish,
who authored the commit 320080272892 ("mm/demotion: demote pages according to
allocation fallback order"), which apparently made this behavior initially,
though, since I may misreading the original author's intention.

> 
> Signed-off-by: wangchuanguo <wangchuanguo@inspur.com>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f8dfd2864bbf..e13f17244279 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1035,11 +1035,11 @@ struct folio *alloc_migrate_folio(struct folio *src, unsigned long private)
>  	mtc->nmask = NULL;
>  	mtc->gfp_mask |= __GFP_THISNODE;
>  	dst = alloc_migration_target(src, (unsigned long)mtc);
> +	mtc->nmask = allowed_mask;
>  	if (dst)
>  		return dst;

Restoring ->nmask looks right behavior to me.  But, if so, shouldn't we also
restore ->gfp_mask?

>  
>  	mtc->gfp_mask &= ~__GFP_THISNODE;
> -	mtc->nmask = allowed_mask;
>  
>  	return alloc_migration_target(src, (unsigned long)mtc);
>  }
> -- 
> 2.39.3


Thanks,
SJ
