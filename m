Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B312D77D
	for <damon@lists.linux.dev>; Mon, 26 Feb 2024 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973018; cv=none; b=iLCpf/Wo1/ve0kD2j85NeTzEzO9uZhwr49HsqkRzgHp+utH8stIo5KNBnYxxBF6EizVSkIZV9qfC4wtXNR/Me0NYfiFTS9T0qzzmEhzQubEsrX4Q//ZoH6n9badFzatwOZMYrlstUWzyUSXU1kcj4/N2hpkVAkFb3mlbRnaJq7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973018; c=relaxed/simple;
	bh=J6isOQHBwpgJQxuhK194OHKrDkPAeRMvr01+zxAUxJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APNgW14wjOLdCjAAYKnTubUGZQDOowSmdHGwxK10Mm2wdzRjJkbnouNfu5KQgDFyWD3EQE4NiwhO+LU1P32Rvsnio/YjV1ZPaWuLz91A30H3NVUPTJLqnsWr8Uk9S5Qvxu3HSLfQ8B1aPznHXI1p2y2ymxoGFFwS3lxWWysd94w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsv0QLkU; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsv0QLkU"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e4881bccc9so1157891a34.2
        for <damon@lists.linux.dev>; Mon, 26 Feb 2024 10:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708973016; x=1709577816; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAkbitPXYXtd7UV/o6SYG/LfxMkpu6ctTHaHbiVeocc=;
        b=nsv0QLkU21zgd+pX9aXE3LeQhfOq3BiQWlUlA5egvcZoqjF2DMGTUbSqlpU/zL5haP
         z6ZhfdS9aWbk4ky0xpRsYNnfzGiT16kRMG2M6AUNd4EP8VACHtZs2hbU+mBlEL+CK2+2
         wIjI6plQ+r3fSWpoTgFPCr3hc/c/qtaNk6GnjhQFcebpWCv3x2VMRcKGb17jGCZYxTZF
         52fmeFVfjZjGVXcA2sOCLBT8CXtNpaYGeaxBQqm264FRCbzU6V8ZAaOjAS70ZAoYbC6P
         oCoRqGjxZpVgiw/ph/VD79UThFMvY13+vmpcZVmAbnhR4woEimpUAzP3lXnCRePlp6EB
         pQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708973016; x=1709577816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAkbitPXYXtd7UV/o6SYG/LfxMkpu6ctTHaHbiVeocc=;
        b=j5mMJUOlWQcq6rd3d9jVzZTk8wTwZPn4SqWCgmCHv4gavPQNnGpNx+awaLHG6WWIYY
         PN4pfAbX+F83QmaOh3MLvH5H2EWDJ9J7zQ7GXPzNKvC9nscIc/sBIPzbnCWFpR4zvVmc
         RgMVjaIeFyvra94c/owUifjTT6XDiCOutQ24Nuig/rZYO+ev/WXHJKlBeaJ7RxOAfEIx
         Zlc3N6RVWgAi7R/WRhO1vPHOg54sZbqiPS6Bdfoi5KsWuGSNVxZgRq0qGEatEdxeCU/1
         qAEKPJ21pOFeGVJeWRxKhU/cfBDEFuG47RVGmp7vbwLMR6jU3Vo3kIFv3QhtAnPlxTan
         cE9A==
X-Forwarded-Encrypted: i=1; AJvYcCWVlP5Hn1vLGgQ3mbD82gi5b1pTiynuvptigeSHbZBk3+pNsYKzm+naLSOcEXffe2sO4x3WMuO35WCXxyopAhnL8o/b1OU=
X-Gm-Message-State: AOJu0Yxw3ZhYdDLd/KKJWoS7BRs7R3VIM1DvmX6jzW+Qu5Iljsz+8/La
	W8K+8OufLLlawT7GSHsC+jQvBAO1YdxLrTiOsXan/o5nuNKJ+tsd
X-Google-Smtp-Source: AGHT+IHJFjHVrXwCb+MKLtrxz4B3i7S6NFPxkP3MbyyfUUwlOxB03i2Y1kUIZWJF/NjtbadQv25Y/g==
X-Received: by 2002:a05:6358:5e8b:b0:176:40d5:2bd5 with SMTP id z11-20020a0563585e8b00b0017640d52bd5mr11919424rwn.6.1708973015596;
        Mon, 26 Feb 2024 10:43:35 -0800 (PST)
Received: from google.com ([2620:0:1000:8411:4943:f730:fe3c:820c])
        by smtp.gmail.com with ESMTPSA id r32-20020a632060000000b005d30550f954sm4277845pgm.31.2024.02.26.10.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 10:43:34 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Mon, 26 Feb 2024 10:43:32 -0800
From: Minchan Kim <minchan@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, sj@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>, Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] mm: madvise: pageout: ignore references rather than
 clearing young
Message-ID: <Zdzb1LYhVO8byNQp@google.com>
References: <20240226005739.24350-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226005739.24350-1-21cnbao@gmail.com>

On Mon, Feb 26, 2024 at 01:57:39PM +1300, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> While doing MADV_PAGEOUT, the current code will clear PTE young
> so that vmscan won't read young flags to allow the reclamation
> of madvised folios to go ahead.
> It seems we can do it by directly ignoring references, thus we
> can remove tlb flush in madvise and rmap overhead in vmscan.
> 
> Regarding the side effect, in the original code, if a parallel
> thread runs side by side to access the madvised memory with the
> thread doing madvise, folios will get a chance to be re-activated
> by vmscan (though the time gap is actually quite small since
> checking PTEs is done immediately after clearing PTEs young). But
> with this patch, they will still be reclaimed. But this behaviour
> doing PAGEOUT and doing access at the same time is quite silly
> like DoS. So probably, we don't need to care. Or ignoring the
> new access during the quite small time gap is even better.
> 
> For DAMON's DAMOS_PAGEOUT based on physical address region, we
> still keep its behaviour as is since a physical address might
> be mapped by multiple processes. MADV_PAGEOUT based on virtual
> address is actually much more aggressive on reclamation. To
> untouch paddr's DAMOS_PAGEOUT, we simply pass ignore_references
> as false in reclaim_pages().
> 
> A microbench as below has shown 6% decrement on the latency of
> MADV_PAGEOUT,
> 
>  #define PGSIZE 4096
>  main()
>  {
>  	int i;
>  #define SIZE 512*1024*1024
>  	volatile long *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>  			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 
>  	for (i = 0; i < SIZE/sizeof(long); i += PGSIZE / sizeof(long))
>  		p[i] =  0x11;
> 
>  	madvise(p, SIZE, MADV_PAGEOUT);
>  }
> 
> w/o patch                    w/ patch
> root@10:~# time ./a.out      root@10:~# time ./a.out
> real	0m49.634s            real   0m46.334s
> user	0m0.637s             user   0m0.648s
> sys	0m47.434s            sys    0m44.265s
> 
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Acked-by: Minchan Kim <minchan@kernel.org>
