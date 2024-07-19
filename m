Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63451B86D5;
	Fri, 19 Jul 2024 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721410957; cv=none; b=gKxKUFXJNMFfIYIrXwNobCXyXZ3m3yXqCksniFRccHzUUBCvzAfNncCAyya+4hlJr3YFly3oVyCTUVineU2pCAnRjAeh4K7/Ggk6MPzq/ure3mzFt/IrorhFTr4mZAsULwjpuz6IFrH2y6jbC22dZmcF7VF6auvotxUzcmD1MPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721410957; c=relaxed/simple;
	bh=Jk9NfEcv66FNR8gsu4jpa1SBZFnUGn3Xmqi1BK+BShw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Byu7dWhYKQry53N7f6cmjkfViooUr1/eFYKSPaS5/9MgiPVlKQJ8y6vtydXM6LnYHJBJdoWX7RsWS/RKQJ+6Va/cTWXm3hp6ojFSVn04hfqwHh56/w/JvM0mwEDYjvG3MF8QjRIsl3ybEL8q0Qvq3EB4YD/vflkz7MdbI4Mdgs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unc6mPAz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unc6mPAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD655C32782;
	Fri, 19 Jul 2024 17:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721410957;
	bh=Jk9NfEcv66FNR8gsu4jpa1SBZFnUGn3Xmqi1BK+BShw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=unc6mPAz3GcSgstjiV93+95v/F7cH1nWylvXxhRctjEDwBI9ClNxEgJzF7InUYOhk
	 xi/QaNizR5RqnYEqNlIjX8gy+kJXkWQUta+G3Mpx7jn3ThW/fdB2guziObcCtApNhe
	 N7NYiQlNAZYEbNUC0kU8+pV0kiLciXDdNODF1nleUAJDmwjXXHW7W0IQT5EvwogH/0
	 0EII1shmxkBY31QS48cZ2zDrjncbkOFlwDuR7hRBxJPRgG8nkEzcd+AmeSjekE1SI+
	 qB2/msF7ED6ecnHl0xaEnzBFTYDyRD/wfW1X6vdphM3wfEy77HefTatKYlbZYXwrp3
	 YVHkTSneLCWig==
From: SeongJae Park <sj@kernel.org>
To: flyingpenghao@gmail.com
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	Peng Hao <flyingpeng@tencent.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3]  mm/damon/lru_sort: adjust local variable to dynamic allocation
Date: Fri, 19 Jul 2024 10:42:34 -0700
Message-Id: <20240719174234.47017-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240719091100.42649-1-flyingpeng@tencent.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Peng,


For DAMON patches, please Cc linux-mm@.  I'd also suggest Cc-ing linux-kernel@
if you don't mind.

On Fri, 19 Jul 2024 17:11:00 +0800 flyingpenghao@gmail.com wrote:

> From: Peng Hao <flyingpeng@tencent.com>
> 
> When KASAN is enabled and built with clang:
>     mm/damon/lru_sort.c:199:12: error: stack frame size (2328) exceeds limit (2048)
> in 'damon_lru_sort_apply_parameters' [-Werror,-Wframe-larger-than]
>     static int damon_lru_sort_apply_parameters(void)
>                ^
>     1 error generated.
> 
> This is because damon_lru_sort_quota contains a large array, and
> assigning this variable to a local variable causes a large amount of
> stack space to be occupied.
> 
> So adjust local variable to dynamic allocation.
> 
> v2: Change the histgram array in damon_quota to dynamic allocation.
> v1: Modify global variables directly.

Please put the version history under '---' line below, as suggested[1] by the
document.  Also, adding lore links to the previous versions would be helpful.

> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  mm/damon/core.c     |  1 +
>  mm/damon/lru_sort.c | 10 +++++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 6392f1cc97a3..ac2b736c9115 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -375,6 +375,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
>  	INIT_LIST_HEAD(&scheme->list);
>  
>  	scheme->quota = *(damos_quota_init(quota));
> +	kfree(quota);

We don't know if the caller has something to do further with it after this
function returns.  Let's keep it do be done by the caller.

>  	/* quota.goals should be separately set by caller */
>  	INIT_LIST_HEAD(&scheme->quota.goals);
>  
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 3de2916a65c3..3b417e413bf2 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -148,10 +148,14 @@ static struct damon_target *target;
>  static struct damos *damon_lru_sort_new_scheme(
>  		struct damos_access_pattern *pattern, enum damos_action action)
>  {
> -	struct damos_quota quota = damon_lru_sort_quota;
> +	struct damos_quota *quota = kmemdup(&damon_lru_sort_quota,
> +					    sizeof(struct damos_quota), GFP_KERNEL);

Let's do sizeof(*damon_lru_sort_quota).  Also, please keep 80 columns line size
rule[2] for DAMON code.

[1] https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format
[2] https://docs.kernel.org/process/coding-style.html#breaking-long-lines-and-strings

> +
> +	if (!quota)
> +		return NULL;
>  
>  	/* Use half of total quota for hot/cold pages sorting */
> -	quota.ms = quota.ms / 2;
> +	quota->ms = quota->ms / 2;
>  
>  	return damon_new_scheme(
>  			/* find the pattern, and */
> @@ -161,7 +165,7 @@ static struct damos *damon_lru_sort_new_scheme(
>  			/* for each aggregation interval */
>  			0,
>  			/* under the quota. */
> -			&quota,
> +			quota,
>  			/* (De)activate this according to the watermarks. */
>  			&damon_lru_sort_wmarks);
>  }
> -- 
> 2.27.0

Thanks,
SJ
