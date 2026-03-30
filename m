Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729563C3426
	for <damon@lists.linux.dev>; Mon, 30 Mar 2026 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900272; cv=none; b=FNsL1wX/GtN3q2offH4pikZCPoswv+h31N/x6H8dZoTAKmq0XzDCkJJpmys222/45looGIfKcFqDvf7FNUs4jEozq7Q9MToFsDKrXY4N5STCo3n6Y0tGz2Jgl/dunjQ56MgZ5DdeEkeq3f+vCteMdwLDTnAVGtyrFFy14g4V3LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900272; c=relaxed/simple;
	bh=9L1cA9vTygIkhYV1en7DF8nAQihNgI5jM70ZDTI8hgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tunkwUEH4HACzFOugG2wIa7KO4OlJcsHICY3Z9GJob5BrjUylCgvPzEwp/ZCzZkfqlMlrzAHHfzpvhSWuhZNcmU02HQbEEhFguTQz4mgBQSYVRQMw2BGrNYeyKEZqjqVnmk/YMg052iSdS1Hc6Go+APuhFOcPIdJNW53LvlTd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Krltcl83; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Krltcl83"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d9827661bso1124704a91.3
        for <damon@lists.linux.dev>; Mon, 30 Mar 2026 12:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774900269; x=1775505069; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMb9m9x8HtmjF/C+mcgDOPYpBJhNZyScWz814Eqb+bM=;
        b=Krltcl83t8D0tv3EbuBAj4dyiuq/6ZgSwM7mSagT+L2ywSTQRX2cerlOOunNEnjYlP
         biJUp7OH7h8i00p6mXf8JuE/G9CdxGoNdiZA/T1PjGcmcXhTBjx8omKVPonU9u5wA2C1
         /t2E8NXQWSknEt4+1r0Y5vw4evQ70mxe6u5tLdW/wpNpVodcRa2lxEmjvCAJgowbw2rY
         IF2OXpPya7f8uVmthQZfEUrSaeTqeFopSPW85VnvacRNtJNZtFmcFf7QMs9CwPe/kJ2c
         MHU0Ecr7H/y0NrIZ90Jsdc3wAy29A1ZEhPoY3oD7zxixpZZq5xVCVDGfZ7esvnGq6ihd
         v5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774900269; x=1775505069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AMb9m9x8HtmjF/C+mcgDOPYpBJhNZyScWz814Eqb+bM=;
        b=m1eCQpiDTJyyn+4h5oQ6+/OMBQSKlL6q+0bwi2SX4ae3ryw1qnYoMBhV8Ild5ImlTk
         TaNRq13XbmIoHQt/v+IV3BT5iT9GS0ccggIV2ULCLVVYdjy/vl3o9/Q+EqEDJAIi25gi
         o17scuxxYZ+NE4KDziH9H7liYro4MP8MInfsk2bMhTGI92Z5+QwefnNNj7XAY1c3iF8x
         pv0Aq8d0pNkTsh0gqB/R0AWAOMGwFxk++AMfmtxzeBWlWkrR/I2YpVvoEL1yLVAZhLcB
         LX19TuvVmS9IvZq+qTyqzTxRbPiLGcQtuTL4wIZVeux2jL91vV8rI89UFgok3lLcTYcC
         BviA==
X-Gm-Message-State: AOJu0YwXc+NtQDKpNFyQVNz+pyL/fJySlGX1CVIwARnz3MiZEidAKFRh
	ZGsQFYNGHY/0ZPhaU85DrBQvINLGIZSyliBV1tfMPrHcjopIdKygv1DW
X-Gm-Gg: ATEYQzzsASDqPCb5ID/k+CYJrQL/ewVcYlRYvm5J5l/DYW1hHeWtpcO4LoizfrbL087
	o9/RYVaLCT7zitTLXoWa8Xo8D6WPnMR8uSlFrJm3L/PzcRgalyouo99LDjdfcWn6NzgnLU0VoRn
	B7rGTJhTaaHXf5lxuy/o2En97jx6IT5iO9FT6xr7uqvrWP+LIxAzmo1Ix8mECVJhVkGnC8bxKjW
	t3pmeW8onl9iUkLtGQVyX3w8CwcVFJUiQtGhs3c858aiecDQ0/N/mI36P63e6ZXRDtTaTczYb2D
	F0a/l9laZFoBrAxS5U2bCNj0pHQaZvNcoetv/b1XnzJ6ui2LHRrV4fqeujO/B0cEw1yrx07vl3Z
	ywYPKYQ0bcwJM9p3mfr3+EtY68C9ZIAvsvDKhvs5hYe5OvBcBtmokCss2z9uqUk86SKQihH3C9q
	6m7j4YeIKf3RO+ys+z1FM/YDalb1Uh3KDg5lX1MJhxqT0HGB6XHuk=
X-Received: by 2002:a17:903:1c6:b0:2b2:5a5a:4f2d with SMTP id d9443c01a7336-2b25a5a5320mr24976745ad.31.1774900269466;
        Mon, 30 Mar 2026 12:51:09 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427658e4sm108071895ad.48.2026.03.30.12.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:51:09 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com,
	sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Tue, 31 Mar 2026 03:51:07 +0800
Message-ID: <20260330195107.71609-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330185347.45872-1-aethernet65535@gmail.com>
References: <20260330185347.45872-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [...]
> > @@ -2941,6 +2944,14 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
> >  	}
> >  }
> >  
> > +static void damon_update_thread_status(struct damon_ctx *ctx)
> > +{
> > +	if (ctx->thread_status.kdamond_pid)
> > +		*ctx->thread_status.kdamond_pid = -1;
> > +	if (ctx->thread_status.enabled)
> > +		*ctx->thread_status.enabled = false;
> 
> Can this write race with the user enabling the module? If a user writes 'Y'
> to 'enabled', the store function spawns kdamond and prepares to set 'enabled'
> to true. If kdamond exits immediately (e.g., due to invalid targets), could
> this line asynchronously set 'enabled' to false before the store function
> overwrites it with true?
> 
> If so, the system would be left in a state where the thread is dead but
> 'enabled' is true. Subsequent attempts to write 'N' to 'enabled' would fail
> on damon_stop(), leaving the module permanently locked.

You are right. I now see the potential race between kdamond exiting and
the enabled_store(). While it seems unlikely, the window exists and
could lead to an inconsistent state. I'm sitll thinking about the way to
synchronize this without introducing new issues. I will try to address
this is next-version once I have a solid plan.

> > +}
> > +
> >  /*
> >   * The monitoring daemon that runs as a kernel thread
> >   */
> 
> [ ... ]
> 
> > @@ -3065,17 +3076,23 @@ static int kdamond_fn(void *data)
> >  	kdamond_call(ctx, true);
> >  	damos_walk_cancel(ctx);
> >  
> > -	pr_debug("kdamond (%d) finishes\n", current->pid);
> >  	mutex_lock(&ctx->kdamond_lock);
> >  	ctx->kdamond = NULL;
> >  	mutex_unlock(&ctx->kdamond_lock);
> >  
> > +	if (ctx->thread_status.enabled && *ctx->thread_status.enabled)
> 
> Can this access freed memory? If the kdamond_lock is dropped and
> ctx->kdamond is NULL, damon_is_running(ctx) becomes false. If a concurrent
> sysfs operation removes the context, could ctx be freed by damon_destroy_ctx()
> before these lines execute, causing a use-after-free and memory corruption in
> damon_update_thread_status(ctx)?

I have performed tests with KASAN enabled on virtme-ng. During multiple
start/stop/fail cycles, KASAN did not report any UAF.

> > +		pr_debug("kdamond (%d) crashed\n", current->pid);
> 
> Does this log normal user-requested shutdowns as crashes? When a user stops
> the module by writing 'N' to 'enabled', the parameter store blocks on
> damon_stop(). Since the global 'enabled' variable is still true at this
> point, won't this incorrectly print a crash message instead of finishing
> normally?

Thank you for reminder. This logic is indeed redundant and pontentially
confusing to users. I will restore the original output in next-version.
:>

> [...]

Best regards,
Rui Yan
