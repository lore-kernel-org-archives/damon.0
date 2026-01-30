Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94D345725
	for <damon@lists.linux.dev>; Fri, 30 Jan 2026 03:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769742442; cv=none; b=BZcm+0PFvMWshCFTp052IXD9dIJQcH2LLvmSsKcT0YAa8mBk0fwWwSKzzn9oWkbYo/E/Sz/n48Au/tTQxFTlUtk3xNHpV0e/T87Vs7uk2/FZiLC9DuxUACp1A0KIw/oHqBiL/eUKinB8+gXRJEuY6f1PZ8RwPjKbvhnojkUwoc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769742442; c=relaxed/simple;
	bh=0ol3zWhKJfXyZOd84T33CmJHEfbcYptuWnia3jjBik0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=uH2rTe5WcoFM4XjwQUxFHLeD+6x5fsfWq2w9wLhX+F0sIOcjn4rxljehkgLzB9iMrZwLZo3hgy9fn9xiceIBjZFM8S8KIGzNdiuxbcZxeL3NZU8GcByCxb7ufl2eltKhpMm4SF+g95ep5ZHMPRAX0jIVn5v4xjnUsP8F1/6ohoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OSReZxRq; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OSReZxRq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=doBblbOwHdShc4Ks1wKLoAH6Jx+hawhblsEzVk31/Ac=;
	b=OSReZxRqks6Mn+4xZc/BGDtgA59KlnSpys1LAlyeyCDRs0CZLytsQPzK2cJ+3MZyX175minF6
	3gCTz2appOma9TEGWjcaEExiVmR3CWOpjrAY0n3tfxvzIe3lLibNn0031sRfHSRz6h0SyL/dYKs
	qhyg/ULFl3IFSFttv8/qlws=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f2LRm4ZnxznTVF;
	Fri, 30 Jan 2026 11:03:16 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A6C64048B;
	Fri, 30 Jan 2026 11:07:09 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Jan 2026 11:07:08 +0800
Message-ID: <71e02d8a-94b7-4b9c-877e-5efd4f7aba44@huawei.com>
Date: Fri, 30 Jan 2026 11:07:08 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon: unify address range representation with
 damon_addr_range
From: Quanmin Yan <yanquanmin1@huawei.com>
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <enze.li@gmx.com>, <sunnanyong@huawei.com>, Enze Li
	<lienze@kylinos.cn>, =?UTF-8?B?5Lil5p2D5rCR?= <yanquanmin1@huawei.com>
References: <20260129161029.48991-1-sj@kernel.org>
 <d6f2b111-bb42-4437-9711-bf06cf9afefa@huawei.com>
In-Reply-To: <d6f2b111-bb42-4437-9711-bf06cf9afefa@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf200018.china.huawei.com (7.185.36.31)

在 2026/1/30 10:26, Quanmin Yan 写道:
> Hi SJ,
>
> [...]
>
>> Actually, there is another bug that need to be fixed.  Nonetheless, 
>> that's
>> orthogonal to this patch, so it is not a blocker of this patch in my 
>> opinion.
>
> Are you referring to the scenario where, on a 32-bit system with LPAE 
> support, the biggest System RAM address found exceeds the range of 
> unsigned long? Actually, DAMON only actively searches for the biggest 
> System RAM address when the user does not set a monitoring region. In 
> this case, we always reset addr_unit to 1, which essentially restricts 
> DAMON’s monitorable address range to 0–UL. Therefore, the described 
> situation does not occur. For details, please refer to commit [1]. 
> However, we could perhaps further optimize this by finding any biggest 
> System RAM address, setting damon_addr_range, and dynamically 
> adjusting addr_unit. However, there are currently no specific 
> requirements for this, so this work has been temporarily put on hold. 
> [1] commit dfc02531f413 ("mm/damon/reclaim: use min_sz_region for core 
> address alignment when setting regions") Thanks, Quanmin Yan
>
> [...] 

(Sorry there was an issue with my email client. I am resending now.)

Are you referring to the scenario where, on a 32-bit system with LPAE
support, the biggest System RAM address found exceeds the range of
unsigned long?

Actually, DAMON only actively searches for the biggest System RAM
address when the user does not set a monitoring region. In this case,
we always reset addr_unit to 1, which essentially restricts DAMON’s
monitorable address range to 0–UL. Therefore, the described situation
does not occur. For details, please refer to commit [1].

However, we could perhaps further optimize this by finding any biggest
System RAM address, setting damon_addr_range, and dynamically adjusting
addr_unit. However, there are currently no specific requirements for
this, so this work has been temporarily put on hold.

[1] commit dfc02531f413 ("mm/damon/reclaim: use min_sz_region for core
address alignment when setting regions")

Thanks,
Quanmin Yan

