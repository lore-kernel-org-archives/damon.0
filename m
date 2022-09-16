Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFF915A2
	for <damon@lists.linux.dev>; Fri, 16 Sep 2022 08:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353EAC433D6;
	Fri, 16 Sep 2022 08:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663317773;
	bh=q//Tw/cZDCMYfrc+5KH+QG9LHPSmCS0RQFK/fL7LNww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ryst4ArblI3iQoFM68HXRdB+vQw60iT6hckhC56MNByf/qS+wMUSrBQc0UR4ABVwm
	 BZCCs+aA1+jRcj37l2ScJeDnfpjZG6K/E8EXrZ5OZDbnoTNTpKxTi3w6YNttvkOQL0
	 BUJzZZRBeUMivkVGdCDfdzJby4B3pixeRPhqI7afVHMc4Bvi+Qt6Q9Nuxtl9Kte/rV
	 2+WV/KN4NnxD1/+aX9ARdJUTE/8L/jXNbXK4j7iKNk/k5SM4jhLkhnjw0ElxJNGwKV
	 nBEm06yiG/G45zKqg6Vql2GHkUK/QruAT0kDHRIhgeTupJCBDljMRe82KbVZ8RiDmo
	 7SpYnJy/UJ3zg==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 1/2] mm/damon/sysfs: avoid call damon_target_has_pid() repeatedly
Date: Fri, 16 Sep 2022 08:42:51 +0000
Message-Id: <20220916084251.105360-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915142237.92529-1-xhao@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Sep 2022 22:22:36 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In damon_sysfs_destroy_targets(), we call damon_target_has_pid() to
> check whether the 'ctx' include a valid pid, but there no need to call
> damon_target_has_pid() to check repeatedly, just need call it once.

Good eyes, nice finding!

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  mm/damon/sysfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 1fa0023f136e..966ea7892ccf 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -2143,9 +2143,13 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
>  static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
>  {
>  	struct damon_target *t, *next;
> +	bool has_pid = false;
> +
> +	if (damon_target_has_pid(ctx))
> +		has_pid = true;

How about doing more simple and short like below?

    bool has_pid = damon_target_has_pid(ctx)

Other than this,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> 
>  	damon_for_each_target_safe(t, next, ctx) {
> -		if (damon_target_has_pid(ctx))
> +		if (has_pid)
>  			put_pid(t->pid);
>  		damon_destroy_target(t);
>  	}
> --
> 2.31.0
