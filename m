Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB91F6AA2
	for <damon@lists.linux.dev>; Mon, 19 Sep 2022 17:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5B8C433D6;
	Mon, 19 Sep 2022 17:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663608173;
	bh=HQIglUDLQBaVF3vEx2t8CopF+c8dwQhHTb2AFxrgu3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cv58B3MTc5nooSeZ9Qg1zHKNeXUqEIGH1PDfcEBDT9ZrVx8Rps0eTWEhDjl/WApmd
	 Jkb3WSKtiQBsPBPGn7fZ9/3C2okpojKRa9Rkc9tLvwYdSREFXA74/mB67mujbBBpMQ
	 sjz9o1utC+J0Cmu+DLwJN+/MFZBq0+Ed95XWkP7D+T7LmltXLzxTsz8olcNEQ8u4XD
	 EW0Vd4aj3mYE9eT/jNvNi1vOs1xJWOA71NKadjoBr14D/QIe6KIYtwh4H6MQAQ0eTH
	 gfIOOyxcRtkvnY0Ii2OyQV9QhirDOxWsQkfDDU4+PTK0ARp4NU36auS4CQHmQaMC4A
	 dpWYps+/xMzmg==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/damon/sysfs: use kzmalloc instead kmalloc to simplify codes
Date: Mon, 19 Sep 2022 17:22:51 +0000
Message-Id: <20220919172251.61428-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919151201.66696-2-xhao@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 19 Sep 2022 23:12:01 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In damon_sysfs_access_pattern_alloc() adn damon_sysfs_attrs_alloc(),
> we can use kzmalloc to alloc instance of the related structs, This makes
> the function code much cleaner.

This definitely makes the code cleaner, thank you.  But, the initial intent of
the code is to initialize the fiedls that really need to be initialized at the
point, for the efficiency and also for making it clear which field is needed to
be initialized to what value here.  It's also intended to make readers wonder
about where and how the remaining fields are initialized.

So, to my humble eyes, this change looks like making the code a little bit
inefficient and unclear, sorry.


Thanks,
SJ

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  mm/damon/sysfs.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index b852a75b9f39..06154ece7960 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -657,13 +657,7 @@ struct damon_sysfs_access_pattern {
>  static
>  struct damon_sysfs_access_pattern *damon_sysfs_access_pattern_alloc(void)
>  {
> -	struct damon_sysfs_access_pattern *access_pattern =
> -		kmalloc(sizeof(*access_pattern), GFP_KERNEL);
> -
> -	if (!access_pattern)
> -		return NULL;
> -	access_pattern->kobj = (struct kobject){};
> -	return access_pattern;
> +	return kzalloc(sizeof(struct damon_sysfs_access_pattern), GFP_KERNEL);
>  }
>  
>  static int damon_sysfs_access_pattern_add_range_dir(
> @@ -1620,12 +1614,7 @@ struct damon_sysfs_attrs {
>  
>  static struct damon_sysfs_attrs *damon_sysfs_attrs_alloc(void)
>  {
> -	struct damon_sysfs_attrs *attrs = kmalloc(sizeof(*attrs), GFP_KERNEL);
> -
> -	if (!attrs)
> -		return NULL;
> -	attrs->kobj = (struct kobject){};
> -	return attrs;
> +	return kzalloc(sizeof(struct damon_sysfs_attrs), GFP_KERNEL);
>  }
>  
>  static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
> -- 
> 2.31.0
