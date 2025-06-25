Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752452F365E
	for <damon@lists.linux.dev>; Wed, 25 Jun 2025 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750890443; cv=none; b=m01XizC1VHcYDR5qnxhPwaf9035do4MR5YWEhF8T3CLyKKoelthdJUkwFX6+4d/G4/bK7nCwmw244oUr8o3D+QxY07FoSHsgxOuVYW7TwahHtOZNSzK35fsj5Wrvn9o3KAqzUYmR56tsvAIHL6efoJSnztOn1PV/9B7AbTECxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750890443; c=relaxed/simple;
	bh=FGJxPUS0n/OzPxPwZhLw2UTMDjcVqtYFbqunl99CARI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VjynUqEwFjczLm47sGzg/5mXtFfcnuZ12ZdtKDIXYq8Sul1pTDfYr4f7DTCqVbtaLRPJ4G+/j/rQSsAa3BNkO6u7BR1Grdk9mdEvXSeKpdip3g8YBhgJNdev8gG7SJnZhanWb4pMkoEqCkRpEDCWwAf/m3G+EZYOHtBGm+QQ9io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-e6-685c77c6f285
Message-ID: <08a1f2b7-15ac-4677-88d8-7112f0f9d5da@sk.com>
Date: Thu, 26 Jun 2025 07:27:18 +0900
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
Subject: Re: [PATCH 3/3] samples/damon: fix bugs for damon sample for start
 failures
Content-Language: ko
To: SeongJae Park <sj@kernel.org>
References: <20250623181142.44434-1-sj@kernel.org>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250623181142.44434-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsXC9ZZnke6x8pgMg/WrJCzmrF/DZvHk/29W
	i3tr/rNaHP76hsmBxWPTqk42j02fJrF7nJjxm8XjxeaZjAEsUVw2Kak5mWWpRfp2CVwZd1ft
	Yi04yFNxpfEJWwPjZc4uRk4OCQETidb/r1lh7OZ/X1lAbF4BS4mpt86D2SwCqhIN61ayQcQF
	JU7OfAIWFxWQl7h/awY7iM0sMJNR4s0pHhBbWCBMYuKK7WwQcRGJ2Z1tzCC2iICixLnHF8F2
	CQkYSfz8txcsziagJnHl5SQmEJtTwFji5/pFTBC9ZhJdW7sYIWx5ie1v5wDVcwHduYRNou/2
	ZHaIoyUlDq64wTKBUXAWkvtmIdk9C8msWUhmLWBkWcUolJlXlpuYmWOil1GZl1mhl5yfu4kR
	GOjLav9E72D8dCH4EKMAB6MSD++Ga9EZQqyJZcWVuYcYJTiYlUR4p5lHZQjxpiRWVqUW5ccX
	leakFh9ilOZgURLnNfpWniIkkJ5YkpqdmlqQWgSTZeLglGpgjEhJ6D30TXGW161j79yf2040
	XmSqV7FYzPlMYrDpMxW5JVYTdmdMuW152nTDfMmnqqUrohi6jmW47Bb+MWvOznvPO8/OU8i2
	ZmHfvlHZ8fcMFSm9+b1t8/7vrFfondsf1qP/T2669p+KHSo1Xq/3z0suOR/A/DNeMoRNZMn7
	ItcTT7Ublt0vUGIpzkg01GIuKk4EAPSzfF5wAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXCNUNLT/dYeUyGwYd5/BZz1q9hs3jy/zer
	xeG5J1kt7q35D2R9fcNk8XvbCjYHNo9NqzqBxKdJ7B4nZvxm8XixeSajx7fbHh6LX3xgCmCL
	4rJJSc3JLEst0rdL4Mq4u2oXa8FBnoorjU/YGhgvc3YxcnJICJhINP/7ygJi8wpYSky9dR7M
	ZhFQlWhYt5INIi4ocXLmE7C4qIC8xP1bM9hBbGaBmYwSb07xgNjCAmESE1dsZ4OIi0jM7mxj
	BrFFBBQlzj2+yApiCwkYSfz8txcsziagJnHl5SQmEJtTwFji5/pFTBC9ZhJdW7sYIWx5ie1v
	5zBPYOSbheSMWUhWzELSMgtJywJGllWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBgbys9s/E
	HYxfLrsfYhTgYFTi4d1wLTpDiDWxrLgy9xCjBAezkgjvNPOoDCHelMTKqtSi/Pii0pzU4kOM
	0hwsSuK8XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbGnEk7DJNT1s02vd3/7ol4gZX8dGd7ZQHz
	d07vL0ZPVt9xhUW0K49hgfB+77q3jQ4nLJcHvb8RIxw+f/2UQPXyN0nR2Y1dJ/wnbPx3qu66
	lmXPdulvHj1/JhacZndc4DRzwjepf285DjLNKk3+O3+2z+9WtTU1cZMmzvsa/PxindQmh1x+
	9X25SizFGYmGWsxFxYkARfmPfWACAAA=
X-CFilter-Loop: Reflected

Hi SeongJae,

On 6/24/2025 3:11 AM, SeongJae Park wrote:
> On Mon, 23 Jun 2025 12:16:32 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
>> Hi SeongJae,
>>
>> On 6/23/2025 1:29 AM, SeongJae Park wrote:
>>> Hi Honggyu,
>>>
>>> On Sun, 22 Jun 2025 21:09:25 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> [...]
>>> If we want to make stable kernel maintainers' life easier, we would better to
>>> split this into three patches, for each module, and add appropriate Fixes, as
>>> below.
>>
>> Spliting this into three patches is okay.
> [...]
>>> Could you please do so?
>>
>> If we do, then this patchset has to come before "enabled" renaming patch.
>>
>> In addition, I remember mixing stable and non-stable patches together in the
>> same patchset isn't welcomed by Andrew or other stable tree maintainers.  So I
>> might be better to split those three fix patches into a separate patchset.
> 
> I didn't think they would really bother such mixed patch series, but, yes,
> please do so.  Being nice to others is cool :)

Sure.  I will split "Fixes" changes in a separate patchset.

> 
>>
>> The only thing that bothers me in that case is writing cover letter for simple 2
>> or 3 patches as they are relatively simple.
> 
> I think you could also add the divide-by-zero fix (first patch of this series)
> to the series.

Sure.

>>
>> But it isn't that hard so can manage those in the next spin.
> 
> Thank you, looking forward to the next revisions!

Thank you too.  I will send it within a few days.

Honggyu

> 
> 
> Thanks,
> SJ
> 
> [...]

