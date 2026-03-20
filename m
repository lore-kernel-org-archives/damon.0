Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE5F2620E5
	for <damon@lists.linux.dev>; Fri, 20 Mar 2026 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019139; cv=none; b=FvkWJABau9zrIpRRrcdZ4LPUPLoamGfxUy1avWfpRqi7XpsTLH7VZlu45atIjGLTyOsISe5l1Ib7/8EzIFFcbTFDpLGu9vbBiw1Gbxeffu+fX/1/hwclkoyHiuOGDWS1V8IHm276bOW4FrzeuTLGT2xGIdKYRFQ2QFwTlykQRis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019139; c=relaxed/simple;
	bh=0JzefbnFDDUAaPXmhGXPuuosVEsGt8ZsfIx+ICZ5XIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udPouLpqdvtZ6iil5DVy2Rj2irR481AkTgIDYqnwQFozYSb0kxD4PNqdUWXepIG4HPGpzUluA7G6a+x7OaGop0SVK9g36J1DeQPGx9bk/RAXVVCFW9WmjcZg5dsC+aNMCsARPFBi+BRxw7GV5PwAzCdEM8ARNuuydX5nYmhkANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNZCnAqj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNZCnAqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FECC4CEF7;
	Fri, 20 Mar 2026 15:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774019139;
	bh=0JzefbnFDDUAaPXmhGXPuuosVEsGt8ZsfIx+ICZ5XIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jNZCnAqjl1CLFi85I0hi+AXYLvnD+QnKeBuACo1Qy2c5EcFGBofio5O8jrMcYMj21
	 vYuJj4LOI5dWYK9UUPN7gY76gTAu3Ko4OCvk5uJ5X/7/1pKueJEDZI5cnTUKNYUjyc
	 DH2pSAOWbr004DEN+2seNW3xHkhv4P74DPN6B/Aog9S1ECpic85DD1/xmhYz7pILEZ
	 Ht8ANtsURPfdh6ge2D1yK45F/n6G84PSYXd4R2K9LSs779y5TRBoDU/ZghRMV/rDxr
	 zyD/Z2KurpgLVL4gZV43bbEzOU/eHxej+bFLMKONXo1pfYYWevns7ITnX7N/buvBMz
	 8Rb/aHQuLVkzA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon/ops-common: optimize damon_hot_score()  using fls()
Date: Fri, 20 Mar 2026 08:05:36 -0700
Message-ID: <20260320150536.98893-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320072431.248235-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Liew,

On Fri, 20 Mar 2026 15:24:31 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> The current implementation of damon_hot_score() uses a manual for-loop
> to calculate the value of 'age_in_log'. This can be efficiently replaced
> by the fls().

This makes sense.  But, it seems ilog2() looks more same to what the current
code is trying to do.  How about using ilog2() instead of fls()?

> 
> In a simulated performance test with 10,000,000 iterations, this
> optimization showed a significant reduction in latency:
> - Average Latency: Reduced from ~9ns to ~1ns.
> - P99 Latency: Reduced from ~60ns to ~41ns.
> - Throughput: The loop-based version mostly fell into the 40-50ns range,
>   while the fls-based version shifted significantly towards the 20-39ns
>   range in the test environment.
> 
> Although these results are based on a simulated kernel module test
> environment [1], they indicate a clear instruction-level optimization.
> 
> [1] https://github.com/aethernet65535/damon-hot-score-fls-optimize/blob/master/test-kernel-module/fls.c

Makes sense!

> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> ---
> Note on testing methodology:
> I attempted to measure the performance directly within the kernel using
> bpftrace, perf, and ktime inside damon_hot_score(). However, the results
> were highly unstable (ktime), and in some cases (perf/bpftrace) the
> function was difficult to trace reliably (likely due to my own tracing
> limitations).
> 
> Despite the instability of in-kernel ktime measurements, one thing
> remained consistent: the fls-based version significantly improves the
> "long tail" latency compared to the for-loop.
> 
> Test results from the simulated module:
> - fls-based:
>     DAMON Perf Test: Starting 10000000 iterations
>     =============================================
>      Total Iterations : 10000000
>      Average Latency  : 1 ns
>      P95 Latency      : 40 ns
>      P99 Latency      : 41 ns
>     ---------------------------------------------
>      Range (ns)      | Count    | Percent
>     ---------------------------------------------
>      20-39           | 3522000  |   35%
>      40-59           | 6478000  |   64%
>      60-79           | 0        |    0%
>     =============================================
> 
> - for-loop:
>     DAMON Perf Test: Starting 10000000 iterations
>     =============================================
>      Total Iterations : 10000000
>      Average Latency  : 9 ns
>      P95 Latency      : 51 ns
>      P99 Latency      : 60 ns
>     ---------------------------------------------
>      Range (ns)      | Count    | Percent
>     ---------------------------------------------
>      20-39           | 0        |    0%
>      40-59           | 9894000  |   98%
>      60-79           | 98000    |    0%
>     =============================================
> 
> Full raw benchmark results can be found at [2].
> 
> If anyone could suggest a more robust way to profile this specific
> function within live DAMON context, I would greatly appreciate the
> guidance.
> 
> [2] https://github.com/aethernet65535/damon-hot-score-fls-optimize/tree/master/result-raw

Nice test results!  I think this deserves to be in the git history.  Could you
please add this on the commit message area, rather than this commentary area in
the next version?

> 
>  mm/damon/ops-common.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 8c6d613425c1..0294de61a23a 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -117,9 +117,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
>  		damon_max_nr_accesses(&c->attrs);
>  
>  	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
> -	for (age_in_log = 0; age_in_log < DAMON_MAX_AGE_IN_LOG && age_in_sec;
> -			age_in_log++, age_in_sec >>= 1)
> -		;
> +	age_in_log = min_t(int, fls(age_in_sec), DAMON_MAX_AGE_IN_LOG);
>  
>  	/* If frequency is 0, higher age means it's colder */
>  	if (freq_subscore == 0)
> -- 
> 2.53.0


Thanks,
SJ
