Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6717E
	for <damon@lists.linux.dev>; Mon,  6 Mar 2023 02:06:00 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PVMNV2v6CzrSRF;
	Mon,  6 Mar 2023 10:05:14 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 10:05:57 +0800
Message-ID: <51e294bd-c241-ec7e-97d0-b1a7f3534578@huawei.com>
Date: Mon, 6 Mar 2023 10:05:57 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] mm/damon/paddr: fix folio_nr_pages() after
 folio_put() in damon_pa_mark_accessed_or_deactivate()
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, "Matthew Wilcox
 (Oracle)" <willy@infradead.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20230304193949.296391-1-sj@kernel.org>
 <20230304193949.296391-3-sj@kernel.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230304193949.296391-3-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected



On 2023/3/5 3:39, SeongJae Park wrote:
> damon_pa_mark_accessed_or_deactivate() is accessing a folio via
> folio_nr_pages() after folio_put() for the folio has invoked.  Fix it.
> 

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

> Fixes: f70da5ee8fe1 ("mm/damon: convert damon_pa_mark_accessed_or_deactivate() to use folios")
> Cc: <stable@vger.kernel.org> # 6.3.x
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>   mm/damon/paddr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 10f159b315ea..0db724aec5cb 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -277,8 +277,8 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
>   			folio_mark_accessed(folio);
>   		else
>   			folio_deactivate(folio);
> -		folio_put(folio);
>   		applied += folio_nr_pages(folio);
> +		folio_put(folio);
>   	}
>   	return applied * PAGE_SIZE;
>   }
