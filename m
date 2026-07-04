Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7561E9919
	for <damon@lists.linux.dev>; Sat,  4 Jul 2026 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783189514; cv=none; b=uEO8cwqLLtNQjAjn8oDJ2RTQvlknlfVBGfuu3klR3wMCRAlua6j2Zdqw85eSx2w/x93F7YqI0KvkvymoBpIjus06zsVpV5YCy56cOv2td8dix0Unw3+wPzisimk6f0UNBsAieZmaTMdIZL+5OPUD6yJIufQBWqtOVXqV6L7+tX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783189514; c=relaxed/simple;
	bh=sTjVxoK3XVevRcI+ToX2IIF6sjFmbtqrI0eZgAw4gmI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SszpgDBh4ydi9RKHLKWMuVd9Ldj5aKaWJNaZgzUpyBWYp3JXQ4/F4+KIUzQnlbnLUk1RJpNXySwkfWI/YMS3uegasrDYSVlyYbGeqSVnmln4IzVM/18A//mQcaj3dwRZxhtHIJDrdonTiGRiJGN87bUgBM84RoZm06f21FbbsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXbwVobC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXbwVobC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D53B1F000E9;
	Sat,  4 Jul 2026 18:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783189513;
	bh=hemeR6Mjf59spw/hJBNUsyLMKEvy+AEzBA8SSThNbfs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HXbwVobCgjUEMviUj5n3hyeveGYv7+OLL7q8V3WBZ8hzYKeQwqQmWlsVmG3fmo+ug
	 R6Kl2BdtyxouZKCH24aGod/A7HJCgYGewnOi2JLxdwvpKra8IyopJzMzdr0jxoAGFn
	 hWl5cHbMbymoxoQJ6MIuHecNponmBW/U6g7+fH3MT9RMqjwP2wM1iKOJVCk4svzsHi
	 8FBL11/x/D3527ghUXE9xkHLURhN3gi+XCibRhuTZ3TVdTVubzzAGnxzzdzWVhBbrS
	 Jb1Xb53pOOT6Zki8ViXFMhRVFb6wRLQgTBClhd2QyXnBPN0Ghxo3pM+Y4ixSzoFq8C
	 hbW1294sZbZoA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 09/11] mm/damon/core: stop ctx in damon_call()
 before reruning an error
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260704181135.132956-10-sj@kernel.org>
References: <20260704181135.132956-1-sj@kernel.org>
 <20260704181135.132956-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 18:25:12 +0000
Message-Id: <20260704182513.4D53B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent invocations of `__damon_stop()` triggered by canceled `=
damon_call()`s lead to a double `kthread_stop()` deadlock.
--

commit 5b208204f87a1b80335c35ce1b66a42e8f74a1ba
Author: SJ Park <sj@kernel.org>

mm/damon/core: stop ctx in damon_call() before reruning an error

This commit updates damon_call() to ensure the DAMON context is explicitly
stopped when a call fails or is canceled.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index aa48bf44c2a0b..9c15d44084af4 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -1956,8 +1958,13 @@ int damon_call(struct damon_ctx *ctx, struct damon=
_call_control *control)
>  		return 0;
>  	wait_for_completion(&control->completion);
>  	if (control->canceled)
> -		return -ECANCELED;
> +		goto canceled;
>  	return 0;
> +
> +canceled:
> +	__damon_stop(ctx);

[Severity: High]
Could this lead to a deadlock if multiple threads invoke damon_call()
concurrently on the same context?

If multiple threads are waiting in damon_call() and the kthread exits, it
cancels all pending controls and wakes the waiters. These threads will jump
to the canceled label and call __damon_stop(ctx) concurrently.

Looking at __damon_stop(), it reads ctx->kdamond without clearing it:

static void __damon_stop(struct damon_ctx *ctx)
{
	struct task_struct *tsk;

	mutex_lock(&ctx->kdamond_lock);
	tsk =3D ctx->kdamond;
	if (tsk) {
		get_task_struct(tsk);
		mutex_unlock(&ctx->kdamond_lock);
		kthread_stop_put(tsk);
		return;
	}
	mutex_unlock(&ctx->kdamond_lock);
}

Does this allow multiple threads to fetch the same task struct and call
kthread_stop_put() concurrently?=20

Since kthread_stop() waits on the kthread's exit completion which is
signaled via complete() (waking only one waiter), would the subsequent
threads block forever in kthread_stop(), causing a deadlock?

> +	return -ECANCELED;
> +
>  }
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704181135.1329=
56-1-sj@kernel.org?part=3D9
