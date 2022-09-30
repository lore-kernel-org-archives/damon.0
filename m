Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6D1841
	for <damon@lists.linux.dev>; Fri, 30 Sep 2022 03:46:40 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VR0KQ4u_1664509589;
Received: from 30.240.98.80(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VR0KQ4u_1664509589)
          by smtp.aliyun-inc.com;
          Fri, 30 Sep 2022 11:46:31 +0800
Message-ID: <61df199f-5579-933e-3f11-35f204f93bf4@linux.alibaba.com>
Date: Fri, 30 Sep 2022 11:46:26 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v1] mm/damon: add DAMON_OBJ macro
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20220921164143.59971-1-sj@kernel.org>
From: haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220921164143.59971-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi SJ,

在 2022/9/22 上午12:41, SeongJae Park 写道:
> Hi Xin,
>
> On Wed, 21 Sep 2022 11:49:42 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> In damon/sysfs.c file, we use 'container_of' macro to get
>> damon_sysfs_xxx struct instances, but i think it has a little
>> inconvenience, because we have to pass three arguments to
>> 'container_of', and the codes also look a bit long, so there i add a
>> 'DAMON_OBJ' macro, you just need to pass one arguments, then you can get
>> the right damon_sysfs_xxx struct instance.
> Thank you always for your helps and efforts, but I have some comments below.
>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   include/linux/damon.h |   7 ++
>>   mm/damon/sysfs.c      | 230 +++++++++++++++++-------------------------
>>   2 files changed, 102 insertions(+), 135 deletions(-)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index e7808a84675f..a3b577677caa 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -24,6 +24,13 @@ static inline unsigned long damon_rand(unsigned long l, unsigned long r)
>>   	return l + prandom_u32_max(r - l);
>>   }
>>   
>> +/*
>> + * Get damon_sysfs_xxx relative struct instance.
>> + */
>> +#define DAMON_OBJ(_type) ({						\
>> +	const typeof(((struct _type *)0)->kobj)*__mptr = (kobj);	\
>> +	(struct _type *)((char *)__mptr - offsetof(struct _type, kobj)); })
>> +
> So, this macro assumes two implicit rules.
> 1. The caller would have a relevant 'struct kobject *' variable called 'kobj',
>     and
> 2. The '_type' would have the field 'kobj'.
>
> I think the implicit rules could make some people confused, so would be better
> to be well documented.  Even though those are well documented, I think it
> cannot intuitively read by everyone.  Making the name better self-explaining
> might help, but then the length of the code would be not so different.
>
> So IMHO, this change makes the code a little bit shorter but unclear to
> understand what it does.  And at least to my humble eyes, use of
> 'container_of()' makes the code a little bit more verbose, but clear to
> understand.  I have no idea how we can make this code shorter while keeping it
> still easily understandable, and I think the level of verboseness is acceptable
> for the readability.  So Nack at the moment, sorry.

I really feel the need to do that， how about keep it in the sysfs.c 
file, and change it like this：

#define DAMON_OBJ(_struct) container_of(kobj, struct _struct, kobj)

it will feel easy to understand and made sense.

>
>
> Thanks,
> SJ
>
> [...]
