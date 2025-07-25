Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2070C2836F
	for <damon@lists.linux.dev>; Fri, 25 Jul 2025 03:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753413329; cv=none; b=CyJfo2hcE+nrcxBIpsLcYnhac75f8mkACqGzutPx3NTf8QTREUPCk8SFcQXqHXrB4tQI3W4BFsC/7XoIbqcPplQZMJNVrXrzqNZy0lz/b2/BM0CkrPwz4/aUXA/LU1HKvEYeYcP7wAx7BGx29ryx0hdHCkgTcZ0kIrl4nV1RP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753413329; c=relaxed/simple;
	bh=Id76nfCvrP58gVNn51aNy52/FZfBLf1rPi3lVtNNo7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sa5rNE/UkApx2EhtbiljzMu12N0el7rsZO3I/D69ZSD+B7EdmQ//znTAWHuNk4lRwVyJdVTSJvclRv6AsC06twQIuXoVLrYCIqmli7LtVWR2auDFJ0R9QsEgvwlB1cwUn+RJ4Zizk+uEl+FPEUWRPR/p1mmjURIMHSsrNwO17R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bpCYl3PMkzYdNB;
	Fri, 25 Jul 2025 11:10:51 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 591D81402CB;
	Fri, 25 Jul 2025 11:15:24 +0800 (CST)
Received: from kwepemq100012.china.huawei.com (7.202.195.195) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Jul 2025 11:15:24 +0800
Received: from [10.174.177.186] (10.174.177.186) by
 kwepemq100012.china.huawei.com (7.202.195.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Jul 2025 11:15:23 +0800
Message-ID: <a5c871c8-dc52-4245-8513-94ccc2b46c94@huawei.com>
Date: Fri, 25 Jul 2025 11:15:22 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/damon: add full LPAE support for memory monitoring
 above 4GB
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>
References: <20250422174301.58953-1-sj@kernel.org>
From: zuoze <zuoze1@huawei.com>
In-Reply-To: <20250422174301.58953-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq100012.china.huawei.com (7.202.195.195)



在 2025/4/23 1:43, SeongJae Park 写道:
> On Tue, 22 Apr 2025 19:50:11 +0800 zuoze <zuoze1@huawei.com> wrote:
> 
> [...]
>> Thanks for the patches - I’ve noted the RFC series and user-space
>> updates. Apologies for the delay; I’ll prioritize reviewing these soon
>> to verify they meet the intended tracking goals. Appreciate your
>> patience.
> 
> No worry.  Please take your time and let me know if there is anything I can
> help.
> 
> I think we can improve the user-space tool support better for usability.  For
> example, it could find LPAE case, set addr_unit parameter, and convert
> user-input and output address ranges on its own.  But hopefully the current
> support allows simple tests of the kernel side change, and we could do such
> improvement after the kernel side change is made.
> 
> 

Hi SJ,

Apologies for the delayed response. We've verified your patch in our
environment and confirmed it supports LPAE address monitoring. However,
we observed some anomalies in the reclaim functionality. During code
review, we identified a few issues:

The semantic meaning of damon_region changed after addr_unit was
introduced. The units in damon_addr_range may no longer represent bytes
directly.

The size returned by damon_sz_region() now requires multiplication by
addr_unit to get the actual byte count.

Heavy usage of damon_sz_region() and DAMON_MIN_REGION likely requires
addr_unit-aware adjustments throughout the codebase. While this approach
works, it would involve considerable changes. What's your perspective on
how we should proceed?

Best regards,
Ze Zuo

> Thanks,
> SJ
> 
> [...]
> 


