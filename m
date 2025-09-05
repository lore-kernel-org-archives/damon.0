Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B93230DEB8
	for <damon@lists.linux.dev>; Fri,  5 Sep 2025 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063324; cv=none; b=ipXUQ3MSZFCSvTP3s1LpNrxhyLnieoj3ujRyL3RX8/uVOxTC00c1km7aS1pcWuMAM5FU5pgNVTpRCMdOZV9D+0YhGfS6KjRIrJ8KYmxBlB0OH6oRpNlS/tdMraZ6D6skoa0v/tWqu7kCiJi62K5a19FIuOUcEjsgrBJlI9KtCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063324; c=relaxed/simple;
	bh=JZFdnGqzplwr3lvaG1sLqZIuXDZxZqRjmE580gxlejg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euzw6SglsHw34WlIZprfYXD/zR7lkBG/+zZ+RDQzvr07z/mKd4n6M1AllKLuyyne+use8o3c1J4zj2cxUeMBHnzDehQrFyGdRpQCvAv5IIfD15Kr6ajQ+dw9KVVvNv47iPq+AD10KeCHCGYUkn/52QCTSVyERlEdq3gLti9iXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-55-68baa88e0248
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	honggyu.kim@sk.com,
	kernel_team@skhynix.com
Subject: Re: [BUG] 'damo stop' causes kernel crash in v6.17-rc3
Date: Fri,  5 Sep 2025 18:08:26 +0900
Message-ID: <20250905090827.969-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250905035411.39501-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsXC9ZZnoW7fil0ZBlv/cFs8+f+b1eLw1zdM
	Dkwem1Z1snm82DyTMYApissmJTUnsyy1SN8ugSvj2ezbrAX3TSpWPzvP2MDYodXFyMEhIWAi
	sWtyUBcjJ5j5b+t9RhCbTUBD4uChk8wgtoiAoET/4xmsIDazgJfE+f1zweLCAvYSGz7NYwKx
	WQRUJf4tms8CYvMKmEms23WDBWKmpkTDpXtgNZwCxhKXjx8Cmy8kwCPxasN+Roh6QYmTM5+w
	QMyXl2jeOhtoPhdQ70tWiaev7zNDDJKUOLjiBssERv5ZSHpmIelZwMi0ilEoM68sNzEzx0Qv
	ozIvs0IvOT93EyMwvJbV/onewfjpQvAhRgEORiUeXoPCnRlCrIllxZW5hxglOJiVRHhn8AKF
	eFMSK6tSi/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0tSC2CyTJxcEo1MPqdXeP/U322
	ZWMwS8O8ua9vO3NYai9rvC/5jEHi77Iuo/xXxdfylj712/Gp+XjZQ9Ymv/ONTb610qo33zQr
	7gmbGbd69WaX/bliqVO8/s3bfsuyUUbv/vsF/vIzvc5eCb6WpeS+b27Ujd66fu4rc3lfqmx+
	5ds784JGGZd3/A8HE+k25XWh2UosxRmJhlrMRcWJAAqZkoMrAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkluLIzCtJLcpLzFFi42LhmiGro9u3YleGwecnjBZP/v9mtfj87DWz
	xeG5J1ktDn99w+TA4rFpVSebx4vNMxk9vt328Fj84gNTAEsUl01Kak5mWWqRvl0CV8az2bdZ
	C+6bVKx+dp6xgbFDq4uRk0NCwETi39b7jCA2m4CGxMFDJ5lBbBEBQYn+xzNYQWxmAS+J8/vn
	gsWFBewlNnyaxwRiswioSvxbNJ8FxOYVMJNYt+sGC8RMTYmGS/fAajgFjCUuHz8ENl9IgEfi
	1Yb9jBD1ghInZz5hgZgvL9G8dTbzBEaeWUhSs5CkFjAyrWIUycwry03MzDHVK87OqMzLrNBL
	zs/dxAgMoGW1fybuYPxy2f0QowAHoxIPr0Hhzgwh1sSy4srcQ4wSHMxKIrwzeIFCvCmJlVWp
	RfnxRaU5qcWHGKU5WJTEeb3CUxOEBNITS1KzU1MLUotgskwcnFINjFuWuxx4n7KKP5xz0b35
	R746SnJH1YZNLJ+lyTCnQmXGVOZX97e4Ck9o37Lt5ou+NxlhF7Wbsl68f3Fp/6H3i5a8Sjt8
	YOu3jhU+s06/aLueuUyB9b/MxyVfrqxa9K2kc9Oyc51etkuTc5+e9fv7IlxpjWNT2ZplW7eu
	SxfsN3/Os+XoywdpC20WK7EUZyQaajEXFScCAIgZ5wYcAgAA
X-CFilter-Loop: Reflected

On Thu,  4 Sep 2025 20:54:11 -0700 SeongJae Park <sj@kernel.org> wrote:
> On Thu,  4 Sep 2025 17:29:45 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> 
> > On Wed,  3 Sep 2025 21:02:03 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > Hi Yunjeong,
> > > 
> > > On Thu,  4 Sep 2025 10:17:38 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> > > 
> > > > Hi!
> > > > 
> > > > I encountered a kernel crash when running 'damo stop' in kernel v6.17-rc3, 
> > > > I tested and confirmed that this issue also occurs in v6.17-rc1.
> [...]
> > > I found commit d809a7c64ba8 ("mm/damon/sysfs: implement refresh_ms file
> > > internal work") is the first bad commit, according to 'git bisect'.  And
> > > actually the code is broken for multiple kdamonds case, since it is sharing one
> > > damon_call_control object for multiple kdamonds while overwriting the data
> > > field to later-called one.
> 
> More problematically, the damon_call_control->list is continuously overwritten
> by the multiple kdamond threads.  This corrupts the damon_call_control lists of
> the contexts, and as a result kdamond_call() infinitely loops.  Hence
> kdamond_fn() cannot catch the termination request and the hang happens.
> 
> > >
> > > I haven't yet deep dive into by what code path the issue happens, but sharing
> > > this first, since I have to go out soon.  I'll further take a look later.
> > > Meanwhile, could you please also confirm if it is the first bad commit for your
> > > issue, too?
> > 
> > Thanks for sharing your analysis!
> > I also confirmed that first bad commit is d809a7c64ba8.
> > The previous commit b907494768e5 doesn't cause the above issue.
> 
> Thank you for confirming.  I confirmed attaching patch fixes the problem with
> your repro on my setup.  Could you please also test that on your machines and
> confirm if it fixes the issues on your setups, too?  If you confirm, I will
> post it soon.

Thank you for the patch. I have confirmed that it fixes the problem on QEMU.
I will test it on my physical machine early next week and share the result
with you.

> 
> [...]
> > > 'scripts/decode_stacktrace.sh' can show which line of what source file each of
> > > the above line points.  So if you could share the output of the script from
> > > your next bug reports, it would be pretty helpful.
> > 
> > I'm not aware of this tool, thank you for letting me know!
> > I'll trying using it next time.
> 
> No worry, and let me know if you need any help for that.
> 
> And please don't delay or hesitate reporting new issues in future for learning
> of a tool.  I'd prefer getting early and incomplete issue reports much more
> than late and complete reports. :)
> 

Thank you for the advice. I'll report any issues right away:)

> 
> Thanks,
> SJ
> 
> [...]
> 
> === >8 ===
> >From 6754cdb95c03313fd7d9f104b9dbe851ecef237e Mon Sep 17 00:00:00 2001
> From: SeongJae Park <sj@kernel.org>
> Date: Thu, 4 Sep 2025 20:18:46 -0700
> Subject: [PATCH] mm/damon/sysfs: use dynamically allocated repeat mode
>  damon_call_control
> 
> For testing.
> 
> Fixes: d809a7c64ba8 ("mm/damon/sysfs: implement refresh_ms file internal work") # v6.17.x
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h |  2 ++
>  mm/damon/core.c       |  8 ++++++--
>  mm/damon/sysfs.c      | 23 +++++++++++++++--------
>  3 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index ec8716292c09..aa7381be388c 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -636,6 +636,7 @@ struct damon_operations {
>   * @data:		Data that will be passed to @fn.
>   * @repeat:		Repeat invocations.
>   * @return_code:	Return code from @fn invocation.
> + * @dealloc_on_cancel:	De-allocate when canceled.
>   *
>   * Control damon_call(), which requests specific kdamond to invoke a given
>   * function.  Refer to damon_call() for more details.
> @@ -645,6 +646,7 @@ struct damon_call_control {
>  	void *data;
>  	bool repeat;
>  	int return_code;
> +	bool dealloc_on_cancel;
>  /* private: internal use only */
>  	/* informs if the kdamond finished handling of the request */
>  	struct completion completion;
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7aeb3f24aae8..be5942435d78 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2510,10 +2510,14 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
>  		mutex_lock(&ctx->call_controls_lock);
>  		list_del(&control->list);
>  		mutex_unlock(&ctx->call_controls_lock);
> -		if (!control->repeat)
> +		if (!control->repeat) {
>  			complete(&control->completion);
> -		else
> +		} else if (control->canceled && control->dealloc_on_cancel) {
> +			kfree(control);
> +			continue;
> +		} else {
>  			list_add(&control->list, &repeat_controls);
> +		}
>  	}
>  	control = list_first_entry_or_null(&repeat_controls,
>  			struct damon_call_control, list);
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 0ed404c89f80..a182670493bb 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1565,14 +1565,10 @@ static int damon_sysfs_repeat_call_fn(void *data)
>  	return 0;
>  }
>  
> -static struct damon_call_control damon_sysfs_repeat_call_control = {
> -	.fn = damon_sysfs_repeat_call_fn,
> -	.repeat = true,
> -};
> -
>  static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
>  {
>  	struct damon_ctx *ctx;
> +	struct damon_call_control *repeat_call_control;
>  	int err;
>  
>  	if (damon_sysfs_kdamond_running(kdamond))
> @@ -1585,18 +1581,29 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
>  		damon_destroy_ctx(kdamond->damon_ctx);
>  	kdamond->damon_ctx = NULL;
>  
> +	repeat_call_control = kmalloc(sizeof(*repeat_call_control),
> +			GFP_KERNEL);
> +	if (!repeat_call_control)
> +		return -ENOMEM;
> +
>  	ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
> -	if (IS_ERR(ctx))
> +	if (IS_ERR(ctx)) {
> +		kfree(repeat_call_control);
>  		return PTR_ERR(ctx);
> +	}
>  	err = damon_start(&ctx, 1, false);
>  	if (err) {
> +		kfree(repeat_call_control);
>  		damon_destroy_ctx(ctx);
>  		return err;
>  	}
>  	kdamond->damon_ctx = ctx;
>  
> -	damon_sysfs_repeat_call_control.data = kdamond;
> -	damon_call(ctx, &damon_sysfs_repeat_call_control);
> +	repeat_call_control->fn = damon_sysfs_repeat_call_fn;
> +	repeat_call_control->data = kdamond;
> +	repeat_call_control->repeat = true;
> +	repeat_call_control->dealloc_on_cancel = true;
> +	damon_call(ctx, repeat_call_control);
>  	return err;
>  }
>  
> -- 
> 2.39.5
> 
