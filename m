Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729441CCB4B
	for <damon@lists.linux.dev>; Mon, 13 Jan 2025 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793796; cv=none; b=esBU+HkHiRakDuKKHPtxBRGeOceHhOXjWhEnOtPu5Urn4gLIcHa8R2tSqcVsRRGa75ugL97g1wH5qFJXi0bPLMvYnQSSnNCvvTO8FUt9TLHlzSqXaa8f+WstHgbuWFveaRwX/guvkHtvfx8E1szSUDBt8TRjsgWYENtXKcLAorQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793796; c=relaxed/simple;
	bh=uPw2sDECkRR33mE3fpDXv7rzwJQNurpTnfV4CbbdCg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MfrYjXk8zHhzg5PkAdZkoT+AaEF3yBjO040jDdCkTZO10fdA6GFu/b/UzFZPadvlbJQZbsEgk3Enb/QKFMdwJFAl2kVqZdBaGFVIx19Y2Ck53KnGDsBCmdv0scTDhbyLOOD3MBbZyQoSKRSuFOtNVjfwcc5YHqjzIwek1kYWrT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pslPNXFx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pslPNXFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BFAC4CED6;
	Mon, 13 Jan 2025 18:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793795;
	bh=uPw2sDECkRR33mE3fpDXv7rzwJQNurpTnfV4CbbdCg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pslPNXFxQWxCpVSFzpmuwnPaNvCYkxDBsQgesKVspmuqkAwKmfGzCanXIZU/7jPUw
	 kjQne8OFofSUdu4+F4H3+NpkiBtc7aPkcswT1JjfG3fA6dIT9HT2R5a/z+rR+PWYON
	 7Wvd3nNNDsHJQnE+XCYDWgprUIflHbuniWLUA885uqz1VDg6aRNsrR0z+FIclezITW
	 3NoOo6LaId1tzE2EM20dMNaNWXoJMeNYwD464HYm7LUPpf3n/aMoN8iZRJWHgWvOA6
	 EdeiDcEjCkvWdUhsHGBrwm3AHbwSXMY3sShKJpVX2yAZlDIuEWEdOKx0ylBIcuCWE8
	 twUYOtG5CKzkg==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: increment pa_stat damon address range by folio size
Date: Mon, 13 Jan 2025 10:43:11 -0800
Message-Id: <20250113184311.6572-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113180340.805474-1-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Usama,


Let's use "mm/damon/paddr: " prefix for the patch title, to be more consistent
with others.

On Mon, 13 Jan 2025 18:03:40 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> This is to take into account for folios with size > 1 page.
> Iterating at PAGE_SIZE increment would increment sz_filter_passed
> multiple times for the same folio by folio_size, providing incorrect
> stats.

damon_get_folio() returns NULL if the page is a tail page.  Hence I think it
will not increment sz_filter_passed multiple times?

> Hence go through the folio only once.

I tink this is still nice to do, for more efficiency.  Can you post v2 of this
patch after updating the commit message and addressing below comments?

> 
> Fixes: 6347f3385dd0 ("mm/damon/paddr: report filter-passed bytes back for DAMOS_STAT action")
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  mm/damon/paddr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 6b4397de4199..cc789a97c6f5 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -504,7 +504,8 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
>  	if (!damon_pa_scheme_has_filter(s))
>  		return 0;
>  
> -	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
> +	addr = r->ar.start;
> +	while (addr < r->ar.end) {
>  		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
>  
>  		if (!folio)

In this case, the code does "continue".  'addr' is not advanced, so it will
result in an infinite loop.  Let's do 'addr += PAGE_SIZE' here, to avoid that.

> @@ -515,6 +516,7 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
>  		else
>  			*sz_filter_passed += folio_size(folio);
>  put_folio:
> +		addr += folio_size(folio);
>  		folio_put(folio);
>  	}
>  	return 0;
> -- 
> 2.43.5


Thanks,
SJ
