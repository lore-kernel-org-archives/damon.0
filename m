Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7510B34751F
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402291; cv=none; b=tkej03m3YOYdSeVGPju1eV7MyLsyFQHligkk4d0NeAVu9mfxKqAFwZ/GjzD6sMVB7ELms0ssiEaflqWTeDuLN+k6c6eKUglAV2MpdmRD/2p6aLIZKhSe6kFIcEeOthDgbJ6g64o8I2DMbalPL7yYlsJDWd18iaDQGAlj8AMC0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402291; c=relaxed/simple;
	bh=iC7and9h7b1SIUvtmbF0bA5C1kwIySKrp0zXHTwCAuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzbM0y4kPPAs7J1AiKNTx9KcCrfdcXTfJHuhMyMvPZeUMHxUp4ONKbeEnuyDGdWDUlztpbpgK031+iMkjoIahrYGWbXiEAYgb6vqwNpFCErFEXFgDuC7RpwWmsKg31IIvOtPiE8665zc7zqkZprvevgPvWTzXjgqJa0bjm9X7+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnsacEce; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnsacEce"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so1717252a12.3
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 19:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788402284; x=1789007084; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nEnLbsLjH8lfXnlpNq4YY44i+y0cC+hZ66l4ewIS6QE=;
        b=lnsacEceJZ79JDy5RibakFKVujI0ePg8K4LnbqC+yvxHJzBmY2bMSYvoek7TO+xMhE
         Y7Ok/Qdn4dSzOlsJv/6T5YNIR3oWpdpRkP8fnk2X/UUzjXNOgBPBMCv5puYQEFgKupVa
         JmF2E9E6lGGkeB6h8iK0iK02istL8pjHFGZ865rTOAskcCvlo4G3fApagCwEUu+DCxtZ
         sr3DQvcE9+B8fzeF2sKtv/uyK1/N+y3l1Yo3YuwsrUuejZV/B8CYUOgehCnFJ/1U8kBh
         hNUrDPAogdv6qXHTEHNJmMx3jo1ruFTma2yO/Wcspud37QDXdWQB/fpzJHWgNqfe0ysz
         ns8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788402284; x=1789007084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nEnLbsLjH8lfXnlpNq4YY44i+y0cC+hZ66l4ewIS6QE=;
        b=YbuKHbZD0PPKp9CzuSEEsiC2AGsuERKhut8TxH02ls7q8egieVRqGXoVrEU2SXYIfm
         u9/GCtFPsXHLDTJoo9vAmH06mwcKNoMgxbzMTofiacLAmrP5pLy4ZssGH+F8UJeg6+NE
         J5fVMcaTKlYWdpx8nVQl50B4irwfbaNHiMLhCfLLKjCkBceRlkry9M12tMKru7azvieB
         iVdVM6jyTcjxpcC2KNKNl023gLuvHtp0oVjXSnTr4q7b5KiKpkweadDZcrwPMMnZThIs
         AbREYyPeRI4oiDMpW0VNsM+HJV5u4vO4n4POPxRz1lFuYE+arbdKs7jOPNY8zsPZq82h
         S19Q==
X-Forwarded-Encrypted: i=1; AKwUvByNRDFuIt3y5Y8G2FHuvS+sDCNL75xI1MdU6qSUA5mavTT35V+VqwVynevQMknt9dboCIRHcA==@lists.linux.dev
X-Gm-Message-State: AFuF++nymS9cr5EhfRqLtk8VhufO9NJfPj8sw/s5VRk2XurTcz+J4YnN
	WVoHX6FW40ZQre5FCAkJXx3/cbNdx6pv06N/2vrwN380xBwvvYg95sGJ
X-Gm-Gg: AYBFou2imEwNKgsTji5Y22kGYrQPMucLT8hxEvacSAockTSLQLXHt5QB8tvtgu13p8d
	gZYaV+0O5ZlOn/n662LLbRPjXAzIuWdINyV39LCQY1K/FDnU4ys0EVA0oAUoSIuGjl8MvKgpD+M
	RNF0lXD/vfTkwKJqbPZ/d+uPqcZoUqbhRr84rrdIb770w/mQsuJntLMV8bE2WJP0/55LPZhcZl8
	E+LulpAwFQcVpWDX1/T8gVpmq4L7mm0IHMLUJFVqiQGwcHN2qGOryXeYLppbUX82vd266uyFPj3
	34q7TUhI4UlR61hUIWycYLlkfbOVa4wywAIV+eW9kdCVSA/iYo1XGcwPtgdZLvJRl2ZIU9+nHk/
	kRSZj+ECDWXqWAqJN0nbW53fvEyC8E/Hx22H1zmZ1Ilm+3CVSq8g6tcvwD28kn6ic+AIPxjrP8y
	sppHuAlCR5tR0t1FV4ZMtNWdAuHdGwZNtdUEYNXX5e6sRqaruMQee6eiJHvWw=
X-Received: by 2002:a17:90b:5384:b0:398:ceef:edbd with SMTP id 98e67ed59e1d1-39aee1bbae0mr14243570a91.18.1788402283444;
        Wed, 02 Sep 2026 19:24:43 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08766a2dsm2107662a91.15.2026.09.02.19.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 19:24:43 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 03/12] mm/damon/vaddr: remove a debug message
Date: Thu,  3 Sep 2026 10:24:22 +0800
Message-ID: <20260903022431.74074-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902054747.99370-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 22:47:36 -0700 SJ Park <sj@kernel.org> wrote:

> There is a debug message in the DAMON virtual address space operation
> set.  It has not really been used in a meaningful way for the last few
> years, though.  Remove it.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/vaddr.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index c8c32b2ae0402..f884d3f78f30a 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -189,22 +189,12 @@ static int damon_va_three_regions(struct damon_target *t,
>   *   <BIG UNMAPPED REGION 2>
>   *   <stack>
>   */
> -static void __damon_va_init_regions(struct damon_ctx *ctx,
> -				     struct damon_target *t)
> +static void __damon_va_init_regions(struct damon_target *t)
>  {
> -	struct damon_target *ti;
>  	struct damon_addr_range regions[3];
> -	int tidx = 0;
>  
> -	if (damon_va_three_regions(t, regions)) {
> -		damon_for_each_target(ti, ctx) {

Thanks for the cleanup. The debug message was the only user of
ctx here, so the signature cleanup follows naturally.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

> -			if (ti == t)
> -				break;
> -			tidx++;
> -		}
> -		pr_debug("Failed to get three regions of %dth target\n", tidx);
> +	if (damon_va_three_regions(t, regions))
>  		return;
> -	}
>  
>  	damon_set_regions(t, regions, 3, DAMON_MIN_REGION_SZ);
>  }
> @@ -217,7 +207,7 @@ static void damon_va_init(struct damon_ctx *ctx)
>  	damon_for_each_target(t, ctx) {
>  		/* the user may set the target regions as they want */
>  		if (!damon_nr_regions(t))
> -			__damon_va_init_regions(ctx, t);
> +			__damon_va_init_regions(t);
>  	}
>  }
>  
> -- 
> 2.47.3
> 

Sent using hkml (https://github.com/sjp38/hackermail)
