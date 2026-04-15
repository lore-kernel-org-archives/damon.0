Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371C3806AB
	for <damon@lists.linux.dev>; Wed, 15 Apr 2026 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278710; cv=none; b=EKnN7099VoOto7EIDeTiWNE5k/Kmx9yYHO3n+yuZ4GQK3dTd5gm0oH8qHaA9pZA2bTSjX9kZ+17/o1bFqbCP88yK7stzNfOhs0OfP/LCt5Jr14WdkuchkqQrd6bksyRDnyRjGRN9dhHmMDbosr1SORzSTTeoYWxu7sKtapHoxa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278710; c=relaxed/simple;
	bh=wM+bhSSUxzMiE7Qosb576bXP5PjBB+M/j51wpfeuWYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofR5m3NJWx+vtnGHRklotYUqm2honYW79gFTxA+Zn8OjuhXyvX7knpewrVkDstN7SehD8eX+hRgVbjRSJKKsRwaG0QQ9jg0wZTGo/U0W7U9csyKPu4Aod5aj/PMLSP1ag9MXaE7WiZNyXsyXley4Xjzh23twSPhTrrKPmhwB+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCOvjZQS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCOvjZQS"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8296dabef74so6531314b3a.1
        for <damon@lists.linux.dev>; Wed, 15 Apr 2026 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278706; x=1776883506; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WupQx6W6/LXfROgbPlaGvE5ASqZyPH3jS54/5qrkZO4=;
        b=lCOvjZQSFOIfBVPxI+o4SzzU3Ieql4He79UWtmbybvvrHgXNnKgn+OJpzfk8VtGs83
         VOX6VbXB29HdtzJaqLmhXQzbyLlNpKAvH86aUcFu/63FLI7W+MaxeRXBSUThlmYsvGHl
         KO/9Xql5OahLjUAIuCsvBFD1HHTKTw/mYRA46lac4/HpTaoaifeuDUJU1uMhXSSQcV31
         4kp7tjVwIMWB0JF0/YUefgFpU3cel6vtGY+4IBSJz+pYUSwfafljKdMgetX6SrIiijpS
         Gh5dRAIo6qMUdzc0SghGEPghNOjMdC3hIL/64x//Sh0bw57Ra0UsgJcQemO/qGZi3bc/
         Gg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278706; x=1776883506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WupQx6W6/LXfROgbPlaGvE5ASqZyPH3jS54/5qrkZO4=;
        b=Hp3UOGA1d0D7YtNs2xY+FFhp3m849+ONmYYP8BuRNeuSeO+0j9+k3HDDyMfawiIyZ4
         UHTE5tbUYsXw/LBlB5o95NltMtWTiuaxUupojfgugHTPZVMZo5GxSBk8HmilKR5sKEB4
         Ht75MA3PlVHYFLuwd/G3aCuDJ2yw6D4YpKp5VhjgMwfBJc7+u9kMFKJfS4JkBtW8vYt9
         o0/V+qIbx4R3qW5wUHngEAetHJ8+jf92OA7+uIbm7DwHcavXcDAUwiRiNBNYhKOf6pbb
         ti9pWD4ppP9e1edJfeurU3mdI4xiIhhjSIqyX7icM3HZh5Xw40tHgrMHAAHVr0h5HjTZ
         51KQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qUpaMhPgj7K5AnzCXQQTd1ceM27iNlwK/t58n5EUF4Gvz28vFfyECjjS/SEZ1a9fSB3+FWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YysVttrRxvJ9y5DulW+0aauKRvtupwEmcAEgZuFCdQ27DGbY3Zm
	sBzH+0rJNmrPThaeCfMF+xCqiK2HkKvnSh0S76lFiaS0ClQyURMw9CVl
X-Gm-Gg: AeBDievcElhqvPjZDausrYUpqi6EwHSDjMq/gcqG5Okpuq4/Nnb6nSzRDar4xkTgbPG
	vmFOth4KleFp4tEAx/k9+kNuISzHc6kCR3L+3RqWkefIrc54sq21eyf5yx++BnvxPpJg3w/cp4n
	+2ieL6umriKo1GSu7ZxhaczKFn7jBdm/4yuTkOF3lOStosUKtnl7cEbVLIySvpiWLmx2IH1Uf9p
	glJN27v3H5EgGrkF+hQSNUUEezHG7wqFCdeZwK9lQH5fl/c/N40MgX1MHo83A9zEFL4DJoC97cQ
	tDKiveYM+S4o3/HDfRnCkGFHjqGq7SKA278KTi1jklSMbSEuDNpQ895cdvJytyGQG5b9jl7zs3P
	ApnUbnabANDa1M772iQLTQCvMivTaPAIe2NBrx1PZfZkBGi8yI0E2OKoPzHoheft/JNg9XGPMNl
	QR6HrNy3Jcq78Yu8NZy4fELr4/LAeDNE9I1lEW3KRzZIU63wmY6Dw=
X-Received: by 2002:a05:6a00:2985:b0:827:4372:dd15 with SMTP id d2e1a72fcca58-82f0c2c2096mr22049833b3a.40.1776278705868;
        Wed, 15 Apr 2026 11:45:05 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f69ef0b79sm2380698b3a.36.2026.04.15.11.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:45:05 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/2] mm/damon: reset thread status parameters upon kdamond termination
Date: Thu, 16 Apr 2026 02:45:12 +0800
Message-ID: <20260415184512.14026-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003434.83697-1-sj@kernel.org>
References: <20260414003434.83697-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 Apr 2026 17:34:34 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Mon, 13 Apr 2026 17:23:03 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Tue, 14 Apr 2026 02:52:47 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > Problem
> > > ========
> > 
> > Let's align the underline with the subject.  Also, let's add one blank line
> > after the underline.
> > 
> > > When kdamond terminates unexpectedly, 'enabled' remains 'Y' and
> > > 'kdamond_pid' remains stale. This prevents user from restarting DAMON
> > > because both writing 'Y' and 'N' to 'enabled' will fail.
> > > 
> > > "Unexpected termination" here means the kdamond exits without any user
> > > request (e.g., not by writing 'N' to 'enabled').
> > 
> > Could you please further explain when such termination can happen?
> > 
> > > 
> > > User Impact
> > > ===========
> > > Once kdamond terminates this way, it cannot be restarted via sysfs
> > > because:
> > > 
> > > 1. DAMON_LRU_SORT/DAMON_RECLAIM is built into the kernel, so it cannot
> > >    be unloaded and reloaded at runtime.
> > 
> > I think this is quite obvious, so may better to be dropped.
> > 
> > > 2. Writing 'N' to 'enabled' fails because kdamond no longer exists;
> > >    Writing 'Y' does nothing, as 'enabled' is already Y.
> > > 
> > > As a result, the only way to restore DAMON functionality is a full
> > > system reboot.
> > 
> > Thank you for clarifying the user impact.  I think this deserves Cc-ing
> > stable@.
> > 
> > I think 'Problem' and 'User Impact' can be unified into one section.
> > 
> > > 
> > > Solution
> > > ========
> > > damon_commit_ctx() sets 'maybe_corrupted=true' at the beginning and only
> > > sets it to false upon successful completion. When 'maybe_corrupted'
> > > remains true, kdamond will terminate eventually.
> > 
> > This seems better to be explained earlier, on the problem section.

Okay, this is my current commit message:

    Problem
    =======

    When kdamond terminates unexpectedly, 'enabled' remains 'Y' and
    'kdamond_pid' remains stale. This prevents user from restarting DAMON
    because both writing 'Y' and 'N' to 'enabled' will fail.

    "Unexpected termination" here means the kdamond exits without any user
    request (e.g., not by writing 'N' to 'enabled'). This can happen when:
    - Internal error of kdamond.
    - Invalid parameters commit via 'commit_inputs' (e.g., addr_unit=3).

    The root cause is that damon_commit_ctx() sets 'maybe_corrupted=true' at
    the beginning and only sets it to false upon successful completion. When
    'maybe_corrupted' remains true, kdamond will terminate eventually.

    Once kdamond terminates this way, it cannot be restarted via sysfs
    because writing 'N' to 'enabled' fails (kdamond no longer exists) and
    writing 'Y' does nothing ('enabled' is already Y). As a result, the only
    way to restore DAMON functionality is a full system reboot.

    Solution
    ========

    The problem is that 'enable' parameter value is not trustworthy.
    Instead of relying on the 'enabled' variable, use damon_is_running(ctx)
    which reflects the true kdamond state.

> > [...]
> > So the problem is that 'enable' parameter value is not trustworthy, and this
> > series is trying to make it trustworthy.  I think it is bit complicated,
> > especially for stable@ fix.  What about simply using more trustworthy
> > information, e.g.,
> > 
> > '''
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> > @@ -390,7 +390,7 @@ MODULE_PARM_DESC(addr_unit,
> >  static int damon_reclaim_enabled_store(const char *val,
> >                 const struct kernel_param *kp)
> >  {
> > -       bool is_enabled = enabled;
> > +       bool is_enabled = false;
> >         bool enable;
> >         int err;
> > 
> > @@ -398,6 +398,9 @@ static int damon_reclaim_enabled_store(const char *val,
> >         if (err)
> >                 return err;
> > 
> > +       if (ctx)
> > +               is_enabled = damon_is_running(ctx);
> > +
> >         if (is_enabled == enable)
> >                 return 0;
> > 
> > '''

Thank you for the suggestion. I have tested this implementation and it
works expected. I agree that its complexity is much lower and more
suitable for a stable fix.

> > 
> > > 
> > > Changes from RFC-v1
> > > (https://lore.kernel.org/20260330164347.12772-1-aethernet65535@gmail.com)
> > > - Remove RFC tag.
> > 
> > When dropping RFC tag, let's start from v1 again, from the next time.

Regarding the versioning, I have two questions:
1. Is version number inhritance only required when converting from
   non-RFC to an RFC?
2. Should my next version be tagged as v3 (since the current one is v2)?

> 
> Also, I just found the patches don't have Fixes: and Cc: stable@.  Could you
> please add those appripriately?

Regarding the Fixes: tags, I will include the following:
- Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
- Fixes: 059342d1dd4e ("mm/damon/reclaim: fix the timer always stays active")

Best regards,
Rui Yan
