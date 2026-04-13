Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D6E371D01
	for <damon@lists.linux.dev>; Mon, 13 Apr 2026 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776117909; cv=none; b=Wrre8c/s6jJHi35pfgzJmxtt2BaC1WQgZjVAe8HxkomFL27HBEztNwcw0l7/r/ewP8fYr84aXYwJJDgrrLz0iZHi+Oj1czp1+3Xe4e8yOtDfj/jwcefNl5K1PZZ8BGBsp4GvLd0wu++z2/dqWwH8Ztg97KgAqlcABhM1Mh0tR/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776117909; c=relaxed/simple;
	bh=oDzQhKrAp6F/AWq1e9WOn/UKlJWK8YCzISRNZN2ST3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuIi9nPZ/JVqgiUKTezLOpmHTPUVUjV3gZOox9zNUnh/DYyfBYg6EwHd3DW8TKvxCCZFM5ev8fkv3yeO14sARDaedhzFk4b4Ipk9rVdLU/Nbl2thGeJ4W0sKErTcAUzibY2Q3cLlcKS7Mltyw7MKSX+3WG9W9q91Yk5z6CgslMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLRzPcob; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLRzPcob"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso3160887a91.2
        for <damon@lists.linux.dev>; Mon, 13 Apr 2026 15:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776117907; x=1776722707; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFqmvhvq87dy3WOhk3Zg6qiaEyb6f/a+2bHVxARmKOM=;
        b=DLRzPcobzJ3lUR+V5bVgB48DiHEOOa4/iI7mEHhTcUTJZ0nbndbsVGfF1q99ELieAl
         JKSlPC7qQYoseEQaQ4E3u24f0A2R0bMSSj1PwhWLRjBa6dWocTB0Fr3WTDk/gRiIm3sV
         MgTuhdNfwZYQ5+j6MdcSTmZq6D9vNfspf4dscAR3d+u7c9DDlb/jttSF3qv+77EEEfm6
         tAyPCvVWkG8/1z9XEU8x9ngw1TbBuy9ldMjVKLlnDcRUwKToQGCi4P+SsqXOckB63c8a
         ujcaklFdbHalYl7FS4h3u85H7EKX41cpmZmitCHUesS58Xz7e3eF9H0QZ7qObYCbWo5L
         qNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776117907; x=1776722707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hFqmvhvq87dy3WOhk3Zg6qiaEyb6f/a+2bHVxARmKOM=;
        b=Zg55/cFFmVuAG8RfjAIot1L5cCpls6z5/qmWcloTFhjMUnaCN7DpnhTtqIaR6Xu0pu
         /GUye4g3sSqY3Mzmxz5i+Tb+Drcl31ky4MPcp1YkF161/D+h6dyDLvgLax11coVx/yRd
         X4sTGL2BbniKV8+qXAJ5I/B1wf4vjd06fydQa/bvUm9/+E55WAg1vrNk/L8JV7gLFKW7
         O60fUgAIa7fh/2gLk+d4ncN6kef6A6e+PX+ddwHDeo/5Z2yr0xwlochCA0JLURr552SU
         NCMj3W4YmClWr4IUquVEQsdVjvG6el0mvZrtzVCE9Kmten0KXZ79rflbMxStKAfp3ZY1
         GQyg==
X-Gm-Message-State: AOJu0Yym711cNeRrDvJiR5GZvC7qxugAtWoe3iMwkTYHHAQQ248KPADh
	HxwVPmIi3CeoCX8EqXFhwj27xRjTuog/4o78R01tv7shk9l0WEwzQmRY
X-Gm-Gg: AeBDiesNSHZy7gTL9/wv16dWerlX7zg7bNcAiuXHwCoHQGNU1hfdqoVYfNJ1E58I1iV
	p3FMt7tXetyd/+/aKwfW2d6MOkKZN1vKNCxX6NnLD55Vc32zbTBt8AJFwPYZsKl9Yyic2pV5MC/
	W68usdVz1mO5wJmJ1qMDw8XYMfoQOHSEntNhHYph4CExf5nR9r9wUUpZWZYYeUETTBFSRTe7WtD
	LitvpRdbDxHKJVaKll/fRckr7DsX8lSH93klxYmxmsuMsclmVQ/BhB+JwvEFCFYm4PEZaWAvRwT
	OfDhi9ZkVbbHnOFcIV3DF1V0Y9Vbv/rTYu34/vA0VP+D4/aiPPirDqZFJ9k4Ya4mVOFJ1EEQwS1
	x6pQGRKn5gc5BnZXiUzHcIaynH2hJ8Lbbr9/ku68KgB1izbuWDky306yYDSv6Ztq7Z/J2r26Q22
	7Cwglr/qJT67IfKpMQIJdCuleEgrGvMbJ7GzIe3g==
X-Received: by 2002:a17:90a:d408:b0:35e:594a:5b6b with SMTP id 98e67ed59e1d1-35e594a62afmr7098853a91.24.1776117907376;
        Mon, 13 Apr 2026 15:05:07 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79219c618asm11103980a12.18.2026.04.13.15.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 15:05:07 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com,
	sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/2] mm/damon: reset thread status parameters upon kdamond termination
Date: Tue, 14 Apr 2026 06:05:11 +0800
Message-ID: <20260413220511.30677-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413185249.5921-1-aethernet65535@gmail.com>
References: <20260413185249.5921-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

I've reviewed the Sashiko report on [PATCH v2 1/2] and [2/2]. Since the
issues are essentially the same, I want to reply to them all in one
email.

# PATCH v2 1/2
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 554559d729760..96c8d0dfcafd2 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> > @@ -344,6 +344,10 @@ static int damon_lru_sort_apply_parameters(void)
> >  	if (err)
> >  		goto out;
> >  	err = damon_commit_ctx(ctx, param_ctx);
> > +	if (err) {
> > +		enabled = false;
> > +		kdamond_pid = -1;
> > +	}
> 
> Does updating the module parameters here require holding kernel_param_lock?
> 
> Since damon_lru_sort_apply_parameters() can be executed asynchronously by the
> kdamond thread when a user writes to the commit_inputs parameter, changing
> these variables locklessly might introduce a race condition.
> 
> If enabled is set to false here while kdamond is still preparing to terminate,
> could a concurrent sysfs write (echo Y > enabled) read the false state and
> proceed to call damon_lru_sort_turn(true) because it incorrectly assumes the
> worker has completely stopped?
> 
> If so, damon_lru_sort_turn(true) would call damon_commit_ctx(ctx, ...) and
> modify the shared ctx structures while the exiting kdamond worker thread is
> concurrently executing its cleanup block, such as damon_destroy_targets(ctx).
> 
> Can this concurrent modification of the context lists lead to use-after-free
> issues or list corruption?

# PATCH v2 2/2
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 86da147786583..e3e148fd80f97 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> [ ... ]
> > @@ -250,6 +250,10 @@ static int damon_reclaim_apply_parameters(void)
> >  	if (err)
> >  		goto out;
> >  	err = damon_commit_ctx(ctx, param_ctx);
> > +	if (err) {
> > +		enabled = false;
> > +		kdamond_pid = -1;
> > +	}
> >  out:
> >  	damon_destroy_ctx(param_ctx);
> >  	return err;
> 
> Can prematurely resetting enabled to false here introduce a race condition
> leading to a use-after-free of the DAMON context structures?
> 
> If damon_reclaim_apply_parameters() is invoked from the kdamond worker thread
> (for example, when applying commit_inputs) and damon_commit_ctx() fails,
> ctx->maybe_corrupted is set to true. This signals the kdamond thread to
> break its main loop and begin its teardown phase, such as executing
> damon_destroy_targets() to free lists.
> 
> Because enabled is set to false asynchronously here, a concurrent sysfs write
> of 'Y' to enabled will succeed and immediately trigger
> damon_reclaim_turn(true). This unconditionally calls
> damon_reclaim_apply_parameters() and executes damon_commit_ctx() from the
> sysfs thread.
> 
> Since damon_commit_ctx() locklessly mutates and frees items in
> ctx->adaptive_targets and ctx->schemes, would this race directly with the
> still-exiting kdamond thread traversing and freeing those exact same lists,
> resulting in list corruption and a use-after-free?

The core issue is - modifying 'enabled' and 'kdamond_pid' in the error
path of damon_commit_ctx() is racy.

My plan for v3:
- Remove the reset code in damon_*_apply_parameters()
- Keep only the fix in damon_*_turn(false)

This resolves the restart issue without introducing new races.
Please let me know if this direction looks good.

Small changes for v3:
- Delete a "=" at the bottom of "Problem" (commit message):

      Problem
-     ========
+     =======

Best regards,
Rui Yan
