Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED851C861D
	for <damon@lists.linux.dev>; Wed,  1 Apr 2026 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775004243; cv=none; b=gj5n6aj+zbKfrF9KkA4lx/T9DjMrMbpZAAr5jDZEjVF+7yO8tILlXWM9wiVKN1Yk85bxV07ub7TyBxXpy46Dp2oRd3Nmr9ivOH52FuD1wMqbpyoBC7rk+BaS3Uj5kBjIIureez8Cqx2Z4aTzlEVSPukOJw7PK0zFCubFx391mEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775004243; c=relaxed/simple;
	bh=6HLg+daKemhcsyvc2Z8QkE7LSs10O0Nc3zdCGX7p03I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8JNO1E15cMzCRBHibA2TKUMieVdZBrsKlHMKYRszZHmpFFCo53MPBThPHws0GDCNpC7f7ihuvR8LID3dBCkUrxt8rjOm7lOhNqR9VFXW2hky44SPf3f9R6+ZirfWhwiAf2eqBvI3iRFXqNKJt/oKZj5cNr6iqcS5JPkVabn3zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ah4YX0Hl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ah4YX0Hl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AF0C19423;
	Wed,  1 Apr 2026 00:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775004242;
	bh=6HLg+daKemhcsyvc2Z8QkE7LSs10O0Nc3zdCGX7p03I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ah4YX0Hlwz87zByh7BTWO+SP42Q0S2SoarNUck4KRKIOVwokqWCiHjq+ZyiGSIXlS
	 8RFZaJcNlKmfjr+ESK3cP/8oGPB7CQ9zplKeCy6WiXQlP70AlqkdIY1r1ODyJQkJKU
	 /cRS72GB7WbIiHQguuGG/YRq5STNYIVALEzY3BSjrzaHYBe2Idle/ZW3mNnXWtm4Qq
	 QFxdjwCP/Hx0ZjQp12BSN9mYBQz1am1bxwbTXZbe22wbL+x99NDYA6Y2UGpp4XRalh
	 0XybcSOdSz/mGk9oBsXSZNTf1l+Q3JpIyS3B/8kX5TnAdLvlgS73zzbEs6/hnuxd6/
	 CPg6vuyAq8dYg==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Tue, 31 Mar 2026 17:44:00 -0700
Message-ID: <20260401004400.85613-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331160956.16312-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  1 Apr 2026 00:09:56 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> On Tue, 31 Mar 2026 14:58:36 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > [...]
> > Option 1: Introduce a generic termination callback
> > ==================================================
> > Add 'void *after_terminate_fn(void*)' and 'void *after_terminate_data'
> > to 'struct damon_ctx' or 'struct damon_operations'. While this extends
> > the Core API, it provides a clean notification mechanism. When kdamond
> > exits for any reason, the module can perform its own cleanup (e.g.,
> > resetting 'enabled' and 'kdamond_pid') within its own callback. This
> > keeps the core logic decoupled from module parameters.

Maybe this is the right long term direction.  But to my understanding the fix
should be backported to stable kernels.  Is that correct?  If so, I'd prefer
simple quick fix that can easily backported.

> > 
> > Option 2: On-demand state correction in the module
> > ==================================================
> > In damon_{lru_sort, reclaim}_enabled_store(), if damon_stop() fails, we
> > check is_kdamond_running(). If the kdamond is found to be terminated, we
> > forcibly reset 'enabled' and 'kdamond_pid'.

I think this can work, and simple.

> > 
> > My perspective
> > --------------
> > I personally prefer OPTION-1 because it ensures the sysfs state in
> > synchronized actively.
> > 
> > OPTION-2 is simpler and avoids API changes, but it's a "passive" fix
> > that only triggers when user atttempts a write operation. User might
> > still see inconsistent value until they try to interact with the module.

I agree your concern.

> > [...]
> 
> To avoid over-complicating the Core API (Option 1 or current approach),
> I've implemented a lightweight, on-demand synchronization mechanism in
> the module layer.
> 
> By overriding the '.get' operator of the 'enabled' parameter, we can
> detect if kdamond has terminated and reset the module-level state right
> before the user reads them.
> 
> Since sysfs parameter access is protected by 'kernel_param_lock', this
> approach is race-free and keeps the DAMON core decoupling intact.
> 
> Core Implementation:
> 
> 	if (enabled && !damon_is_running(ctx)) {
> 		enabled = false;
> 		kdamond_pid = -1;
> 	}
> 
> 	return param_get_bool(buffer, kp);
> 
> Test Log:
> 
>     # cd /sys/module/damon_lru_sort/parameters/
>     # echo Y > enabled 
>     # echo 3 > addr_unit 
>     # echo Y > commit_inputs 
>     # cat enabled 
>     N
>     # cat kdamond_pid 
>     -1
> 
> I think this approach is better than my previous OPTION-1 and OPTION-2.
> Does this looks good to you?

Looks not bad.  But, what if we read kdamond_pid before reading enabled?
Also, what if the user simply try writing N to enabled?  Wouldn't user still
see the partial-broken status?  So this doesn't seem gretly superior to the
option 2.

Based on your above reproducer, I understand this issue happens by the
damon_commit_ctx() failure.  If it is not wrong, can't we catch the
damon_commit_ctx() failure from the calling place and make appropriate updates?


Thanks,
SJ

[...]
