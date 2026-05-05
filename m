Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A848094D
	for <damon@lists.linux.dev>; Tue,  5 May 2026 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993216; cv=none; b=L16RJOrHJcuT00jFH1KttAA3SvTG7vfmMgkwCCI6rX9xqvroLPQ3s+YhihvpfiJYvoN0k+V+KDBOCLX9JaBpZRHPv9FyfcXcSnl2/FO3TfuJ6LWWPIaOAfeoQC/WZOp4Z3yECD7CpjsRZU6q1cURSkBPMSkYmciCMfVxGoxiy/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993216; c=relaxed/simple;
	bh=BZtWcFg1Tvsaq4gSNlFAUnttdIjwgkp0plWzZaR5Srg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0Pdvj3CfZIT9hlH1hNdL+zPUNwUsFlYzZ9cZxZdVvhn59xJL9GeaxI8dFvpI6Zzw1W6VFoRmAxHJPwgkWxInB1fQ90RYrWM+xesiItnSsk/Op6p6aMNNf9BqGH2HHYbSyn1hulqQoZ6wKGd2I7RvAB5V9QwW9FGGmcVZjjmhAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI/YiKVx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI/YiKVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604EAC2BCB4;
	Tue,  5 May 2026 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777993216;
	bh=BZtWcFg1Tvsaq4gSNlFAUnttdIjwgkp0plWzZaR5Srg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kI/YiKVxEFpklK3I1aB/a0tDs+xz/VVn3Kln8yJ2mX5lp/LqZ1SNZhBTNEeNSV0UK
	 9cPstX5g4CGPxLBTO8AX/hOx84i33dWJ0kCJMslQAl4Wi0erU9LJESTy6WWApcDl6+
	 WBqnwAPKVlpJYY3uZcPI0yhB0MZe60bHXtlROc5x2LK3/Cu8ihy/QdbWDSEasGtTZP
	 csKWymO0hGdTb/WJSueAmNAMCaph5phu7Ol0X1DfnviTOogbwOkrF73niSw1Ykx8ZV
	 2e2bJ09yR7mbCv8R1Tnab8OS+O/huzJY+TXua3Wx83p8HSa5ZTQTmmX4cLhvPOleSo
	 lvXA7pZbtBlZw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.1.y] mm/damon/core: disallow time-quota setting zero esz
Date: Tue,  5 May 2026 08:00:12 -0700
Message-ID: <20260505150012.29007-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260504181048.E3BE2C2BCB8@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 04 May 2026 18:10:48 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Unmitigated integer overflow in the `throughput` calculation permanently breaks time quotas.
> - [High] Incorrect initialization of `charged_from` completely bypasses quotas for the first 5 minutes of system boot.

No real issues for this patch.

> --
> 
> commit 558d8bfd17c7ba00954bbbf18a4eb2783d713b59
> Author: SeongJae Park <sj@kernel.org>
> mm/damon/core: disallow time-quota setting zero esz
> 
> This commit addresses an issue where DAMOS time quotas could make the
> effective size quota smaller than the minimum region size. By forcing
> the effective size quota to be at least DAMON_MIN_REGION, it prevents
> schemes from being unexpectedly deactivated.
> 
> Link: https://lore.kernel.org/20260407003153.79589-1-sj@kernel.org
> Link: https://lore.kernel.org/20260405192504.110014-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index ab5c351b276ce..94f8450f6e843 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -802,6 +802,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
> >  	else
> >  		throughput = PAGE_SIZE * 1024;
> >  	esz = throughput * quota->ms;
> > +	esz = max(DAMON_MIN_REGION, esz);
> 
> Can the throughput calculation overflow here?
> 
> Looking at damos_set_effective_quota() before this change, throughput is
> calculated using:
> 
>     throughput = quota->total_charged_sz * 1000000 / quota->total_charged_ns;
> 
> Both total_charged_sz and total_charged_ns accumulate indefinitely over the
> scheme's lifetime. The intermediate multiplication by 1000000 is performed
> in unsigned long precision.
> 
> Could this overflow after a large amount of memory is processed? For
> instance, it could wrap around after around 18.4 TB on 64-bit systems, or
> just 4KB on 32-bit systems where unsigned long is 32-bit.
> 
> When the multiplication wraps around, the numerator becomes artificially
> small, causing the computed throughput to collapse to near-zero. While
> clamping esz to DAMON_MIN_REGION prevents total deactivation, does the
> overflow permanently trap the scheme into processing exactly one minimal
> region per charge window?

Good catch.  But not this patch's fault.  On 32bit, use of addr_unit would
mitigate the issue so that reasonable amount of progress can be made.  Also,
the impact should not be significant.

> 
> Also related to the effective size quota updates, is there a regression
> during early system boot?
> 
> Looking at damos_quota_init_priv(), quota->charged_from is initialized
> to 0 rather than the current jiffies.
> 
> In kdamond_apply_schemes(), the charge window only starts when:
> 
>     time_after_eq(jiffies, quota->charged_from + interval)
> 
> Because jiffies starts at INITIAL_JIFFIES (which casts to a negative long,
> typically -300*HZ), does time_after_eq() fail for the first 5 minutes of
> system uptime?
> 
> During this 5-minute period, damos_set_effective_quota() would never be
> invoked, leaving quota->esz at its default initialized value of 0.
> 
> Because quota->esz == 0 is treated as no limit by the scheme application
> checks, do early-boot schemes (like damon_reclaim) run entirely
> unthrottled for the first 5 minutes, completely ignoring user-configured
> CPU and size quotas?

We initialize charged_from as jiffies for every charge window, on
damos_adjust_quota().  So the issue shouldn't exist.


Thanks,
SJ

[...]
