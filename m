Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE5B7C
	for <damon@lists.linux.dev>; Tue, 20 Sep 2022 01:58:50 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VQGhopY_1663639121;
Received: from 30.240.98.170(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQGhopY_1663639121)
          by smtp.aliyun-inc.com;
          Tue, 20 Sep 2022 09:58:42 +0800
Message-ID: <10f3f03d-e616-0619-cbe1-8515a3d7fc0e@linux.alibaba.com>
Date: Tue, 20 Sep 2022 09:58:41 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v1 2/2] mm/damon/sysfs: use kzmalloc instead kmalloc to
 simplify codes
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20220919172251.61428-1-sj@kernel.org>
From: haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220919172251.61428-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2022/9/20 上午1:22, SeongJae Park 写道:
> On Mon, 19 Sep 2022 23:12:01 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> In damon_sysfs_access_pattern_alloc() adn damon_sysfs_attrs_alloc(),
>> we can use kzmalloc to alloc instance of the related structs, This makes
>> the function code much cleaner.
> This definitely makes the code cleaner, thank you.  But, the initial intent of
> the code is to initialize the fiedls that really need to be initialized at the
> point, for the efficiency and also for making it clear which field is needed to
> be initialized to what value here.  It's also intended to make readers wonder
> about where and how the remaining fields are initialized.

Maybe the other func like damon_sysfs_kdamonds_alloc() also need to do 
like this, you can see it return directly by

kzalloc.

static struct damon_sysfs_kdamonds *damon_sysfs_kdamonds_alloc(void)
{
             return kzalloc(sizeof(struct damon_sysfs_kdamonds), 
GFP_KERNEL);
}

> So, to my humble eyes, this change looks like making the code a little bit
> inefficient and unclear, sorry.
>
>
> Thanks,
> SJ
>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   mm/damon/sysfs.c | 15 ++-------------
>>   1 file changed, 2 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
>> index b852a75b9f39..06154ece7960 100644
>> --- a/mm/damon/sysfs.c
>> +++ b/mm/damon/sysfs.c
>> @@ -657,13 +657,7 @@ struct damon_sysfs_access_pattern {
>>   static
>>   struct damon_sysfs_access_pattern *damon_sysfs_access_pattern_alloc(void)
>>   {
>> -	struct damon_sysfs_access_pattern *access_pattern =
>> -		kmalloc(sizeof(*access_pattern), GFP_KERNEL);
>> -
>> -	if (!access_pattern)
>> -		return NULL;
>> -	access_pattern->kobj = (struct kobject){};
>> -	return access_pattern;
>> +	return kzalloc(sizeof(struct damon_sysfs_access_pattern), GFP_KERNEL);
>>   }
>>   
>>   static int damon_sysfs_access_pattern_add_range_dir(
>> @@ -1620,12 +1614,7 @@ struct damon_sysfs_attrs {
>>   
>>   static struct damon_sysfs_attrs *damon_sysfs_attrs_alloc(void)
>>   {
>> -	struct damon_sysfs_attrs *attrs = kmalloc(sizeof(*attrs), GFP_KERNEL);
>> -
>> -	if (!attrs)
>> -		return NULL;
>> -	attrs->kobj = (struct kobject){};
>> -	return attrs;
>> +	return kzalloc(sizeof(struct damon_sysfs_attrs), GFP_KERNEL);
>>   }
>>   
>>   static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
>> -- 
>> 2.31.0
