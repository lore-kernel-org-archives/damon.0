Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65313F7AAC
	for <damon@lists.linux.dev>; Fri,  5 Jun 2026 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655332; cv=none; b=nkroMFn7518Q6fhojxnuqMFDBh/ughWEosQBb/srvEhteVyMJ0m+2O/zs3N6ocobfa9JXrJIv/7d/JlM7Fu0f/kopQJ8z+/oR6fGqsoLt+7Sww/6mcg+mTSWsj+dYz3mpQrLwpqcM23FreK69mNwgoc8K3GsP/bGZQ4gDqNS/tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655332; c=relaxed/simple;
	bh=A+2YP2pntDzuNpPWx2oBPu0kHqqcwEdG0y9YD5WUl9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VGcsgGB36JbglDrXSDO7sCB5aDGcB70twO2hpYn0WkX0IT4zMBiigudVlEj1dAPffMRsICHmnWQ8R6S69v35demP8pTrGQS/6uuumJBh4ulPtsvkVhUASL7Stdi5UaYrSofnTatKbQ2gTvEOEJ+yWXCAnwqByxkzJe1fS2xLYLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gWyLf1WBlzHnGgv;
	Fri,  5 Jun 2026 18:27:54 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 81F1C40584;
	Fri,  5 Jun 2026 18:28:49 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Jun 2026 13:28:48 +0300
Message-ID: <441348c8-f98b-4eff-9fb6-784932b390a9@huawei-partners.com>
Date: Fri, 5 Jun 2026 13:28:48 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 4/4] Documentation/admin-guide/mm/damon: add
 DAMON-based Hugepage Management
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260605010943.83146-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260605010943.83146-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 6/5/2026 4:09 AM, SeongJae Park wrote:
> On Thu, 4 Jun 2026 15:03:37 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> Add documentation for the DAMON-based Hugepage Management
>> (SAMPLE_DAMON_HUGEPAGE) feature, which automatically manages
>> huge pages by identifying hot memory regions and collapsing
>> them back to regular pages. The documentation covers the
>> module's features, operation, and all available module
>> parameters.
> 
> For sample modules, I'd like the code to be simple enough to be able to
> understand it without a dedicated documentation.  Apparntly this documentation
> is made since you were following the pattern of non-sample modules like
> reclaim.c and lru_sort.c.  Could you please make the sample module simpler and
> drop this patch?

As mentioned in my reply to the cover letter, I will remove almost all
the module parameters to make it more simple.
 
> 
> Thanks,
> SJ
> 
> [...]
> 

-- 
Asier Gutierrez
Huawei

