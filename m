Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061DE2E62A9;
	Mon, 16 Feb 2026 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771268269; cv=none; b=oDQ/aFi1Rr34A2vmeQBP760QBs36TrvplgqOA3Qc9e6CqFV0CZaipTLw5N+KhN4ELwevarcTEnMz/4mriaXFjDQUw3EBDfA03wkZOCKeaV9PQ0iWpRtMoz092AuU40WzonbGPjDSik1MWfHaCEk5Zim2sVqkfO9cxJjCtQtwlNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771268269; c=relaxed/simple;
	bh=lQ2xyyBLXyHLyreiYyKcm6LlV+Vy+ZHITtyVg+hPIgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tW+QhX0cYLAVxf0T8PQ50vymXOQZleqKbeu5QYrrAZjwdUHFD3V/xAtiDaKAscPdj7eP2Ep0HPXRD/3TVqUdy0i8KlfKoVLo3XxcyHZX0fOdxeUe9Txb2AFG7naz3Cxf6ooPAiHTOCkEfLQJK77Rc3d8XzQIPzBpGYfNV6eHG34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rW8J7eWF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rW8J7eWF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6EBC116C6;
	Mon, 16 Feb 2026 18:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771268268;
	bh=lQ2xyyBLXyHLyreiYyKcm6LlV+Vy+ZHITtyVg+hPIgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rW8J7eWFtzv1ZCG2v/ALJTmtLtZEVya180Dgfva2dYVX3PjHEjHg71QpvT8BVRtF4
	 hyHW6tcINHuH7LFFbmSsPp5RmBp4V6+hTf/qK3akLn4aazKKh/g+I2pbRmmuV8ioJJ
	 x4dbgreuc2NcmjhQ1m7zkZhrJzz3p1wT1ow61OeEv+eHY/WIIHvmvVSriRWobFUzt1
	 XwXv2x/Zb6NHY5EjArVB+AdRKjxz2XxNyorXMQKnB4pcjrY7eguoxVraM1PCRFOKB+
	 r+1Bt5AQ5dXf6oWtxNPgYH9kmT2nFH+E7WZDxbPzWn0a35zVmAE7K80g/X4BkshOJM
	 zSDV3W7k1Unqg==
From: SeongJae Park <sj@kernel.org>
To: Raul Pazemecxas De Andrade <raul_pazemecxas@hotmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"security@kernel.org" <security@kernel.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm/damon/core: dangling walk_control pointer in damos_walk() on inactive context
Date: Mon, 16 Feb 2026 10:57:40 -0800
Message-ID: <20260216185741.74145-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To:  <CPUPR80MB81718B12798BCF9959535B05956CA@CPUPR80MB8171.lamprd80.prod.outlook.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Hello Raul,

On Mon, 16 Feb 2026 16:26:22 +0000 Raul Pazemecxas De Andrade <raul_pazemecxas@hotmail.com> wrote:

> From 7d82f231f99949d041045789d3ed912ad7e25546 Mon Sep 17 00:00:00 2001
> From: Raul Pazemecxas De Andrade <raul_pazemecxas@hotmail.com>
> Date: Mon, 16 Feb 2026 13:06:04 -0300
> Subject: [PATCH] mm/damon/core: clear walk_control on inactive context in
>  damos_walk()

Seems you copy-pasted this patch on your email body.  It is more usual to send
the patch as a complete new mail thread, using 'git send-email'.  Please
consider doing so if you send a patch again, next time.

> 
> damos_walk() sets ctx->walk_control to the caller-provided control
> structure before checking whether the context is running. If the context
> is inactive (damon_is_running() returns false), the function returns
> -EINVAL without clearing ctx->walk_control. This leaves a dangling
> pointer to a stack-allocated structure that will be freed when the
> caller returns.

Nice catch!

> 
> This is structurally identical to the bug fixed in commit f9132fbc2e83
> ("mm/damon/core: remove call_control in inactive contexts") for
> damon_call(), which had the same pattern of linking a control object
> and returning an error without unlinking it.

Correct.  Nonetheless, the user impact is prettry trivial compared to the
damon_call() bug.  Let me explain why I think so below.

> 
> The dangling walk_control pointer can cause:
> 1. Use-after-free if the context is later started and kdamond
>    dereferences ctx->walk_control (e.g., in damos_walk_cancel()
>    which writes to control->canceled and calls complete())

But, there is no such use case to my understanding.  DAMON sysfs interface is
the only damos_walk() user.  And when a user asks it to turn DAMON on with a
context that was used before and now stopped, it does not use the damon_ctx
object that was used before.  Instead, it deallocates the damon_ctx object that
was used before, allocates a new damon_ctx object, and use the new one.  The
new one doesn't have the stale pointer, so no real issue happens.  Please let
me know if I'm missing something.

So this is a good theory for potential future bugs.  Nonetheless, this is not
what can happen right now in the real world.  I agree the pointer is better to
be cleared as this patch suggests, to reduce such potential future risks.

> 2. Permanent -EBUSY from subsequent damos_walk() calls, since the
>    stale pointer is non-NULL

This is the real bug.  Returning -EBUSY while DAMON is turned off may confuse
users.  Nonetheless, this happens only while the DAMON context is turned off.
If you starts it again, DAMON sysfs interface starts it with newly allocated
internal damon_ctx object as I mentioned above.  The new object doesn't have
the stale pointer, so works normally.

For example, after the reproducer steps in your bug report [1], you can show
below:

    # echo on > $DAMON/0/state
    # echo "update_schemes_tried_regions" > $DAMON/0/state
    # echo $?
    # 0

Again, I think this is a real bug that could make users be confused, and
therefore better to be fixed.  Nonetheless, calling damos_walk() against
stopped DAMON context seems not a common use case.  So I think the real impact
is trivial.

> 
> Fix this by clearing ctx->walk_control under walk_control_lock before
> returning -EINVAL, mirroring the fix pattern from f9132fbc2e83.

Sounds reasonable.

> 
> Reported-by: Raul Pazemecxas De Andrade <raul_pazemecxas@hotmail.com>

Closes: https://lore.kernel.org/CPUPR80MB8171025468965E583EF2490F956CA@CPUPR80MB8171.lamprd80.prod.outlook.com

> Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Raul Pazemecxas De Andrade <raul_pazemecxas@hotmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  mm/damon/core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 5e2724a4f..fb00879af 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1559,8 +1559,13 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
>       }
>       ctx->walk_control = control;
>       mutex_unlock(&ctx->walk_control_lock);
> -     if (!damon_is_running(ctx))
> +     if (!damon_is_running(ctx)) {
> +           mutex_lock(&ctx->walk_control_lock);
> +           if (ctx->walk_control == control)
> +                 ctx->walk_control = NULL;
> +           mutex_unlock(&ctx->walk_control_lock);
>             return -EINVAL;
> +     }
>       wait_for_completion(&control->completion);
>       if (control->canceled)
>             return -ECANCELED;
> -- 
> 2.51.2

I also found 'git am' of this patch is not cleanly working on mm-new.  Please
consider using mm-new as the baseline [2] next time.

To ensure this is not forgotten and merged into the mainline, I added this
patch to my tree, after manually rebasing on mm-new, adding a note about the
user impact, and adding the above tags that I offered.  Unless I find something
on this patch needs to be changed, and you mind, I will post it again after the
current merge window, to make sure it goes to the mainline.  So no additional
work from your side is required.

Nonetheless, if you prefer to make a new revision of this patch and repost on
your own, please do so.

[1] https://lore.kernel.org/CPUPR80MB8171025468965E583EF2490F956CA@CPUPR80MB8171.lamprd80.prod.outlook.com
[2] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees
[3] https://git.kernel.org/pub/scm/linux/kernel/git/sj/damon-hack.git/tree/patches/next/mm-damon-core-clear-walk_control-on-inactive-context.patch?id=398e6f536b37de82f789d74ea93815dfcb129d99


Thanks,
SJ

[...]
