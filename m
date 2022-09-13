Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A233CC
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 14:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C540AC43150;
	Tue, 13 Sep 2022 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663080074;
	bh=0Iu5DsvC2OjaeqYGhwmLixwDgdWUl/BFj6dhTq4RAts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p9Zm7asacy4VFjm24SgyTL0RRdpJv68cAyH0gdlTLHAHQg+8sQHqWn/+3anIjp6IG
	 wwLvL+MdXvOS9NT8hhDH6UklUcGMa3rcncpD51I6+EXMec52o59k2Qi0Ey76Wfp1Tf
	 Yq1CNCaySzlU6sxB8GeIRvWTCf2lF4xvLrRyP7KAIS4uESjxQt5XukzZcPkWNaYi4a
	 Sdvk2W7L8RRvrlFQt6ljuAqr68jVK+vALzs1DfS+v13/OB5wGsG3T0xVF66TYIKj/H
	 6PO+4ZjiGM98bH32tLQGDytl4cq83o+5vK/dsctgjUpw82j9zCJVDqcb4S1R7oxALp
	 lh4CI7QYQY7cQ==
From: SeongJae Park <sj@kernel.org>
To: xiakaixu1987@gmail.com
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] mm/damon/sysfs: use the wrapper directly to check if the kdamond is running
Date: Tue, 13 Sep 2022 14:41:12 +0000
Message-Id: <20220913144112.95690-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1662995513-24489-1-git-send-email-kaixuxia@tencent.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kaixu,

On Mon, 12 Sep 2022 23:11:53 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> We can use the 'damon_sysfs_kdamond_running()' wrapper directly to
> check if the kdamond is running in 'damon_sysfs_turn_damon_on()'.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/sysfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 7488e27c87c3..84861c4085a5 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -2455,8 +2455,7 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
>  	struct damon_ctx *ctx;
>  	int err;
>  
> -	if (kdamond->damon_ctx &&
> -			damon_sysfs_ctx_running(kdamond->damon_ctx))
> +	if (damon_sysfs_kdamond_running(kdamond))
>  		return -EBUSY;
>  	if (damon_sysfs_cmd_request.kdamond == kdamond)
>  		return -EBUSY;
> -- 
> 2.27.0
> 
