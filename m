Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE600280037
	for <damon@lists.linux.dev>; Tue,  9 Dec 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765264912; cv=none; b=sE62j6BxWVsLBtOAyksxsr8Z+4Kr8tGPb7Q23kNj9pjky12JluCVNPhMg1Ary9IRysvPuOEbUlbUR3H/3N/nfZRwEfIJ81lrHmYoTFaITOqp3kziUpXafo8+MVnzuvxaCF6Xu0cKcIpgYrynpADwmcdVT3YpztFz4UXMTvAfEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765264912; c=relaxed/simple;
	bh=YFsjm86FdvkgcY6Jiigg9An1/lmF5ic/ii6TJuTDmGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9uFgx/tRTgHoMYmFnVfo8NEXr3cIYjydyvoEBRcBFOhs1j9gh3zm8Ct0zedNHnAXQefsb/wZZqJDcXlsaADfeOtIusEfpW10Y8WacEEmgVxuCI3awqTsVGvOIa8Wk9v2FyiY+DwYZc+CwXpoGTmAiMxqREvaWnQ/Zns1rRbVxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNDULjqH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNDULjqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A8AC4CEF5;
	Tue,  9 Dec 2025 07:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765264911;
	bh=YFsjm86FdvkgcY6Jiigg9An1/lmF5ic/ii6TJuTDmGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uNDULjqHUgaW7V6B+JgMTxVCIdhI5LwAO4x9mGGF2NAzKCSz8cfG/YlWW7dScHzx5
	 SYhrMuK5bePqInXB/WmVJuw+j4Cq9i7ni3uV9XICTDN+PP9OwXtQJmlPvnpVKnlU2S
	 M9BPCmrTFKbQwmFQWya1JVIKxB21FKTZHi8WIzBdT/Eczdt3G58U2l/t1E3Gt1JUc2
	 FwFU0TEkaHOr02EdA0CQbGtTP4A1v3G7HQX1COy1C/Ev7payIQJrtojta8o4fAS7nP
	 gMfp1MPNHDpwI11VIQgnMZwAZyHYSzTM9vnVukJdBahtkEkT03SnqWqafmZiaD6JoU
	 9aqy7F1xb0f5Q==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH] mm/damon/core: delete damon_target when detected invalid
Date: Mon,  8 Dec 2025 23:21:45 -0800
Message-ID: <20251209072146.42315-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209055713.270737-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  9 Dec 2025 13:57:13 +0800 Enze Li <lienze@kylinos.cn> wrote:

> Currently, DAMON does not proactively clean up invalid monitoring
> targets during its runtime.  When some monitored targets exit, DAMON
> still makes the following unnecessary function calls,
> 
>   --damon_for_each_target--
>   --damon_for_each_region--
>       damon_do_apply_schemes
>         damos_apply_scheme
>           damon_va_apply_scheme
>             damos_madvise
>               damon_get_mm
> 
> and it is only in the damon_get_mm() that it may finally discover that
> the monitoring target no longer exists.

Thank you for finding this inefficiency, Enze!

> 
> To avoid wasting CPU resources, this patch modifies the
> kdamond_need_stop() logic to proactively clean up monitoring targets
> when they are found to be invalid.

However, this could introduce an unexpected behavior change to DAMON sysfs
users.  Let's consider a DAMON context having three target processes (a, b, c)
is running.  The second process is terminated.  And the user updates the target
with two existing processes and a new process (a, d, c) using the online commit
feature.

Before this change, 'a' and 'c' targets keep running with the old monitoring
results.  The target for 'b' is replaced for 'd'.  After this change, the
target for 'b' is removed from the list, and 'c' becomes the second target of
the list.  Because the online commit feature works based on the indices of
targets on the list, target for 'c' is updated for 'b', lose previous
monitoring results.

Please let me know if I'm missing something.

> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> ---
>  mm/damon/core.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index f9fc0375890a..eb5612bfd6bf 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2462,7 +2462,8 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
>   */
>  static bool kdamond_need_stop(struct damon_ctx *ctx)
>  {
> -	struct damon_target *t;
> +	struct damon_target *t, *next;
> +	bool valid_target_exist = false;
>  
>  	if (kthread_should_stop())
>  		return true;
> @@ -2470,11 +2471,16 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
>  	if (!ctx->ops.target_valid)
>  		return false;
>  
> -	damon_for_each_target(t, ctx) {
> +	damon_for_each_target_safe(t, next, ctx) {
>  		if (ctx->ops.target_valid(t))
> -			return false;
> +			valid_target_exist = true;
> +		else
> +			damon_destroy_target(t, ctx);
>  	}
>  
> +	if (valid_target_exist)
> +		return false;
> +
>  	return true;
>  }

So, from the beginning part of the patch description, I understand your concern
is the unnecessary function calls in kdamond_apply_schemes().  What about
checking the target validness using ctx->ops.target_valid() and avoid going
deeper if it is invalid?  Seems the damon_for_each_target() loop is a good
point to do this.

What do you think?


Thanks,
SJ

[...]
