Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952B13D5223
	for <damon@lists.linux.dev>; Wed,  4 Feb 2026 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210464; cv=none; b=Nz+CggqhTZUUskEHPFOTIw1HLQdVE0bd51Z1fvdRAoHapwjWeGdWg7Jxv8PWk5q5oGEIoOIHdhsPQKbrtrbIiADpwlWm/dvLp+GhGXEweY3nLpVk43eTlKp1oEivrgP33HnZaqWPgYdKyUYDqGRyJ8UlYWTZyKCr4FFYT0bU52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210464; c=relaxed/simple;
	bh=RnF2+n9sGW5Z5FNVADHxsiwhB17zi+K/YhZ03gS8aGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fc6rrgNi4g6gn8O1RU/5hsMU1fm9UFbJ5NSgomK9C1E4NrVa/VxGwvOMtPcQEIfwIImTqJbe7BLTnBoIbN+DJrwDhGGgjPeyzGHI2DKGHJeRtTab9Hz7YcnIDqMds5EKc804m8en4Cfcjs+xpQN5qwF9g4mfQ+v6lyr5MFrPivA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5gbg5N0HzHnGk1;
	Wed,  4 Feb 2026 21:06:39 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E36D40569;
	Wed,  4 Feb 2026 21:07:41 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 16:07:40 +0300
Message-ID: <8b8e9dde-33ff-41f7-8563-d9aeaf5efeb5@huawei-partners.com>
Date: Wed, 4 Feb 2026 16:07:40 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] mm/damon: Support hot application detections
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260204071712.16325-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260204071712.16325-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 2/4/2026 10:17 AM, SeongJae Park wrote:
> On Tue, 3 Feb 2026 17:25:11 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> 
>> SeongJae,
>>
>> Thanks a lot for all the useful feedback.
> 
> The pleasure is mine! :)
> 
>>
>> One thing that I was not sure about while working on this patch set
>> is whether to have an external new module or adding the logic to 
>> damon core. I mean, the hot application detecting can be useful for
>> all other modules and can improve DAMON performance.
> 
> All exising non-sample DAMON modules are working for the physical address
> space.  I hence finding no many opportunities to bring benefits of hot
> application detection to those.
> 
> I agree the hot applications detection could be useful in general and creative
> DAMON use cases for virtual address spaces.  Implementing the feature in DAMON
> core layer and exposing it via DAMON sysfs interface will help such use cases.
> But it seems not straightforward to imagine how the sysfs interface can be
> extended for the feature.
> 
> So, I think it would better to be implemented inside the new module at the
> moment.  Later, if we end up having more modules that use the feature, we could
> move it to the modules-common or the core.  If we further find a good way to
> integrate that with sysfs interface, definitely it could go to core.
> 
> From this point, however, I realize the feature can also be implemented in the
> user sapce in a pretty straightforward way.  Have you considered that?

I though about it. However, accessing the task_struct directly and extracting
the utime is much more efficient that getting the required info from the user
space.

> 
>> What do you think?
>> My implementation was module based because I tried to avoid changes
>> to DAMON core for the RFC.
> 
> If there is a good reason to implement that not in the user space but the
> kernel space, as I mentioned above, it seems the module is the right place to
> me.
> 
> 
> Thanks,
> SJ
> 
> [...]
> 

-- 
Asier Gutierrez
Huawei

