Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B073D80
	for <damon@lists.linux.dev>; Sun, 25 Sep 2022 17:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758AAC433D6;
	Sun, 25 Sep 2022 17:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664127615;
	bh=J6MQ6nba3bNXWm13BqriajL0itO1C/a8zLexNF1ZFAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OkZq0jGhSkSPq3kPxaEBOl3PECjK2uwJU8qNaC8mEG878Nx9bpO9VH5hWpcNPtZSM
	 8NkHoT0XQOvB4qzY8nquutwdwOjgFIRjYGnhQmnThHYNzyn7xnyZlpBz9Be3dlB8jJ
	 aCVo56CPytTSyD0RHmHgIqlMJGLJNU1UztPfbPryWs2LTKPjdrWK6Shf60MQQ0FOm0
	 paZ/GxPMeJ/Wt88zj70ZPOy5lDnNGtQBgILNuD8+YoBwTTDXWaGF+KnGeHSr7w5Cgx
	 zZenW1YI/ihUwvNBJnzJrxDCKmGiZT9X4gE/Ddyea4ESq27QxhCHD+HiYdvMGA6aoC
	 Uj7oCUZWPniMQ==
From: SeongJae Park <sj@kernel.org>
To: Levi Yun <ppbuk5246@gmail.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] damon/sysfs: Fix possible memleak on damon_sysfs_add_target.
Date: Sun, 25 Sep 2022 17:40:13 +0000
Message-Id: <20220925174013.59565-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220925140257.23431-1-ppbuk5246@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 25 Sep 2022 23:02:57 +0900 Levi Yun <ppbuk5246@gmail.com> wrote:

> When damon_sysfs_add_target couldn't find proper task,
> New allocated damon_target structure isn't registered yet,
> So, it's impossible to free new allocated one by
> damon_sysfs_destroy_targets.

Good finding, thanks!

> 
> By calling additional damon_free_target when find_get_pid function,
> Fix possible memory leak.
> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>

Could we add relevant 'Fixes: ' and 'Cc: <stable@vger.kernel.org>' tags?

> ---
>  mm/damon/sysfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 7488e27c87c3..28ed07d26d55 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -2184,8 +2184,11 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
>  		return -ENOMEM;
>  	if (damon_target_has_pid(ctx)) {
>  		t->pid = find_get_pid(sys_target->pid);
> -		if (!t->pid)
> +		if (!t->pid) {
> +			damon_free_target(t);
> +

Seems unnecessary new line?

>  			goto destroy_targets_out;
> +		}
>  	}

Looks good to me, but...  How about simply doing 'damon_add_target()' before
'if (damon_target_has_pid())', like below?

```
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 455215a5c059..9f1219a67e3f 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2172,12 +2172,12 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,

        if (!t)
                return -ENOMEM;
+       damon_add_target(ctx, t);
        if (damon_target_has_pid(ctx)) {
                t->pid = find_get_pid(sys_target->pid);
                if (!t->pid)
                        goto destroy_targets_out;
        }
-       damon_add_target(ctx, t);
        err = damon_sysfs_set_regions(t, sys_target->regions);
        if (err)
                goto destroy_targets_out;
```


Thanks,
SJ

>  	damon_add_target(ctx, t);
>  	err = damon_sysfs_set_regions(t, sys_target->regions);
> -- 
> 2.35.1
> 
> 
