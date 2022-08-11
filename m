Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A0C17D2
	for <damon@lists.linux.dev>; Thu, 11 Aug 2022 00:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD39C433C1;
	Thu, 11 Aug 2022 00:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660179164;
	bh=GvjbTsP/kYDC8sXh+otSCioOHXkIHtb+6aCTV1apucE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9WRFOlAlmqYUaaq4KefajE3gP33ZUsEyGw8V824b/wb9DQ5JGEWzHuj4CcZrBoD7
	 nIchLlLQjZwuD+5Pjxpe+W7tZJc2kkTG/I/RKOqsxgttF6Wr+G5c4wAM2Q5gTgrYzk
	 PSJWpxJxcqMhDq9QMiIgf/GppC8PVvbJUR3ViJaPLlap4zXs8TDNVTf9TaGvtWHbZR
	 +PiVpuJ/vTCN9cODMbo/qaN8WcY7feI+sACFhH1lylqdCLpJFVv61mmdjZx+PwhnO0
	 hRUiU/GiO1OlLPt1YWlA+3B2YtO15KQMiKuXV7niisoSV0UQBTuijqVzvJpSoYrp/I
	 C4fetMV76UWPg==
From: SeongJae Park <sj@kernel.org>
To: Kenneth Lee <klee33@uw.edu>
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] mm/damon/dbgfs: Use kmalloc for allocating only one element
Date: Thu, 11 Aug 2022 00:52:41 +0000
Message-Id: <20220811005241.51597-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220808220019.1680469-1-klee33@uw.edu>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kenneth,


Thanks for this patch, and sorry for this late reply.

On Mon, 8 Aug 2022 15:00:19 -0700 Kenneth Lee <klee33@uw.edu> wrote:

> Use kmalloc(...) rather than kmalloc_array(1, ...) because the number of
> elements we are specifying in this case is 1, kmalloc would accomplish the
> same thing and we can simplify.
> 
> Signed-off-by: Kenneth Lee <klee33@uw.edu>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/dbgfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index cb8a7e9926a4..51d67c8050dd 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -1041,7 +1041,7 @@ static int __init __damon_dbgfs_init(void)
>  				fops[i]);
>  	dbgfs_fill_ctx_dir(dbgfs_root, dbgfs_ctxs[0]);
>  
> -	dbgfs_dirs = kmalloc_array(1, sizeof(dbgfs_root), GFP_KERNEL);
> +	dbgfs_dirs = kmalloc(sizeof(dbgfs_root), GFP_KERNEL);
>  	if (!dbgfs_dirs) {
>  		debugfs_remove(dbgfs_root);
>  		return -ENOMEM;
> -- 
> 2.31.1
