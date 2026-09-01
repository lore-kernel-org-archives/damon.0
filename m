Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AACB2DECA8
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 05:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788240068; cv=none; b=QOtNDkipVpesxonel0h/lzEy2TM8/a6tnPFMOyVFujB3iBTHedUPynn3zsg6t4I0FMDkR65tuHcYunD78/EmxHrc6avkQSIMlN9rBVN7eHVOcep+MVg/vEy7dX42AHNqC8ZCO7BSR54Rcoct0g/3Q+ZCGhyfDfP0Q61Eep3Wo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788240068; c=relaxed/simple;
	bh=noWTnldhMW0YaQPIX9cRomMQ5OuCMx3zIYIhKPHHTmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KGQwWsgJIGW3q0YO7OMROyNcBz3thE8HdRTY/K0N1JtQ/G7hRRsaEfw8aSuiHkFlSlcVoPP5TlZsjzTLvO25N4X0hC7OevffRMV1aU5yBTWBF3ZohXp9s5GwjWKt9O/8CVAOJ9ly49nKV/EzJvVxZ+ko3/Jt9ntHuvhW3nkEgBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=KPdsfQ37; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="KPdsfQ37"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hEPG3P/x/ozu+lY/WnNZEs9objWoPkEaUik+WEJ687U=;
	b=KPdsfQ37BIw1yCqTL5PIQaNbF5exr5rkTec1aVoNuzcPU3yQ+ea0WDzDhMS48cbUrfF+qGBOu
	yhNp0EbXLwZopwcmteg9kMpKjsnxzMgY0gm2oE9kGpGgXaHgKNpti5y6Q3mvzD1RC8Mgps2g3Og
	OxqYcw7lwXvkhP6CNvUXXHs=
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hYvMB44C4zJ468Y;
	Tue,  1 Sep 2026 13:20:22 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id A095440571;
	Tue,  1 Sep 2026 13:20:51 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 1 Sep 2026 08:20:51 +0300
Message-ID: <893af75e-690b-48f0-9cc9-afe07c05565c@huawei-partners.com>
Date: Tue, 1 Sep 2026 08:20:50 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] Docs/mm/damon/design: Document hugepage_mem_bp
 target metric
To: SJ Park <sj@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett"
	<liam@infradead.org>, David Hildenbrand <david@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko
	<mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>, Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, <damon@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260901004712.89669-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260901004712.89669-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

On 9/1/2026 3:47 AM, SJ Park wrote:
> On Mon, 31 Aug 2026 13:00:26 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
Hi,
> 
>>
>>
>> On 8/31/26 8:45 AM, Randy Dunlap wrote:
>>> Hi,
>>>
>>> On 8/31/26 7:47 AM, SJ Park wrote:
>>>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>>>
>>>> Document hugepage_mem_bp metric exposed by sysfs.
>>>>
>>>> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>>> Reviewed-by: SJ Park <sj@kernel.org>
>>>> Signed-off-by: SJ Park <sj@kernel.org>
>>>> ---
>>>>  Documentation/mm/damon/design.rst | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
>>>> index aed6cb1cf4831..a8c163475ef2b 100644
>>>> --- a/Documentation/mm/damon/design.rst
>>>> +++ b/Documentation/mm/damon/design.rst
>>>> @@ -713,6 +713,8 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
>>>>    bp (1/10,000).
>>>>  - ``node_eligible_mem_bp``: Scheme target access pattern-eligible memory ratio
>>>>    of a node in bp (1/10,000).
>>>> +- ``hugepage_mem_bp``: Total huge page to total used memory ratio in bp
>>>> +  (1/10,000).
>>>>  
>>>>  ``nid`` is optionally required for ``node_mem_used_bp``, ``node_mem_free_bp``,
>>>>  ``node_memcg_used_bp``, ``node_memcg_free_bp`` and ``node_eligible_mem_bp`` to
>>>
>>> I've looked thru the entire design.rst file and cannot find anything telling
>>> me (or anyone) what "bp" means.  Explain??
>>
>> OK, I found it on the internet. I still think that it would be a
>> good idea to say "basis point" one time (the first time that it is used).
> 
> You are right, and I agree.  I will add that clarification before the next
> merge window.
> 
>>
>>
>> -- 
>> ~Randy
> 
> 
> Thanks,
> SJ

SJ, should I submit a new patch to fix design.rst?

-- 
Asier Gutierrez
Huawei

