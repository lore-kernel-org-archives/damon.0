Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7623FF9
	for <damon@lists.linux.dev>; Wed, 14 Sep 2022 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p0nNQonitIzyxK9JwPGKSpAgLtU8h121WpYGnuj58kg=; b=aDvgresHHEIy2mC6FZyabKavW7
	RUHQ+xcPelAm99KjFHK5m6gLwFw/5d4Dji5VY269XgsRLS7gHzd4FFcQGJwiSQgx/FyDSBbz/TXY5
	LNQvk5X8mIl5fONDkY1Kzu0a10M+kdhRtVqhKOWzIgWPdTqCsrK0g6XTBKPXrytTcvyfOoa9PudCe
	djsOtpUkuvKD4CN2Ql6OTqFQVYGsdar8BrH12EGJiRCyY5VXMuU/yrB/Z05TNEXn4h+L5PVXt9gbt
	ckO+o8/FTgmT1XfFMqPGT4DRZEc0v2Xyj6Yxp4fhj4uGIiRPBc2tXJ5tE6CzcnVmWjdX2NDxT8HJT
	Xo96LboQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1oYVU2-00GF5R-0c;
	Wed, 14 Sep 2022 16:43:30 +0000
Date: Wed, 14 Sep 2022 17:43:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlbfs: use macro SZ_1K to replace 1024
Message-ID: <YyIEsuOm0wEkmpAA@ZenIV>
References: <20220914115723.38271-1-xhao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914115723.38271-1-xhao@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 14, 2022 at 07:57:23PM +0800, Xin Hao wrote:
> Using macro SZ_1K in hugetlbfs_show_options() has no any functional
> changes, just makes code more readable.

Why is it any more readable that way?

> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
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
