Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE8D23D7E0
	for <damon@lists.linux.dev>; Wed, 31 Dec 2025 05:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767158887; cv=none; b=XBQjM6nxhVJ1n4FLGcBmeXpLuyWY/GA4kYBsr6Adpq6vukqrPbx2U0T7sw+5Lf5eHOZnitSGpyNK5cYAYwLtwOpEl5ioNRS3J6xuwb6EzZZwdqyzzCbH7uiAVmnIg+oZLEvG8whNKBynAOB3ygJj/gbJ6jWAjLYFUAvQQxTvRdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767158887; c=relaxed/simple;
	bh=WR+6+OUkqQr+Y5lDdNxUM3EuAUXticwgpKYJ7Mc9H1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWFL3dzK4PqxAnbOX5XSNLFjX72z8PmKksa5H1o7tWg38W5Dqk6t3HlE0QIM9MKQPWj/hYDe0o5S5NQdIT1NSiZVrH5PIgUIBaruPbaITLadJ7tFRU9VjNL0x0sga40pi75ua6L3eEfQYG0DJEzH03oBybnUDYFI1mCOsjdYRyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuG3uyyD; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuG3uyyD"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6446d7a8eadso8629656d50.0
        for <damon@lists.linux.dev>; Tue, 30 Dec 2025 21:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767158885; x=1767763685; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=neE2xjkWXwgvUgGg5ZJ/mbPsEp4n4zK4JeRN0ZAZy7U=;
        b=KuG3uyyD5UAglPRHYyIzTfm2y1VokvizA2Tv5OwrDmB4frAU3CJedGB3QqCC1fAt+A
         R7dKDfWL6V2pyoXxFUcjsAfv92rR75uZWN5OjbVtZskfhIohfOlRm6MrGamt+J+WkyDm
         Q8km7LIMfAn2/y+4wkt+y8BuOoJ1MUTokVex61/Y56lQ10nSVAmkCRCSPpFTDUtH9UoR
         zkmBrwuqhHjtIz00AgRPF8Zvsh8QO+bvLk20f0BiUbwMTXxrHP1P2ld5sVRPBh/FvRQB
         j1qHaN21aKKBeUcjjintn4nx5Tvn28wasoEFTy/bIjczkmG/bKZeFlpeiJjVUpSAzDvu
         ZWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767158885; x=1767763685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neE2xjkWXwgvUgGg5ZJ/mbPsEp4n4zK4JeRN0ZAZy7U=;
        b=i89YqzmLmbiRdjAh5PLQczoz1OsgDTSrek+f/0gADPJ4A/wCzWcKVeItl0bAwu8JIl
         bQhBHyLvoseSpoCFIhij2/AoA5pRmdVK5hKp9bvy0onrcvICy/E+LbJ/c9Hi0gq/TOCM
         iYzkgC823GudbNPeVZveOHSrMTiGL+WdcKxW7ecdMwud4KisBgB3X9qwRFmnltjpZCEm
         bfa5FijzZorZ4HTmNv2uii/WnPB4Ai3N6flTR3uq6hUIQXv5f/79akQcMK5eFaYIRsVR
         /u923imc9Er/oehIe6IWWLsHulVmXvomAd5uIsfUhPtZhjd280FIfF9pTnolrdVAR2Kx
         qLpg==
X-Forwarded-Encrypted: i=1; AJvYcCVnqa4f2/i8vCPPQSvky3A3Qjg/OVQNFTMukjzPwYCvST3UNChjuiBgz8hqT7sQ5lDBBolwuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgLD0dHrO9U/7gA+vwzTtKL1bqLOKI0blpPeOHBcnuqDmHUQCX
	hB09sdD6I+ZN51tODXBGQKRKB5L9kHO0YXEnPf/QTk1EP72EGSULIhX/z1kjWdvf4kTq+m96dEO
	ko/iOYBKLh1HpZQA8N7GriM7Sccpmge0=
X-Gm-Gg: AY/fxX62biBW1DCw7fg6iYB2VQlBKyYzv2trVa0949to8Xbp6oZLeuI8Cklfh63FYTH
	6hXxdC37lXw8eelsaLErZZbRYF9WvjUbTZpe+eifqacm+WHfquZFc4X4TFLFHoXjg84otyurhNa
	Y12oha+bjmSgVJYcVz3kwv1q1FD715dMWb94zXY1zOzzqQr9x5v9ljmXL6+z9LuUtlkCfxWTbS0
	VvhYUmAwZyQodE2RrAvJGAKdFut9Cv2TLn0VIy2Jf9nk6eU6TK9ECSopm/fuZwnQ4zDA8FhP2fN
	W0duANI=
X-Google-Smtp-Source: AGHT+IEXZaIdD+WLGv3jQi1HvQb+WET+wjlJvMaD1oEmCvE1HqOdYGi+snxXD9Pe5VDdymn3M0Y1Zoc0IoKr3Gc7U/Y=
X-Received: by 2002:a05:690e:bcb:b0:640:dfa4:2a6c with SMTP id
 956f58d0204a3-6466a8b6e4fmr28144084d50.63.1767158885298; Tue, 30 Dec 2025
 21:28:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251230034516.48129-1-sj@kernel.org> <20251231012522.75876-1-sj@kernel.org>
In-Reply-To: <20251231012522.75876-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Wed, 31 Dec 2025 14:27:54 +0900
X-Gm-Features: AQt7F2qc4ikpHLFjT-n4BMfolCsHaYaz_KyU9_25Xqa-F_N79PKbP9l9_QEVNRY
Message-ID: <CAHOvCC6F5zLnBF=v7G5k1WdDZZmkBAK94ixzLiPF0W53wdtyeA@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: remove call_control in inactive contexts
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "# 6 . 14 . x" <stable@vger.kernel.org>, 
	damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Dec 2025 at 10:25, SeongJae Park <sj@kernel.org> wrote:
>
> On Mon, 29 Dec 2025 19:45:14 -0800 SeongJae Park <sj@kernel.org> wrote:
>
> > On Mon, 29 Dec 2025 18:41:28 -0800 SeongJae Park <sj@kernel.org> wrote:
> >
> > > On Mon, 29 Dec 2025 17:45:30 -0800 SeongJae Park <sj@kernel.org> wrote:
> > >
> > > > On Sun, 28 Dec 2025 10:31:01 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > >
> > [...]
> > > > I will send a new version of this fix soon.
> > >
> > > So far, I got two fixup ideas.
> > >
> > > The first one is keeping the current code as is, and additionally modifying
> > > kdamond_call() to protect all call_control object accesses under
> > > ctx->call_controls_lock protection.
> > >
> > > The second one is reverting this patch, and doing the DAMON running status
> > > check before adding the damon_call_control object, but releasing the
> > > kdamond_lock after the object insertion is done.
> > >
> > > I'm in favor of the second one at the moment, as it seems more simple.
> >
> > I don't really like both approaches because those implicitly add locking rules.
> > If the first approach is taken, damon_call() callers should aware they should
> > not register callback functions that can hold call_controls_lock.  If the
> > second approach is taken, we should avoid holding kdamond_lock while holding
> > damon_call_control lock.  The second implicit rule seems easier to keep to me,
> > but I want to avoid that if possible.
> >
> > The third idea I just got is, keeping this patch as is, and moving the final
> > kdamond_call() invocation to be made _before_ the ctx->kdamond reset.  That
> > removes the race condition between the final kdamond_call() and
> > damon_call_handle_inactive_ctx(), without introducing new locking rules.
>
> I just posted the v2 [1] with the third idea.
>
> [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org

I generally agree with what you've said so far.  However, it's inefficient
to continue executing damon_call_handle_inactive_ctx() while kdamond is
"off".  There's no need to add a new damon_call_handle_inactive_ctx()
function.  As shown below, it's better to call list_add only when kdamond
is "on" (true), and then use the existing code to end with
kdamond_call(ctx, true) when kdamond is "off."

+static void kdamond_call(struct damon_ctx *ctx, bool cancel);
+
 /**
  * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
  * @ctx:       DAMON context to call the function for.
@@ -1496,14 +1475,17 @@ int damon_call(struct damon_ctx *ctx, struct
damon_call_control *control)
        control->canceled = false;
        INIT_LIST_HEAD(&control->list);

-       if (damon_is_running(ctx)) {
-               mutex_lock(&ctx->call_controls_lock);
+       mutex_lock(&ctx->call_controls_lock);
+       if (ctx->kdamond) {
                list_add_tail(&control->list, &ctx->call_controls);
-               mutex_unlock(&ctx->call_controls_lock);
        } else {
-               /* return damon_call_handle_inactive_ctx(ctx, control); */
+               mutex_unlock(&ctx->call_controls_lock);
+               if (!list_empty_careful(&ctx->call_controls))
+                       kdamond_call(ctx, true);
                return -EINVAL;
        }
+       mutex_unlock(&ctx->call_controls_lock);
+
        if (control->repeat)
                return 0;
        wait_for_completion(&control->completion);

Thanks,
JaeJoon

>
>
> Thanks,
> SJ
>
> [...]
