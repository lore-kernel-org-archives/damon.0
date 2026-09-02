Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA7E481673
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361438; cv=none; b=PElYdtlKygstQY6yIoFyty9rvy2AR3uz2z01h8qupjKAiaO4zOYcAHwla2228ZDhZ2MdggDZvDOnpGMZ0e/Yy8Bom3s2PWbeElhI2DvysXRTlthA4lcUlxTbi6KZ0/cmafuGxzQ/KsX53/b7GuZb33GdWOXY7tnJ6RqsnbK9bLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361438; c=relaxed/simple;
	bh=yt0tIgNGVachlwlrDD5uOfjgvr9ImpP1acApgeOOnsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pOhGMpURLWJ1myeMrzoX39OfUfc/gAzdO0r53UaKiLbzmIpT4ZBGYbUz9IBG0xN248VUyf8ZkGygQmZBMbZriwnbqPXFrQROkEkuO50ZByMCWRPWgTtZVnZJqxwAzaGxTRUh36coReY/X7BVmQhn872ur7gkqpOsubUJtruCMS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=JjR28d8t; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="JjR28d8t"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4M78E0ObIENsRiRRK+u7y9UbS3R6BJ4hM9bzTVDKV7o=;
	b=JjR28d8tmO/cLBZzM28RFnyU2knLbRFYR2FV3FdhZxKQvodPP9FwXxFlgM5Nga5o56RYcTtSl
	+SXgpKW4RWSvwDgFcjgLOvZbttMeR80lVBOD5kRCJe2Z7U5Eb8Thv07bV288/Oxa6HWq3yDnegO
	/EzpcIZ0a2YUXxpnir7u2cc=
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hZmF93FJxzJ46Dn;
	Wed,  2 Sep 2026 23:03:09 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id D5D4740571;
	Wed,  2 Sep 2026 23:03:40 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 2 Sep 2026 18:03:40 +0300
Message-ID: <9ac2a10f-1551-410e-a9c0-173a1daeb1ab@huawei-partners.com>
Date: Wed, 2 Sep 2026 18:03:39 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto
 tuning
To: SJ Park <sj@kernel.org>, Lian Wang <lianux.mm@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20260901142307.100701-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260901142307.100701-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SJ and Lian,

On 9/1/2026 5:23 PM, SJ Park wrote:
> Hi Lian,
> 
> On Tue,  1 Sep 2026 14:58:35 +0800 Lian Wang <lianux.mm@gmail.com> wrote:
> 
>> Hi SJ and Asier,
>>
>> Thanks for working on this and for providing the server results.  I have two
>> questions about what hugepage_mem_bp is intended to represent.
>>
>>> Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP auto tuning. Add a new DAMOS quota
>>> goal metric to measure the amount of huge page consumption to total
>>> memory consumption ratio.
>>
>> First, NR_ANON_THPS tracks anonymous PMD mappings, while NR_SHMEM_THPS and
>> NR_FILE_THPS track PMD-mappable page-cache folios.  Therefore, splitting only
>> an anonymous PMD mapping can change hugepage_mem_bp without physically
>> splitting the folio.  Is the intended metric PMD-mapped memory or physical
>> large-folio memory?  Clarifying this and adding a mapping-only test may help.
> 
> Good point.  I was just missing this.  So, hugepage_mem_bp is not accounting
> anon mTHPs, right?  Since hugepage_mem_bp is for general hugepages, I think
> this is better to be improved.  Seems using MTHP_STAT_NR_ANON that is exposed
> as 'nr_anon' can be used?  Because this is an improvement rather than a fix of
> a bug, I think doing this as either a followup or new version of this series
> are ok.  Asier, what do you think?
Agree, I will submit a new patch to fix this behaviour and account for mTHP.

Lian, thanks a lot for the review and pointing this issue.>>
>> Second, the metric is global while a DAMOS scheme can target one process.
> 
> Actually it can target multiple processes if those are in single DAMON context.
> 
>> THPs from other processes or NUMA nodes can satisfy the target or dilute the
>> monitored process's changes.  Is this intentional?
> 
> I think it is intentional.  The user should have the control on collapsing
> hugepages, or believe the uncontrolled collapse mechanisms.
> 
>> If so, documenting the
>> scope and testing a background THP workload may be useful.
> 
> More documentation and testing are always welcome :)
> 
>>
>> The temporal results approach the 10% and 25% targets, while the consistent
>> results overshoot the 10% target to about 20% and 45%.  I would describe this
>> as control-response data.  TPS, latency, TLB, fragmentation and collapse CPU
>> data could further show the workload benefit and cost.
> 
> Yes, those would be helpful.  That's not mandatory for this simple change in my
> opinion, though.  I would let Asier decide whether and when to make and share
> such data.
The idea of this patch was to introduce auto tuning. I think I submitted thebenchmark results when I sent the DAMOS_COLLAPSE feature.

Anyway, it shouldn't take long for me to get more data. I think it may be useful
for people to know the actual results in real application.

SJ, what's the best place to publish all those data? I believe you have more
experience sharing this data and which platform is the most useful one.>>
>> If I have misunderstood any of this, please feel free to ignore these
>> comments and correct me.
> 
> Your comments are very helpful, thank you for your review and comments, Lian.
> 
>>
>> The enum, quota-goal wiring and sysfs exposure otherwise look consistent with
>> the existing DAMOS autotuning framework.  I consider the points above
>> follow-up questions about semantics and evaluation, rather than blockers for
>> this series.
> 
> I agree.
> 
>>
>> For the series:
>>
>> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> 
> Thank you!
> 
>>
>> Please feel free to Cc me on related follow-up patches.  I am happy to help
>> review the code.  Besides my own DAMON work, I have recently been reviewing
>> and learning from other DAMON and MM work, and I would be glad to continue.
> 
> I'm curious if you and general reviewers need or prefer to directly be Cc-ed.
> I was naively thinking people can search and review DAMON patches by
> subscribing to the mailing list or using the archives via lore.kernel.org like
> tools.
> 
> 
> Thanks,
> SJ
> 
> [...]

-- 
Asier Gutierrez
Huawei

