Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3185F296BC1
	for <damon@lists.linux.dev>; Thu, 29 Jan 2026 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703037; cv=none; b=eMmatQZQrcg5jWIt0lR9RN157ufuAx0KBtkjpKV364nranDSDgkEE16Z+982aYMHqGct1my5Q2zsG0t8467F2J5mgBLhy7JIlD1xF2/mdP/jUiQP26N1I1wHVu3yKkZmP0euVmY6CENXTHzVEs5hGUMFgL0mf3zVbvKphxLjink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703037; c=relaxed/simple;
	bh=7qUXCNz5uw4XhHflyWVkqQxP0L7Oakns3jaa0oz4FYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWhEDlY8OJcBgru6D2R7yxvv6z/BNeD2CjdbI7w5NpPfVrcZzenNAjZVsMTC0RzwnkBShmu9KC7liLSB48XL0MehDx6cftgp0XEspMhYmWHNAKZiiaUa0QdP+8DT2tJ9R9Su/6RcSRejtFgU0pr1wk73Kn2/2DYWpNPOH3uIE+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNZlHJMA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNZlHJMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924B4C4CEF7;
	Thu, 29 Jan 2026 16:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769703036;
	bh=7qUXCNz5uw4XhHflyWVkqQxP0L7Oakns3jaa0oz4FYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNZlHJMABc5rWCv62g5iBM+MpPrnRpom0IY3QzYKejxZmdThV4je8u0JIbodyIMcu
	 ypizCps2nk/cAm0nWn0xnYhEbYV55ic3UHkkm3y6w8q1syW+WITLFyNxC5gyeL7aJj
	 +WdBpPMf4NIOnhrdgfMk0D3rtX8tbPZNYX9siB+zrhdpLnB5/UiwCFCQRvnc1BB6ZQ
	 ExbqDWX46aFuE5B6UIYs9SiSq0XjEtl7Un+s+1coGEEt7T3lEGN/wIh6MUvATLyEZa
	 XeWmZCaPzj2kGgW4SQcKdFZMKUivHHacR2pSyks3lGBjz3U4GbFAVZFRbWGkQzWFKS
	 d+lvh7A6D4oqw==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH] mm/damon: unify address range representation with damon_addr_range
Date: Thu, 29 Jan 2026 08:10:28 -0800
Message-ID: <20260129161029.48991-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129100845.281734-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 29 Jan 2026 18:08:45 +0800 Enze Li <lienze@kylinos.cn> wrote:

> Currently, DAMON defines two identical structures for representing
> address ranges: damon_system_ram_region and damon_addr_range.  Both
> structures share the same semantic interpretation of a half-open
> interval [start, end), where the start address is inclusive and the end
> address is exclusive.

Nice finding!

> 
> This duplication adds unnecessary redundancy and increases maintenance
> overhead.  This patch replaces all uses of damon_system_ram_region with
> the more generic damon_addr_range structure, ensuring a unified type
> representation for address ranges within the DAMON subsystem.  The
> change simplifies the codebase, improves readability, and avoids
> potential inconsistencies in future modifications.

Actually, there is another bug that need to be fixed.  Nonetheless, that's
orthogonal to this patch, so it is not a blocker of this patch in my opinion.

> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  mm/damon/core.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 70efbf22a2b4..5e2724a4f285 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2856,20 +2856,9 @@ static int kdamond_fn(void *data)
>  	return 0;
>  }
>  
> -/*
> - * struct damon_system_ram_region - System RAM resource address region of
> - *				    [@start, @end).
> - * @start:	Start address of the region (inclusive).
> - * @end:	End address of the region (exclusive).
> - */
> -struct damon_system_ram_region {
> -	unsigned long start;
> -	unsigned long end;
> -};
> -
>  static int walk_system_ram(struct resource *res, void *arg)
>  {
> -	struct damon_system_ram_region *a = arg;
> +	struct damon_addr_range *a = arg;
>  
>  	if (a->end - a->start < resource_size(res)) {
>  		a->start = res->start;

The above line is storing 'resource_size_t' value to 'unsigned long' field.
That shouldn't be a problem on 64 bit environments.  With introduction of
damon_ctx->addr_unit [1], however, DAMON started supporting environments that
'unsigned long' is not enough to represent the whole physical address range,
such as 32 bit environments with large phyiscal address extension.  On such
environments, this could be a problem.

Nonetheless, this is orthogonal to this patch, as I mentioned above.  So it
shouldn't block this patch.  I will fix the problem unless someone steps up
faster than I.

[1] commit 09a616cbb371 ("mm/damon/core: add damon_ctx->addr_unit") 


Thanks,
SJ

[...]
