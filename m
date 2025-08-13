Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5511D3074AA;
	Wed, 13 Aug 2025 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104547; cv=none; b=jS8ASk4d9ue9fQVXXpBFWPzgQpQrFxTcpzSkCP4Vsyq2MD2sdD57jy4/7OtGf/UzLodvrqj8QwrHEqPWvJJbgdoz6O6t2Ys6guf7ZjD2BmtI/vUW4xMktGawtco1w2L2KlxlskEJka+5OHuy0nAktBRUmreUEduaCv6pEjN2gus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104547; c=relaxed/simple;
	bh=pxPFIqlcVAMG5sLiG3JCncN+PKieiRwzMe/d3NJAQGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5G6r0uaFIQ6+XiUBBKhsDmPo29IPyTz2Rjvd7HId21uJvc3qoW7FhWHOqirJckM9G/aulCGacoG38pzk4FpV18CyJqg4NJBakXCDZUfUliQH8kyF6uLe9QUHuU3sip6J/sBRx4UnnHLp2nlCclF4ERVtTmMmLeky99SWgNM3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ek1oiK1X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ek1oiK1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17D2C4CEF8;
	Wed, 13 Aug 2025 17:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755104546;
	bh=pxPFIqlcVAMG5sLiG3JCncN+PKieiRwzMe/d3NJAQGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ek1oiK1XjXTi0SESN0AUPvtcaMoHxYRtyyZaq295L01XSarSLm92n3YPf5vxwipsw
	 KGqabxNl58laYyM/23faOZSmlQluwCUO5e/WArOUQgverIDf10+X0FpW3M2FCWhaJG
	 i5OazMp25tk4QUOzpzvlwS1cHO/JP/DUEAPjdl5Zck0wPnvFYZL5B67T66uEkrRSDN
	 FTv9BU3mOnVhEhbUvwwOg6L7f8kLZhkrd4OkaIQfoavKlcq10q/xPm8jtE+Jo66HQG
	 BVOaYz2N9jsxARJZQX373m4zG5Q7YKcyFQYLPe0s7az+NAe8cIda9dT+k0WOFNV82/
	 VjnbRziy0istg==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 13/16] mm/damon/sysfs: ensure valid addr_unit setting in damon_sysfs_apply_inputs()
Date: Wed, 13 Aug 2025 10:02:24 -0700
Message-Id: <20250813170224.6128-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813050706.1564229-14-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 13:07:03 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> By calling damon_sysfs_turn_damon_on(), the execution of damon_commit_ctx()
> can be bypassed. Therefore, it is necessary to prevent ctx->addr_unit from
> being set to 0 in damon_sysfs_apply_inputs() and update min_region to avoid
> potential issues.

Nice catch!

> 
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
> ---
>  mm/damon/sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index bea782b0a711..122824776c1d 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1422,7 +1422,8 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
>  	err = damon_select_ops(ctx, sys_ctx->ops_id);
>  	if (err)
>  		return err;
> -	ctx->addr_unit = sys_ctx->addr_unit;
> +	ctx->addr_unit = sys_ctx->addr_unit ? : 1;

So this is fixing a bug of the seventh patch ("mm/damon/sysfs: implement
addr_unit file under context dir") of this series, right?  It is better to not
add a broken patch, and then fixing it in the same series.  Let's squash the
fix of the problem into the patch.  Don't forget adding your Signed-off-by on
the patch.

Also, since sys_ctx->addr_unit is initialized as 1, the value being zero is
user's wrong input.  Let's return -EINVAL instead of making it silently
success.

> +	ctx->min_region = max(DAMON_MIN_REGION / ctx->addr_unit, 1);

Seems this is a fix of an issue in the 12th patch ("mm/damon: add
damon_ctx->min_region and damon_target->min_region") of this series?  Let's fix
it on the patch.

>  	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
>  	if (err)
>  		return err;
> -- 
> 2.34.1


Thanks,
SJ
