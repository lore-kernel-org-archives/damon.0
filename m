Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50C253A7
	for <damon@lists.linux.dev>; Wed,  2 Jul 2025 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751414935; cv=none; b=aeNIsIegqaWoXkAUVX8lr5GMGUiOI9PB2AazNmwtMyS8tJ3yKVtMA2mCrWOyqwCteW6CMHESLGZSQRtR/pcjkAOGgtulORyfkXi9SnAyHzCcxW+ddasvIW8fnvUKbw4GMvElfAMhedFfoV5e8EaVomMPiGtmazs+VouKqn0rAAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751414935; c=relaxed/simple;
	bh=PrVT5eS6qqKOQ5gHM1tWewQ023DXYURGIeTUPqG8WnM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iZ5vXpFQA3hkLWFSBwsMWh+habHa0WClJWXuU3J8ZMpOZfLc1s2u3jqvaP4djI3rSWmekE9/W5MuQL4MC6rlKu5TqRaMfVQTGrXO4qWP3URxIgKVxQgcuoVS+ZVTJZSQ15JcIBLx2HGlLrHaPU/4rXwInBvId2Ygw32GhL52iUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-76-686478900130
Message-ID: <846357e0-8eaf-44a4-a9c4-3f1a6864a304@sk.com>
Date: Wed, 2 Jul 2025 09:08:47 +0900
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
Subject: Re: [PATCH v2 4/4] mm/damon: fix divide by zero in
 damon_get_intervals_score()
To: SeongJae Park <sj@kernel.org>
References: <20250701170006.53864-1-sj@kernel.org>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250701170006.53864-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsXC9ZZnoe6EipQMg83T5CzmrF/DZvHk/29W
	i3tr/rNaHP76hsmBxWPTqk42j02fJrF7nJjxm8XjxeaZjAEsUVw2Kak5mWWpRfp2CVwZu/YG
	FRwWqeibwtvA+Ja/i5GTQ0LAROLBupnMMPbTNfdZQWxeAUuJ50vug8VZBFQkPs6dxQgRF5Q4
	OfMJC4gtKiAvcf/WDHYQm1lgJqPEm1M8XYwcHMICkRJb16iBhEUEFCXOPb7IChIWEjCS+NIk
	C1EtIjG7sw1sOpuAmsSVl5OYQGxOAWOJ6f/fskDUmEl0be1ihLDlJba/nQNUzwV05RI2iT3X
	l7BAnCwpcXDFDZYJjIKzkFw3C8mOWUhmzUIyawEjyypGocy8stzEzBwTvYzKvMwKveT83E2M
	wABfVvsnegfjpwvBhxgFOBiVeHhPXEnOEGJNLCuuzD3EKMHBrCTCyycLFOJNSaysSi3Kjy8q
	zUktPsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cDocE3h0pzq7XpTLitxH1p9pKn1
	Y0zN22/LxG+8Kp92mJNVoehEwBPzBXnfZqspTCo/+XPashiGWCvz4DNcMwUZZi27Wvjh+oS4
	t9P6lHfY1JlWrIvr/z7frsF5Re2E0l9aNrkvP517U1euZ6hz7GJl4PH9N5zO+j/Uf2Mi86+t
	oemXv0b1iTcPlViKMxINtZiLihMBCOjP+2wCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsXCNUNLT3dCRUqGwZeP/BZz1q9hs3jy/zer
	xeG5J1kt7q35D2R9fcNk8XvbCjYHNo9NqzqBxKdJ7B4nZvxm8XixeSajx7fbHh6LX3xgCmCL
	4rJJSc3JLEst0rdL4MrYtTeo4LBIRd8U3gbGt/xdjJwcEgImEk/X3GcFsXkFLCWeL7nPDGKz
	CKhIfJw7ixEiLihxcuYTFhBbVEBe4v6tGewgNrPATEaJN6d4uhg5OIQFIiW2rlEDCYsIKEqc
	e3yRFSQsJGAk8aVJFqJaRGJ2ZxvYdDYBNYkrLycxgdicAsYS0/+/ZYGoMZPo2trFCGHLS2x/
	O4d5AiPfLCRHzEIyahaSlllIWhYwsqxiFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIDOBltX8m
	7mD8ctn9EKMAB6MSD++Bs8kZQqyJZcWVuYcYJTiYlUR4+WSBQrwpiZVVqUX58UWlOanFhxil
	OViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYyddT8fb7UW2DHDY9/lL5G/f+ZkhScnPbm+
	uv66kEtpuEi5QrOvcotTcJ6VzvzcZ3kuVT/uqd3fK3ZPWVfoakbV63s///KcqdE7Y6Xj4Cw3
	M3xWzNeNrCZPg33qbqzhyfI6/E4zL7Fn26Ge2vbQVdtuvp21TMp94QE7HaM/6wIvPYqqnelY
	/EGJpTgj0VCLuag4EQDIWJ55XAIAAA==
X-CFilter-Loop: Reflected

Hi SeongJae,

On 7/2/2025 2:00 AM, SeongJae Park wrote:
> Hi Honggyu,
> 
> On Tue,  1 Jul 2025 17:19:26 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
>> The current implementation allows having zero size regions with no
>> special reasons, but damon_get_intervals_score() gets crashed by divide
>> by zero when the region size is zero.
>>
>>    [   29.403950] Oops: divide error: 0000 [#1] SMP NOPTI
>>
>> This patch fixes the bug, but does not disallow zero size regions to
>> keep the backward compatibility since disallowing zero size regions
>> might be a breaking change for some users.
>>
>> Fixes: f04b0fedbe71 ("mm/damon/core: implement intervals auto-tuning")
>> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
>> Cc: Yunjeong Mun <yunjeong.mun@sk.com>
>> ---
>>   mm/damon/core.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index b217e0120e09..e274a4d958d6 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -1448,7 +1448,10 @@ static unsigned long damon_get_intervals_score(struct damon_ctx *c)
>>                        access_events += sz_region * r->nr_accesses;
>>                }
>>        }
>> -     target_access_events = max_access_events * goal_bp / 10000;
>> +     if (likely(max_access_events) > 0)
> 
> This makes checkpatch.pl complaints as below:
> 
> WARNING: Using likely should generally have parentheses around the comparison
> #39: FILE: mm/damon/core.c:1451:
> +       if (likely(max_access_events) > 0)
> 
> This is not performance critical part, so I think we can simply drop likely().
> 
>> +             target_access_events = max_access_events * goal_bp / 10000;
>> +     else
>> +             target_access_events = 1;
> 
> But, target_access_events could still be zero if goal_bp is zero or
> max_access_events * goal_bp is less thatn 10000?
> 
> I'd like to simply do the target_access_events calculation as is, and set
> target_access_events as 1, if it is zero.  Since this is not a performance
> critical path, I think that's ok.

Sure. I've just made it as you mentioned in v3.

> 
> Also, in the previous version, we discussed the reproduction step requires
> sample modules.  But seems we can also reproduce this with the official DAMON
> sysfs ABI by setting the intervals goal zero, and I just confirmed that.  Let's
> Cc stable@.

I've cc'ed stable@ in v3. Thanks for your help!

Thanks,
Honggyu

> 
>>        return access_events * 10000 / target_access_events;
>>   }
>>
>> --
>> 2.34.1
> 
> 
> Thanks,
> SJ

