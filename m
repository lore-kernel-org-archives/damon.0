Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3531348167F
	for <damon@lists.linux.dev>; Thu, 13 Aug 2026 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786631281; cv=none; b=RpItXddfi5BCjndxhMh/7yyosNFHEzuKDh3cn+W+IYAwIrYJPTHSCgsAWF0Z9xinAoCpsL8wrlhC+mpyaPD1hTjsNl58AYzCy6UB1WLrpbFpWR4hlkW4sKMaTevJ5GA6v5kFCTO/vUu959x3KwKzbZ9zbKYt7lURT+dHs9iiw0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786631281; c=relaxed/simple;
	bh=dZhh9InyTFAheZGTiX41YUP5tT+ol+3zszzVDRPR8Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Su853047NplTZ8GhxJDD2tk3fd7QOjdJjh3IbqUUETune0HgXobr0as0Xq12IEqWpHuR/MRhKxfwaDxQBJab0uVqWUGwpE2cga53hypACJSdvEXXtlsC8fHdieA/Q6/GinGZ7CbWSbxGt/Y4Q2AsFchM2IdsRC+VLY62Z7lzj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=Ji+tqZc8; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="Ji+tqZc8"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8Oi6n+pIbtn2p/PtSVSa90n9gJGnn2kr5BFRe783XBY=;
	b=Ji+tqZc89R8Ep1quUgbgA6lMFuqZRkdN8JfDhGM5D+97Cv/uPFb/I0OucCxCjAqpSkySdbHKH
	Ru2frcYgmVVa5SK0B6ojK3E0AmSkKKurO94d5ddFK96FQhD77HtN4n4U1enM+X7rMLi0qGuw9i5
	Z6uNAafHUKSQT+ux0KSbUPQ=
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hLSNZ1WP0zJ46dM;
	Thu, 13 Aug 2026 22:26:54 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 80BF54058B;
	Thu, 13 Aug 2026 22:27:52 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 17:27:52 +0300
Message-ID: <c55a94f4-6ad2-4b60-b0ce-bf670dcc2f7b@huawei-partners.com>
Date: Thu, 13 Aug 2026 17:27:51 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm/damon/core: handle NULL ctx parameter in
 damon_call()
To: SJ Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20260813135536.103668-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260813135536.103668-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 8/13/2026 4:55 PM, SJ Park wrote:
> Hi Asier,
> 
> 
> Thank you for your review!
> 
> On Thu, 13 Aug 2026 11:33:01 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> 
>> Hi SJ,
>>
>> On 8/13/2026 6:49 AM, SJ Park wrote:
>>> When NULL damon_ctx pointer parameter is passed, damon_call() could do
>>> NULL dereference.  The caller is responsible to avoid that.  It is easy
>>> to forget, and there are many damon_call() callers.  Meanwhile,
>>> damon_call() is never meant to be performance critical.  It uses mutex
>>> and completion.  Add the NULL pointer check inside damon_call() so that
>>> callers can pass the parameter without NULL checks.
>>>
>>> Signed-off-by: SJ Park <sj@kernel.org>
>>> ---
>>>  mm/damon/core.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>>> index 92631a36d7b51..5882f9c94c47f 100644
>>> --- a/mm/damon/core.c
>>> +++ b/mm/damon/core.c
>>> @@ -2188,6 +2188,8 @@ int damon_kdamond_pid(struct damon_ctx *ctx)
>>>   */
>>>  int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
>>>  {
>>> +	if (!ctx)
>>> +		return -EINVAL;
>>>  	if (!control->repeat)
>>>  		init_completion(&control->completion);
>>>  	control->canceled = false;
>>
>> I know that this is a minor optimization, but how about moving INIT_LIST_HEAD(&control->list)
>> to right before list_add_tail?
>>
>> It doesn't make sense to initialize the list before checking call_controls_obsolete.
> 
> I agree it might be more efficient.
> 
> I think my intention of the code was to to keep the call_controls_lock critical
> section minimal with access to things that really protected by the mutex.
> Moving the simple initialization should be fine.  As you mentioned, it should
> be minor change.  I'm bit concerned if it will confuse people if the list head
> is also protected by the mutex, though.  What do you think?
Good point, I didn't think about it.

Given that damon_call is not called often, I believe user experience should be
more important than efficiency. Anyway, you have the last word.
> 
>>
>> Maybe this suggestion should go in a different patch.
> 
> I agree.
> 
> Thanks,
> SJ
> 
> [...]

-- 
Asier Gutierrez
Huawei

