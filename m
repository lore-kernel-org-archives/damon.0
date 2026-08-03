Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54864400966
	for <damon@lists.linux.dev>; Mon,  3 Aug 2026 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769043; cv=none; b=lV5sPziizeK8Ro/3/4MhW8BRfHZUBwm7+mpMxqcjNNStlpnqzmOEUUBQUJ4UpcKWGnF32KMyDSwHpIqmu4oZKSD0rWmIIS6dEAgEX8kbT3yBr/8E57jOKeO/LafJbyJdr6kdKTkmhoKObc6ZmrzW3bpcQZpPn/ipIVbk8lToFKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769043; c=relaxed/simple;
	bh=sJUF2UnrPqNELsMR2fGhE2BlL02YRxP+ImQptnWyR38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCvSR98mvlpvEX6cnbusqnvDCE0qozr7dgXtJGYHw1rAyY02YKuNcDzvzsEGsjudU59/W4WOosW7S8ztpUQiPSifTTq6PSkifQj0aPsBbjYWf+i2vhkGifEQJV6iCWkiADCZG3Sxipdim5Bz6QJJotgT/b2we0IhdnaSwPRkX4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ma8jzilH; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma8jzilH"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47362928f65so3407543f8f.2
        for <damon@lists.linux.dev>; Mon, 03 Aug 2026 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785769041; x=1786373841; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=doE31CPU3agNQxp/VoBL0iESGBCUl1rgFFpxig9/S98=;
        b=Ma8jzilHHc3EC0zm1Nqcy8s0JI18pEaDiu56zddXKePovnPL17HBA5j4128cUhJM1m
         W3fCEpg9seLTQdZktLlbJjD7bxeGxj8bcTkIonK39nwhmpWhE/oaX1bOqczmLeFX8nZO
         hJcL+pDO7z9LPyQ8dk18lIJhT31G9BAVfMhKm8pDXEVbLsU7QlwdaelpnHb6sQxSOgy3
         IYooQE0W1PnobrQtWUx7yErIhsq7inwfb12B1DwTXnkVkUf82+8vOgbKVitTiiiR2R7M
         KIkhGNybBOcPyb8piLhSrKs+nPD55XVMEn/bDWP8boFr2uPLxwAuEQ6gBZunVfRA0d5b
         c2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785769041; x=1786373841;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=doE31CPU3agNQxp/VoBL0iESGBCUl1rgFFpxig9/S98=;
        b=JALHrqmMmSWuSmUMtAXl7lebUJxT8xPs/1e4riV6tJ6Xhdbut1KqYshJUqGLb9JkQy
         YKamh60kyPPTQxU8fdsLN5eazDQmbxRvLiutUb5c4J2hHMd4yPmTZjqFgAhc4V0pHaZv
         5Bob/c9yM6KJm/kWpiQHV0ZuipGfNqN7yvab0E7SmKLu0sTu9vzfL3HMQYLTKq2Wiz6r
         IhiHqLch06yR1UxUq13cn9JPq+ckmuceDkXvvDYEnK5PF1N8LjTZRgO5+hmMzFTYCYcw
         mygEb2KabEpdiC1kPXlyllRxdsBO+R0exe9Aeha/+djq5VBhmPJia4i99/sCo3kTtbaF
         dpMA==
X-Forwarded-Encrypted: i=1; AHgh+Rq6tsqEHTZ9aTfEufkuItJCJOuw8Kbm9jf9aVFwxv69mlyr4giZSsKGeDytAKm313Kg96/UjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0hdneUCDc14bBmpvaQNazkYBL0FtngLlPIzB0+wq8E0FxPHa/
	Z/o/J3kwKvVNM5wDILRWQjPhUdbUnD0HCuHVm3TBtxxmHgpnCPj040jz
X-Gm-Gg: AR+sD13ohsL4WBKMAmf/0W7+JiC36BvrZu0ppGeYS+fjEhyUgdHZD/v4Y8NbBVFKCAB
	4845pD+VpuvP/9OAdHdujNfpDeUJRp3FzP/3PiwmwAYqEZEsn5h3yhKR3RbdVuRGPkkPU8CgdFD
	OXi5iZMy/BlmkPB5yA6hp9Z8BbVMNqrdXEVuMr3MTClyDyfV4OwlBCCo/x6blDzt++efLctM6l7
	wAfm+4JRbzxaoG5icLnd1Q04gEPidtPs6J+0i3xoVOFX33sR2pNSxrTX6c/77EOoTJX5zXog5U5
	myv5vQAAsDfFWYd5+Ejwfyv3wDPv0tTB4oR0uvAqKLvV78f5tEC4x06fmj2JgnPo2lQoeFpVoEB
	ZUllm9STX7Bu/8Fz2FYOTKgbJn4NWyQc0Hn+DHU6DKlMM7x3K63AVBl5SoXY2uodSTyoMWqRcyu
	AxbXlSm/1xKryNlDdw0cJoiXx42t2UOnb1Qwyzwq/V54Fjs1awu4m64i01N5tLIVgl+CZOzs8uo
	liIXC10Banqqw8U1PclJmETHQ==
X-Received: by 2002:adf:fdcd:0:b0:47f:8fc8:af01 with SMTP id ffacd0b85a97d-47fd72f1fd4mr22343046f8f.27.1785769040415;
        Mon, 03 Aug 2026 07:57:20 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458bf7csm35015001f8f.32.2026.08.03.07.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:57:20 -0700 (PDT)
Date: Mon, 3 Aug 2026 15:57:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
 damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/damon/lru_sort: error out for >10000
 active_mem_bp
Message-ID: <20260803155715.08868ca7@pumpkin>
In-Reply-To: <20260803134034.15217-3-sj@kernel.org>
References: <20260803134034.15217-1-sj@kernel.org>
	<20260803134034.15217-3-sj@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 06:40:33 -0700
SJ Park <sj@kernel.org> wrote:

> damos_quota_score() can trigger division by zero if the target value is
> zero.  DAMON_LRU_SORT lets users set the target value for the hot memory
> scheme via active_mem_bp parameter.  It avoids setting it as the target
> value if the parameter value is zero.  However, it also sets the cold
> memory scheme with a target value that is calculated as '10000 -
> active_mem_bp + 2'.  Hence, if a user sets active_mem_bp 10002, the cold
> memory scheme's quota goal target value can be zero.  As a result,
> division by zero can be triggered.  Fix by returning an error when the
> user tries to start DAMON with >10000 active_mem_bp parameter value.
> 
> It makes no sense to set active_mem_bp with 10002.  It also requires
> module parameters write permission to reproduce the issue.  That said,
> the consequence is quite bad.
> 
> One reliable way to reproduce the issue is like below:
> 
>     # cd /sys/module/damon_lru_sort/parameters
>     # echo 1000 > wmarks_high
>     # echo 995 > wmarks_mid
>     # echo 0 > wmarks_low
>     # echo 10002 > active_mem_bp
>     # echo Y > enabled
>     # dmesg -w
>     [...]
>     [  597.421247] Oops: divide error: 0000 [#1] SMP NOPTI
>     [  597.428848] RIP: 0010:damos_quota_score+0x6f/0x480
> 
> This issue was discovered [1] by Sashiko.
> 
> [1] https://lore.kernel.org/20260801213028.5127-1-sj@kernel.org
> 
> Fixes: 40d98d31cd70 ("mm/damon/lru_sort: support active:inactive memory ratio based auto-tuning")
> Cc: <stable@vger.kernel.org> # 7.0.x
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/lru_sort.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 7e077084cb03a..3920d5042f109 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -233,6 +233,8 @@ static int damon_lru_sort_add_quota_goals(struct damos *hot_scheme,
>  
>  	if (!active_mem_bp)
>  		return 0;
> +	if (10000 < active_mem_bp)

That is backwards...

> +		return -EINVAL;
>  	goal = damos_new_quota_goal(DAMOS_QUOTA_ACTIVE_MEM_BP, active_mem_bp);
>  	if (!goal)
>  		return -ENOMEM;

