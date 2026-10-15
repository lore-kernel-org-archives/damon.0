Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829534C041B
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063451; cv=pass; b=V1ESSHkZ79go6632LaRd2rQvrgzDJdcDwpiqpaotT80eJWLmtZUPiy09xmfVm9J5lLT6XnB99+70o6XF9csR0LjXuXN09EE0Nx66okaLu0P40nLgeF8nR+cEbcYHyyzLVlNuz2/I7d7dU45oIqIlC37Y4ySYE9O1b5whKE61FKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063451; c=relaxed/simple;
	bh=wwroiIRXs/CRA75/gQ0CHxDlWEw1REJkT9ChcJnJ6aE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BYMPqeiakC/+Y/sSDTtbb/4K2uLkQSYDhgNzT5ITYBtZt5Dq/j/mjnFY21Z5oHQmwcyloCs9I7+fEszJ2prZEqpoOUv5YF8DJcY2hzydJuSmAlCAve/HOFHKD5yRacfLlULN2OOBjU3Zk25pCQwHUh309Q3kMG9B/AM5NW4qlT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dame0N82; arc=pass smtp.client-ip=74.125.231.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dame0N82"
Received: by mail-oi2-f9.google.com with SMTP id 5614622812f47-4f47feb5a15so794978b6e.1
        for <damon@lists.linux.dev>; Thu, 15 Oct 2026 04:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792063449; cv=none;
        d=google.com; s=arc-20260327;
        b=Owvee8ycpfLxEDW0d0l37GsIlPNjMFBrla3Jb2d65UYxFDbmhhYJIXf58/tWhwpMRJ
         l+bPaYR7R1z6wJbeD1E1L+VTDZ9k20IuI6FfkqMk0PgGjTctk6fS31+n2bziwz235Dfb
         t1yAstBKboF9mKrcT55O6zPuhi48ASw0TDd/4MfwdAIHj9VPE2MBf6KSrgcAXZMb/Y+x
         utr8ZDJ0gp48kPafzhKymw0wp27JpLnz5WTGPaeED/r1+s66AJF5usbxeasXOCkNY+Vy
         XUc6N4m5aDrq3kA+Bka5GtN7AJLaaVPhpRsJqO0xgF7zl9DufcWvSty/RESnJEBh1C4X
         LgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WcPHvbOIREflq3CVha0FzUPYhrPrea+3ze3za5U7XAU=;
        fh=8bsVAvSPyRAWy1fZ7b/DPu7NvRhyn3oojIlyPxlwC24=;
        b=cVhvIh8Ud4D3UL+5A69zUn34YA8RdYwpZMQ5HiHHxl/QNeGSJINl5vTrrgppwhUngg
         vQ3ci3JN5HNQZzQmDjx0WnQcSy2c79iILmo+f2LThICaIhrq/8ln3fYy7sNNvzj+nWII
         xTFBAM3dKJcwdj8tKlp/HtQwCqm6/Mf09ks4dpBQ4i5WeKhffukD3RSJzBtjLLAAUA3M
         YVS21oeQceJMATnFxWrtPvsBBik4JYM/J/lFTVWEqE9NsFprTUBjnAXQKGTiWSOjxxnv
         RSG8DPPxBi6PfG627F+SQ4w6a46hgbfAfCy/LtodLuzH4DzQ0SHYcUg+XNJYlVEGp/zl
         4lIw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792063449; x=1792668249; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WcPHvbOIREflq3CVha0FzUPYhrPrea+3ze3za5U7XAU=;
        b=Dame0N82iWTfO1X+qUVmzgW6tQAfRVp7EZruZb9RKKuSePi03gMj9MpjOrxpHYeD1x
         nfSmks6Cb/mzRyeGMuIXLqFxPtkw+rTCYFZZc6ZzHq1MOEI4rrwDF33ZQu//2GF0dL+Z
         9Illedzp2sqnBbk0FMI81FZoLWGWKTiHmv8PVztVsghtf1Z3AY8bdDyMR8tYC6m3LJmX
         N6/c8raAj9JpEmxm7XjEsfm4hg+8fvkbQSmwJDuD7Aq0BIMRYDw2WhgUnJ9+UgwC9lvP
         sOBtu9oyrSUqLKRGtfNR5JMk8SfJou2FW6cP59HAj3cAkmldOKVKGHfMhTbMLIKMGs5m
         wcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792063449; x=1792668249;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WcPHvbOIREflq3CVha0FzUPYhrPrea+3ze3za5U7XAU=;
        b=CtHQhAPMcI53m5wO5T0ph6ihUXsaVfuV8A1aXxRBm9et8ljqfryqptH2q6wlit9/Og
         mgWescXhRZkAwq2EbBRKlEcL7CUQGorcGE9I68/tq796eAtiIKhoz5KRHEzBNEH+3QIb
         MIxu2o4iX+lJraoUC0fEdjbB8YL+kaFUuwpIw8J3lqeZKfSFlps814JV5BoFxt5iGbgg
         Tt2OUsuE5DEqdIdLHI78nA8y52eTRUxcQrIPDQlQc6LjIwPLDBBI4P+o82F1LkrKDkWG
         Xum4c4zRI0FTrN8g3TsuY2e3ClnR9nPTIj5pOukZKalqjM3Q5iUX4MjXkLX2B2z6ZZ/F
         49nQ==
X-Forwarded-Encrypted: i=1; AKwUvByzOX1ieNblI8OP9nVRKV5LtgQxnQPdrNb7aU+Ld3cyjDmDjoK4w0j9F3Dx4Ow0zb40NNPiNQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYI/Agxp/MkHQQuuXL4imkelA7ge9LvUPaQglQg3zq8+V6jdMJZx
	SmiVLeO7NbwCiinzdk1R8NMTstpqvz781F7YDDOBZF3HXqvcEXEShWDldm1AlHRxnOiR3cNKLlb
	lWG26hR49yxl/evLxgsgX4k7vVFcLxOU=
X-Gm-Gg: AYBFou3aL7wjXGKUzF7tF+IyGTgJrwlyGXZu3V2k6ioZ5h8lXUWEMzAVmILJijxzdYp
	cY1m+1MbizyqT/QxuyoF4qUI5ZQTH2XeesJRb2B5wJmZ/0G9mwo9tpWtOE72z0oafV8rF6YfIiG
	lqLoAsTScjzeKJrFQVCiZp/eD3dgVE/E1ywN3b0oXEqaHSzHjjEljhCXUjZajDLR8yJy9VvW26/
	qtphmN8jVIAdg0kWDuyPO5qqkVbTE6k90URFA0On9B2KN0hO6xWdujOmM8CKTzfsx4sXZe0f5Cv
	DDzzRoaUI9ANoLu9WuZmo0ib/JD1nz2/UMvM2TOzibi9OoMB76KfiebvRQ9wa+GZXl6F84Bnnow
	JXOVKjt/aLQ==
X-Received: by 2002:a05:6808:15a7:b0:4e9:73ce:e2a1 with SMTP id
 5614622812f47-50c5417a0demr16310600b6e.44.1792063449448; Thu, 15 Oct 2026
 04:24:09 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 15 Oct 2026 07:24:08 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 15 Oct 2026 04:06:47 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Aveline Noir <jm5905938@gmail.com>
Date: Thu, 15 Oct 2026 07:24:08 -0400
X-Gm-Features: AclHuK_yRe_VjBLBEog6BC-f_xFyKGJAr2pWJTMKXgRYUILAdC4oSPS6DMOyP2A
Message-ID: <CANOyQmFkTQMEpR10sxjoB+8XMsk=m9DAJVnyxguwV2LLYCg09A@mail.gmail.com>
Subject: [BUG] DAMON: 32-bit overflow selects wrong sampling interval
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

In an unmodified i386 QEMU kernel built from mm-new commit
ad9f2d463666, an intervals goal selected a 2500 us sampling interval
after the first aggregation.  The same trace inputs give 2812 us with
full-width arithmetic.

The kernel has CONFIG_DAMON_VADDR, CONFIG_DAMON_SYSFS, and tracing
enabled.  The guest monitored a 1 MiB VADDR range as four contiguous
256 KiB regions, with sample_us=5000, aggr_us=100000, access_bp=400,
aggrs=1, and min_sample_us=2500.  The default minimum of 5000 us would
hide the difference.

At the first aggregation boundary, the four damos_before_apply records
for kdamond.0 showed nr_accesses=1,1,1,3.  The next
damon_monitor_intervals_tune record showed sample_us=2500; sysfs then
reported sample_us=2500 and aggr_us=50000.  The records cover the same
four 262144-byte regions before the first tune.

For that aggregation, the inputs to damon_get_intervals_score() are:

  max_access_events = 4 * 262144 * 20 = 20971520
  access_events     = (1 + 1 + 1 + 3) * 262144 = 1572864

On 32-bit unsigned long, max_access_events * access_bp wraps before
division by 10000.  This gives a target of 409364, a score of 38422 bp,
and the observed interval of 2500 us.  With full-width arithmetic, the
target is 838860, the score is 18750 bp, and the interval is 2812 us.
The later mult_frac() remainder multiplication does not overflow in the
observed 32-bit path, so the difference here comes from the target
multiplication.

The affected expression is in mm/damon/core.c.  Widening only the
target product would make the later 32-bit mult_frac() remainder
multiplication overflow for these same inputs.  The 2812 us result
requires sufficient width throughout the score calculation.

The 2500 us interval was measured on the unmodified kernel.  I
calculated 2812 us from the trace; I have not tested a patched kernel.
The i386 config, guest init, serial/trace log, and build/run steps:

  https://github.com/jm5905938/kernel-mail/tree/195d7017352a3d0f4a0475b98f3b03650f5c14ea/cases/2026/damon/2026-10-15-bug-reports/02-intervals-goal-32bit-overflow

Thanks,
Aveline Noir
