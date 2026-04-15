Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FEB313537
	for <damon@lists.linux.dev>; Wed, 15 Apr 2026 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776297338; cv=none; b=Tnh9NRVmkV3CXUBmkz1vtGhb+ACqE185l3bIpJUQ0eevHpvYwP7VTQMzhNb9cp9Q7aYlTOLzYPV2Ag6pGZmmtPc8/53G/AUg9CNxBVdszUe6l7UXOK1YJqv4auVjfhUuoWppQHp6/FJR+0eS+2qD5Mm4qerqPtIZxV/lCQfO2bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776297338; c=relaxed/simple;
	bh=2ndUQ7WOyZeVIswHE1bYk6rDm8lMOU3HeDaztOLdi4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqTcSTS7Ru4zoxeW66y4C9Fs+yzEMzRCGV4Elk/pizwGzXpFXXvcvAnWntpfsqHyWrBcrPUk89sB2g+T9GYEuafRHOXV2iWTeW6eWQWlq+oH28yQU0xbK2YD8R7Qt1vvAMJxQvWb8bwbFnZupDAOctmGDpKNSnrZFtHScFIfonw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6KBWJaQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6KBWJaQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71773C19424;
	Wed, 15 Apr 2026 23:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776297337;
	bh=2ndUQ7WOyZeVIswHE1bYk6rDm8lMOU3HeDaztOLdi4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I6KBWJaQU6ji0uWaMjS6ilsQ5ZrtJEE2iaaqev0LY44UO0vvEAI/kuqE8EZ0fcDxN
	 ZUSay40jUaFnjCZ5T8H0dvR7albPK84NOmsjZqrM1IZAHB3KZWwcwQkyrCPQYgRWcN
	 W2nBHbcXPhFdn8Z8Kqp4q+wtmE/2axpnpPHFxQQPkOtxl2o4S/rRrEI+NKZm8/xOIj
	 Sqv5Ba9IC0TShzXrr23Iuvyr8CuntXFfV25zE8nHcYbgW5ZhRlLzxwg84XmJC3skSI
	 LtyKDdmSFxw7bhcVAQtYQYpHOcS0nmhlbI+nw31ZBdzW87H9roZwKBoby2Zo4XJc4G
	 B3wFLz8YV1aiQ==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/2] mm/damon: reset thread status parameters upon kdamond termination
Date: Wed, 15 Apr 2026 16:55:29 -0700
Message-ID: <20260415235529.86329-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415184512.14026-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 16 Apr 2026 02:45:12 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Mon, 13 Apr 2026 17:34:34 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Mon, 13 Apr 2026 17:23:03 -0700 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > On Tue, 14 Apr 2026 02:52:47 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > 
> > > > Problem
> > > > ========
> > > 
> > > Let's align the underline with the subject.  Also, let's add one blank line
> > > after the underline.
> > > 
> > > > When kdamond terminates unexpectedly, 'enabled' remains 'Y' and
> > > > 'kdamond_pid' remains stale. This prevents user from restarting DAMON
> > > > because both writing 'Y' and 'N' to 'enabled' will fail.
> > > > 
> > > > "Unexpected termination" here means the kdamond exits without any user
> > > > request (e.g., not by writing 'N' to 'enabled').
> > > 
> > > Could you please further explain when such termination can happen?
> > > 
> > > > 
> > > > User Impact
> > > > ===========
> > > > Once kdamond terminates this way, it cannot be restarted via sysfs
> > > > because:
> > > > 
> > > > 1. DAMON_LRU_SORT/DAMON_RECLAIM is built into the kernel, so it cannot
> > > >    be unloaded and reloaded at runtime.
> > > 
> > > I think this is quite obvious, so may better to be dropped.
> > > 
> > > > 2. Writing 'N' to 'enabled' fails because kdamond no longer exists;
> > > >    Writing 'Y' does nothing, as 'enabled' is already Y.
> > > > 
> > > > As a result, the only way to restore DAMON functionality is a full
> > > > system reboot.
> > > 
> > > Thank you for clarifying the user impact.  I think this deserves Cc-ing
> > > stable@.
> > > 
> > > I think 'Problem' and 'User Impact' can be unified into one section.
> > > 
> > > > 
> > > > Solution
> > > > ========
> > > > damon_commit_ctx() sets 'maybe_corrupted=true' at the beginning and only
> > > > sets it to false upon successful completion. When 'maybe_corrupted'
> > > > remains true, kdamond will terminate eventually.
> > > 
> > > This seems better to be explained earlier, on the problem section.
> 
> Okay, this is my current commit message:
> 
>     Problem
>     =======
> 
>     When kdamond terminates unexpectedly, 'enabled' remains 'Y' and
>     'kdamond_pid' remains stale. This prevents user from restarting DAMON
>     because both writing 'Y' and 'N' to 'enabled' will fail.
> 
>     "Unexpected termination" here means the kdamond exits without any user
>     request (e.g., not by writing 'N' to 'enabled'). This can happen when:
>     - Internal error of kdamond.
>     - Invalid parameters commit via 'commit_inputs' (e.g., addr_unit=3).
> 
>     The root cause is that damon_commit_ctx() sets 'maybe_corrupted=true' at
>     the beginning and only sets it to false upon successful completion. When
>     'maybe_corrupted' remains true, kdamond will terminate eventually.
> 
>     Once kdamond terminates this way, it cannot be restarted via sysfs
>     because writing 'N' to 'enabled' fails (kdamond no longer exists) and
>     writing 'Y' does nothing ('enabled' is already Y). As a result, the only
>     way to restore DAMON functionality is a full system reboot.
> 
>     Solution
>     ========
> 
>     The problem is that 'enable' parameter value is not trustworthy.
>     Instead of relying on the 'enabled' variable, use damon_is_running(ctx)
>     which reflects the true kdamond state.

I don't want to be picky, but ...  I still feels this is easy to make readers
including future myslef be confused for some points.  Given this is a bit
serious bug fix, I feel I have to raise the bar, at least for future myself.
What about below?

	Kdamonds for DAMON_RECLAIM and DAMON_LRU_SORT could stop without
	properly updating 'enabled' parameter value, when parameters online
	commit fails due to invalid user inputs or internal memory allocation
	failures.  The enabled parameter value, which can be stale after
	certain kdamond stops, is used by the modules' kdamond start/stop
	logic, to avoid doing unnecessary start/stop works.  As a result, uses
	cannot restart the kdamonds before the system is rebooted and 'enabled'
	parameter value is correctly reset.  For example, the issue can be
	reproduced like below:

	<your reproducer>

	Fix the issue by using damon_is_running(), which should reflect the
	true kdamond state, instead of the 'enabled' parameter.

> 
> > > [...]
> > > So the problem is that 'enable' parameter value is not trustworthy, and this
> > > series is trying to make it trustworthy.  I think it is bit complicated,
> > > especially for stable@ fix.  What about simply using more trustworthy
> > > information, e.g.,
> > > 
> > > '''
> > > --- a/mm/damon/reclaim.c
> > > +++ b/mm/damon/reclaim.c
> > > @@ -390,7 +390,7 @@ MODULE_PARM_DESC(addr_unit,
> > >  static int damon_reclaim_enabled_store(const char *val,
> > >                 const struct kernel_param *kp)
> > >  {
> > > -       bool is_enabled = enabled;
> > > +       bool is_enabled = false;
> > >         bool enable;
> > >         int err;
> > > 
> > > @@ -398,6 +398,9 @@ static int damon_reclaim_enabled_store(const char *val,
> > >         if (err)
> > >                 return err;
> > > 
> > > +       if (ctx)
> > > +               is_enabled = damon_is_running(ctx);
> > > +
> > >         if (is_enabled == enable)
> > >                 return 0;
> > > 
> > > '''
> 
> Thank you for the suggestion. I have tested this implementation and it
> works expected. I agree that its complexity is much lower and more
> suitable for a stable fix.

Thank you for testing!

> 
> > > 
> > > > 
> > > > Changes from RFC-v1
> > > > (https://lore.kernel.org/20260330164347.12772-1-aethernet65535@gmail.com)
> > > > - Remove RFC tag.
> > > 
> > > When dropping RFC tag, let's start from v1 again, from the next time.
> 
> Regarding the versioning, I have two questions:
> 1. Is version number inhritance only required when converting from
>    non-RFC to an RFC?

I'd request such conversion when dropping RFC tag.  E.g.,

RFC -> RFC v2 ... -- (drop RFC) -> v1 -> v2 ...

> 2. Should my next version be tagged as v3 (since the current one is v2)?

The ship is already sailed for this patch series.  Please tag it with v3.  But
please follow the suggestion from next times.

> 
> > 
> > Also, I just found the patches don't have Fixes: and Cc: stable@.  Could you
> > please add those appripriately?
> 
> Regarding the Fixes: tags, I will include the following:
> - Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")

This seems correct, but ...

> - Fixes: 059342d1dd4e ("mm/damon/reclaim: fix the timer always stays active")

Is this correct?  At the point of this commit, there was no commit_inputs
parameter.  Were you able to confirm this issue can and cannot be reproduced on
this commit and its parent commit, respectively?


Thanks,
SJ

[...]
