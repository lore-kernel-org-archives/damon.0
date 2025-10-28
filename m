Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20829347C7;
	Tue, 28 Oct 2025 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661164; cv=none; b=aZXhSr7WaOkIO1h6kAx7GTERRCIZ8fBTWw1slRhLohFkuHwlK+8jnf05w6m650CcRozSRlOcspnuZz9AVaRzwlIDa13+lfDR2QgrprYGlv0g6DkufmaYM/aohj1fFtY/I6UPZ1h28RvSVehEuC35zTHInRzHdpacPd1wZd4WsNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661164; c=relaxed/simple;
	bh=N7sqXu/YPYOQkrbkKQmvopRhYdbD+uh6iTOl+OZens4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZSIyWBr8kEqW5qCZunfR0n8gcH7aVDKRYVvqR6U+UtjAYt+4MZ/z5dz7vRzAgFpTwZ033KvLVoGxj/xGsqWd20Wzd5+eHTQ247GqUOGpe6TjCRRGUpLvR2Kv/jTRM7ddkpZg9/u7itxAYffoZGYJRP1JlSo6C21cFWqH2CzdSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQqLNS2F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQqLNS2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766FDC4CEF7;
	Tue, 28 Oct 2025 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761661163;
	bh=N7sqXu/YPYOQkrbkKQmvopRhYdbD+uh6iTOl+OZens4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQqLNS2F1BrctVycOmZfPXF8RU8+BhtweqoXmHoDpmq7M5ySp0o5vaD1jVrWzRjFL
	 F44wZVDedxfNFqd+Mzlyi5aTtNsSm1G7RCl//3iN7FYVimQf1MKYotncuadkC+6uNw
	 NdMnRpaed4nIswY0m2ltRx0QCFaDDAF1sImMYAqEP40VdGW4Eky2CrjvM/IJ4v0WDu
	 obHXZwnDx7U1Nj6+j6Za7OqYM7pIOcU3NurV1QHhrXc4PY/e/GGqcRzMO7k4emw63L
	 bPcprgQan8qNEuohr/ZZNaIeR8omNj82FNRBZjCFFw4+yK7yyYyvep7CRNT9NS0d3H
	 QmKqgvjS9MnXg==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH] mm/damon/stat: set last_refresh_jiffies to jiffies at startup
Date: Tue, 28 Oct 2025 07:19:14 -0700
Message-ID: <20251028141915.49989-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028061927.1378746-1-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 28 Oct 2025 14:19:27 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> In DAMON_STAT's damon_stat_damon_call_fn(), time_before_eq() is used to
> avoid unnecessarily frequent stat update.
> 
> On 32-bit systems, the kernel initializes jiffies to "-5 minutes" to make
> jiffies wrap bugs appear earlier. However, this causes time_before_eq()
> in DAMON_STAT to unexpectedly return true during the first 5 minutes
> after boot on 32-bit systems (see [1] for more explanation, which fixes
> another jiffies-related issue in DAMON). As a result, DAMON_STAT does not
> update any monitoring results during that period, which can be more
> confusing when DAMON_STAT_ENABLED_DEFAULT is enabled.
> 
> Fix it by setting last_refresh_jiffies to jiffies at startup.

Nice catch, thank you for this patch!

> 
> [1] https://lkml.kernel.org/r/20250822025057.1740854-1-ekffu200098@gmail.com
> 
> Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated memory bandwidth")
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
> ---
>  mm/damon/stat.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> index 6c4503d2aee3..6dc3e18de910 100644
> --- a/mm/damon/stat.c
> +++ b/mm/damon/stat.c
> @@ -132,6 +132,9 @@ static int damon_stat_damon_call_fn(void *data)
>  	struct damon_ctx *c = data;
>  	static unsigned long last_refresh_jiffies;
>  
> +	if (unlikely(!last_refresh_jiffies))
> +		last_refresh_jiffies = jiffies;
> +

How about doing the initialization together with the declaration?  E.g.,

 static int damon_stat_damon_call_fn(void *data)
 {
        struct damon_ctx *c = data;
-       static unsigned long last_refresh_jiffies;
+       static unsigned long last_refresh_jiffies = jiffies;



Thanks,
SJ

[...]
