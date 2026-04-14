Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F03D561
	for <damon@lists.linux.dev>; Tue, 14 Apr 2026 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126183; cv=none; b=IAtIeE6V5XV2ktFvEuxaPWlDyOiVvCHJvnPtQiWaF0zuu/PM87xzZbXM+neIvx1lEDBo0CQkYscNwMqmpb+hqXNvO8gbTYZDGo70kLDVyT1EXLiX5VHgx4LiXu+sZ3gKGuedbp+6uaWfApYSqSWNLwYYJY+AZ43k9V6BQWHNJts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126183; c=relaxed/simple;
	bh=rUPIO44OS0Rco3GvN57c0BXurHCc9flcjQqmcQyfIfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuUV+0LO986+BSVCVpTUszMn5IuzDbaKYqLmNzCiR+EJMCkW15IOm8tf7vE4WglU6RdgGrzJnjMo0Sckrw48Izj/1lg7y3PwcOqtDeSVAb9PbJP6zTy1xOqMPlokDIUcSVG+iSO9CgOLdkdKrDPQrDqMV5Girt00ymWMyBpFN4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFC+xDNx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFC+xDNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678E7C2BCAF;
	Tue, 14 Apr 2026 00:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126183;
	bh=rUPIO44OS0Rco3GvN57c0BXurHCc9flcjQqmcQyfIfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFC+xDNxVZ7H1zSIPMZdUup9eX9wkebQIij2neJzsBGlAmCV1TP3+NbVMlx0yhypt
	 ka+4TLqgz0AIa7O/2RJP0uzCvgdrht1PDh/cMt013nUTCqmxIeRcunnUF8NavZrM9D
	 VDPAJJqDa8wl6UkgNfoXDEK4dM/z8jj3XmyMsEb9b0IJpJpsGBq15dFrpmcBVesv3E
	 6OARsnGZz8qFFJvHcjGBeaE0n299WE53HUNIcL0k9mQyclsjsIwsweW3iITzy/VuMO
	 l5b8fgU0A578t3osFs9cObvaGrGfPPCfgOQeujnNdTEUf6H6izFidliLGlg+fF0i5t
	 cxYxHK78vUzMw==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/2] mm/damon: reset thread status parameters upon kdamond termination
Date: Mon, 13 Apr 2026 17:22:59 -0700
Message-ID: <20260414002300.83328-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260413185249.5921-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Apr 2026 02:52:47 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Problem
> ========

Let's align the underline with the subject.  Also, let's add one blank line
after the underline.

> When kdamond terminates unexpectedly, 'enabled' remains 'Y' and
> 'kdamond_pid' remains stale. This prevents user from restarting DAMON
> because both writing 'Y' and 'N' to 'enabled' will fail.
> 
> "Unexpected termination" here means the kdamond exits without any user
> request (e.g., not by writing 'N' to 'enabled').

Could you please further explain when such termination can happen?

> 
> User Impact
> ===========
> Once kdamond terminates this way, it cannot be restarted via sysfs
> because:
> 
> 1. DAMON_LRU_SORT/DAMON_RECLAIM is built into the kernel, so it cannot
>    be unloaded and reloaded at runtime.

I think this is quite obvious, so may better to be dropped.

> 2. Writing 'N' to 'enabled' fails because kdamond no longer exists;
>    Writing 'Y' does nothing, as 'enabled' is already Y.
> 
> As a result, the only way to restore DAMON functionality is a full
> system reboot.

Thank you for clarifying the user impact.  I think this deserves Cc-ing
stable@.

I think 'Problem' and 'User Impact' can be unified into one section.

> 
> Solution
> ========
> damon_commit_ctx() sets 'maybe_corrupted=true' at the beginning and only
> sets it to false upon successful completion. When 'maybe_corrupted'
> remains true, kdamond will terminate eventually.

This seems better to be explained earlier, on the problem section.

> 
> Therefore:
> 1. In damon_{lru_sort, reclaim}_turn(): Add fallback logic to reset
>    parameters when damon_stop() fails but kdamond is not running.
> 2. In damon_{lru_sort, reclaim}_apply_parameters(): Reset parameters
>    when damon_commit_ctx() fails, as kdamond will terminate due to
>    maybe_corrupted mechanism.

So the problem is that 'enable' parameter value is not trustworthy, and this
series is trying to make it trustworthy.  I think it is bit complicated,
especially for stable@ fix.  What about simply using more trustworthy
information, e.g.,

'''
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -390,7 +390,7 @@ MODULE_PARM_DESC(addr_unit,
 static int damon_reclaim_enabled_store(const char *val,
                const struct kernel_param *kp)
 {
-       bool is_enabled = enabled;
+       bool is_enabled = false;
        bool enable;
        int err;

@@ -398,6 +398,9 @@ static int damon_reclaim_enabled_store(const char *val,
        if (err)
                return err;

+       if (ctx)
+               is_enabled = damon_is_running(ctx);
+
        if (is_enabled == enable)
                return 0;

'''

> 
> Changes from RFC-v1
> (https://lore.kernel.org/20260330164347.12772-1-aethernet65535@gmail.com)
> - Remove RFC tag.

When dropping RFC tag, let's start from v1 again, from the next time.


Thanks,
SJ

[...]
