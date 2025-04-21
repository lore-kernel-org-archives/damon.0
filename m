Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C947D3F4
	for <damon@lists.linux.dev>; Mon, 21 Apr 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745254529; cv=none; b=AVNvPNKTOSd9rolB8Ei44KP9vriYDx48fk1gFYmuSFZkvPQxURF0AN4Bwj7zSNe0I/L5HMOOJZ3Cz2Ae1QugkfQg5oG0M7opheT/Z9TbyNaHLWrrvJ73D6/yIJbGvvkeiDYPRD7r7S3iZnbaHhGaVzMcxVWQnPEXO8ipBkdm4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745254529; c=relaxed/simple;
	bh=vCD0XJPVvTQ7ClTvp5r9Reuax/fl3ozWdPhgvSVXChU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UL31D2wYsXzT14rWDBDE3+QRM6NhGFMG1wPAoVztQVyydZfUqqiJN1Tr84+kutOmr6Nju+T4Ou9ED37KtBaCeGSJqt1rIwSMWitnSdcX86XBxBCEmiqWalkPWmBBqqEq1Kd4/lUuClmNilDZO+GEtEQAXVR5pMAqRB3xaiXJiRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjOSRuou; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjOSRuou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB46C4CEE4;
	Mon, 21 Apr 2025 16:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745254528;
	bh=vCD0XJPVvTQ7ClTvp5r9Reuax/fl3ozWdPhgvSVXChU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjOSRuouuzmwWgiGU8sqfl/PplfBlOdCRkzBjjNh0eOPnkuzELNP+l5eHcpDc7aEF
	 3sHrzCQ00Xhc4ycI/E9jkjYmGvmd72NbV9elTjzVFQxDOT60NU93ZXk2farHeElDwk
	 ZACcCY19ZhALgsHYzwbushwbCoyOAwtX3p+VbgI7gQy5RcOlTw6Xlc8+/juf8SZOAN
	 gShmK2pfq0Rm0DTof3b1N1xwiPvrKu6yrxx9RaKB7sJ/nXzoPwjFTNQklwWndG8qLX
	 LqwRAgOeLH387gkg843zETlDgyVUyO0xeATgLoCW4NqS354XH2fGYiPQmbNcCDtV0x
	 mk6HWJjqCbqsQ==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: Initialize sampling_addr in damon_new_region()
Date: Mon, 21 Apr 2025 09:55:25 -0700
Message-Id: <20250421165526.8517-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250421033919.404013-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Apr 2025 11:39:19 +0800 Enze Li <lienze@kylinos.cn> wrote:

> Since sampling_addr is used across vaddr and paddr modules, initialize
> it in damon_new_region().
> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> ---
>  mm/damon/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index f0c1676f0599..d197a5e3901c 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -128,6 +128,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
>  
>  	region->ar.start = start;
>  	region->ar.end = end;
> +	region->sampling_addr = 0;
>  	region->nr_accesses = 0;
>  	region->nr_accesses_bp = 0;
>  	INIT_LIST_HEAD(&region->list);

I unfortunately cannot find why this is required.  Is there a use case that
reads uninitialized sampling_addr or any problem that comes from the fact that
damon_new_regions() is not initializing the field?

Only operations set implementations write and read damon_region->sampling_addr,
so I was thinking not initializing the field on the core layer is no problem.
I will be happy to be corrected if I'm missing something.


Thanks,
SJ

> 
> base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
> -- 
> 2.43.0
