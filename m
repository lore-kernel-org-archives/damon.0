Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E982DFA24
	for <damon@lists.linux.dev>; Wed, 20 Aug 2025 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755684389; cv=none; b=k+AWABvy2Zyxm5+LrYX6d4etqysgxFPw089B6qpVmY3Km2i1X7wFPnbz2IlVQ0kMjGaPKia3vD+ku5reo6YbeHnylcLTuvD2A0oDnMm+0azs1KvyIPri8vrdvtdlHrOSowVc2PdgGv7mMkiLY+SS7kAEIvbnU5huIW7vJbIf0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755684389; c=relaxed/simple;
	bh=Hj//tIArwuoyfjv7T19BKeF/ztcvMefPEzInMuIwrEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R+OzgnuM00fRYI1OZMtpBzUKEdtiETTMsCKpUHcWBPaNvQ8uKBjrCKtY/F55V9eFZhu6J4grEyV7dJv8r54UCKKpQB/0b/bs+0CEIh657GGrewCQXXfCLL/L1LBtYxu4SHfyspwQyK/J9tiPW54wNAfAwbTtGSuJCDZzp9Fy3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c6MTt6gyNz2gLJt;
	Wed, 20 Aug 2025 18:03:30 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 118B81A0171;
	Wed, 20 Aug 2025 18:06:24 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Aug 2025 18:06:23 +0800
Message-ID: <43c2ce03-04ac-4da4-a9e2-7f1393939d14@huawei.com>
Date: Wed, 20 Aug 2025 18:06:22 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 16/16] mm/damon/core: handle quota->esz overflow
 issues
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
References: <20250813171521.6482-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250813171521.6482-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Hi SJ,

在 2025/8/14 1:15, SeongJae Park 写道:
> On Wed, 13 Aug 2025 13:07:06 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>
>> In the original quota enforcement implementation, the traffic
>> calculation multiplied A by 1000000 due to time unit conversion,
>> making it highly prone to overflow on 32-bit systems:
>>
>> damos_set_effective_quota
>>    if (quota->total_charged_ns)
>>      throughput = quota->total_charged_sz * 1000000 /
>> 		quota->total_charged_ns;
>>
>> Requiring total_charged_sz to be less than 4GB/1000000 is unreasonable.
>> Additionally, when overflow occurs and causes quota->esz to become
>> extremely small, the subsequent damos_apply_scheme logic permanently
>> sets sz to 0, while quota stop updating, ultimately leading to complete
>> functional failure:
>>
>> damos_apply_scheme
>>    if (quota->esz && quota->charged_sz + sz > quota->esz)
>>      sz = ALIGN_DOWN(quota->esz - quota->charged_sz, DAMON_MIN_REGION);
>>
>> Total charged stats use the unsigned long long data type to reduce
>> overflow risk, with data reset capability after overflow occurs.
> Thank you for finding this issue!  I don't want to change the data type if
> possible, though.  Could replacing the easily-overflowing throughput
> calculation with mult_frac() fix the issue?

Thank you for your guidance, it does work effectively. The relevant changes
have been included in patch #12 of the v2 series[1].

[1] https://lore.kernel.org/all/20250820080623.3799131-13-yanquanmin1@huawei.com/

Thanks, Quanmin Yan

