Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C365F126C02;
	Fri, 12 Jun 2026 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224324; cv=none; b=Xa+I0VJc9xD7/3lR36V06j7WXkb8JCx7yw0YC51EuCaiK8natdAmEahBQe1JPLKQiUoR3sPg3PLwah6v0zkUm9xFQUOjjpk99UVxeDPfdZo/nLY7PXt/VxeHtYyZoNLs1QKjUD1HlXBJDiLaLDGCFLPsHMahf7Wu4dWs85q2LvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224324; c=relaxed/simple;
	bh=jpmX8ReHc9Z3pmITgZBHU+8Kzn7Pi0gvwplCQIMb3LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uc/TrZOzxuK5zU3QQCWCGPVmZFVp1si73XgWclHQ6d15C5YEolbmmcFMNxVu2zvPgoB1sB3uu0GzomemLdkDb0gwXCk01t2rRNqqfgn7c3czNCJgMWsE8zS302PM2G8JCX64ehl8bqkZipL5cug5biN0KzE+oQP7hAEqwmNB9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxXlPK1w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxXlPK1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F27F1F000E9;
	Fri, 12 Jun 2026 00:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224323;
	bh=i3ENLsWlXbr9jUyZwD29G+H9s7CK7T6F8TR/DsF/P3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DxXlPK1wNOHGBUDY3DKKYEUyWq4lifVDsdwRvsb0G/4xpsJgMw4y7xihUZRD1gqDd
	 IAdBeQrGa32bLkB8YfGLCd2/aC2vrY+kjU3Ec0IxKy9qTThCP31XR/hpaQNr+bV4F5
	 89g3KCd8C0R4E1LZ8xx9M9oJ+GyioTUyHFJ9aP6TnUMqghArxbgcQI4kT04wV9wPSK
	 o/cJqOkPykpCV4uZPI43UejsV4O+LU9fIskbdiCi53AQoutxkxYLNqWkHcBrFUTxoC
	 f94ItBnyhUKwKXnJhBwAew4Mt1pkD285szi+9LPJJbVrEXKqs3xVammG0DNrfm5Muk
	 iclZjYDvwirsQ==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 3/4] mm/damon/sysfs: support hugepage_mem_bp quota goal metric
Date: Thu, 11 Jun 2026 17:31:55 -0700
Message-ID: <20260612003156.83465-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611150244.3454699-4-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 11 Jun 2026 15:02:43 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Add the "hugepage_mem_bp" to the sysfs-schemes interface.  Also handle
> DAMOS_QUOTA_HUGEPAGE_MEM_BP when constructing quota goals.
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> ---
>  mm/damon/sysfs-schemes.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 329cfd0bbe9f..dc46ec128083 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -1267,6 +1267,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
>  		.metric = DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
>  		.name = "node_eligible_mem_bp",
>  	},
> +	{
> +		.metric = DAMOS_QUOTA_HUGEPAGE_MEM_BP,
> +		.name = "hugepage_mem_bp",
> +	},
>  };
>  
>  static ssize_t target_metric_show(struct kobject *kobj,
> @@ -2877,6 +2881,9 @@ static int damos_sysfs_add_quota_score(
>  		case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
>  			goal->nid = sysfs_goal->nid;
>  			break;
> +		case DAMOS_QUOTA_HUGEPAGE_MEM_BP:
> +			goal->current_value = sysfs_goal->current_value;
> +			break;

We do this for only DAMOS_QUOTA_USER_INPUT, because that needs to receive the
user input.  For other metrics that DAMOS self-find the values, this is not
needed.  Same for HUGEPAGE_MEM_BP.  So I don't think this change is needed.

Please let me know if I'm missing something.


Thanks,
SJ

[...]
