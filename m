Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A45334689
	for <damon@lists.linux.dev>; Fri, 17 Oct 2025 03:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760670730; cv=none; b=iPFE28nbiatzmSsqw2JZFGx+/BZaSmjgv32GkZEyMGHllELDFAsJLEWs51pqh9G1OsrT4LCGd7YTaq3K8gT2dxVr8NPTKZESvT5/X8MC1LAzQr7p3ZDNaIvdE4aNuXuonrD8RhcufnUeFJqBkqFogV3wYPZQJ9qBpXBIkTOkV4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760670730; c=relaxed/simple;
	bh=KgW31NEnDhxto3WN62s7zXrxJ5MAVGQG5f7IyV2pPSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AdNWDqbr2QO7Fcf9V5rjj0mTvp9moq/Q9ZlFTRm2M+Zre5ApRT9J9e38nkn5YYk3vLxf2xVdTJUuSpMGW/R59GMrKHcEIhVuQ1g32L0q4SS6x//FI8e9ocm5Rc1/RZ445HC06GfNGBnn2jhQ4y/NR2rikJDPkv+ujcoJ4vY+hmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gMJT8zxU; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gMJT8zxU"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dcvrMD3sQma3OYREUgSzhCQmw7Fa8hfqaZyefSFbX3o=;
	b=gMJT8zxUzHGc/AelXSc6QEx7C+SjQ4cXio4lyn84xfFtq0ygyFg6Vm25uv25TuTNI8JNi67O1
	G6SZ70HTCQGbA5j/tybwGp1RgWoUiw348EQUaNdU0/ZNAQHVBYXXY6DXINVYbN1XNdxXslHzn8J
	wl/G7VC4fmIpKFA7FGV2WWE=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4cnqbw6LWqz1cyVm;
	Fri, 17 Oct 2025 11:11:40 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A9C7140294;
	Fri, 17 Oct 2025 11:12:02 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Oct 2025 11:12:01 +0800
Message-ID: <4c2e5879-e554-49c0-8f05-094031cbb64a@huawei.com>
Date: Fri, 17 Oct 2025 11:12:00 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon: add a min_sz_region parameter to
 damon_set_region_biggest_system_ram_default()
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
References: <20251016194851.65981-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20251016194851.65981-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Hi SJ,

在 2025/10/17 3:48, SeongJae Park 写道:
> On Thu, 16 Oct 2025 18:47:17 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>
>> After adding addr_unit support for DAMON_LRU_SORT and DAMON_RECLAIM,
>> the related region setup now requires alignment based on min_sz_region.
>>
>> Add min_sz_region to damon_set_region_biggest_system_ram_default()
>> and use it when calling damon_set_regions(), replacing the previously
>> hardcoded DAMON_MIN_REGION.
> Can we add more detailed description of the end user issue on the commit
> message?  My understanding of the issue is that the monitoring target address
> ranges for DAMON_LRU_SORT and DAMON_RECLAIM would be aligned on
> DAMON_MIN_REGION * addr_unit.
>
> For example, if user sets the monitoring target address range as [4, 8) and
> addr_unit as 1024, the aimed monitoring target address range is [4 KiB, 8 KiB).
> But damon_set_regions() will apply DAMON_MIN_REGION as the core address
> alignment.  Assuming DAMON_MIN_REGION is 4096, so resulting target address
> range will be [0, 4096) in the DAMON core layer address system, and [0, 4 MiB)
> in the physical address space.
>
> So the end user effect is that DAMON_LRU_SORT and DAMON_RECLAIM could work for
> unexpectedly large physical address ranges, when they 1) set addr_unit to a
> value larger than 1, and 2) set the monitoring target address range as not
> aligned in 4096*addr_unit.
>
> Let me know if I'm misunderstanding something.
>
> Also, if you encountered the issue in a real or a realistic use case, adding
> that on the commit message together would be very helpful.

Thank you for the additional explanation! Your understanding and description of
the issue are entirely correct.

Our ultimate goal is to have the monitoring target address range aligned to
DAMON_MIN_REGION. In the original logic, however, damon_set_regions() did not
take the newly introduced addr_unit into account, and directly performed core
address alignment based only on DAMON_MIN_REGION. As a result, the monitoring
target address range was aligned to DAMON_MIN_REGION * addr_unit, causing
DAMON_LRU_SORT and DAMON_RECLAIM to potentially operate on incorrect physical
address ranges. Therefore, we need to use min_sz_region instead of
DAMON_MIN_REGION in damon_set_regions().

I will add the detailed commit description in the v2 patch.

>> Fixes: 2e0fe9245d6b ("mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT")
>> Fixes: 7db551fcfb2a ("mm/damon/reclaim: support addr_unit for DAMON_RECLAIM")
> Let's break this patch into two patches, so that we have one fix per broken
> commit.

Yes, I actually considered splitting it up before submitting this patch, but found that
doing so might make the patches look odd. Since we're modifying the input parameters
of damon_set_region_biggest_system_ram_default(), all the call sites of this function
need to be updated accordingly. It seems we might need to split this into three patches:
1. Preparation patch: Add the min_sz_region parameter to
    damon_set_region_biggest_system_ram_default(), passing ctx->min_sz_region in stat.c,
    and passing DAMON_MIN_REGION when calling this function in reclaim.c/lru_sort.c?
2. Fixes patch 1: Modify lru_sort.c to pass param_ctx->min_sz_region.
3. Fixes patch 2: Modify reclaim.c to pass param_ctx->min_sz_region.

I'm not entirely comfortable with this approach. Would it be acceptable to submit this
as a single patch?


Thanks,
Quanmin Yan

>> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
>> ---
>>   include/linux/damon.h | 3 ++-
>>   mm/damon/core.c       | 6 ++++--
>>   mm/damon/lru_sort.c   | 3 ++-
>>   mm/damon/reclaim.c    | 3 ++-
>>   mm/damon/stat.c       | 3 ++-
>>   5 files changed, 12 insertions(+), 6 deletions(-)
> The code change looks good to me.
>
>
> Thanks,
> SJ
