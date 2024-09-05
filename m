Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAFB1A3A9D
	for <damon@lists.linux.dev>; Thu,  5 Sep 2024 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557711; cv=none; b=oAhXaaH4b+n1yl6aJTL+PuRDyoZhXaRo5Hf6D+KkcU9HrhUW8QpVSyN/Dmw+aYPVTI4Mfd6M0L9dznn0kY02UB/qzJpNSB3hSmCmveBuBdfTx5A3n3E/5kYGZH7MSKompS+upDtt2slMZO9/j0kjdQurDDs4zT5rTqlMjdCAn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557711; c=relaxed/simple;
	bh=MJdenvQvCyO3+Lbld4ggLe3q56cyEuPbMle8Vr6UWc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qp9UZwqBOkx0wuIzNTmwvOg9RyBmcVGV93SUlODJ1V+uVIyfFprKnZ0KADTlO/MUH5yIWhfVg2NiI7zqME9hIbOvBFBU66rEM9TzJqXYFhemxjr0YfJJX9t42yUtkkxVA5iEDxbSq2NwkgLs2TMs2gwg4/DzKgRaJ6ecxClj1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+ZSyXI6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+ZSyXI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414C7C4CEC3;
	Thu,  5 Sep 2024 17:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725557710;
	bh=MJdenvQvCyO3+Lbld4ggLe3q56cyEuPbMle8Vr6UWc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+ZSyXI6wFp0O2Z25jwUids7KsMUS2kdAaaXAro3DvtUVWKcW4YcIVwheeJA2cPmM
	 fGH+A0X/o3GvRJJXoqgBRsQhDcAE7tUtQ3ZU/xR6YZkVwSRwlKnyABCMeV5H6D1r6D
	 B5Gbi5u8ucstXz2U8cFDjLv0BxiyXSRFfmKUJqsYRJxo298RS6arlqAErPbTfOizsi
	 FPpFEMR2hVikr8lptLZyzlwbiMCI0jXAnjele8vnWhChtmoD0/Y5i0kAHn6toAlWdz
	 jc93OEGVrkUTTEuYVykkKyGObeE6Nyj2Q++hAyqmUNlp1ctihsiSdKDHDPQw2SlrlE
	 Z3rY7yBhlKxng==
From: SeongJae Park <sj@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Problems running DAMON kunit tests with spinlock debugging enabled
Date: Thu,  5 Sep 2024 10:35:07 -0700
Message-Id: <20240905173507.47124-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <944f3d5b-9177-48e7-8ec9-7f1331a3fea3@roeck-us.net>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Guenter,

On Wed, 4 Sep 2024 14:04:03 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

[...]
> Here is another problem. With all other problems fixed, when running on a 32-bit system:
> 
>      # damon_test_feed_loop_next_input: EXPECTATION FAILED at mm/damon/core-test.h:488
>      Expected damon_feed_loop_next_input(last_input, 200) > damon_feed_loop_next_input(last_input, 2000), but
>          damon_feed_loop_next_input(last_input, 200) == 923006 (0xe157e)
>          damon_feed_loop_next_input(last_input, 2000) == 1190503 (0x122a67)
>      # damon_test_feed_loop_next_input: pass:0 fail:1 skip:0 total:1
>      not ok 16 damon_test_feed_loop_next_input
> # damon: pass:14 fail:1 skip:1 total:16
> 
> Problem is that both damon_feed_loop_next_input(900000, 200) and
> damon_feed_loop_next_input(900000, 2000) overflow on 32-bit systems.

Thank you for reporting this yet another important issue!

> 
> Also,
> 
> static unsigned long damon_feed_loop_next_input(unsigned long last_input,
>                  unsigned long score)
> {
>          const unsigned long goal = 10000;
>          unsigned long score_goal_diff = max(goal, score) - min(goal, score);
>          unsigned long score_goal_diff_bp = score_goal_diff * 10000 / goal;
>                                                            ^^^^^^^^^^^^^^^
> 
> Since goal == 10000, the last statement has no effect.

You're right, thank you.

> 
> The diff below should address the problem for the most part, though the calculations
> may still overflow for large parameter values.
> 
> Guenter
> 
> ---
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7a87628b76ab..ab9c625ee2e0 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -10,6 +10,7 @@
>   #include <linux/damon.h>
>   #include <linux/delay.h>
>   #include <linux/kthread.h>
> +#include <linux/math64.h>
>   #include <linux/mm.h>
>   #include <linux/psi.h>
>   #include <linux/slab.h>
> @@ -1451,8 +1452,7 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
>   {
>          const unsigned long goal = 10000;
>          unsigned long score_goal_diff = max(goal, score) - min(goal, score);
> -       unsigned long score_goal_diff_bp = score_goal_diff * 10000 / goal;
> -       unsigned long compensation = last_input * score_goal_diff_bp / 10000;
> +       unsigned long compensation = div_u64((unsigned long long)last_input * score_goal_diff, 10000);
>          /* Set minimum input as 10000 to avoid compensation be zero */
>          const unsigned long min_input = 10000;

Thank you for kindly sharing this, too.  Your detailed reports of symptoms,
root cause, and possible fix help a lot.

As you also mentioned, this function may better to be significantly re-written
with overflows in mind.  However, I have no enough time and setup to
sufficiently test the fix for now, due to some personal reasons.  Also, the
issue is important, but not time-critical for now, in my humble opinion.
Please let me know if someone has different opinions.

So, I made one possible fix off the top of my head, and posted as an RFC patch:
https://lore.kernel.org/20240905172405.46995-1-sj@kernel.org

I only tested that against the kunit test on my 64bit machine.  After I get
some time and setup (maybe 1-2 weeks later), I will take more time to review
the code, do more tests, and post RFC-dropped version.


Thanks,
SJ
