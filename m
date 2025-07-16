Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309C52AE8E
	for <damon@lists.linux.dev>; Wed, 16 Jul 2025 01:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631099; cv=none; b=VzzluOkOs3QCa+1r5KgkFXaYt5oGARr6hck6blhNQc5nOVW+tRDBIjt9ZwM+IRP6ZR6lTFCEAOLGSAkqeqTuHfQutlm9wX3O0IkXCvLzbQQXN25qltwqqPGLjCXDYsD2Wi1zyM8BVIvDhXVDvo63HCOvEeXu1jnEqgVM9f/bIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631099; c=relaxed/simple;
	bh=EJiTLMPRgmPaG1Rq1pRDiA2bIfmxYOyssrBRqts0fH4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N/3lUjiHjd4hvUgcXDiyYbAs6uwAq/fooLbyDGIaBsre/BwPiYKN3KAt2dVMomuL23JBvrfpT3oJQyG6QYhSnhvAIC6xXD5yKnHGC4il4JZI66bySkLppm0Z0UYvooAK3083vhvAN8oXD6m0rA7tY+OW5eW3FE2p26v0Hs3BIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-10-6877072e6042
Message-ID: <5d1aa6f2-fa5f-4cc2-a3c7-3b5144391524@sk.com>
Date: Wed, 16 Jul 2025 10:58:06 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev,
 kernel-team@meta.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/4] mm/damon/sysfs: support periodic and automated
 stats update
Content-Language: ko
To: SeongJae Park <sj@kernel.org>
References: <20250715234316.91272-1-sj@kernel.org>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250715234316.91272-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsXC9ZZnoa4ee3mGwdldGhZz1q9hs3hyoJ3R
	4sn/36wW+y4CuQvblrBYXN41h83i3pr/rBaHv75hcuDw2LSqk81j06dJ7B4nZvxm8XixeSaj
	x+K+yawe5y5WeHzeJBfAHsVlk5Kak1mWWqRvl8CVsf+Oc8Ea+YqV/YdYGxhnS3YxcnJICJhI
	XNjYyAJj/7l3jRHE5hWwlHh6cyETiM0ioCqxcMMHdoi4oMTJmU/A6kUF5CXu35oBFOfiYBZ4
	wShxfu9vNpCEsECUxM7f/WANzAIiErM725hBbBEBRYlzjy+ygthCAkYSz+f9AlvGJqAmceXl
	JLBlnALGEk0/25kges0kurZ2MULY8hLb385hBlkmIXCGTWLeztusEFdLShxccYNlAqPgLCQH
	zkKyexaSWbOQzFrAyLKKUSgzryw3MTPHRC+jMi+zQi85P3cTIzBWltX+id7B+OlC8CFGAQ5G
	JR7eHdZlGUKsiWXFlbmHGCU4mJVEeCdfAgrxpiRWVqUW5ccXleakFh9ilOZgURLnNfpWniIk
	kJ5YkpqdmlqQWgSTZeLglGpgtNPyvK8tV8k0+/6KuQZ8szNfHtS8+br78LvGubeUXsotF9+5
	+uSL8FN1U5TYQteEBbgpi5kv4C+KflvVdKji7t6c+drJ3Flhf68/lT44z9CofFaH1II95Xlr
	FzRH3l6cEFLozvjoe+bzdwd7EnXOhjhZbxfteW+1wMvG4mrH2bj/2Tej7wscV2Ipzkg01GIu
	Kk4EAFeB1PiRAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXCNUNLT1ePvTzD4ORPKYs569ewWTw50M5o
	8eT/b1aLfReB3MNzT7JaLGxbwmJxedccNot7a/6zWhz++obJgdNj06pONo9Nnyaxe5yY8ZvF
	48XmmYwei/sms3qcu1jhsfjFByaPz5vkAjiiuGxSUnMyy1KL9O0SuDL233EuWCNfsbL/EGsD
	42zJLkZODgkBE4k/964xgti8ApYST28uZAKxWQRUJRZu+MAOEReUODnzCQuILSogL3H/1gyg
	OBcHs8ALRonze3+zgSSEBaIkdv7uB2tgFhCRmN3ZxgxiiwgoSpx7fJEVxBYSMJJ4Pu8X2DI2
	ATWJKy8ngS3jFDCWaPrZzgTRaybRtbWLEcKWl9j+dg7zBEa+WUjumIVkxSwkLbOQtCxgZFnF
	KJKZV5abmJljqlecnVGZl1mhl5yfu4kRGPjLav9M3MH45bL7IUYBDkYlHt4d1mUZQqyJZcWV
	uYcYJTiYlUR4J18CCvGmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgsky
	cXBKNTCKpP5jShL/VvbdI5HT4oLz5In6j1POa2X+2RCVd2GugtwVJrv4Yxs3cOfN2f3glYNO
	zLE1KUpbP0yWcz32d2/cquPXmS4/9LWcEhe3+Hns5FdfYzY39c1Mv5xRczhxSw2L1w2t+9z/
	L89c2PjEZduHj0tOlZsGMSzhzlupYcnT5C1+59aeaKYsJZbijERDLeai4kQASiefnngCAAA=
X-CFilter-Loop: Reflected

Hi SeongJae,

On 7/16/2025 8:43 AM, SeongJae Park wrote:
> On Wed, 16 Jul 2025 07:20:57 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
>> Hi SeongJae,
>>
>> On 7/13/2025 5:46 AM, SeongJae Park wrote:
>>> DAMON sysfs interface provides files for reading DAMON internal status
>>> including DAMOS stats.  The content of the files are not automatically
>>> updated, though.  Users should manually request updates of the contents
>>> by writing a special command to 'state' file of each kdamond directory.
>>> This interface is good for minimizing overhead, but causes the below
>>> problems.
>>>
>>> First, the usage is cumbersome.  This is arguably not a big problem,
>>> since the user-space tool (damo) can do this instead of the user.
>>>
>>> Second, it can be too slow.  The update request is not directly handled
>>> by the sysfs interface but kdamond thread.  And kdamond threads wake up
>>> only once per the sampling interval.  Hence if sampling interval is not
>>> short, each update request could take too long time.  The recommended
>>> sampling interval setup is asking DAMON to automatically tune it, within
>>> a range between 5 milliseconds and 10 seconds.  On production systems it
>>> is not very rare to have a few seconds sampling interval as a result of
>>> the auto-tuning, so this can disturb observing DAMON internal status.
>>>
>>> Finally, parallel update requests can conflict with each other.  When
>>> parallel update requests are received, DAMON sysfs interface simply
>>> returns -EBUSY to one of the requests.  DAMON user-space tool is hence
>>> implementing its own backoff mechanism, but this can make the operation
>>> even slower.
>>>
>>> Introduce a new sysfs file, namely refresh_ms, for asking DAMON sysfs
>>> interface to repeat the essential contents update with a user-specified
>>> time delay.
>>
>> Thanks for working on this, but I have a few questions.
>> 1. Could you please list up what are the "essential contents"?
> 
> Thank you for asking this.  The contents are auto-tuned monitoring intervals,
> DAMOS stats, and auto-tuned effective size quota.

Thanks, but I meant the specific list of damon knobs refreshed.  If there are
too many knobs, then don't have to list them all.

> I will add these on the next version cover letter.

Thanks.

>> 2. Does it mean that it is different from writing "commit" to "state"?
>> 3. If not, then is there equivalent action to writing something to "state"?
> 
> "refresh_ms" works same to other DAMON parameter files.  You can set it before
> starting DAMON, or "commit" new values (including 0 for turning this refresh
> off) in runtime.
> 
> I'm not that confident if I understood your point very well, especially what
> "it"s mean.  Let me know if I'm misunderstanding something.

I mean writing "commit" to "state" refresh all knobs, but it seems "refresh_ms"
internally refresh paritial knobs so I was wondering what are refreshed and what 
aren't.

Regarding the "equivalent action", I was also wondering if there is a command
that works same as "refresh_ms" internally does among the command below.

   update_tuned_intervals
   commit_schemes_quota_goals
   update_schemes_stats
   update_schemes_tried_regions
   update_schemes_tried_bytes
   clear_schemes_tried_regions
   update_schemes_effective_quotas

https://docs.kernel.org/admin-guide/mm/damon/usage.html#kdamonds-n

In other words, if there is the same command listed above, then users might be
able to run a script that regularaly write the command to the current "state"
even without this "refresh_ms".  I know having "refresh_ms" is much better
though.

Thanks,
Honggyu

> 
>>
>> If possible, then this kind of information is better to be documented because
>> users might get confused if something isn't udpated when "refresh_ms" is set.
> 
> You're right!  I'll add above things on the next version of the cover letter.
> 
> 
> Thanks,
> SJ
> 
> [...]

