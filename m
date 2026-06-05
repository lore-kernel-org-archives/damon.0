Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C994D2ED2
	for <damon@lists.linux.dev>; Fri,  5 Jun 2026 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780657991; cv=none; b=rheyEfNQEgqHUDptGLIMx1991AqCguOLAL2TlaAmDENyMisaTAyY9lY/GvZjxLeFn987k+XkAl3eOZ86AwE9HU5DH1wilzdf3KnlXxVhIk3sEmuiZlLhRwJUsO7Y1bxJMeEbKKkfB/bnNpDdMME9zP1jEHmzVncjiZv4P0ofwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780657991; c=relaxed/simple;
	bh=Ooxk+lVhfF98dUGEdWvtkuY0Fng4kOAybu+ncYCdgvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bkfzrMFKN9FGS9zXJV6QPHgGjDejuXrr58syR8r5VltkV+Vd8g8rDUgC2+a1maOCDAfkh9O3aO9Cf4ILaAFQt20tTojZnP2n7FyE4oo+qsSxOzTmgHnP8FbUx3BLsK8OJD8PWI9KS9/tdK3XwMxDRerUn2/ruki5RCv5FIGVa0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gWzKg3MtBzHnGkZ;
	Fri,  5 Jun 2026 19:12:07 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id D09B740584;
	Fri,  5 Jun 2026 19:13:02 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Jun 2026 14:13:02 +0300
Message-ID: <a9269eaf-a567-4dfe-99a3-cee4b13946de@huawei-partners.com>
Date: Fri, 5 Jun 2026 14:13:01 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/4] mm/damon: Generalize ctx_target creation for
 damon_ops_id and add vaddr support
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260605005023.82747-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260605005023.82747-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 6/5/2026 3:50 AM, SeongJae Park wrote:
> On Thu, 4 Jun 2026 15:03:35 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> This patch adds a new function damon_modules_new_vaddr_ctx_target.
>> Since ctx_target creation for vaddr and paddr is almost
>> identical, the logic is extracted to a new function,
>> damon_modules_new_ctx_target, and vaddr and paddr functions
>> are left just as interfaces.
>>
>> This change was suggested earlier1 and it is needed to allow
>> developers to create DAMON modules that use DAMON_OPS_VADDR targets.
>>
>> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>> Suggested-by: SeongJae Park <sj@kernel.org>
>> ---
>>  mm/damon/modules-common.c | 31 +++++++++++++++++++++++++++----
>>  mm/damon/modules-common.h |  3 +++
>>  2 files changed, 30 insertions(+), 4 deletions(-)
> 
> This change is for the sample module that will be introduced by the third patch
> of this series, right?
> 
> I'd like sample modules to be simple and completely isolated under sample/
> directory.  Is this change really required for the sammple directory?  If not,
> could we please drop this patch?
So, just create the context manually in the module without a new
damon_modules_new_vaddr_ctx_target interface?> 
> Thanks,
> SJ
> 
> [...]
> 

-- 
Asier Gutierrez
Huawei

