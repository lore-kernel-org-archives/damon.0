Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40C3DFC62
	for <damon@lists.linux.dev>; Mon, 30 Mar 2026 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896831; cv=none; b=F5vQrs7mF50jyjwxGYkeF2ZiO8USRTWce45L2uKSbUH0SDngNALmUw8o0dpEuvzfw5rRszoKLP3esPO8md+kM1UkeKJClnPl1NqFh8oJFAdk8RKprgbyGQDofnwojj1TF8gUsBHBSYwN9ucDGOLWb0YqHE3qHuMsSdxnSeQRaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896831; c=relaxed/simple;
	bh=ipy+D9Iv7mdp387NSVOoc5MeOQGDThhtKrfERPOwO4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTKSUuPGnIBQthIGl2vNmb/NPM1+DMZKkS/PKNHpPCrJj6QatEl2TB3jI6w2VIHuzOzX5hV1wJehrrqguSSfiK80ajknRBkSWkh3SK8NS1C9PaPsRAOAlGQxialZBnZP0RfwClZhdPOw8/ZGQ72eheBY5uR9j/zj3C83v4unbzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjUJe2ay; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjUJe2ay"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso2021806a12.1
        for <damon@lists.linux.dev>; Mon, 30 Mar 2026 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774896830; x=1775501630; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOPmx7D4lJnGv8mhfy1r+7P3JieUvPPQgAmz2i26ZRY=;
        b=kjUJe2ayYCKKZ8ikUnwWGy3slD9QCsyUdJHeo9h5PzNzZBm/QCgMwygkxBO/7sO4A2
         zOkGv3trvaog4/wxvaV17au7V9MLw9Ic5va8NrJ0jOzMQdu5DEVk44D5gtUiRzCHPBdi
         aEE6RaytR3MuWCtl1ROZPuNsyzeGPEh9yr2hUjOGlEZlPMvuBVVgkHu9yjFpqrsehJkx
         fU0It0U4Rpgn1EKy5a+eIliuq+5fFyFpukUGYf3xxsf7Um1aWgxxePSPF6Ac6imjaddR
         6MLmaZXIhKi3tnldPagpmsjoS8+1sS6zgcNx5asL1piB0BBf9aY+oqgiOTTlMyurCBIl
         T4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774896830; x=1775501630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gOPmx7D4lJnGv8mhfy1r+7P3JieUvPPQgAmz2i26ZRY=;
        b=nlX6b6bXT5AlIYw01MjP1M2G2aMqtm3TMcQau32Zbtpb99ttnlF+bRsW8CtwXoq36b
         QV4XlwMei0a2iYBjnl6K7gunMjy51KJtyAr4rRZ0Qbl8p/v48vhsa2/QozNxSmvDkYpH
         rX1a4VHrRNuCQDiECJAAtmDn8PlXq2Gm1Az5HmnD1emhIdpynzcnjUbq1hBHe3N3Alfv
         AWO+X25yyJhCgVcLFVIG8DApksHn8WlTyLoNWBDiT1pcN/0Q+BjUuFarL+qhev4bkyOG
         sDUgtpk5vBDJ8i+tfWRvpFdk9FJCXkqNqHQvMuxYT+yHhPS6/a4OZzz2MHbgkxUCfkr0
         xdyw==
X-Gm-Message-State: AOJu0Yx58X5CpAXAn52RDowGteZxVHmbut92axfUAHQ+QyHwjBUFi5dU
	jeM5AO98nhxDnWInU+akyG6/D9BrCxnaK5B25hfCTMaVI2zvQ0LI6ZUr
X-Gm-Gg: ATEYQzyslNm7WocNA/L7kgWB2KWZ8hG5oW8/4q97X6I7nN9wDK+8h3IC6noXMfINGgM
	aNhVnnGObi37yb5AJLXhP1WD54cBXC2C3gqu928L7NK4TvSBAH63un3ndeLNLzw99LyuAmgIFsk
	ry6cuUcP7D2EUBGDs1xTmYW4nHzo4pvrOg3RRUY+JC898HcDieZe948x76prHb2DowpDrUISLdQ
	sxRkkKAoClUGfn8SbEcxngatu2NTsrrKNX/RQPv0AOZTqvQ7YSSy+RFtHcZRn//gumTKpWMXOtq
	laQ8Y6Okrq4aJJ3Dln3Y/9cHSDEPrIFdPn9DSuTq1Z5d8eGTzWeV6Jr9tJHx6a6KJcRaE7yHLRk
	WsJfRe4RLaQWYkRqqqJYODxUCrifFi+HJMoVb3CbJwN3P4EzYzCTJnNy1ujxKHLuOxjJyFSXObp
	YsxnaRxkF9GMjGVEa0Bhh7RwmAraw65tNIlF3ivVHnwqKg97Nh5pg=
X-Received: by 2002:a05:6a20:938c:b0:389:8f3f:50ce with SMTP id adf61e73a8af0-39c87b5fb6fmr14525878637.56.1774896829730;
        Mon, 30 Mar 2026 11:53:49 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76916baa6asm6708324a12.4.2026.03.30.11.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:53:49 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: Re: (sashiko review) [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Tue, 31 Mar 2026 02:53:47 +0800
Message-ID: <20260330185347.45872-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330164347.12772-1-aethernet65535@gmail.com>
References: <20260330164347.12772-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260330164347.12772-1-aethernet65535@gmail.com
# start of sashiko.dev inline review
commit 636b179cc5df5a638d7988bd9de56ce4d8602f4a
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon: reset thread status parameters upon kdamond termination

This commit introduces a thread status structure in the DAMON context to
link the kdamond state with module parameters. It updates these parameters
when the kdamond thread finishes to reflect its actual state.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index db6c67e52d2b..6c71203beec5 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -2941,6 +2944,14 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
>  	}
>  }
>  
> +static void damon_update_thread_status(struct damon_ctx *ctx)
> +{
> +	if (ctx->thread_status.kdamond_pid)
> +		*ctx->thread_status.kdamond_pid = -1;
> +	if (ctx->thread_status.enabled)
> +		*ctx->thread_status.enabled = false;

Can this write race with the user enabling the module? If a user writes 'Y'
to 'enabled', the store function spawns kdamond and prepares to set 'enabled'
to true. If kdamond exits immediately (e.g., due to invalid targets), could
this line asynchronously set 'enabled' to false before the store function
overwrites it with true?

If so, the system would be left in a state where the thread is dead but
'enabled' is true. Subsequent attempts to write 'N' to 'enabled' would fail
on damon_stop(), leaving the module permanently locked.

> +}
> +
>  /*
>   * The monitoring daemon that runs as a kernel thread
>   */

[ ... ]

> @@ -3065,17 +3076,23 @@ static int kdamond_fn(void *data)
>  	kdamond_call(ctx, true);
>  	damos_walk_cancel(ctx);
>  
> -	pr_debug("kdamond (%d) finishes\n", current->pid);
>  	mutex_lock(&ctx->kdamond_lock);
>  	ctx->kdamond = NULL;
>  	mutex_unlock(&ctx->kdamond_lock);
>  
> +	if (ctx->thread_status.enabled && *ctx->thread_status.enabled)

Can this access freed memory? If the kdamond_lock is dropped and
ctx->kdamond is NULL, damon_is_running(ctx) becomes false. If a concurrent
sysfs operation removes the context, could ctx be freed by damon_destroy_ctx()
before these lines execute, causing a use-after-free and memory corruption in
damon_update_thread_status(ctx)?

> +		pr_debug("kdamond (%d) crashed\n", current->pid);

Does this log normal user-requested shutdowns as crashes? When a user stops
the module by writing 'N' to 'enabled', the parameter store blocks on
damon_stop(). Since the global 'enabled' variable is still true at this
point, won't this incorrectly print a crash message instead of finishing
normally?

> +	else
> +		pr_debug("kdamond (%d) finishes\n", current->pid);
> +
>  	mutex_lock(&damon_lock);
>  	nr_running_ctxs--;
>  	if (!nr_running_ctxs && running_exclusive_ctxs)
>  		running_exclusive_ctxs = false;
>  	mutex_unlock(&damon_lock);
>  
> +	damon_update_thread_status(ctx);
> +
>  	return 0;
>  }

# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260330164347.12772-1-aethernet65535@gmail.com
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260330164347.12772-1-aethernet65535@gmail.com
#
# [1] https://github.com/sjp38/hackermail
