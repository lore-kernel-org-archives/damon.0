Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4568884A21
	for <damon@lists.linux.dev>; Wed,  4 Sep 2024 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476794; cv=none; b=n4Vd62JNyOV9C8nm9Z/KRC6+kucZALDDWAA8UhJudijiDrO0V2C3CJ/L9YMftVtwlgRA+KzkbI83tPN+4g03Zij3OwE50ZmYHyHbAPhd8UHM2O63pW7n+vJPzY3J3dMnWfzA0UU/xC/Be6+MYFI2berbmYAOwEgzH1uvsoSkDcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476794; c=relaxed/simple;
	bh=HF4JYSY7vO5Fj8SpztFP2qJTHso0A7hen0wcl5bXQxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agkGT+pq6cutU75j2lUNQgmLlL4C6PmM7p++0HD8n/Jw1gpZ6IFJS6ZlLODbNHTC+Ud+78rHJPnWqemvWIGinjLheLacNFplJ+7VoufvLwkDLT9isJ7CryvnqCOKBSLK5CPUJqaiFK7Ar042wsEOz5cv93llHX9EwaxD/DF4tBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOgyDj9p; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOgyDj9p"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20570b42f24so38328305ad.1
        for <damon@lists.linux.dev>; Wed, 04 Sep 2024 12:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725476791; x=1726081591; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HYSTb2LAFdmzPq+OFrAM2CwqWAfWo0NEI0z9BiyczWs=;
        b=ZOgyDj9pY1ZhvQK5LRdpfafybPER1LVXdhc5IqIOE0L5SgoqDFQAHt8x3PAIhLV5rp
         wvcKP0bf3w2nHUzyVitWSFhesyq9dRhpHim8WQpX4dwwpVGuVZUqmaQiSehv2soyAGeZ
         TCGie93drPd2YPzKL+1WKeovLLxWMRnCmvMMTOnsx5XYPyxWH9ecnXKZY246lSVyrF/A
         EZrkk0FNhqWPe/wGkpGCk1ZwfjNauxpzy9KlWA2kgYEh+DCFdw6htBxVmj1UNB62WOHz
         DGbLOFFtkmqIRvVt5Kktpluy7nGpNeo+A8P48tQfVtSfbkP6OWRhe59jANZRBi4Wl7MG
         P35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725476791; x=1726081591;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYSTb2LAFdmzPq+OFrAM2CwqWAfWo0NEI0z9BiyczWs=;
        b=V1HwkcuNiLeagEeXiINGYgDCtk8iC6VPSlzanmHo9dk0kUjBDDgnEbtrIMSXVYAFEs
         Czhc4v3EWl+HTBfa0exfvsKpgi/jEmqQHjeZzRDMYceLrUR2rXp0J3RhaorU5IJOodSZ
         CJJPvYyZoG87oPgunfN7/hLlHrmXLvbTaxZaclRZsK+/jqmnkrdEUIbnynti+6UvlXQ6
         /FOI0nypFYqSJh0ju6mszHZFbZDgtIvTYg/y4Oj8P6xzPwAVTLscnrd8jJ0in5rCmJck
         X4oRLHcr4H2tKsCuuN+ldbd6XpHMnqsomRCp18ooXAsYo1xZnOrJWJDCQVJo2wDjhwq1
         TH3Q==
X-Gm-Message-State: AOJu0YxCZpMCuHs5plczjcHB2fwX2bzyMiO//X63a5AiGBrQnog6CbWo
	W3WAcPqt5mu1vG/TDqILqmXzcpx9AbLxu2pcFnsQgvxlmMf74KJCpbwKkg==
X-Google-Smtp-Source: AGHT+IGFStsHjslQri7Pbrd+CxduL0rv2tAX978on78Xs43UWLOmdToclwXgeFlQvdtBdkd/catZIA==
X-Received: by 2002:a17:902:ce06:b0:205:86f5:333d with SMTP id d9443c01a7336-20699b3701amr83733745ad.55.1725476791336;
        Wed, 04 Sep 2024 12:06:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea56918sm16637955ad.218.2024.09.04.12.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 12:06:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c62934de-001d-4f41-bc00-17244cd04d89@roeck-us.net>
Date: Wed, 4 Sep 2024 12:06:29 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems running DAMON kunit tests with spinlock debugging
 enabled
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
References: <20240904175306.1862-1-sj@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240904175306.1862-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/24 10:53, SeongJae Park wrote:
> Hi Guenter,
> 
> On Tue, 3 Sep 2024 19:46:44 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On 9/3/24 19:24, Guenter Roeck wrote:
>>> On 9/3/24 18:00, SeongJae Park wrote:
>>>> Hi Guenter,
>>>>
>>>> On Tue, 3 Sep 2024 12:23:50 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> when trying to run DAMON kunit tests with spinlock debugging enabled,
>>>>> I get the following error messages.
>>>>>
>>>>>       BUG: spinlock bad magic on CPU#0, kunit_try_catch/209
>>>>>        lock: mm.13+0x40/0x840, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
>>>>>       CPU: 0 UID: 0 PID: 209 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc6-00148-g178297ec52d6 #1
>>>>>       Tainted: [N]=TEST
>>>>>       Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>>>>>       Call Trace:
>>>>>        <TASK>
>>>>>        dump_stack_lvl+0x9e/0xe0
>>>>>        do_raw_spin_lock+0x63/0xb0
>>>>>        damon_test_three_regions_in_vmas+0x121/0x450S
>>>>>        ...
>>>>>
>>>>> This happens because damon_test_three_regions_in_vmas() calls
>>>>> mt_init_flags() with MM_MT_FLAGS, which sets MT_FLAGS_LOCK_EXTERN.
>>>>> Because of this, the spinlock is not initialized, which then results
>>>>> in the error message when mas_lock() is called during the test.
>>>>>
>>>>> Unfortunately, replacing MM_MT_FLAGS with MT_FLAGS_ALLOC_RANGE |
>>>>> MT_FLAGS_USE_RCU or just with MT_FLAGS_ALLOC_RANGE doesn't help;
>>>>> it results in various "suspicious RCU usage" messages.
>>>>
>>>> Thank you very much for this report with the grateful detailed investigation!
>>>> I was able to make and send a fix[1], thanks to the investigation.  Seems it
>>>> may need some more revisions[2], though.  I'll continue discussion on the
>>>> thread.
>>>>
>>>> [1] https://lore.kernel.org/20240904004534.1189-1-sj@kernel.org
>>>> [2] https://lore.kernel.org/jy6263g6em4jsdhp6tknmh2cljpuvq652kvcet4ko3z2xt7pym@ltc5h5twsszu/
>>>>
>>>>
>>>
>>> Some more problems. I tried your patch on various architectures.
>>> Unfortunately, that didn't turn out well. See below for some of the failures.
> 
> Nice finding, thank you for reporting this!  Just to be clear, seems this is
> independent from the originally reported issue or the fix for it.  Please let
> me know if not.
> 

It is a different problem.

>>>
>>> [ I am not sure I understand the code in damon_test_nr_accesses_to_accesses_bp(),
>>>     especially
>>>       .aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
>>>     What happens if sizeof(int) == sizeof(long) ?
>>>     Unless I am really missing something, .aggr_interval will be
>>>     0 in that case.
> 
> I agree.  aggr_interval would be zero in the case.  And in this case,
> damon_max_nr_accesses(attrs) in damon_nr_accesses_to_accesses_bp() returns
> zero, so damon_nr_accesses_to_accesses_bp() will get a divide by zero problem.
> That is, the problem happens when damon_nr_accesses_to_accesses_bp() is called
> with zero aggr_interval, regardless of the architecture.
> 
>>> ]
>>>
>> The diff below fixes the problem in damon_test_nr_accesses_to_accesses_bp().
>> Obviously I don't know if this is the correct fix.
>>
>> Guenter
>>
>> ---
>> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
>> index 0cee634f3544..8072f83b2bba 100644
>> --- a/mm/damon/core-test.h
>> +++ b/mm/damon/core-test.h
>> @@ -309,6 +309,9 @@ static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
>>                   .aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
>>           };
>>
>> +       if (sizeof(int) == sizeof(long))
>> +               kunit_skip(test, "Test requires sizeof(int) != sizeof(long)");
>> +
>>           KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);
>>    }
> 
> So, above fix would work, but I think doing the skip if the resulting
> aggr_interval is zero would make more sense.  Having more comments would also
> be nice.
> 

Sure; the above was not intended to be a final (or even acceptable) fix,
just a workaround to let me run tests with damon kunit tests enabled
on 32-bit systems.

Thanks,
Guenter

