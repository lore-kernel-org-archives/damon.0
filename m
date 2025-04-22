Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93D227CB01
	for <damon@lists.linux.dev>; Tue, 22 Apr 2025 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322618; cv=none; b=c9+wzMgi0RB/PpJ7+sPM4dPJYc5/c56tXZk7NGsr6nHMnASp7n+eB7fqmw8syEi3EjqOLSj7/Uirt1My42ZqPllFkKciQSJEGpgbo3jHWvL59CV6d22KLs0t4s1YaOkEITz62ivvTACxhg2+MO2weCO1cS3l34zjRIOHK2y7Wok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322618; c=relaxed/simple;
	bh=KKJLjPyWjfnxzFp3p0ywc5/TE412obarPe/mL5i9v4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=llMs6YkiMZ8J+gtKcWLg5vJDJ91F+RX0+W5pqs52TzOXMgJ2mOX/JWxHYThu49ACXlYuH4MOEqjpSMO60hTRDiopCrOIRulF70kpSF8x2KQt/2FdSodLctxt0R63osCMXj5EvXsu0+X/cq7OCFOf9OuJ0ANzKBHbQpR/uYDq9bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZhgYC5tnDz27hFg;
	Tue, 22 Apr 2025 19:50:55 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id C072D1A0188;
	Tue, 22 Apr 2025 19:50:12 +0800 (CST)
Received: from [10.174.177.186] (10.174.177.186) by
 kwepemg500008.china.huawei.com (7.202.181.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Apr 2025 19:50:12 +0800
Message-ID: <68043882-1878-4cca-a8fc-5e6cb9a88395@huawei.com>
Date: Tue, 22 Apr 2025 19:50:11 +0800
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
	<wangkefeng.wang@huawei.com>
References: <20250420162706.2844-1-sj@kernel.org>
From: zuoze <zuoze1@huawei.com>
In-Reply-To: <20250420162706.2844-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500008.china.huawei.com (7.202.181.45)



在 2025/4/21 0:27, SeongJae Park 写道:
> Hello Ze,
> 
> On Mon, 14 Apr 2025 09:21:55 +0800 zuoze <zuoze1@huawei.com> wrote:
> 
>>
>>
>> 在 2025/4/12 0:35, SeongJae Park 写道:
>>> On Fri, 11 Apr 2025 14:30:40 +0800 zuoze <zuoze1@huawei.com> wrote:
>>>
>>>> 在 2025/4/11 6:25, SeongJae Park 写道:
>>> [...]
>>>>> So I still don't anticipate big problems with my proposed approach.  But only
>>>>> prototyping and testing would let us know more truth.  If you don't mind, I
>>>>> will quickly write and share a prototype of my idea so that you could test.
>>>>>
>>>>
>>>> Sounds good! Please share the prototype when ready - happy to test and
>>>> help improve it.
>>>
>>> Thanks, I will share the prototype as soon as be ready. I expect up to a few
>>> weeks.
>>>
>>
>> Got it! Excited to see the prototype. Let me know if you need anything
>> in the meantime.
> 
> I posted the RFC patch series[1] a few days ago.  I also just implemented[2]
> and pushed the support of it on DAMON user-space tool.  Please let me know if
> you find any concern on those.
> 

Thanks for the patches - I’ve noted the RFC series and user-space
updates. Apologies for the delay; I’ll prioritize reviewing these soon
to verify they meet the intended tracking goals. Appreciate your
patience.

> [1] https://lore.kernel.org/20250416042551.158131-1-sj@kernel.org
> [2] https://github.com/damonitor/damo/commit/5848e3a516e3b10e62c4ad7ebf0e444d7be09f6b
> 
> 
> Thanks,
> SJ
> 
> [...]
> 
