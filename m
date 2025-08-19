Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D84279351
	for <damon@lists.linux.dev>; Tue, 19 Aug 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615166; cv=none; b=PKkadgotrfjNvzXT35aTDvlCD/Yh66KLZWrhzxEooHUVEMck9Q7C7HSHFpqA3XVWDCK6s7kbiDqkEMhofeluB6XjYm66HZAQzUjKwfQqS+JICP99q7zqh2Cex+mTbw+K1Wj9Jbi0NY3kPYTEAUKkxhaz53KkWn01RbmYpHy45dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615166; c=relaxed/simple;
	bh=uy6I8kZCHvUlbjE38jIb5vqXRXv3OnTovzkv3PfbRJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h/yNJ3wG/Dp88rLLmq6/wElureu6FrkfGUOeiwPL1K32D+IuLLgw/2ZCL4c8yFFuyqp5pu3vtA0pzwhg7Msm+IZ754NlfzbDPzV/SW3glV/Y8sAl359Do5+7AUGXqzwC0VjE6jGx5zjKlxf1lcKZKBoAm2/LASs8EifFThsOLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c5srz5CmDz2CgFZ;
	Tue, 19 Aug 2025 22:48:19 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 2914E140149;
	Tue, 19 Aug 2025 22:52:42 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 22:52:41 +0800
Message-ID: <48fd269c-a61d-4459-ab86-8235adecaf93@huawei.com>
Date: Tue, 19 Aug 2025 22:52:40 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 12/16] mm/damon: add damon_ctx->min_region and
 damon_target->min_region
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
References: <20250813164907.5885-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250813164907.5885-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Hi, SJ

在 2025/8/14 0:49, SeongJae Park 写道:
>> To me, keeping the synchronization seems more complicated than just passing the
>> addr_unit value to relevant functions.  I'd prefer passing the addr_unit to
>> relevant functions.  It could require more changes and might make code uglier,
>> but I think that's easier to maintain, and we can cleanup/refactor the code
>> later.
>>
>> Could you please do so in the next version?

Yes, I've revised patch 12 based on your suggestions and will send out the v2 version shortly.

Thanks,
Quanmin Yan

