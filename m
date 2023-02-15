Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963996109
	for <damon@lists.linux.dev>; Wed, 15 Feb 2023 15:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7O/CtBBPkdDhkIEeL0V0v4LD7N06poGA5q+c+AakFcc=; b=rczzgNYdlPXgCEQdETnrU6Ozg6
	L6yUQ9uF+/bH9BQwN2r450aDfHyyn9lQrbsH2MOdB1ogqJwqZ/QFp5qwCgymAVO5Eee0PwKED1DBu
	HJcrLfox+FTvNIBX6S/7yC+XSf+tXQvtOW+nN/7CI/yMuRINSWFosqtCjJCU3nZxjm2CJxeJ/U6Tw
	h8Zxl50dRjjPnQrEeOXSLYDgM8cehU/AL1DJiH9BZJun+0hqxQhjUbL4gOjgwLg/B+pj4ehal94D3
	1ZHdcYnOiZc7X0YbcXH85C9Gf3259V0BY2uSUswvyDddtcFyQqOQv78EQf6wDlWwxGirygQItZnHF
	C6zPg+LA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSJxG-007aPM-Oh; Wed, 15 Feb 2023 15:44:22 +0000
Date: Wed, 15 Feb 2023 15:44:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, sj@kernel.org,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeelb@google.com, muchun.song@linux.dev, naoya.horiguchi@nec.com,
	linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
	mike.kravetz@oracle.com, damon@lists.linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mm: change to return bool for
 isolate_movable_page()
Message-ID: <Y+z91pcxAuygc92J@casper.infradead.org>
References: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
 <cb877f73f4fff8d309611082ec740a7065b1ade0.1676424378.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb877f73f4fff8d309611082ec740a7065b1ade0.1676424378.git.baolin.wang@linux.alibaba.com>

On Wed, Feb 15, 2023 at 06:39:37PM +0800, Baolin Wang wrote:
> Now the isolate_movable_page() can only return 0 or -EBUSY, and no users
> will care about the negative return value, thus we can convert the
> isolate_movable_page() to return a boolean value to make the code more
> clear when checking the movable page isolation state.
> 
> No functional changes intended.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

A couple of nits below, not worth respinning the patch series for:

> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index c88b96b48be7..6b252f519c86 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -71,7 +71,7 @@ extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
>  		unsigned long private, enum migrate_mode mode, int reason,
>  		unsigned int *ret_succeeded);
>  extern struct page *alloc_migration_target(struct page *page, unsigned long private);
> -extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
> +extern bool isolate_movable_page(struct page *page, isolate_mode_t mode);

You can drop the 'extern' here.

> +++ b/mm/memory_hotplug.c
> @@ -1668,18 +1668,18 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  		 * We can skip free pages. And we can deal with pages on
>  		 * LRU and non-lru movable pages.
>  		 */
> -		if (PageLRU(page)) {
> +		if (PageLRU(page))
>  			isolated = isolate_lru_page(page);
> -			ret = isolated ? 0 : -EBUSY;
> -		} else
> -			ret = isolate_movable_page(page, ISOLATE_UNEVICTABLE);
> -		if (!ret) { /* Success */
> +		else
> +			isolated = isolate_movable_page(page, ISOLATE_UNEVICTABLE);
> +		if (isolated) { /* Success */

I would have dropped the "/* Success */" here.  Before, commenting
"!ret" is quite sensible, but "isolated" seems obviously success to me.


Thanks for doing all this.
