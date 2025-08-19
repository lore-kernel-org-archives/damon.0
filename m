Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626E72580CB
	for <damon@lists.linux.dev>; Tue, 19 Aug 2025 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613093; cv=none; b=KelTKdtCTic01aBLvCUPCgVdzGtQoT/AOhgDlAcZc4OaGfOo9cDQKKo7Htm11a8UOTZmiqqKtFv5Ppc45M1+RyTiCkp+q9biXkKyWu6qIPMtkY5LHfjHjOas/zF/WW8q61ALi9U2qnHIn6LZyL+AcEV77p5d0eBm6deM8dSHb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613093; c=relaxed/simple;
	bh=/O6It6HdictGCO1G8ukNC77Rl08quMLWLfPrHg+HhbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gs1ngFYdC/WtyWXAyMWzP6YtTHnPzJmskqHTkpwwCNslcKZR0UbqoQa+Dh62CSphdywHw+jHXCscjKp8qNrs/OuM70x+XexU6s2lSr+8R3U5Y17NwSrgHR7A8NfenPIf7BnHT2719d5tSPbb5jhdeHnBsA5VupGkRkheaAKG3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c5s6q3Kjwz2gLBM;
	Tue, 19 Aug 2025 22:15:15 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 36E1E140120;
	Tue, 19 Aug 2025 22:18:08 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 22:18:07 +0800
Message-ID: <6b9baf0c-fdc2-4f16-84f7-c4ada507f8f1@huawei.com>
Date: Tue, 19 Aug 2025 22:18:06 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 03/16] mm/damon/paddr: support addr_unit for
 DAMOS_PAGEOUT
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
References: <20250819062613.39988-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250819062613.39988-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Hi SJ,

在 2025/8/19 14:26, SeongJae Park 写道:
> Sorry for the above wrong link.  Plese use
> https://lore.kernel.org/20250813170806.6251-1-sj@kernel.org instead.

Okay, I've merged the corresponding changes into the original patches. So now we have v2 versions
for patches 3, 4, 5, and 6. I'll send out the patches later. That understanding is correct, right?

Thanks,
Quanmin Yan

