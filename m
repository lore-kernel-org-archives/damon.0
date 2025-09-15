Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB681311589
	for <damon@lists.linux.dev>; Mon, 15 Sep 2025 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948753; cv=none; b=Lsm0E21lR+9J7Y6NMY9pKv2m+7Q5jnRKeUDogQRa3ny1HMlTr/vI05agFy5UbZ76p5dOeVWial7ONDX1gtgPDjEVQmoGo+/iBW51FviZa7WVAfccV1pPGJ89uvWBqBYde7nC8AVJwqtYOpTiHqAI3qXJLqguZwlUuvsjhEAu+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948753; c=relaxed/simple;
	bh=Y+OAfwjN2zLWZP+9G119tAeZdgN0q8dCC78S2c4KhVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEC3phte/+BOiYWC1icvuq2PNyBosi7M+VpgqgTKslFGfbHusHuyIx7aKfN4nqbXHTZ7W17oxzjzSbUYoNb+pXNGMwGINkz2ePx3v+/RIhm2K6u2SwrTHdUGq5YLOBTlgYcEBhXLVXDWe8+9BQXqbX7xH2qJvcxxAIl/d057PSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHB/xiC1; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHB/xiC1"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d603cebd9so35253227b3.1
        for <damon@lists.linux.dev>; Mon, 15 Sep 2025 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757948751; x=1758553551; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fZzkxHP1OOwmzsUzfvvWxxzPkZrOBgcHf91zQ9q6bA=;
        b=UHB/xiC1n4PqPOzR+5PCRqc9RDdPVS4Ezny11bOf1jEBIUfzyiKr21cw7prlsN/s5p
         pQdD4EkLX+ZmMsvQOz3xdSHqH8hWJ4ra5t+2LaNYoBAY+R1aPXdClEkgAnawY81vL9Qs
         OiOgXDaBbKpDDiWfXXNCbsVgq2DvBLiesRj7P2Hl6pCJJ0Uzzeha7ZW90wOvF0da5sDm
         ABK99BOj+3uwrZRJH7HYX8yxhL3L11lm2feFoNBUSagPKAhnZnKDq9Dt53EgNZtAa1z9
         Sz8FRipCZ1AALo0nFqMDLXIftKK5VIPHVBzx4lhjFI3dLmVTtZJsK5AwomeC6hDruHsF
         1sZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757948751; x=1758553551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fZzkxHP1OOwmzsUzfvvWxxzPkZrOBgcHf91zQ9q6bA=;
        b=UnmhDpzlZCmFDHPrXaGPRT3oIqcLzndyoO3edDY5Xgmvetxqfz6vxyROf0l5hiZBaw
         TO2o1pDhLBKU0a0aZ0yU3IwM67Hhh8O9/V1pk0xXu2l/G/0y644o+O/U2Rwnl9lNU7DM
         aSUEzaRRgM/ve94OHisCRGcWM2Q2pu0NDf/Df0fOuEDYBAE+ROSrRiOhavxg69dHCzdL
         f4/FyvpQbK55X3ziNMHtqSivj1PZVHkW1SBBcWiJSZLfMJAklr2MAdFUhylE+cY/q9O+
         sYr1ZzWU+QWawXB2bzuuZ0zAhSx1lDLe44Ql7qfAEPEZkUgeCQt7fvWDwWZJY6MRZYrk
         s34Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvL/F5H1K4EZE1faQEHHbmjo2UFVkXM/sDd9tgXaEiDXc3Mk2t0RwD2p6GMypJjaWRIHHgxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwozODqlZzg7gnu3QCr3c59J4iwmEwQgT7SFggJsxGXJ9pjsBg+
	F51zkPZkzaJDcSRXt4vCiH0SejUYZROCOOMNNWUprBNnuaz3zExqDX0+
X-Gm-Gg: ASbGncv8Z5iM/BfLpuEdf73+XeVpotxD4odLU3qEFFpfNxypB+CcdJaItYq01byDgnl
	W2Ki7qpXeYYQBu6QhU7tmCmEX4MM64y2XbsTIK3PdVggvqw3/DuelAqAqTKZYrFR9XbOJc5dSoI
	WjGWlyrUj3HPs+gaAc/BL81UcPcU5nDdfs+T3c2wjZ9vjs6se3Uv1yvYVdBhvVUhTmgjCcVRsjG
	BjUQbvP5Al4BDFVa0Yx//TA00jBiKHJ/pIkFnYGZ59gAdi0GPI+eEXEQaXxmdpPTMCPBRrqJntS
	IeloJWI96c9ZP64HTpSHPy7IiugKT5mFStnxEYc/kf1xjkiAG3NViV/n4ICQBUWsmV9HbSTgM4l
	4y8ensY5LDGRAJcQfwgXdwiIoEiSTnGJrAV9oMk06BoRCs3OqX49uy8ct4nuo5SF5
X-Google-Smtp-Source: AGHT+IFVR4/jZB2COJFPEGxfd0jRNijX9bwoQRclaQiC53MprmBZ+9vZhNJplkD1Ak6GytefEA05oQ==
X-Received: by 2002:a05:690c:4904:b0:733:af83:51b2 with SMTP id 00721157ae682-733af836cf2mr41991207b3.45.1757948750534;
        Mon, 15 Sep 2025 08:05:50 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:55::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f76238386sm32849077b3.8.2025.09.15.08.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:05:50 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/6] mm/damon/lru_sort: use param_ctx correctly
Date: Mon, 15 Sep 2025 08:05:47 -0700
Message-ID: <20250915150548.1486984-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915015807.101505-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 14 Sep 2025 18:58:04 -0700 SeongJae Park <sj@kernel.org> wrote:

> damon_lru_sort_apply_parameters() allocates a new DAMON context, stages
> user-specified DAMON parameters on it, and commits to running DAMON
> context at once, using damon_commit_ctx().  The code is, however,
> directly updating the monitoring attributes of the running context. This
> doesn't cause a real user problem but apparently this is an
> unintentional mistake that can cause code review confusions and future
> real problems.  Fix the wrong use of the parameter context.

Hi SJ,

Thank you for the patch! I am a little bit confused by the behavior in
damon_lru_sort_apply_parameters. I was hoping that you could help me understand : -)
In particular, I think that this patch fixes two possible user visible errors.

My understanding is that we want to make changes to the param_ctx first,
validate the changes, and commit these changes to the global ctx struct at the
end. In the middle in the errors, we can abort the operation without committing,
and ctx will remain unchanged.

So to me, it does seem like the current code could lead to some visible effects
from the user's perspective (error-handling case).

Also, I am a bit confused by how the commit is currently called. We have
err = damon_commit_ctx(ctx, param_ctx), where the first argument is the
destination and the second argument is the source. There is a bit of a mismatch
because in the current code we have the following:

+------------------------------------------------+
|              ctx                    param_ctx  |
+------------------------------------------------+
| New &damon_lru_sort_mon_attrs                  |
|                                     New scheme |
| attrs overwritten to NULL	  <--            |
| scheme rewritten to new scheme  <--            |
+------------------------------------------------+

So in particular, the global ctx will never have the correct attrs pre-patch,
since it will always be rewritten by param_ctx, which never had its attrs
initialized.

I hope this makes sense : -) All of this is just to say that this patch does
more than just improve review confusions -- I think there at least two errors
that this fixes for the user. So perhaps a more descriptive commit will be
helpful in the future, since we are also adding a fixes tag?

Thank you again for the patch, SJ! Feel free to add:
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Have a great day!
Joshua

> Fixes: a30969436428 ("mm/damon/lru_sort: use damon_commit_ctx()")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/lru_sort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 14d31009c09e..ab6173a646bd 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -219,7 +219,7 @@ static int damon_lru_sort_apply_parameters(void)
>  		goto out;
>  	}
>  
> -	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
> +	err = damon_set_attrs(param_ctx, &damon_lru_sort_mon_attrs);
>  	if (err)
>  		goto out;
>  
> -- 
> 2.39.5

Sent using hkml (https://github.com/sjp38/hackermail)
