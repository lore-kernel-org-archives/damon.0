Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDBF3D7C
	for <damon@lists.linux.dev>; Wed, 14 Sep 2022 14:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD70FC433D6;
	Wed, 14 Sep 2022 14:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663164208;
	bh=nhVx0gn7AsjC6QInzn3fLYFpoPK1KO9cyf+fOkCT9HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SvVLexy7CgJW1FDPPbCnSdrJR+Np8nJ32ilJenWAzRyWchi3rvEJ19jjIMz/eEAvH
	 7oybCy1aXMbhosyA0hUotVurSi6W6PjjfJMV8yR25kAyINIZRnBkMf4ZzB4GQC/GAh
	 5W3+Ma4UCgwuHGjhh73H28hwtw9q+dGvIInkxOPN/GvWsPXrq1WcX8udaH8FyD2UEd
	 R6jFSTYD9LFmWApsBDkvMJecz4upILYqqGndBVe9mrb8ewqHWdK911o1RmWcZj1e/X
	 JtRNQDj7Myi6PY6dHd5unxdH9UVBHMupu3SqUICv0H/ky9LIk88DYAaJhPS8gygWyG
	 Lnd1yn8OZkzAQ==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlbfs: use macro SZ_1K to replace 1024
Date: Wed, 14 Sep 2022 14:03:26 +0000
Message-Id: <20220914140326.1121-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914115723.38271-1-xhao@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 14 Sep 2022 19:57:23 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> Using macro SZ_1K in hugetlbfs_show_options() has no any functional
> changes, just makes code more readable.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  fs/hugetlbfs/inode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index f7a5b5124d8a..9b9784ffe8de 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1023,10 +1023,10 @@ static int hugetlbfs_show_options(struct seq_file *m, struct dentry *root)
>  	if (sbinfo->max_inodes != -1)
>  		seq_printf(m, ",nr_inodes=%lu", sbinfo->max_inodes);
> 
> -	hpage_size /= 1024;
> +	hpage_size /= SZ_1K;
>  	mod = 'K';
> -	if (hpage_size >= 1024) {
> -		hpage_size /= 1024;
> +	if (hpage_size >= SZ_1K) {
> +		hpage_size /= SZ_1K;
>  		mod = 'M';
>  	}
>  	seq_printf(m, ",pagesize=%lu%c", hpage_size, mod);
> --
> 2.31.0
