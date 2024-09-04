Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728011E764D
	for <damon@lists.linux.dev>; Wed,  4 Sep 2024 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479899; cv=none; b=HyCgGIeDtGvfqbfmMHBrtQfZcOPjcbgmlNoPIU9aeGoAMw1EX5rulmM12GaI1RwEsZU9KonlyFpyOeV1fKTYYzpdLpuFi+VbkijKQ6lQM1gtKksAstFPq7r5st+4yZCcLPyjYqq3/RwNz6RlU2Sy98NLxFs4egbQq0Ieg2fy4UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479899; c=relaxed/simple;
	bh=zavzUwXlxjfb5MjitZxKh7537njoiHYD+hBJaxyi3B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tChPEIWAKW95PPVQ+Ee1u176AWFbvlRygTT6ry2PEkw3vsEEgD2qd7bHEyqpxiPR8lwWxiLMUVZDoblze/GrJ8CfR31zGz9TmXWyu5sfxsEkW47gt8vC5KnRJpgtsVlRfyliRKumDxPZc7mIiPabSwNzVYYnJzM1dRcsBa3yAUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMYcn28Q; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMYcn28Q"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7cd9cfe4748so29350a12.2
        for <damon@lists.linux.dev>; Wed, 04 Sep 2024 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725479893; x=1726084693; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPICdxGtZMm7EVbsBiDOXLzIL+MnaADtVMssqy1cp2c=;
        b=PMYcn28QvAGmvnjR1I7nNcITBK+xjN4Ztna3AlDMbxAX8OASknwdHMD5GFqWkIpoTN
         QtUvLjgWuSovTpjLrk7OAE4CrjCA53JfcTndx1LWzLzMuxLensYE0crMcDc33/C6MiBW
         DN3ccs3+TzEuO5gpzpMxnu4hcZfhABOGHlqTjtwKrfmfP4KelJOkTOUm7O786WN/dSzB
         Pbh4sydWesNbIJPY7zbIwRDctaPC2WN6qFCPyz2B6CB71eiaH7YWBfR7Vvao9QS71bRq
         gOB33mK/xom9tKKL2X38izGhL3A+4npzs8FxEL98XU/jAErKRV3J0Sa1qqpAi0CVSoOO
         i4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725479893; x=1726084693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPICdxGtZMm7EVbsBiDOXLzIL+MnaADtVMssqy1cp2c=;
        b=HC3uTJfCDmtfRbZnpR9ZEmj3g+E5sZqVWbt99RxZw4IOJ9x4V81haeS91mBgNjRXR2
         c5lnPLE9X7y7U8Zi9NhJlQiw5uShGj7u9zzm8tTsDMQhBqOYl1dOCDRPdt7OsfeWbmnF
         rk5qpQ1BcpyslHZJL8degPo7hWMr8maw5OcVvKiLQtixgWvF/5DVz24MhCPSMTE5rmGq
         XR6sotS21KnbhtVopEPaET2tra5C/D9Z5GOLIzWB5CtDe2/O6tveGd4XKZTiBo6C6pUk
         vkRm1bMMiTN7JniIJFUCfWeAZdBT54Jj1w3jPOrtC5d73pHt5W5mt0qcm70J5MXB4j6B
         WYkA==
X-Forwarded-Encrypted: i=1; AJvYcCUl+jRtWaPP9Ya4VUsXns2KHdOOuU02w7qSSuypS+3w6kjdi6SUiJKbroAG6xxpmhZC7T9JbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzorZA+AKNmWlf9BiXvLMV9y5c/MoX42g5GRx416cQgLXICJj04
	RnkRDQa2zdSHV/YhG4ZRyzO51P97eDPzqQvhxhoevdJ9MUsW92wv
X-Google-Smtp-Source: AGHT+IHiuHFL/47pKWStSEZDU1pmVIBJvuKjwmas3mljqR/n/RvBLMuLXDlS66q4XOAagB8218fbcQ==
X-Received: by 2002:a17:90a:70cf:b0:2d8:f12f:6bed with SMTP id 98e67ed59e1d1-2da5592440bmr7912187a91.3.1725479892758;
        Wed, 04 Sep 2024 12:58:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da53740084sm4907126a91.32.2024.09.04.12.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:58:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 4 Sep 2024 12:58:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/tests/vaddr-kunit: init maple tree without
 MT_FLAGS_LOCK_EXTERN
Message-ID: <b253cae1-8363-4f26-9698-97e76b4b17dd@roeck-us.net>
References: <20240904172931.1284-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904172931.1284-1-sj@kernel.org>

On Wed, Sep 04, 2024 at 10:29:31AM -0700, SeongJae Park wrote:
> damon_test_three_regions_in_vmas() initializes a maple tree with
> MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
> mt_lock of the maple tree will not be used.  And therefore the maple
> tree initialization code skips initialization of the mt_lock.  However,
> __link_vmas(), which adds vmas for test to the maple tree, uses the
> mt_lock.  In other words, the uninitialized spinlock is used.  The
> problem becomes clear when spinlock debugging is turned on, since it
> reports spinlock bad magic bug.
> 
> Fix the issue by excluding MT_FLAGS_LOCK_EXTERN from the maple tree
> initialization flags.  Note that we don't use empty flags to make it
> further similar to the usage of mm maple tree, and to be prepared for
> possible future changes, as suggested by Liam.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/1453b2b2-6119-4082-ad9e-f3c5239bf87e@roeck-us.net
> Fixes: d0cf3dd47f0d ("damon: convert __damon_va_three_regions to use the VMA iterator")
> Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes from v1
> (https://lore.kernel.org/20240904004534.1189-1-sj@kernel.org)
> - Keep lock usage and update the initialization flags (Liam)
> - Fix a typo: s/celar/clear/ (Guenter)
> 
>  mm/damon/tests/vaddr-kunit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> index 83626483f82b..a339d117150f 100644
> --- a/mm/damon/tests/vaddr-kunit.h
> +++ b/mm/damon/tests/vaddr-kunit.h
> @@ -77,7 +77,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
>  		(struct vm_area_struct) {.vm_start = 307, .vm_end = 330},
>  	};
>  
> -	mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
> +	mt_init_flags(&mm.mm_mt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU);
>  	if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
>  		kunit_skip(test, "Failed to create VMA tree");
>  
> -- 
> 2.39.2
> 
