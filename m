Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1B64683
	for <damon@lists.linux.dev>; Thu, 15 Sep 2022 13:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE49C433C1;
	Thu, 15 Sep 2022 13:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663249553;
	bh=zvTn9BWL/FcNXRvKgOxjhue2aM2e2uoqaWld7P/b3RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRA6W5Q0sRPZn6UzpoUEdY4q9113j7YXLElel6nUDhpaUq/jxErH35CXDRAqju9Ki
	 CuCAtJriOhsk5GYS+BFDk66R0Arv27ZzPVDLwrUft2bG68sCq3AqGmAyTKPIqDEQYk
	 KJpz4x2T4BRnD9X2qKF6FVj9I+SuOOmeEJAqcdiuHjx9y1FQ7UrSiz/i0K1fcKlLsk
	 57p/li2bFIvxT1j1bib6LwoG0M6pr6CyYZONohl14Iuya80R5ZaNvOxtTbXAXB8dg6
	 bwQnAMgDibpnu0zhuKgu0fcV/FoZkTmOkS8e4JNBBgAwgFK3cmuNaBUbj0H8YWpEBK
	 /T4hRTMn5+ibg==
From: SeongJae Park <sj@kernel.org>
To: xiakaixu1987@gmail.com
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] mm/damon: use 'struct damon_target *' instead of 'void *' in target_valid()
Date: Thu, 15 Sep 2022 13:45:51 +0000
Message-Id: <20220915134551.99224-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1663241621-13293-1-git-send-email-kaixuxia@tencent.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kaixu,


On Thu, 15 Sep 2022 19:33:41 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> We could use 'struct damon_target *' directly instead of 'void *' in
> target_valid() operation to make code simple.

Nice finding.

> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  include/linux/damon.h | 2 +-
>  mm/damon/vaddr.c      | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index c5dc0c77c772..1dda8d0068e5 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -346,7 +346,7 @@ struct damon_operations {
>  	unsigned long (*apply_scheme)(struct damon_ctx *context,
>  			struct damon_target *t, struct damon_region *r,
>  			struct damos *scheme);
> -	bool (*target_valid)(void *target);
> +	bool (*target_valid)(struct damon_target *t);
>  	void (*cleanup)(struct damon_ctx *context);
>  };
>  
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 3f84584f9982..f53c2ff2bcc8 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -593,9 +593,8 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
>   * Functions for the target validity check and cleanup
>   */
>  
> -static bool damon_va_target_valid(void *target)
> +static bool damon_va_target_valid(struct damon_target *t)
>  {
> -	struct damon_target *t = target;
>  	struct task_struct *task;
>  
>  	task = damon_get_task_struct(t);
> -- 
> 2.27.0
> 
