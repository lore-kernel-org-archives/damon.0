Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CF820E338;
	Fri, 18 Oct 2024 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729276395; cv=none; b=pr8AJOCw41Q1Sg6WwbF1k5QZPpwRhan8bkJ88MOjXhuZIBLo/HF7LFkuQGRrwey+1RW5gaTf3y2fhdt4QvUwurfXOzE0d48vDWGUoa45Ulti14wd/RSzd//H0vcAsWvnhmg3ZCTEDiEDCkZcDKLdBU/G0cZXILnDw4XBk16n/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729276395; c=relaxed/simple;
	bh=JTS7l00ywra+1THYcJZQsN2BffW5M/t8l3w1Xebv1OM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tGfpRr2WxPh60NL+Qa6xknT1CqeED5vXfQ7nhI13fmhnjCw1ExaLo5iJVfHhEh7dqySZciMUbCCNdwSHiAwyXsl1ngpo3Fygd8WZTtqeMeaJ+Tt6+4qhA/VsIQv7ySCzRM71NVIM9v5opV/mbGeCEKh5yTXe65daLHawjsYBKc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McAj2UUm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McAj2UUm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA92C4CEC3;
	Fri, 18 Oct 2024 18:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729276393;
	bh=JTS7l00ywra+1THYcJZQsN2BffW5M/t8l3w1Xebv1OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=McAj2UUmemN7Ro4awQUL87JqeBbXfmKjq2cM8Fwd7q1LREln2bEm3wx7q57aMals4
	 GxZhlCzr+MgJQQ90mW2t+ztjMqF9QqARyIhzrbpoIGsbN4kIG+BBCeallm2Db5QJRL
	 zmJmxFEddNqSjQcSpdiJKr4jhjE/d+1GZdPK818Vud4dIInqnGRM5k3xzgz3CAAzdp
	 MzEKZFo6JkFyDFwpoAJRIy5rZ+ytsNCIBXLajDmjvD3M5dBr/epwJ8srxEShQg34BI
	 /xGkU54J96atDcVKRSxml40m57fWnVKGty2Q85cfj6sQRLZtpuxtGGvPv3rXZJNDW1
	 WKcJbdpvbolqw==
From: SeongJae Park <sj@kernel.org>
To: Zheng Yejian <zhengyejian@huaweicloud.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	sieberf@amazon.com,
	shakeel.butt@linux.dev,
	foersleo@amazon.de,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/vaddr: Fix issue in damon_va_evenly_split_region()
Date: Fri, 18 Oct 2024 11:33:10 -0700
Message-Id: <20241018183310.115850-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241018035304.1050135-1-zhengyejian@huaweicloud.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Zheng,


Thank you for sharing this nice finding and fix!  I have a few comments below.

On Fri, 18 Oct 2024 11:53:04 +0800 Zheng Yejian <zhengyejian@huaweicloud.com> wrote:

> According to the logic of damon_va_evenly_split_region(), currently at
> least following split cases would not meet the expectation:
> 
>   Suppose DAMON_MIN_REGION=0x1000,
>   Case1: Split [0x0, 0x1100) into 1 pieces, then the result would be
>          acutually [0x0, 0x1000), but NOT the expected [0x0, 0x1100) !!!

Nice finding!  However, as long as DAMON_MIN_REGION is respected, [0x0, 0x1100]
region could not be created.  So, the problematic case cannot happen in real?
Please let me know if I'm missing something.

And, why would someone call the function with nr_pieces 1?

>   Case2: Split [0x0, 0x3000) into 2 pieces, then the result would be
>          acutually 3 regions:
>            [0x0, 0x1000), [0x1000, 0x2000), [0x2000, 0x3000)
>          but NOT the expected 2 regions:
>            [0x0, 0x1000), [0x1000, 0x3000) !!!

Nice finding!

> 
> The root cause is that when calculating size of each split piece in
> damon_va_evenly_split_region():
> 
>   `sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);`
> 
> both the dividing and the ALIGN_DOWN may cause loss of precision,
> then each time split one piece of size 'sz_piece' from origin 'start' to
> 'end' would cause:
>   1. For the above Case1, the 'end' value of the split 1 piece is
>      aligned but not updated!!!
>   2. For the above Case2, more pieces are split out than expected!!!
> 
> To fix it, in this patch:
> - As for the expect to split 1 piece, just return 0;

As mentioned above, I think this is not needed, since the problematic case is
unreal.

> - Count for each piece split and make sure no more than 'nr_pieces';
> - Add above two cases into damon_test_split_evenly().

Thank you for adding tests!

> 
> BTW, currently when running kunit test, DAMON_MIN_REGION is redefined
> as 1, then above ALIGN_DOWN cases may not be test, since every int
> value is ALIGN-ed to 1.
> 
> After this patch, damon-operations test passed:
> 
>  # ./tools/testing/kunit/kunit.py run damon-operations
>  [...]
>  ============== damon-operations (6 subtests) ===============
>  [PASSED] damon_test_three_regions_in_vmas
>  [PASSED] damon_test_apply_three_regions1
>  [PASSED] damon_test_apply_three_regions2
>  [PASSED] damon_test_apply_three_regions3
>  [PASSED] damon_test_apply_three_regions4
>  [PASSED] damon_test_split_evenly
>  ================ [PASSED] damon-operations =================
> 
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
> Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
> ---
>  mm/damon/tests/vaddr-kunit.h |  2 ++
>  mm/damon/vaddr.c             | 13 +++++++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> index a339d117150f..b9a03e4e29e5 100644
> --- a/mm/damon/tests/vaddr-kunit.h
> +++ b/mm/damon/tests/vaddr-kunit.h
> @@ -300,6 +300,8 @@ static void damon_test_split_evenly(struct kunit *test)
>  	damon_test_split_evenly_fail(test, 0, 100, 0);
>  	damon_test_split_evenly_succ(test, 0, 100, 10);
>  	damon_test_split_evenly_succ(test, 5, 59, 5);
> +	damon_test_split_evenly_succ(test, 4, 6, 1);

If my above assumption (the first problem is unreal) is not wrong, maybe this
test is not needed?

> +	damon_test_split_evenly_succ(test, 0, 3, 2);

Nice.

>  	damon_test_split_evenly_fail(test, 5, 6, 2);
>  }
>  
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 08cfd22b5249..1f3cebd20829 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -67,10 +67,14 @@ static int damon_va_evenly_split_region(struct damon_target *t,
>  	unsigned long sz_orig, sz_piece, orig_end;
>  	struct damon_region *n = NULL, *next;
>  	unsigned long start;
> +	int i;

Purpose of this variable is counting the number of splitted regions, and
comparing it against 'nr_pieces', right?  Because nr_pieces is 'unsigned int',
let's make this 'unsigned int' type, too.

>  
>  	if (!r || !nr_pieces)
>  		return -EINVAL;
>  
> +	if (nr_pieces == 1)
> +		return 0;
> +

As mentioned above, I don't think this is not needed.

>  	orig_end = r->ar.end;
>  	sz_orig = damon_sz_region(r);
>  	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);
> @@ -79,9 +83,11 @@ static int damon_va_evenly_split_region(struct damon_target *t,
>  		return -EINVAL;
>  
>  	r->ar.end = r->ar.start + sz_piece;
> +	/* origin region will be updated as the first one after splitting */

I don't think this comment is easy to understand.  Let's just remove it.

> +	i = 1;
> +	n = r;

Why we need this? for 'nr_pieces == 1' case?  If so, I don't think we need to
take care about the case for the above mentioned reason.  Please let me know if
I'm missing something.

>  	next = damon_next_region(r);
> -	for (start = r->ar.end; start + sz_piece <= orig_end;
> -			start += sz_piece) {
> +	for (start = r->ar.end; i < nr_pieces; start += sz_piece, i++) {
>  		n = damon_new_region(start, start + sz_piece);
>  		if (!n)
>  			return -ENOMEM;
> @@ -89,8 +95,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
>  		r = n;
>  	}
>  	/* complement last region for possible rounding error */
> -	if (n)
> -		n->ar.end = orig_end;
> +	n->ar.end = orig_end;

Maybe this change is related with the above 'n = r' line?  But, I don't think
we need that, as commented there.

>  
>  	return 0;
>  }
> -- 
> 2.25.1


Thanks,
SJ
