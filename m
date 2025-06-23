Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDBF1DDD1
	for <damon@lists.linux.dev>; Mon, 23 Jun 2025 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750647889; cv=none; b=ocdHvVJk7GNUwP02eF1thLCXCd5rUejMbSNnT4/zCXIG65CKvKhPNN1KLOSwPxj5T1CW1xtrz7HD3p4cDtuekr3fm+4Omz9LIomF1xoNpJnLFBpWTyEp4+iXbeQzrqfYcVjZO5adLTujrtSs3+oDG22+2pOkkvjTjCroQB1VGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750647889; c=relaxed/simple;
	bh=yOQnI+EWtWEWIPKs4a6T53hKl1IUxDyOZWBrd0wFE2c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AozJ6z7cUJkg19K2cGxok8Zwz/yRCOkphugiatYzFyQx1+8p8SEanQd//nvc1a+JsN3c0O0m9/fIp8R/++reuG7qxb1Mj9qEKmuxX5ap+ruWRzgCeXDwWyAPX5V2F9aGJXv7Jfe92yM7vRlr9vKvpgMq+DAi2ZqSOa7ycphQXKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-a8-6858c4491717
Message-ID: <47a128b2-f4a3-45a6-a0b8-7309e1ddc8be@sk.com>
Date: Mon, 23 Jun 2025 12:04:41 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, damon@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [PATCH 2/3] samples/damon: change enable parameters to enabled
Content-Language: ko
To: SeongJae Park <sj@kernel.org>
References: <20250622161422.50852-1-sj@kernel.org>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250622161422.50852-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXC9ZZnka7nkYgMg62HrSzmrF/DZvHk/29W
	i3tr/rNaHP76hsmBxWPTqk42j02fJrF7nJjxm8XjxeaZjAEsUVw2Kak5mWWpRfp2CVwZVw8d
	YC3YJFbx90cnUwPjQcEuRg4OCQETieNbhLsYOcHMzrUbWUBsXgFLicMHroHZLAKqEn/+3oCK
	C0qcnPkEzBYVkJe4f2sGO4jNLDCTUeLNKR4QW1jAW2La3H9sEHERidmdbcwgtoiAosS5xxdZ
	QWwhASOJCfeug9lsAmoSV15OYgI5h1PAWOJpSxhEq5lE19YuRghbXmL72zlAY7iAzlzCJvHu
	5nlGiJslJQ6uuMEygVFwFpLzZiFZPQvJrFlIZi1gZFnFKJSZV5abmJljopdRmZdZoZecn7uJ
	ERjky2r/RO9g/HQh+BCjAAejEg9vAk9EhhBrYllxZe4hRgkOZiUR3kNOYRlCvCmJlVWpRfnx
	RaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGGdpf7vWNu9xzqyvKtZLbE4t
	2rP7d++lqMN6taXqxl9V7vS/axQ3LE7bdSXP9KWh7MZ9KY8ZJSOPurfVux5QnHvz5iRjY1PN
	dqefjhs2yMYZbAljmC12cKXNNe0+O+G7zj27nU4qJuX4Zp2812NxoTrq69+DXp2H05/NXdZz
	eIVSUddpwb7bz5VYijMSDbWYi4oTAYUKUyRuAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXCNUNLT9fzSESGwfJr+hZz1q9hs3jy/zer
	xeG5J1kt7q35D2R9fcNk8XvbCjYHNo9NqzqBxKdJ7B4nZvxm8XixeSajx7fbHh6LX3xgCmCL
	4rJJSc3JLEst0rdL4Mq4eugAa8EmsYq/PzqZGhgPCnYxcnJICJhIdK7dyAJi8wpYShw+cA3M
	ZhFQlfjz9wZUXFDi5MwnYLaogLzE/Vsz2EFsZoGZjBJvTvGA2MIC3hLT5v5jg4iLSMzubGMG
	sUUEFCXOPb7ICmILCRhJTLh3HcxmE1CTuPJyElMXIwcHp4CxxNOWMIhWM4murV2MELa8xPa3
	c5gnMPLNQnLFLCQbZiFpmYWkZQEjyypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzAMF5W+2fi
	DsYvl90PMQpwMCrx8K7wjsgQYk0sK67MPcQowcGsJMJ7yCksQ4g3JbGyKrUoP76oNCe1+BCj
	NAeLkjivV3hqgpBAemJJanZqakFqEUyWiYNTqoGx5rHltjNR5WsD5NtKPkpXRJ/fV2OkVfPg
	3K/isOsJCdo7F0kHhqfK/zH2vuSYKKe5fndFuuvkNLc644A/apHVl5donBCPtgo9fXqm1uPG
	m4bMHOs+8veKWk5de3Lb3asSf8LbPx650uffft6xwbu/g3Fep3pp6p+r3/NddTed6P6lu/FJ
	e48SS3FGoqEWc1FxIgBfEy/fXwIAAA==
X-CFilter-Loop: Reflected



On 6/23/2025 1:14 AM, SeongJae Park wrote:
> Hi Honggyu,
> 
> On Sun, 22 Jun 2025 21:09:24 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
>> The damon_{lru_sort,reclaim,stat} kernel modules use "enabled"
>> parameter knobs as follows.
>>
>>    /sys/module/damon_lru_sort/parameters/enabled
>>    /sys/module/damon_reclaim/parameters/enabled
>>    /sys/module/damon_stat/parameters/enabled
>>
>> However, other sample modules of damon use "enable" parameter knobs so
>> it'd be better to rename them from "enable" to "enabled" to keep the
>> consistency with other damon modules.
> 
> I think this is a good change, thank you!
> 
> [...]
>>
>> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
>> Cc: Yunjeong Mun <yunjeong.mun@sk.com>
> 
> I have simple comments about variable names below.  If you address it, please
> feel free to add below.
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

Thanks for the review!

> 
>> ---
>>   samples/damon/mtier.c | 16 ++++++++--------
>>   samples/damon/prcl.c  | 16 ++++++++--------
>>   samples/damon/wsse.c  | 16 ++++++++--------
>>   3 files changed, 24 insertions(+), 24 deletions(-)
>>
>> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
>> index f3220d6e6739..cb273bf4b5c2 100644
>> --- a/samples/damon/mtier.c
>> +++ b/samples/damon/mtier.c

[... snip ...]

>> @@ -160,17 +160,17 @@ static void damon_sample_mtier_stop(void)
>>   static int damon_sample_mtier_enable_store(
>>                const char *val, const struct kernel_param *kp)
>>   {
>> -     bool enabled = enable;
>> +     bool enable = enabled;
> 
> The local variable is to cache the old state of the parameter.  Hence I think
> 'enable' is not a very good name here.  I'd prefer naming the local variable
> and similar ones on other sample modules as 'is_enabled' or somewhat else that
> better represents its usage.

I also thought about comparing "enabled" and "enable" isn't good, but just
didn't fix it to reduce changes.  As you're pointing that issue as well, I will
rename it in the next version.

Thanks,
Honggyu

> 
> [...]
>> diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
> [...]
>> @@ -112,17 +112,17 @@ static void damon_sample_prcl_stop(void)
>>   static int damon_sample_prcl_enable_store(
>>                const char *val, const struct kernel_param *kp)
>>   {
>> -     bool enabled = enable;
>> +     bool enable = enabled;
> 
> Ditto.
> 
> [...]
>> diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
> [...]
>> @@ -92,17 +92,17 @@ static void damon_sample_wsse_stop(void)
>>   static int damon_sample_wsse_enable_store(
>>                const char *val, const struct kernel_param *kp)
>>   {
>> -     bool enabled = enable;
>> +     bool enable = enabled;
> 
> Here, too.
> 
> [...]
> 
> 
> Thanks,
> SJ
> 

