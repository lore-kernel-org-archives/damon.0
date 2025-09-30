Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1362940D
	for <damon@lists.linux.dev>; Tue, 30 Sep 2025 03:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759202308; cv=none; b=qUrbMewnSWr80Zlo7l5wIbh/doRNWWUdyuSFXBcVS/MpXLsZlhYZ2olCwXzozsNWFnJK3EvbzSpOXagD/ZGL/djtrNOB/UNrthgDXsxjZZI7n+h630WrXniLjoIqRYffCwLCRe+DyPUJuU0MFIBwH9zcK8c5B/F8gCk0Ut3UsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759202308; c=relaxed/simple;
	bh=uaZ8qq9KG7UhYZxnVtn80+b0ZXQ4Rtj1Kxa7cWa5kJU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P+AZ/eNar7AV3uy91V+/Gwigi5qRMOXpaS+KQwiwXTtKVqD/oWRET4n7pCsbcuaKrp7XpZX3G2DFZmKUWqD0SbZr12Psxe311aupUDwQBoHQVHboIPv1qvp2JBgE64JD2HG3y/TRHnz/2IZnmOgpOc1k4f4gAXKszDJuZkl3h3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5QdreEX; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5QdreEX"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d60157747so59207277b3.0
        for <damon@lists.linux.dev>; Mon, 29 Sep 2025 20:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759202306; x=1759807106; darn=lists.linux.dev;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PGNLCKGJrXLWa6eAFuG7oNqbsQrVZxx3Sl0hu9yULUc=;
        b=T5QdreEX4FxHRKvVGtSP3+YmQyCIAtT0fcLOGNlmYCR2psY+YADPRMkUEPxrdgETLv
         pZlVRLRbp5JZeIJTHZOp+QPaYIjtB1vACjyZiYSlHAUT/KVPMHC0d4XnRPBOqX/YXMIc
         cqi5EM+Tvf6OP5rmKrZYmkMkLu4BZa0wtIGaVzzC5elWADZZNXA1eNtxdudCaymGT+BW
         WRp00Oa64kHn6FynBBRMbiT3PMfv5C2M7J/Os8Nw0DhGMPOLO/a0iyO+7cwKKFJp8qHR
         xbjoywJCMXCJ6UVTDB8rbB9jP3eSmyz3vuTHMFIMB+Q8ZHmsd4jQaaN+VViE+6oQTN3P
         RTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759202306; x=1759807106;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGNLCKGJrXLWa6eAFuG7oNqbsQrVZxx3Sl0hu9yULUc=;
        b=E4rPnCbjxVXjKeUhpkiwLFEhZrd9U+j5Rj+AjMEek+XqYlzWkuOo+Sg+MbtGDcamPI
         TcrpHKtq4IT3UFY6NyH4M1H+odmlRCDkpY0PMjw1fuGUbgpnbEcj40IBCrkAkpXA05oj
         3441foDNHCXIrHWMTDS0r0DjERLdZmx8CsF1oVOm5x4+z9o8781mvPDubKQV/XssctvD
         yTS6ECZ7yJQsXwXzT1ZTgm2lkOszhFJjOvk9eMyJm5R5dYmiOo4Ht/pXAJyjHjBL81Dr
         HzXboT57nhapc9z1gFDYhNosTITGHd7N0T17AYO6v66IkPGfqnRE4Sd2D0VtLd/h5dYv
         gdXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5B6q+VdB9+Drttv08lDDVHoWCaXFl+ifE4NoG5W/h/TpwsS79Dq/OeE20HFw/FVfoh+DZHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxowpNePl5b51HH3yLqta6RjEb8gLcBAtr8qa/r6CFDjAjdJjck
	kcQYWJwRr1MCze6CtrIxTx1imibdgkk17wgkcylfWtSj/f/J5mRrMQaHcRgMOG0uiA==
X-Gm-Gg: ASbGnctsJbuBp4HE+1RyVEEjalmqWbUjb85+R8GPOJA1uGqsWvFMdifTj/X/2MeONXV
	70ezz88WXbLwI6UDWs/rAeLjknjN8jv2r7Vc5a7asmK1KhUSLIhrZUGs1ZkfW708lhB5RuA0EaD
	68Iqdv6Bj15s07kNI7+1Myz1ss9SiaBLtwkom5UxQ7bapE/ATHD9iAlv9jodyvr6o2qGj9QEo0y
	j0EF3GtuEb4h6MvYSQCQ+ixjsthUjyQtez2jvI6Q1AGaekfns4bPsJgR7L9uCrJ5Ep86sxoqYLn
	dO+ol4Ns+S1gKhXz202OQCyaTweiotkw5wZB2O3WHhZS6MnCl7cIkt1sI60TAhPPr4kQ9Hk26YN
	2FcG141iM0CElrk8khVVTgY2i2jVfm5mhEYFso4QM/4gv3Oh7deiAKqZG/RMcZ5ieZMlbEBUg8f
	LsmiJTxfH+l4d3RPB2pTNPDKoupJXJQiDQwuKF
X-Google-Smtp-Source: AGHT+IFcZqYas2wBQmI9BbRmqml9F+2QA9spZ9yKoBd8FyOombPucba4gtkHHMksFeRZI+3E7DFoZg==
X-Received: by 2002:a05:690c:7302:b0:734:ee:200b with SMTP id 00721157ae682-764052014damr237888467b3.51.1759202305941;
        Mon, 29 Sep 2025 20:18:25 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765c77e72d0sm34142987b3.49.2025.09.29.20.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 20:18:24 -0700 (PDT)
Date: Mon, 29 Sep 2025 20:18:13 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: SeongJae Park <sj@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
    damon@lists.linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, Xinyu Zheng <zhengxinyu6@huawei.com>
Subject: Re: [PATCH] mm/damon/vaddr: do not repeat pte_offset_map_lock()
 until success
In-Reply-To: <20250930004410.55228-1-sj@kernel.org>
Message-ID: <07267988-1736-1372-8994-76892c5cc804@google.com>
References: <20250930004410.55228-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Sep 2025, SeongJae Park wrote:

> DAMON's virtual address space operation set implementation (vaddr) calls
> pte_offset_map_lock() inside the page table walk callback function.
> This is for reading and writing page table accessed bits.  If
> pte_offset_map_lock() fails, it retries by returning the page table walk
> callback function with ACTION_AGAIN.
> 
> pte_offset_map_lock() can continuously fail if the target is a pmd
> migration entry, though.  Hence it could cause an infinite page table
> walk if the migration cannot be done until the page table walk is
> finished.  This indeed caused a soft lockup when CPU hotplugging and
> DAMON were running in parallel.
> 
> Avoid the infinite loop by simply not retrying the page table walk.
> DAMON is promising only a best-effort accuracy, so missing access to
> such pages is no problem.
> 
> Reported-by: Xinyu Zheng <zhengxinyu6@huawei.com>
> Closes: https://lore.kernel.org/20250918030029.2652607-1-zhengxinyu6@huawei.com
> Fixes: 7780d04046a2 ("mm/pagewalkers: ACTION_AGAIN if pte_offset_map_lock() fails")
> Cc: <stable@vger.kernel.org> # 6.5.x
> Cc: Hugh Dickins <hughd@google.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>

Thanks,
Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  mm/damon/vaddr.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 8c048f9b129e..7e834467b2d8 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -328,10 +328,8 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	}
>  
>  	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> -	if (!pte) {
> -		walk->action = ACTION_AGAIN;
> +	if (!pte)
>  		return 0;
> -	}
>  	if (!pte_present(ptep_get(pte)))
>  		goto out;
>  	damon_ptep_mkold(pte, walk->vma, addr);
> @@ -481,10 +479,8 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
>  #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> -	if (!pte) {
> -		walk->action = ACTION_AGAIN;
> +	if (!pte)
>  		return 0;
> -	}
>  	ptent = ptep_get(pte);
>  	if (!pte_present(ptent))
>  		goto out;
> 
> base-commit: 3169a901e935bc1f2d2eec0171abcf524b7747e4
> -- 
> 2.39.5
