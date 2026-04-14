Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1773770B
	for <damon@lists.linux.dev>; Tue, 14 Apr 2026 00:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126882; cv=none; b=WkJSdhJWUg8VismOgVlGoFZESgiYkhvh9yUyhNr68eomH8OIT3ksePZRrrNn2xATiRs5HP6soai2q5ijNz4pprDAbq3zJP2clJZWEVkWn2onk5IeK8Dwsobt11DBb83aAmxUnUcM3fZgtdjrDDQ1TthZOInaR0QIaF1EoBghDd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126882; c=relaxed/simple;
	bh=rKC/FuSHBQjUqfWFKqtW02kqh5fExR6jEuIsswCLAQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q76NOhu5AGufdJeqmwWFslhdNL2ic+cgZnMUKruAAXld58Zw/w5ABhUpjVL+XKuCSMhio1MNlAVvnTPpia9rl3yGo+oCExp/nOixxM87bnJGNY70m9jwUSFN7LybFAspgGw8WJ7+dFfSrl6NbbhXW+BhvkmFUcwKjAINe+AZ5GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg51ZdQx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg51ZdQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBACEC2BCAF;
	Tue, 14 Apr 2026 00:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126882;
	bh=rKC/FuSHBQjUqfWFKqtW02kqh5fExR6jEuIsswCLAQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jg51ZdQxMg5FW7/m4sfIFrbXt8FLCSi9kR/RwRMzsKhRmnFDqEdL8L73RM2C9B3wh
	 AJler8tDrsVk0/yJ6fuPr1AnNbEDbMlgCw+mNwSqFc0drWXFj8kXRyUPKOF2VWIpJU
	 /F0gwD5nupZWX5YscBMpB1wUl+5yFVa/eEp2Ch74vLWK2xbUziYv++f2miXuK6BgUD
	 0FfZx7vkDFPY+XSQ1T91DeieSxicbpAifRVRKRJWbuwGJN5Sz56Ll870Du2roybCu4
	 UhWJ229SsK4sbL6NhFlcYmRYB/HjlgcdEh5f1tbKr/LetZgP9W/1e1OAxQvZzli3+Y
	 yjms/F07QveFg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/2] mm/damon: reset thread status parameters upon kdamond termination
Date: Mon, 13 Apr 2026 17:34:34 -0700
Message-ID: <20260414003434.83697-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414002300.83328-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 Apr 2026 17:23:03 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 14 Apr 2026 02:52:47 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > Problem
> > ========
> 
> Let's align the underline with the subject.  Also, let's add one blank line
> after the underline.
> 
> > When kdamond terminates unexpectedly, 'enabled' remains 'Y' and
> > 'kdamond_pid' remains stale. This prevents user from restarting DAMON
> > because both writing 'Y' and 'N' to 'enabled' will fail.
> > 
> > "Unexpected termination" here means the kdamond exits without any user
> > request (e.g., not by writing 'N' to 'enabled').
> 
> Could you please further explain when such termination can happen?
> 
> > 
> > User Impact
> > ===========
> > Once kdamond terminates this way, it cannot be restarted via sysfs
> > because:
> > 
> > 1. DAMON_LRU_SORT/DAMON_RECLAIM is built into the kernel, so it cannot
> >    be unloaded and reloaded at runtime.
> 
> I think this is quite obvious, so may better to be dropped.
> 
> > 2. Writing 'N' to 'enabled' fails because kdamond no longer exists;
> >    Writing 'Y' does nothing, as 'enabled' is already Y.
> > 
> > As a result, the only way to restore DAMON functionality is a full
> > system reboot.
> 
> Thank you for clarifying the user impact.  I think this deserves Cc-ing
> stable@.
> 
> I think 'Problem' and 'User Impact' can be unified into one section.
> 
> > 
> > Solution
> > ========
> > damon_commit_ctx() sets 'maybe_corrupted=true' at the beginning and only
> > sets it to false upon successful completion. When 'maybe_corrupted'
> > remains true, kdamond will terminate eventually.
> 
> This seems better to be explained earlier, on the problem section.
> 
> > 
> > Therefore:
> > 1. In damon_{lru_sort, reclaim}_turn(): Add fallback logic to reset
> >    parameters when damon_stop() fails but kdamond is not running.
> > 2. In damon_{lru_sort, reclaim}_apply_parameters(): Reset parameters
> >    when damon_commit_ctx() fails, as kdamond will terminate due to
> >    maybe_corrupted mechanism.
> 
> So the problem is that 'enable' parameter value is not trustworthy, and this
> series is trying to make it trustworthy.  I think it is bit complicated,
> especially for stable@ fix.  What about simply using more trustworthy
> information, e.g.,
> 
> '''
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -390,7 +390,7 @@ MODULE_PARM_DESC(addr_unit,
>  static int damon_reclaim_enabled_store(const char *val,
>                 const struct kernel_param *kp)
>  {
> -       bool is_enabled = enabled;
> +       bool is_enabled = false;
>         bool enable;
>         int err;
> 
> @@ -398,6 +398,9 @@ static int damon_reclaim_enabled_store(const char *val,
>         if (err)
>                 return err;
> 
> +       if (ctx)
> +               is_enabled = damon_is_running(ctx);
> +
>         if (is_enabled == enable)
>                 return 0;
> 
> '''
> 
> > 
> > Changes from RFC-v1
> > (https://lore.kernel.org/20260330164347.12772-1-aethernet65535@gmail.com)
> > - Remove RFC tag.
> 
> When dropping RFC tag, let's start from v1 again, from the next time.

Also, I just found the patches don't have Fixes: and Cc: stable@.  Could you
please add those appripriately?


Thanks,
SJ

> 
> 
> Thanks,
> SJ
> 
> [...]
> 
