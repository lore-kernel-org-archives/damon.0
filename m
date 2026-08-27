Received: from mta0.migadu.com (out-78.mta0.migadu.com [91.218.175.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07502F7F14
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849235; cv=none; b=Tua4hD0TPmBCP6hF0eIgPNcfcnjrsk/8GdfzA0TrS/yIeUHohDeFrrgIGr+5PyaByhTLCBo+PDOQtnK2nCPezMuvDh7kbaQhn8adDNOBvEViE4Gwa+Ep9bhPxH7MrTyo5/9jt9UItFtWKbxcigWMjm2PwvT02xJ/yrfeG3P+JCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849235; c=relaxed/simple;
	bh=ptF/ax/1jZdDt8j5oFLsGrhLay+63QE59Z755eP1/VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzSbLUyw1svg2Q/0/M/ye44Ic3yS7/fdOBhU8r7M0bw/xoxMrgRCjAr6s6Z60f9YN/ZsNpUzpuGChbbushm6Y0+RQ3RGKXeOdSMCjNDYlz8MCSqinb/AmyE2GO9u2xhqICF/ZevJvk4jBNvkR+36tTcHoIBITMrFuNR5y7ok9Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cdqoNWQw; arc=none smtp.client-ip=91.218.175.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cdqoNWQw"
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=ptF/ax/1jZdDt8j5oFLsGrhLay+63QE59Z755eP1/VM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787849231; v=1; x=1788454031;
 b=cdqoNWQwGE4pw7YaEc9+Z4A8iIJ2xOp+9g1cUgA1yJoa2gxzxKwXIFbho1iL4ZHPPMB4VVp/
 2yG4NIKB99aaiUAIoMTLveJkSCtbPDQtFkXtIw0oz/jNEbM4UDzeHZ9/cij0FOEWZYoMvo1etI2
 fvjo57CCzcTaOkkrfQNHWKe0=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 9791eedcd5c3b768;
	Thu, 27 Aug 2026 16:47:11 +0000
X-Mizu-Trace-ID: 9791eedcd5c3b768
X-Migadu-Flow: FLOW_OUT
Message-ID: <72252089-0405-441a-a7dc-0e1deeb2f802@linux.dev>
Date: Fri, 28 Aug 2026 00:47:08 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/core: remove declaration of kdamond_fn()
To: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: sj@kernel.org, akpm@linux-foundation.org
References: <20260827163953.83520-1-zenghui.yu@linux.dev>
Content-Language: en-US
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260827163953.83520-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Please ignore this patch.  This is absolutely wrong.  Sorry for the noise..

On 8/28/26 12:39 AM, Zenghui Yu wrote:
> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
> 
> It was added by commit 2224d8485492 ("mm: introduce Data Access MONitor
> (DAMON)") but is actually not needed.  Remove it.
> 
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
> ---
>  mm/damon/core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 37d661e2bbc1..183080556404 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1922,8 +1922,6 @@ static unsigned long damon_apply_min_nr_regions(struct damon_ctx *ctx)
>  	return max_region_sz;
>  }
>  
> -static int kdamond_fn(void *data);
> -
>  /*
>   * __damon_start() - Starts monitoring with given context.
>   * @ctx:	monitoring context

