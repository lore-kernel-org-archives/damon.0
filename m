Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC3E225403
	for <damon@lists.linux.dev>; Tue, 19 Aug 2025 05:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755581141; cv=none; b=mpS5+Bg3Hq7BKyCTTCCDymhwk4mQfY8QboanGpmFYKp4mX+WFPC2wM4Q1uvVg7XKcjQFgx5K0HRk7QXO1mPJXHX21NluxtKrAAfXnxthhETGsWDFbSBqQ1a+03W5Gz4gz5O/s6rchmKjq0LdRFk4X9ucTIc8B+ielanr//ZvXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755581141; c=relaxed/simple;
	bh=yXQc+PcrnqyNAoKXW51Z4gByum0niSizmcaNBF/bkS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CAMh805mkMm+8fBXP30SOJWbFriW3X8JYiNKyZeGU0tbu7B2lCbYV/w5GxJhCEhFGY57SnSeXuc+Gy6uPTw4HfJCFjpsFgchSZr2Z1G8xnebFkbiB6H7mMOk9C2p3A2D9Epa5utCcZEXmRI5CV4kZ0Ex4q+zzPEk7nhs/cBh2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lspyx+YZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lspyx+YZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2257BC4CEF4;
	Tue, 19 Aug 2025 05:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755581141;
	bh=yXQc+PcrnqyNAoKXW51Z4gByum0niSizmcaNBF/bkS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lspyx+YZetpxjXUtPxcRf/mI08qHrcYp3O2eqjl/8OgA8iJT9CTM0PXrO4zd1ouCv
	 V54YX61/XA2SgRktPK6B8eSd5oLS2ezzbsu3w0z4Mmw6vuKHd1eU0rE2W1au3dIdvi
	 DFhJBdSul6AK3LP2ZOG9oj5F8ljIF/I9iACys78irLCviSEf4GrPXSxEoZV0l3IuOf
	 kLA3uGsgWZ4sDRbNeAlA4pVPClsBciim+CaQhK6kOC8Ih4nEImghkJ9tA9x4x8C6Zm
	 2jRg9hbBwss5qHcnVJlIxIL7L1pIS8wVI+ISd9zZOI5u9tCUUnI7ysRiJ7kCAHJbi9
	 l56sBQnVJP19g==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: set initial quota->charged_from to INITIAL_JIFFIES
Date: Mon, 18 Aug 2025 22:25:39 -0700
Message-Id: <20250819052539.38526-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250818183803.1450539-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 19 Aug 2025 03:38:03 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
> include/linux/jiffies.h
> 
>  /*
>   * Have the 32 bit jiffies value wrap 5 minutes after boot
>   * so jiffies wrap bugs show up earlier.
>   */
>   #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> 
> In 32bit system, if quota->charged_from is initialized to 0 as it now,
> it will not adjust event if reset_interval_ms passes for the first 5
> minutes.

Thanks to your clarification on another mail, I now understand this can happen
because time_after_eq() casts the diff of the given two unsigned long values
into signed long type.  I might be not the only one who can be confused on this
part, though.  I think at least I of future will be confused again.  Please add
the detail on the changelog.

The above explanation is not technically wrong, but I think it is not
describing the issue completely.  The above description is saying about only a
case that a DAMOS scheme with quotas is applied just after the system is boot.

But, a similar and much worse problems can happen at anytime if such scheme is
applied while jiffies value is somewhat that can be casted into any negative
signed long value, e.g., about 25 days after the boot, assuming HZ value 1,000.
In the worst case, hence, a quota charging window can continue for up to about
25 days.

The same problem can theoretically happen on 64 bit machines too, though not
practically early (about 300 million years after the boot, assuming HZ value
1,000).

If I'm not wrong, I think the fix of this bug deserves Cc-ing stable@.

> 
> So change initialize value of quota->charged_from to INITIAL_JIFFIES.

So this will fix only just-after-boot time issue.

I think it should be initialized to the jiffies value of the time that the
quota really starts being charged.

> This soultion has already been applied in commit 7d70e15480c0 ("writeback:
> add missing INITIAL_JIFFIES init in global_update_bandwidth()") or else.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
> I think it would be good to add selftest of below senario. 
> 
> 1. Set DAMON with quota.
> 2. Wait and check esz is updated well.
> 3. If esz is not updated after quite long time, set test to fail.
> 
> but I'm not sure that selftest can support environment handling; jiffies
> with INITIAL_JIFFIES or near there.
> 
> If there is another method that i don't know. Could you please let me
> know? Or any better idea?
> 
> ---
>  mm/damon/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index cb41fddca78c..90317a3bcf78 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -366,7 +366,7 @@ static struct damos_quota *damos_quota_init(struct damos_quota *quota)
>  	quota->total_charged_sz = 0;
>  	quota->total_charged_ns = 0;
>  	quota->charged_sz = 0;
> -	quota->charged_from = 0;
> +	quota->charged_from = INITIAL_JIFFIES;

As I argued above, I think we should at least set this as 'jiffies', not
INITIAL_JIFFIES.

Also, damos_quota_init() is called by damon_new_scheme().  We cannot guarantee
if the caller will directly start DAMON with it, or commit it into running
DAMON.

So a better approach would be initializing ->charged_from at the beginning of
kdamond_fn(), e.g., inside kdamond_init_ctx().  For commit case, damos_commit()
may also need to be updated.  To me, this feels too complicated for stable
kernel backports.

What about modifying damos_adjust_quota() to initialize ->charged_from, like
below?

--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2130,6 +2130,10 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
        if (!quota->ms && !quota->sz && list_empty(&quota->goals))
                return;

+       /* First charge window */
+       if (!quota->total_charged_sz && !quota->charged_from)
+               quota->charged_from = jiffies;
+
        /* New charge window starts */
        if (time_after_eq(jiffies, quota->charged_from +
                                msecs_to_jiffies(quota->reset_interval))) {
[...]

In theory, this can also incur wrong behavior in a case that charged_from is
overflowed to zero while total_charged_sz remains zero.  Such cases would be
unrealistic, though.  And even if it happens, nothing goes really wrong.  It
will only extend the current charging window for one reset_interval, once per
jiffies overflow.  Meanwhile, this fix is simple and can be easily backported
to old stable kernels.  So I'd like to recommend this option.

What do you think, Sang-Heon?


Thanks,
SJ
