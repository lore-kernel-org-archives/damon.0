Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7B27E
	for <damon@lists.linux.dev>; Mon,  6 Mar 2023 02:05:17 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PVMJk454XznW8d;
	Mon,  6 Mar 2023 10:01:58 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 10:04:43 +0800
Message-ID: <5b4fda7f-e448-c8e2-3e3c-c80de9b26da8@huawei.com>
Date: Mon, 6 Mar 2023 10:04:43 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/2] mm/damon/paddr: Fix folio-use-after-put bugs
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Vishal Moola (Oracle)"
	<vishal.moola@gmail.com>, <damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20230304193949.296391-1-sj@kernel.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230304193949.296391-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected



On 2023/3/5 3:39, SeongJae Park wrote:
> There are two folio accesses after folio_put() in mm/damon/paddr.c file.
> Fix those.

I saw you send the bugfixes separately :)
> 
> SeongJae Park (2):
>    mm/damon/paddr: fix folio_size() call after folio_put() in
>      damon_pa_young()
>    mm/damon/paddr: fix folio_nr_pages() after folio_put() in
>      damon_pa_mark_accessed_or_deactivate()
> 
>   mm/damon/paddr.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
