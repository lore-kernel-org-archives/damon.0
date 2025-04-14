Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685914B965
	for <damon@lists.linux.dev>; Mon, 14 Apr 2025 01:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744593728; cv=none; b=eWLQdkmpq/zCQyJd/GzXk4N2aGNLImkI8gcbh/BDxQW4t1zXGA4qRiny25u88h7Ety8ZVcGB1COhxHu7YmqhbPKXsNKh19HQAcuBnqg33UElQs1Adt6aVBCimvzRo5Jgh0FfwFvq9UsAPVE9yMMQ2rXADafG8IYIN/RgNRK8j5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744593728; c=relaxed/simple;
	bh=vKCoLxhw8hz2kZDcrhNgcUBgHdIRnC+1rwOo8Ro2vUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YDViN1qaNR344ZOXviwtxxpBs4T466EeSUq3Iap62A9DQC5bbLX0fUzztkURGVPta8jxFwJPiltu99on5tai9xDgpga8z3yXlP4Oi7wHB18rB6T/ArcdqZiwiHXTZYI4TnceYiRrR4tkBYKEcN7amw8X3iot+tg8xV90Gg1WGjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZbTz40y0DzsSgn;
	Mon, 14 Apr 2025 09:21:52 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C66A1A0188;
	Mon, 14 Apr 2025 09:21:57 +0800 (CST)
Received: from [10.174.177.186] (10.174.177.186) by
 kwepemg500008.china.huawei.com (7.202.181.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Apr 2025 09:21:56 +0800
Message-ID: <5801dee7-0c22-4424-acb1-fe5f63645bc8@huawei.com>
Date: Mon, 14 Apr 2025 09:21:55 +0800
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
References: <20250411163528.65021-1-sj@kernel.org>
From: zuoze <zuoze1@huawei.com>
In-Reply-To: <20250411163528.65021-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500008.china.huawei.com (7.202.181.45)



在 2025/4/12 0:35, SeongJae Park 写道:
> On Fri, 11 Apr 2025 14:30:40 +0800 zuoze <zuoze1@huawei.com> wrote:
> 
>> 在 2025/4/11 6:25, SeongJae Park 写道:
> [...]
>>> So I still don't anticipate big problems with my proposed approach.  But only
>>> prototyping and testing would let us know more truth.  If you don't mind, I
>>> will quickly write and share a prototype of my idea so that you could test.
>>>
>>
>> Sounds good! Please share the prototype when ready - happy to test and
>> help improve it.
> 
> Thanks, I will share the prototype as soon as be ready. I expect up to a few
> weeks.
> 

Got it! Excited to see the prototype. Let me know if you need anything
in the meantime.

> 
> Thanks,
> SJ
> 
> [...]
> 
