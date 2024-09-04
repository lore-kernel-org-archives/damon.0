Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B007814A4E0
	for <damon@lists.linux.dev>; Wed,  4 Sep 2024 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725483848; cv=none; b=kCrbSyXEvouob2h8tCxgzszoUfaLkYN9ln69NLFQeg5xABeCfjq1Usde03g55rpcg2jPlg2iK6UbQFZovIvAbb6WvPLdPNEtLNQ2JUFjpaWZWyP1mvX0NjyZIirlzMJonVpabakGa9CRS8dxcmklovRBwHpGZzyfCeLly6S+vaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725483848; c=relaxed/simple;
	bh=m8UMJBRuG2kukaB2SN6yXrjE0Ug3yWsachcsGF01rCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tf76lflrfNxm5FgAEkd8Z1TAX+z8Tglidht5cExefcYom+0AphIMGROfDfU35g8c6fUHKSLntcohPogm35hOk4RIMT1qLkY/RVVk2SefgGuLzRiK134+ETnVvaKi5PTWdWuXrnMKaKFEvGCaruzfq36qZ9v6dXcB1+qf92CgUZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+oqO0Zb; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+oqO0Zb"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7141d7b270dso36654b3a.2
        for <damon@lists.linux.dev>; Wed, 04 Sep 2024 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725483846; x=1726088646; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=K/K3lNz8RJfeA2iIVjiN8Rih3/iRAsI/6N5l813Gc/U=;
        b=g+oqO0ZbC0rDYmZBNIblsUKF7/icWUVvNLO+o8XQniIOinnNRL1h1AdKtacTr1woyi
         J6bA4AdWVINfM3qqwu36Z9/rABSo4LGcwwMPxPEWdWpjOW/4m8CguJT6pxBgYGWODNZP
         lOU9z1QvRjxYuk28TQ89onhD4P1lB+e/EHVTU8BMJ3V54LeAYXx9i9yek204uA8UqJ7T
         6/U8a9Z9dQlJcFvgoMYENsiZa/wYOOxccLJnEgeHwzgA074dPWKTBoIs7eZ+H7rP0LxU
         5YYs+qAQXFfP05Hs9dz33y/IG4Wq+sXVIxnKGD2wjyLHbLu9d7EMqj9PYvW46dSnxIQ+
         fiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725483846; x=1726088646;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/K3lNz8RJfeA2iIVjiN8Rih3/iRAsI/6N5l813Gc/U=;
        b=wm/rxxFHKc+Qh02sk0l6lOWE097F6bvFL+qFt87AgOOaC/j2sBViVT6tlU38d+KUni
         XMFTDRPnlWLbkiGRLWxW7ZcAJ4tnYDVxsQ20K5JXKdqcgXlMXXJJVoZyW59DoggRNHPq
         TI3JKjr1Wz+7tmPp9ydGwzsnCMD+PP8wl9lGuB+eoaLO0SRkfpL3ciF5BC57+w6e0gEs
         uQC2EsrP7wssAAbcNAKhvipiZc268TAcSdC41/F4VwRN0szRTxInlar68D+OIMwtZd15
         CjMbIygFqLYdA1J0zd2knqhrzJ8tQpc61VWpAtXAXZx3xAdwWz6/0KU8fGRpXt839wXP
         qHdA==
X-Gm-Message-State: AOJu0Yw7xlcg4QUU4QmUvGkjO6gc7EPPR02T5/fy5y7axBxySVYqn8Hy
	wNujy2gXFERtdkVy5JHtKRTYlviPxeeRnufH5VJWfrnRjyE7HUPUe5AxTg==
X-Google-Smtp-Source: AGHT+IFqbZoEaX+gYQoec3Jtu0u7euSEEKgE2Hza1LB99Ys6WadVhcpEv4yqyw4xYI9vgG9v0v4K1A==
X-Received: by 2002:a05:6a00:13a5:b0:713:e3f9:b58e with SMTP id d2e1a72fcca58-71744553e2fmr14849028b3a.17.1725483845714;
        Wed, 04 Sep 2024 14:04:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177859a434sm2095866b3a.174.2024.09.04.14.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:04:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <944f3d5b-9177-48e7-8ec9-7f1331a3fea3@roeck-us.net>
Date: Wed, 4 Sep 2024 14:04:03 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems running DAMON kunit tests with spinlock debugging
 enabled
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
References: <20240904175306.1862-1-sj@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240904175306.1862-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 10:53, SeongJae Park wrote:
[ ... ]

> Nonetheless, if the issue can be triggered outside of the test, we may need to
> think a better fundamental fix.  And seems it is the case.
> 
> Sharing current incomplete findings here first.
> 
> First of all, users can set the zero aggr_interval.  And the problematic
> function (damon_nr_accesses_to_accesses_bp()) is called when user updates the
> intervals while DAMON is running, with the old intervals attributes.  Hence,
> users could trigger the issue by making DAMON to run with zero aggregation
> interval, and then updating the intervals to any values.
> 
> Due to another complicatd logic behind the online intervals updates, trigerring
> the issue seems not that simple.  In short, seems it can be triggered only by
> using DAMOS watermarks together.  This is something bettr to revisit later.
> 
> So, I haven't confirmed if this is exploitable or not due to the lack of time
> and other things to do, at the moment.  I will take a look further and share
> more findings soon, hopefully within a couple of days.
> 

Here is another problem. With all other problems fixed, when running on a 32-bit system:

     # damon_test_feed_loop_next_input: EXPECTATION FAILED at mm/damon/core-test.h:488
     Expected damon_feed_loop_next_input(last_input, 200) > damon_feed_loop_next_input(last_input, 2000), but
         damon_feed_loop_next_input(last_input, 200) == 923006 (0xe157e)
         damon_feed_loop_next_input(last_input, 2000) == 1190503 (0x122a67)
     # damon_test_feed_loop_next_input: pass:0 fail:1 skip:0 total:1
     not ok 16 damon_test_feed_loop_next_input
# damon: pass:14 fail:1 skip:1 total:16

Problem is that both damon_feed_loop_next_input(900000, 200) and
damon_feed_loop_next_input(900000, 2000) overflow on 32-bit systems.

Also,

static unsigned long damon_feed_loop_next_input(unsigned long last_input,
                 unsigned long score)
{
         const unsigned long goal = 10000;
         unsigned long score_goal_diff = max(goal, score) - min(goal, score);
         unsigned long score_goal_diff_bp = score_goal_diff * 10000 / goal;
                                                           ^^^^^^^^^^^^^^^

Since goal == 10000, the last statement has no effect.

The diff below should address the problem for the most part, though the calculations
may still overflow for large parameter values.

Guenter

---
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7a87628b76ab..ab9c625ee2e0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -10,6 +10,7 @@
  #include <linux/damon.h>
  #include <linux/delay.h>
  #include <linux/kthread.h>
+#include <linux/math64.h>
  #include <linux/mm.h>
  #include <linux/psi.h>
  #include <linux/slab.h>
@@ -1451,8 +1452,7 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
  {
         const unsigned long goal = 10000;
         unsigned long score_goal_diff = max(goal, score) - min(goal, score);
-       unsigned long score_goal_diff_bp = score_goal_diff * 10000 / goal;
-       unsigned long compensation = last_input * score_goal_diff_bp / 10000;
+       unsigned long compensation = div_u64((unsigned long long)last_input * score_goal_diff, 10000);
         /* Set minimum input as 10000 to avoid compensation be zero */
         const unsigned long min_input = 10000;

