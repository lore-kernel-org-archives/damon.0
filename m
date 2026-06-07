Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAA01EB5C2
	for <damon@lists.linux.dev>; Sun,  7 Jun 2026 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780845888; cv=none; b=Psid9AIvU981DlEvHKLkLMyKxT/AjyFJKbpbX67yFI+xK/4ISR/kXgFhma0iS7ZFH+HYWZmJK31R3B8WXRrl5sC9pqqs4FaYQaUOlg/xeJFIUaeIcnibg84ilsTIw9vpXJ5mPacoGTZKHYcHeDy+QgI+lWW9A//ElMciPX/EjOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780845888; c=relaxed/simple;
	bh=MWCrVEv6nIxM+FbBnw4wPkNHi0dVwOFe+mKiw/ooBwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhdb8T4lrvZx1Evy6pTRuU3/2cyjX+nsQnBKRNLqnfuBoVDZ/vJeM5u5DzOUXrczZxZ4h0BkB6DA7Vu92KC6CIbE0gkbASRtISQ5iAb8pVR81nk+ktoeZ0mG0wQPSeQGI845cyhztktmlfNdh6dEkw+CqnKW1StoJjAmX1oB2ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B3rKEyWt; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B3rKEyWt"
Message-ID: <d057097f-2efc-4f27-861b-ac076b93e34f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780845885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7eM0J2wbw/2K8ZZhLt6TUGKPIkNzPAPBwibQcHHdfg=;
	b=B3rKEyWtrMBqQzOjs3BD43CH+i23fev0mW7/g/PB1V+OQ/EcCL2pUGzT1iTuFSd/xwMKr7
	f4k7GPxMA11+VcVvtQXdpyYVB0Au1zDt5WXZ6FpONLVWZgHsTs1hEsPAPtCG8/27aVCqZs
	MzHaZ7Aa2Mz672dXagqzB1an+cWHqqA=
Date: Sun, 7 Jun 2026 23:24:27 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH 02/10] mm/damon/core: add damon_new_region() debug_sanity
 check
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260306152914.86303-1-sj@kernel.org>
 <20260306152914.86303-3-sj@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260306152914.86303-3-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi SeongJae,

On 3/6/26 11:29 PM, SeongJae Park wrote:
> damon_new_region() is supposed to be called with only valid address
> range arguments.  Do the check under DAMON_DEBUG_SANITY.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index f1a97e85824ac..0c1353164ec81 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -109,6 +109,17 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
>  	return err;
>  }
>  
> +#ifdef CONFIG_DAMON_DEBUG_SANITY
> +static void damon_verify_new_region(unsigned long start, unsigned long end)
> +{
> +	WARN_ONCE(start >= end, "start %lu >= end %lu\n", start, end);
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
> @@ -118,6 +129,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
>  {
>  	struct damon_region *region;
>  
> +	damon_verify_new_region(start, end);
>  	region = kmem_cache_alloc(damon_region_cache, GFP_KERNEL);
>  	if (!region)
>  		return NULL;

This can be triggered with

	echo Y > /sys/module/damon_sample_mtier/parameters/enabled

because both node{0,1}_{start,end}_addr are 0 if people forget to properly
initialize them. This can be avoided by checking the parameters right
before damon_new_region(). But I'm not sure if this is the correct
solution.

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 775838a23d93..4a5d3fb12e1b 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -118,6 +118,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	} else {
 		addr.start = promote ? node1_start_addr : node0_start_addr;
 		addr.end = promote ? node1_end_addr : node0_end_addr;
+
+		if (addr.start >= addr.end)
+			goto free_out;
 	}
 
 	region = damon_new_region(addr.start, addr.end);

Thanks,
Zenghui
