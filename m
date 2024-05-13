Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD0E14B097
	for <damon@lists.linux.dev>; Mon, 13 May 2024 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601845; cv=none; b=Q7kKeGVNWKkHd16OaOfljWmpgSxks0PFVnVeV9QQjqOcwReN35s/xw3jiTV1GJCGjP07ushO7tjqsXjtiQafO6xOncC/KQVpCZ6EGHaKKMnNOLlLUOgHSJLnlmflsGWnxWEa6FKgCOGAcknTsztWvFUq3cRQ2bTLB+bipduPLo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601845; c=relaxed/simple;
	bh=j3t1zFeNKBQd0gUy4VHB63/qi8W1BPNaXQPiQyTHiCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyRA9FgDjz9/WlfUIHRo3BcBosgf6xnvSyHvjVYTTJsWTa3oG75I4DpMoY7abTeDFMFWKjuocyLXUOfrst1i8+rUPltMtOFRILfDz1uLJ3tPgJfXv3IgK3zvlMfnzghbNPlGSn+abRrBeLGGCaoKvuQ+kCqrVDGjEvYZwl5exeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-8a-664201b00e92
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: Honggyu Kim <honggyu.kim@sk.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com
Subject: Re: [RFC PATCH v4 1/5] mm: make alloc_demote_folio externally invokable for migration
Date: Mon, 13 May 2024 21:03:56 +0900
Message-ID: <20240513120358.1503-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240512175447.75943-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsXC9ZZnke4GRqc0g8M72CzmrF/DZvHk/29W
	i8u75rBZ3Fvzn9Xi8Nc3TA6sHptWdbJ5bPo0id3jxIzfLB4vNs9k9Pi8SS6ANYrLJiU1J7Ms
	tUjfLoErY+HsVSwFDfwV69ZOY2lgnM7TxcjJISFgInHt5Q4mGPvb+pssIDabgJrElZeTwOIi
	AooS5x5fZO1i5OJgFtjNKDG/7RozSEJYIE7i5+bbQA0cHCwCqhJ3nvOBhHkFzCSuXJ7NAjFT
	U+Lx9p/sIDangLHE/n8NYHEhAR6JVxv2M0LUC0qcnPkELM4sIC/RvHU2M8guCYE5bBL/Jn1h
	hRgkKXFwxQ2WCYz8s5D0zELSs4CRaRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZGYGguq/0TvYPx
	04XgQ4wCHIxKPLwHGJzShFgTy4orcw8xSnAwK4nwOhTapwnxpiRWVqUW5ccXleakFh9ilOZg
	URLnNfpWniIkkJ5YkpqdmlqQWgSTZeLglGpg9BTK+6/IKXm0e2NZYF7CinmXFDesFb3wMKnk
	6t4F567r77o8/3XYV9urdtNbVTr6FuZtjxL02VJ4PXl++doPfS4WlWv9vCTYfl1ZxBA1tXv+
	srf8X1bnJny4Gvv/T0ty4jITCelLBZNVXugbKAa8OJ7k7jDJpyZQ62ost+PqhC/T9tzpX7Rt
	kRJLcUaioRZzUXEiAMkNyg1JAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsXCNUNLT3c9o1Oawc6F5hZz1q9hs3jy/zer
	xednr5ktDs89yWpxedccNot7a/6zWhz++obJgd1j06pONo9Nnyaxe5yY8ZvF48XmmYwe3257
	eCx+8YHJ4/MmuQD2KC6blNSczLLUIn27BK6MhbNXsRQ08FesWzuNpYFxOk8XIyeHhICJxLf1
	N1lAbDYBNYkrLycxgdgiAooS5x5fZO1i5OJgFtjNKDG/7RozSEJYIE7i5+bbQA0cHCwCqhJ3
	nvOBhHkFzCSuXJ7NAjFTU+Lx9p/sIDangLHE/n8NYHEhAR6JVxv2M0LUC0qcnPkELM4sIC/R
	vHU28wRGnllIUrOQpBYwMq1iFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIDL1ltX8m7mD8ctn9
	EKMAB6MSD+8BBqc0IdbEsuLK3EOMEhzMSiK8DoX2aUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
	vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2MVq+2MvJMr45Y8iUslqf1IBO/3e9XXD1tphnnJSr4
	5X8msb1uOdYk5rX63Pm1/15tjN3K8efcurcv5UPCY5LXNWsdUFvmJerPwF1xkm1K/4mU13xb
	Csw22HM1fAv03FyV6XqRQenLxt2/D22Y9SOn0vhnzA37CXc0HddWMCT4LttycGbfRQMzJZbi
	jERDLeai4kQAfCLvwDkCAAA=
X-CFilter-Loop: Reflected

On Sun, 12 May 2024 10:54:43 -0700 SeongJae Park <sj@kernel.org> wrote:
> From: Honggyu Kim <honggyu.kim@sk.com>
> 
> The alloc_demote_folio can be used out of vmscan.c so it'd be better to
> remove static keyword from it.
> 
> This function can also be used for both demotion and promotion so it'd
> be better to rename it from alloc_demote_folio to alloc_migrate_folio.

This description doesn't match with the changes below.

> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/internal.h | 1 +
>  mm/vmscan.c   | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index b2c75b12014e..b3ca996a4efc 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1052,6 +1052,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
>          unsigned long, unsigned long);
>  
>  extern void set_pageblock_order(void);
> +struct folio *alloc_demote_folio(struct folio *src, unsigned long private);

I still prefer to rename it to alloc_migrate_folio.

>  unsigned long reclaim_pages(struct list_head *folio_list);
>  unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  					    struct list_head *folio_list);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 6981a71c8ef0..27269bc2bcc5 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -933,8 +933,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
>  		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
>  }
>  
> -static struct folio *alloc_demote_folio(struct folio *src,
> -		unsigned long private)
> +struct folio *alloc_demote_folio(struct folio *src, unsigned long private)

Here as well.

>  {
>  	struct folio *dst;
>  	nodemask_t *allowed_mask;
> -- 
> 2.39.2
> 

Thanks,
Honggyu
