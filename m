Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F132264A9
	for <damon@lists.linux.dev>; Wed,  1 Apr 2026 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775058080; cv=none; b=denFNdlvaL3CEavX38cBdxrzH1RmZhEKs9+hlfRIP+FO1cB7J6c7vHCKTcrcN39EaSB3HZPOBNydUH5nQhWL3gPc3yL3rrSFjZBkved2Gz8nqFAsF2V6eYdPkimvjAbbCBqULoxWsLc7l8Vp1idZsHDqiGBVwzTXhNqGQh4s/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775058080; c=relaxed/simple;
	bh=S/VWLw2jpuJ809fs69jIdpFQnzH6zWS3RJfJT30T91Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnSBKTTdcVDgcAboeuc55587as3qI/XQPMeIGdZ2b2MrsQz6COyleejz8zSbToG69qgNsg1iNhX9iw86UIAM+GmqKXz5i8N84azO4QXFvWXN1fnZaE+lcGeOJC16V5Zo4bRisDfSsJwcJGcpxhk8VLhs/548EID/dsMt95ojiow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XM3le0ln; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XM3le0ln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0C4C4CEF7;
	Wed,  1 Apr 2026 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775058080;
	bh=S/VWLw2jpuJ809fs69jIdpFQnzH6zWS3RJfJT30T91Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XM3le0lncmNRcKu3J8uKbGR3DbAO1ZzKNuBwjwWrEyd6vSn0+rTTXTY7L4crjGW6K
	 C0axHHwy0u0Pi5ioLEzoa4Yt5sgKUm7w4minEGAKD3C1Htrp3hxEFkNY2VEzf31sh8
	 CnVAgLvb6sGTh+mupDNpczzTLcYMc2tYSHLhHpyTfixpNnp4vxbUeZB9HmG+DARyE5
	 NloFdgmUdeJVzt04G0sfY4On/8dk05wSlIL6CqqElbELv/PsTbt9qcm6FpmQBPQbtm
	 qRHfFInL11IIrcAzdpj+CZ7ZBKiuatmIv7TJ7POpdrEhgikEAiCNvJaSOMM5DMJcgc
	 SElmbA8STxEbA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Wed,  1 Apr 2026 08:41:18 -0700
Message-ID: <20260401154119.67874-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401082439.12612-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  1 Apr 2026 16:24:39 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Tue, 31 Mar 2026 17:44:00 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Wed,  1 Apr 2026 00:09:56 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > > [...]
> > > > Option 1: Introduce a generic termination callback
> > > > ==================================================
> > > > Add 'void *after_terminate_fn(void*)' and 'void *after_terminate_data'
> > > > to 'struct damon_ctx' or 'struct damon_operations'. While this extends
> > > > the Core API, it provides a clean notification mechanism. When kdamond
> > > > exits for any reason, the module can perform its own cleanup (e.g.,
> > > > resetting 'enabled' and 'kdamond_pid') within its own callback. This
> > > > keeps the core logic decoupled from module parameters.
> > 
> > Maybe this is the right long term direction.  But to my understanding the fix
> > should be backported to stable kernels.  Is that correct?  If so, I'd prefer
> > simple quick fix that can easily backported.
> 
> I agree. While I hadn't initially considered backporting, this bug
> certainly warrants it. A simple and easily backportable fix should be
> our priority for now.

Thank you for generously accepting my concern.

> 
> > > > Option 2: On-demand state correction in the module
> > > > ==================================================
> > > > In damon_{lru_sort, reclaim}_enabled_store(), if damon_stop() fails, we
> > > > check is_kdamond_running(). If the kdamond is found to be terminated, we
> > > > forcibly reset 'enabled' and 'kdamond_pid'.
> > 
> > I think this can work, and simple.
> > 
> > > > 
> > > > My perspective
> > > > --------------
> > > > I personally prefer OPTION-1 because it ensures the sysfs state in
> > > > synchronized actively.
> > > > 
> > > > OPTION-2 is simpler and avoids API changes, but it's a "passive" fix
> > > > that only triggers when user atttempts a write operation. User might
> > > > still see inconsistent value until they try to interact with the module.
> > 
> > I agree your concern.
> > 
> > > > [...]
> > > 
> > > To avoid over-complicating the Core API (Option 1 or current approach),
> > > I've implemented a lightweight, on-demand synchronization mechanism in
> > > the module layer.
> > > 
> > > By overriding the '.get' operator of the 'enabled' parameter, we can
> > > detect if kdamond has terminated and reset the module-level state right
> > > before the user reads them.
> > > 
> > > Since sysfs parameter access is protected by 'kernel_param_lock', this
> > > approach is race-free and keeps the DAMON core decoupling intact.
> > > 
> > > Core Implementation:
> > > 
> > > 	if (enabled && !damon_is_running(ctx)) {
> > > 		enabled = false;
> > > 		kdamond_pid = -1;
> > > 	}
> > > 
> > > 	return param_get_bool(buffer, kp);
> > > 
> > > Test Log:
> > > 
> > >     # cd /sys/module/damon_lru_sort/parameters/
> > >     # echo Y > enabled 
> > >     # echo 3 > addr_unit 
> > >     # echo Y > commit_inputs 
> > >     # cat enabled 
> > >     N
> > >     # cat kdamond_pid 
> > >     -1
> > > 
> > > I think this approach is better than my previous OPTION-1 and OPTION-2.
> > > Does this looks good to you?
> > 
> > Looks not bad.  But, what if we read kdamond_pid before reading enabled?
> 
> You are right. To make this robust, I could apply similar '.get'
> overrides to 'kdamond_pid' as well. This ensures that reading either
> parameter would trigger the state synchronization.
> 
> Would that be too heavy? Or do you think it's unnecessary?

I feel it's bit heavy, or duplication of code that could be avoided in a better
way.

> 
> > Also, what if the user simply try writing N to enabled?  Wouldn't user still
> > see the partial-broken status?  So this doesn't seem gretly superior to the
> > option 2.
> 
> In that case, we could modify the damon_{lru_sort, reclaim}
> _enabled_store(). Before processing the write, we check if kdamond is
> still alive. If it has terminated, we reset the 'enabled' and
> 'kdamond_pid'.

I agree this would work, but again I feel like this is a duplication of code
that could be avoided in a better way.

> 
> > Based on your above reproducer, I understand this issue happens by the
> > damon_commit_ctx() failure.  If it is not wrong, can't we catch the
> > damon_commit_ctx() failure from the calling place and make appropriate updates?
> 
> Yes, we can. We could check 'ctx->maybe_corrupted' right after it
> returns, and reset 'enabled' and 'kdamond_pid' immediately if it's set.
> 
> Do you think this approach is feasible?

I think this is more feasible.  But 'ctx->maybe_corrupted' is a private field
that supposed to be used by only core.c.

What about checking if damon_call() and damon_commit_ctx() failures via therir
return value?  It seems damon_call() fails only when kdamond goes to the
termination path.  damon_commit_ctx() failure always causes the kdamond be
terminated.  So if I didn't miss something that could be a path forward.  What
do you think?


Thanks,
SJ

[...]
