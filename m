Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867D47C
	for <damon@lists.linux.dev>; Tue, 20 Sep 2022 01:59:36 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VQGZuw6_1663638864;
Received: from 30.240.98.170(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQGZuw6_1663638864)
          by smtp.aliyun-inc.com;
          Tue, 20 Sep 2022 09:54:25 +0800
Message-ID: <ff9f1b54-5d50-a43d-62a7-3e1adadf1974@linux.alibaba.com>
Date: Tue, 20 Sep 2022 09:54:23 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v1 1/2] mm/damon/sysfs: remove unnecessary variables
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20220919170305.61335-1-sj@kernel.org>
From: haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220919170305.61335-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2022/9/20 上午1:03, SeongJae Park 写道:
> On Mon, 19 Sep 2022 23:12:00 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> Just do a little change here, the 'err' variable really no need to stay
>> here.
>>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   mm/damon/sysfs.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
>> index 0cca1909bf67..b852a75b9f39 100644
>> --- a/mm/damon/sysfs.c
>> +++ b/mm/damon/sysfs.c
>> @@ -1109,9 +1109,8 @@ static ssize_t start_store(struct kobject *kobj, struct kobj_attribute *attr,
>>   {
>>   	struct damon_sysfs_region *region = container_of(kobj,
>>   			struct damon_sysfs_region, kobj);
>> -	int err = kstrtoul(buf, 0, &region->start);
>>
>> -	if (err)
>> +	if (kstrtoul(buf, 0, &region->start))
>>   		return -EINVAL;
> Good finding.  But, I'd like to let the user know why it really fails by giving
> them the error code that returned by 'kstrtoul()' here.  Let's keep the 'err'
> but return 'err' here.
Ok,  it make sense.
>
>>   	return count;
>>   }
>> @@ -1130,9 +1129,8 @@ static ssize_t end_store(struct kobject *kobj, struct kobj_attribute *attr,
>>   {
>>   	struct damon_sysfs_region *region = container_of(kobj,
>>   			struct damon_sysfs_region, kobj);
>> -	int err = kstrtoul(buf, 0, &region->end);
>>
>> -	if (err)
>> +	if (kstrtoul(buf, 0, &region->end))
>>   		return -EINVAL;
> ditto.
>
>>   	return count;
>>   }
>> --
>> 2.31.0
>
> Thanks,
> SJ
