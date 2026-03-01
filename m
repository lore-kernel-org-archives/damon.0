Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8A430BB5;
	Sun,  1 Mar 2026 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772382826; cv=none; b=m2uW2YcbE/XxbMyPoJQQYEh4sok+m0rp5js9+QOYg+Jg0hCgDq4DWduqx9TtSohwyc2ASZ7S8T+oet2zHJtCbQhoNTFafeLm4ZNn3ZQv1fnvSQqe6F+UclP2DzQW+WWpzbfYlhKMi+Kc38/AWD37XsNjzQ09WyUfMv3MCA7Lp5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772382826; c=relaxed/simple;
	bh=mSj6jEZ06Ohm/vWYhM3VYr9y1jAdM9wKNerjpfHg+c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uebolQGHgZ8aDE/FtGbphRqjs+XuGjStKwve8lRGox8ans1/1yz9KLP7s7AkmKE7KLoh/Z5YLgw4RS/XaoxPo/n/PJnmwoM5WcofT9rN0nbCVqKQtS22bdyQ6XQR0k7vh7xx4oXonTl4ZLgDTk2p8PubCvPzdBtz1AaeTIb50OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoEMPbGX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoEMPbGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997E5C116C6;
	Sun,  1 Mar 2026 16:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772382826;
	bh=mSj6jEZ06Ohm/vWYhM3VYr9y1jAdM9wKNerjpfHg+c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YoEMPbGXEoKrvcD3G+BXlmmxRvenZp48x1mkjangqOwx1mx0QpYwv6Putkn81vFvv
	 2HQHsAL+YyxQDbR+dOrl0Gori1yGuVLoOelDno0SNrHGsTQi3lIwTTf+ZsZXa/l11i
	 esMLqHcS7FuqOXrvCEGPoVxyXqHwXnbCMzZTR1v0LfERXfMBKcZMm6Dc52rFMvD/G7
	 24she6UB40n0SRA0ZP32mjHQQ4Ci0Z4lHBHQfNUV0Ykpw359QtghnwyhVNgIRb2Rlo
	 hnGwZzXXOKtEsr3T9trA35r3RhSw6vslv6F3LAtsFULITsC8fOLNAbupM8oI2tkp1e
	 x0UvmXB3p0WDQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 02/10] mm/damon/core: add damon_new_region() debug_sanity check
Date: Sun,  1 Mar 2026 08:33:36 -0800
Message-ID: <20260301163337.92637-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221193629.19332-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Feb 2026 11:36:19 -0800 SeongJae Park <sj@kernel.org> wrote:

> damon_new_region() is supposed to be called with only valid address
> range arguments.  Do the check under DAMON_DEBUG_SANITY.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 602b85ef23597..a7f5748c1fe17 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -109,6 +109,22 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
>  	return err;
>  }
>  
> +#ifdef CONFIG_DAMON_DEBUG_SANITY
> +static void damon_verify_new_region(unsigned long start, unsigned long end)
> +{
> +

I'll remove the above unnecessary new line in the next spin.

> +	if (start < end)
> +		return;
> +	pr_err("damon_new_region() s called with start %lu >= end %lu!\n",
> +			start, end);
> +	WARN_ONCE();
> +}
> +#else
> +static void damon_verify_new_region(unsigned long start, unsigned long end)
> +{
> +}
> +#endif
> +
>  /*
>   * Construct a damon_region struct
>   *
> @@ -122,6 +138,8 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
>  	if (!region)
>  		return NULL;
>  
> +	damon_verify_new_region(start, end);
> +

The verification may better to be made before the above region allocation.
I'll move it to the beginning of this function in the next spin.

>  	region->ar.start = start;
>  	region->ar.end = end;
>  	region->nr_accesses = 0;
> -- 
> 2.47.3


Thanks,
SJ
