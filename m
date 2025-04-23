Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6F1001EE007
	for <damon@lists.linux.dev>; Wed, 23 Apr 2025 02:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745373905; cv=none; b=HveHvm2J1mpicwN26xZ/Xrvf9jEoy3rP2Vm5bQ0iSXStfYHXrg13k62OvgLN/nbvJwb9CQRn0EP5LASexz7QZIdd2LwQ/TeEAxT6PjPVaaAq+2lZ8ZmaBN1PksAm1D9YlV839YqAb3/kJP0/ip0DSacdUq6LHyGoCEuuOp/Wklk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745373905; c=relaxed/simple;
	bh=yZJ7jR/aZW12eQ5iq+8UpKsm9trXaGEY8ZAigEhAObE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=YFPut3euEaeNgjmroUh1pfoErGA5me91yph77luNP1SrvwFn0hxKnZObS6kzmljpxfZ/36c/JF+TMmkuJW5uEmAR3mXrV/Q4JG/pMoWaowOxQIKNFNj1549hBG/PeG9iUoDmlFXk3GTIDEMuL3KodAftEdkm1dL4kDXR3w8jvjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 3A5DD6018E571;
	Wed, 23 Apr 2025 10:04:57 +0800 (CST)
Message-ID: <21407408-78e4-48eb-8296-fcddc702ae25@nfschina.com>
Date: Wed, 23 Apr 2025 10:04:56 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/sysfs-schemes: using kmalloc_array() and
 size_add()
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 SeongJae Park <sj@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Su Hui <suhui@nfschina.com>, akpm@linux-foundation.org,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <501ea9b1-017b-4517-8de4-7056803e7127@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/4/23 02:50, Christophe JAILLET wrote:
> Le 22/04/2025 à 20:23, SeongJae Park a écrit :
>> On Tue, 22 Apr 2025 13:44:39 +0300 Dan Carpenter 
>> <dan.carpenter@linaro.org> wrote:
>>
>>> On Tue, Apr 22, 2025 at 01:38:05PM +0300, Dan Carpenter wrote:
>>>> On Mon, Apr 21, 2025 at 02:24:24PM +0800, Su Hui wrote:
>>>>> It's safer to using kmalloc_array() and size_add() because it can
>>>>> prevent possible overflow problem.
>>>>>
>>>>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> [...]
>>>>> --- a/mm/damon/sysfs-schemes.c
>>>>> +++ b/mm/damon/sysfs-schemes.c
>>>>> @@ -465,7 +465,8 @@ static ssize_t memcg_path_store(struct kobject 
>>>>> *kobj,
>>>>>   {
>>>>>       struct damon_sysfs_scheme_filter *filter = container_of(kobj,
>>>>>               struct damon_sysfs_scheme_filter, kobj);
>>>>> -    char *path = kmalloc(sizeof(*path) * (count + 1), GFP_KERNEL);
>>>>> +    char *path = kmalloc_array(size_add(count, 1), sizeof(*path),
>>>>> +                   GFP_KERNEL);
>>>>
>>>> Count is clamped in rw_verify_area().
>>>>
>>>> Smatch does a kind of ugly hack to handle rw_verify_area() which is 
>>>> that
>>>> it says neither the count nor the pos can be more than 1G. And 
>>>> obviously
>>>> files which are larger than 2GB exist but pretending they don't 
>>>> silences
>>>> all these integer overflow warnings.
>>>>
>>>
>>> Actually rw_verify_area() ensures that "pos + count" can't 
>>> overflow.  But
>>> here we are multiplying.  Fortunately, we are multiplying by 1 so 
>>> that's
>>> safe and also count can't be larger than PAGE_SIZE here which is 
>>> safe as
>>> well.
>>
>> Thank you for adding these details, Dan.  I understand the size_add() 
>> change
>> can make warnings slience, though it is not really fixing a real 
>> bug.  So I
>> believe there is no action item to make a change to this patch. Maybe 
>> making
>> the commit message more clarified can be helpful, though?
>>
>> Please let me know if I'm misunderstanding your point and/or you want 
>> some
>> changes.
>
> As sizeof(*path) = 1, maybe, just change it to:
>     char *path = kmalloc(count + 1, GFP_KERNEL);
Maybe nothing should change?
Thanks for Dan's explanation again.
I send this patch because  it is mentioned in 
Documentation/process/deprecated.rst that:

"
Dynamic size calculations (especially multiplication) should not be
performed in memory allocator (or similar) function arguments due to the
risk of them overflowing.
"

Although in this case, this dynamic size calculations is  safe.
But it's also fine for me to change this patch or discard this patch 
because there is no
bug really fixed.

Su Hui

