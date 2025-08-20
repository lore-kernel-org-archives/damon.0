Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C80718991E;
	Wed, 20 Aug 2025 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755728198; cv=none; b=EpekHfTtOBajdeL8idB+L1mbrgN3Mn5qnbRd+k5aD4m+tn+RCmsrhQc70h4lhiISeKKWoStCpQ1smSgdnUagtG57rPEcdbVa1orwDLkkVThSBnMrZttqzsbGcJW5b80yrWTLPmjGKY30CVytwbiPsLDnvadH6GzK0BVRqprUv54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755728198; c=relaxed/simple;
	bh=t+tWnrOdC52ng2PKCMOPQ3dU0wAXmGRrWg903Lm9s5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ycp90B7xIl/Qizg1RQLY7PoXAeu/Ok6156ckMjq5o1kdigzr0TtyJxZkm621chDRch31REUsHFAruKwFhxOACac1pFh7o6sl16tdynm3no5hF4gWU59I/BidCy5gQornxM0wTT3RqbSxGzrB+CI2iJkEm5ti1eAJgX0aPZ8E4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbA1UGh1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbA1UGh1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F6BC4CEE7;
	Wed, 20 Aug 2025 22:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755728197;
	bh=t+tWnrOdC52ng2PKCMOPQ3dU0wAXmGRrWg903Lm9s5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VbA1UGh1nC3YLNxH36lmr0c4YOCpU6zi5divlNm5Vp7tVUEfHKWIjwqb3342Ktgu+
	 dLDHwCayCyjiEeOWEf+EhacAOsU2xhK4a55nMVPYy30hDWPGs3zwiT/rI+Majx8b05
	 XJp0xB1FwXZKAdOgSNjrg50hRj7tg2ppob0usfMC7Tz1EZecNieJgmhZQ+dMRbGLv6
	 WAivW2gaszIZrtJTOv5XhfsX8KCmEVEXErinhfqGp4fZQjXCbd8vB8UDOTXk+jkd5Y
	 JmeA4Av2AJiPd9enh172qDGMN7I343+BAUoJrCM0U2ifoLh3z+eZxAg4sqt7OFV7zX
	 bxfNH3+Cosa7g==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com,
	Andrew Paniakin <apanyaki@amazon.com>
Subject: Re: [RFC PATCH mm-next v2 12/12] mm/damon/core: prevent unnecessary overflow in damos_set_effective_quota()
Date: Wed, 20 Aug 2025 15:16:33 -0700
Message-Id: <20250820221633.87243-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250820080623.3799131-13-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Andrew

On Wed, 20 Aug 2025 16:06:22 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> On 32-bit systems, the throughput calculation in function
> damos_set_effective_quota() is prone to unnecessary
> multiplication overflow. Using mult_frac() to fix it.

Andrew Paniakin also recently found and privately reported this issue, on 64
bit systems.  This can also happen on 64-bit systems, once the charged size
exceeds ~17 TiB.  On systems running for long time in production, this issue
can actually happen.

More specifically, when a DAMOS scheme having the time quota runs for long
time, throughput calculation can overflow and set esz too small.  As a result,
speed of the scheme get unexpectedly slow.

Quanmin, could you please add the above paragraph on the commit message?  Also,
I think this fix deserves Cc: stable@ and has no reason to be a part of this
patch series.  Could you please add appripriate tags like below and post again
separately?

    Fixes: 1cd243030059 ("mm/damon/schemes: implement time quota")
    Reported-by: Andrew Paniakin <apanyaki@amazon.com>
    Closes: N/A # privately reported
    Cc: <stable@vger.kernel.org> # 5.16.x

> 
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
> ---
>  mm/damon/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 980e271e42e9..38b5f842ef30 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2102,8 +2102,8 @@ static void damos_set_effective_quota(struct damos_quota *quota)
>  
>  	if (quota->ms) {
>  		if (quota->total_charged_ns)
> -			throughput = quota->total_charged_sz * 1000000 /
> -				quota->total_charged_ns;
> +			throughput = mult_frac(quota->total_charged_sz, 1000000,
> +							quota->total_charged_ns);
>  		else
>  			throughput = PAGE_SIZE * 1024;
>  		esz = min(throughput * quota->ms, esz);
> -- 
> 2.43.0


Thanks,
SJ
