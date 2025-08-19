Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DC7279351
	for <damon@lists.linux.dev>; Tue, 19 Aug 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614766; cv=none; b=DEC1C0O20e4s7vanB8/PnsyF+g1hyoeDCdsTZbLcASk4EhalJZYG3QhT63vqEtTV68PPGwAvSF/EHEc3HMynFsfnkSH+zK4Tjgy/cqDOKLVd8NJHsnYqpbF8cb90az2QB7gUSZjKY3UOMVzohnx6uGlKNgVFNbuTPtP0BtqLUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614766; c=relaxed/simple;
	bh=Xyk4PbdC32rW/p/J8PdathC3nxlXIaSAaPIZYpBq1kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gjdwqGr4XJ+z/fsdP3x8Psbh2wUjozOTR+PSjKOEgVBNCzsAa696MtrVZjS1txdgY9pLbWVu93hrh7YQgzBIpQH8AHog5T8kNFQaszZoYtKjAmD77MIbvT8/Fw24SHt5g8xl1HNR0T5QpilHo/feqR6GenNtryZLgDeCfw/UAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c5sjF42PpzdcS1;
	Tue, 19 Aug 2025 22:41:37 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 396D218007F;
	Tue, 19 Aug 2025 22:46:00 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 22:45:59 +0800
Message-ID: <c3050ee1-a3f6-4f3f-8cd3-a5d67dcdcacc@huawei.com>
Date: Tue, 19 Aug 2025 22:45:58 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 07/16] mm/damon/sysfs: implement addr_unit file
 under context dir
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
References: <20250819062452.39889-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250819062452.39889-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Hi SJ,

在 2025/8/19 14:24, SeongJae Park 写道:
> Hi Quanmin,
>
> As I suggested on another reply[1], please squash attaching patch to this one
> when you post next version of this series.
>
> [1] https://lore.kernel.org/20250813170224.6128-1-sj@kernel.org
>
> [...]
>
>
> Thanks,
> SJ
>
> ==== Attachment 0 (0001-mm-damon-sysfs-return-EINVAL-for-zero-addr_unit.patch) ====
>  From e0a5aa5e571ecd0f58b0914f8fc8562a60014ae8 Mon Sep 17 00:00:00 2001
> From: SeongJae Park <sj@kernel.org>
> Date: Wed, 13 Aug 2025 21:17:03 -0700
> Subject: [PATCH] mm/damon/sysfs: return -EINVAL for zero addr_unit
>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>   mm/damon/sysfs.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index bea782b0a711..eb4269383bae 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1422,6 +1422,8 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
>   	err = damon_select_ops(ctx, sys_ctx->ops_id);
>   	if (err)
>   		return err;
> +	if (!sys_ctx->addr_unit)
> +		return -EINVAL;
>   	ctx->addr_unit = sys_ctx->addr_unit;
>   	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
>   	if (err)

Aha, returning -EINVAL when sys_ctx->addr_unit is 0 makes sense, but I wonder if it
might be better to prevent users from inputting 0 at the source instead? I've attempted
to modify patch 7 by adding a check in addr_unit_store. I'll send out the v2 version
of patch 7 later (PS: I am performing a comprehensive validation of the v2 patch series),
and we can discuss it then.

Thanks,
Quanmin Yan

