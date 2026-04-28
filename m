Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00B3D3304
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381778; cv=none; b=GhcNoQvyzVL6mOHAO77KalNYhiW7qNH7nf74Brs36kiRoeGnt2IZ623IS1Tfv6T5L31hvqUn/cfw7SXxwoQpaHpWRgiVwzQjxKeHaMkIg/xcyyE5GfOxHtUaaFkIhhnHuQpuZ64cXq+1CHyiBjIpnccZbyfgOvl+yWu+v9xhq8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381778; c=relaxed/simple;
	bh=+p9ykq7w/HqPYHjqw7fpoxPvpRjxjhr7uw69j3eefQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nQO3UI5v1OBbDG1dYaRlePoevgudb/RrPW+xdVvbQcPteuluvxE2tps4aQW34B9Q0WrjcjrJwU7GAXsTUL+Xuvg04lkPCl7KiiDymhQmik6UsruS1+otCD7eLZ2NNAbEROTsQMEbhb6Hc2eW8yLGuKZDWvakyA9a+VFR13l9M1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g4gjy05mKzHnGdy;
	Tue, 28 Apr 2026 21:08:54 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id D452940571;
	Tue, 28 Apr 2026 21:09:35 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Apr 2026 16:09:35 +0300
Message-ID: <2d2415b3-d7e8-4b8d-aaad-c4fd27eb18f8@huawei-partners.com>
Date: Tue, 28 Apr 2026 16:09:34 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/19] mm/damon/core: embed damon_probe objects in
 damon_ctx
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20260428003559.113178-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260428003559.113178-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 4/28/2026 3:35 AM, SeongJae Park wrote:
> On Mon, 27 Apr 2026 16:18:14 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> 
>>
>>
>> On 4/26/2026 11:52 PM, SeongJae Park wrote:
>>> Let damon_probe objects be able to be installed on a given damon_ctx, by
>>> adding a linked list header for storing the objects.  Add initialization
>>> and cleanup of the new field with helper functions, too.
>>>
>>> Signed-off-by: SeongJae Park <sj@kernel.org>
> [...]
>>> +static void damon_del_probe(struct damon_probe *p)
>>> +{
>>> +	list_del(&p->list);
>>> +}
>>> +
>>> +static void damon_free_probe(struct damon_probe *p)
>>> +{
>>> +	kfree(p);
>>> +}
>>> +
>>> +static void damon_destroy_probe(struct damon_probe *p)
>>> +{
>>> +	damon_del_probe(p);
>>> +	damon_free_probe(p);
>>
>> Why don't we inline list_del and kfree here instead of calling
>> damon_del/free_probe?
> 
> I want to hide the fact that we are using linked list.  This abstraction also
> makes it easy to control the calling paths of the data structure manipulation.
> Meanwhile, smart enough compilers could inline these if it helps.

I see your point. It make sense.

> 
> Thanks,
> SJ
> 
> [...]
> 

-- 
Asier Gutierrez
Huawei

