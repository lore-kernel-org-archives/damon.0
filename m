Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B62932D43C
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638711; cv=none; b=h8jlaDlsSiVv6OapChQ/Mkk38TAUV76meVpzo428XLpcmM9G01WhQrWa4nRMEzDxF3EvgZk7NRkVtoVfEev90ECqVTSjXU3RsdPVW7fK0+0SJG1zppRrMZx2pjATaU2IS26zA8zDRjrni1g594rHIZwlyR6quqR/WDDJnr69VkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638711; c=relaxed/simple;
	bh=LQSYa66re0iTslGYMNX6YFcOH5jtkZOUXjn4mGRa98c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NuvIpKPSEtF5KT3uN9+Gj2hy4O7LL1G4vS+VLKzY1DC8vqcNoGf+g/cxtGxqhbm/wVt+XxsegDWu3BOnGDYFVn4XfIwEAtmCmRxnW3jW0Y96u25D7rLLYghB8YHW4ZJBdZWjCSrSiEjDyl6uZTW2zAXvxHEW2giyi/TUxEfBjKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=Lu55HiYO; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="Lu55HiYO"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WQ/bIIO+fVLNltTgziHSVBVNXf4iqiNT2wWZgC2YhaU=;
	b=Lu55HiYOJ4+JZue4XXyulYTRzrGLbp8+ldADC/bKhsApTDw8uDXqDBgD55OdwRAPU//nJGQpf
	ZlsVv+/gQFZywoUyx4/MtgqFBCGZxmrqnSkaitEn4AqE9KqpqovtxWyZl8gm32z8CPOTrtVMAW2
	aC8iaLQBuyHu+i8uCxPi4zs=
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h4HVQ156yzHnHSX;
	Tue, 21 Jul 2026 20:57:50 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F9724058B;
	Tue, 21 Jul 2026 20:58:14 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jul 2026 15:58:13 +0300
Message-ID: <524b7d2c-4136-4476-9a84-a3dedcd00c5e@huawei-partners.com>
Date: Tue, 21 Jul 2026 15:58:13 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] mm/damon: Introduce a huge page collapsing
 mechanism using auto tuning
To: SJ Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260721035848.147455-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260721035848.147455-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SJ,

On 7/21/2026 6:58 AM, SJ Park wrote:
> Hello Asier,
> 
> On Mon, 20 Jul 2026 12:01:37 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> Overview
>> ========
>> This patch set introduces a new autotuning which allows to collapse
>> hot regions into hugepages.
> 
> Thank you for making this series well done like this!
> 
> [...]
>> Patches Sequence
>> ================
>> Patch 1 -> Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP and autotuning
>> Patch 2 -> sysfs support for the new quota goal
>> Patch 3 -> Document hugepage_mem_bp parameter
> 
> I'd prefer handling 'total' underflow and returning 10,000 instead of INT_MAX
> from damos_hugepage_mem_bp() corner cases.  But definitely that is no blocker.
> For the series,
> 
> Reviewed-by: SJ Park <sj@kernel.org>
> 
> This series is applied to damon/next [1] tree.  If this series is not added to
> mm.git in short term (~3 days?), I will ask mm.git maintainer (Andrew Morton)
> to pick this.  In the case, I will update patch 1 to do what I mentioned as
> preferred change if you don't mind.  So, no action from your side is needed for
> now.  If it seems I also forgot doing that or you cannot wait for my action,
> please feel free to directly ask that to Andrew.
> 
> [1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees
> 
> 
> Thanks,
> SJ
> 
> [...]

Thanks a lot for your patience and help with the patch series.

I will work on the suggested minor changes once the this patch set
lands into mm-next, if you don't mind.

-- 
Asier Gutierrez
Huawei

