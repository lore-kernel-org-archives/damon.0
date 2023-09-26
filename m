Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84BD637
	for <damon@lists.linux.dev>; Tue, 26 Sep 2023 01:39:07 +0000 (UTC)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rvj5b0Mg1zrSdV;
	Tue, 26 Sep 2023 09:36:51 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 09:39:04 +0800
Message-ID: <39e981f0-3b73-d48b-1f58-cfedab6139fe@huawei.com>
Date: Tue, 26 Sep 2023 09:39:04 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] mm/damon/vaddr-test: Fix memory leak in
 damon_do_test_apply_three_regions()
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <damon@lists.linux.dev>, SeongJae Park
	<sj@kernel.org>
References: <20230925072100.3725620-1-ruanjinjie@huawei.com>
 <20230925081400.9593189a7665c6ff1f812855@linux-foundation.org>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230925081400.9593189a7665c6ff1f812855@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected



On 2023/9/25 23:14, Andrew Morton wrote:
> On Mon, 25 Sep 2023 15:20:59 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> When CONFIG_DAMON_VADDR_KUNIT_TEST=y and making CONFIG_DEBUG_KMEMLEAK=y
>> and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the below memory leak is detected.
>>
>> Since commit 9f86d624292c ("mm/damon/vaddr-test: remove unnecessary
>> variables"), the damon_destroy_ctx() is removed, but still call
>> damon_new_target() and damon_new_region(), the damon_region which is
>> allocated by kmem_cache_alloc() in damon_new_region() and the damon_target
>> which is allocated by kmalloc in damon_new_target() are not freed. And the
>> damon_region which is allocated in damon_new_region() in
>> damon_set_regions() is also not freed.
>>
>> So use damon_destroy_target to free all the damon_regions and damon_target.
>>
>> ...
>>
>> Fixes:  9f86d624292c ("mm/damon/vaddr-test: remove unnecessary variables")
>> Fixes: dae0087aeff4 ("mm/damon/vaddr: remove damon_va_apply_three_regions()")
> 
> Can we please identify a single Fixes: target?  Otherwise, how are
> -stable tree maintainers to determine which kernels need the fix?  

Right！Thank you. Commit dae0087aeff4 just replaces
damon_va_apply_three_regions() with damon_set_regions()，not first
introduce damon_set_regions(). Sorry, there is a mistake.

> 
> I'll go with 9f86d624292c for now.
