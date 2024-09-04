Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB951E0B81
	for <damon@lists.linux.dev>; Wed,  4 Sep 2024 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469104; cv=none; b=vGNGDJTC3VHERq9y1jLz6huQWwTFCwIDMDf7G84hReQHjAwCtSZxd+ESQllp4PUoqLZleDP8Ka5BiLkMDqw/pXMrMK0MgF4haC+76ghBfH0enygqnO0oQKvF9Ro8UAe+JP2e2HsUHekzqtmZX904mcUQgw29shElS6BcdznmNGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469104; c=relaxed/simple;
	bh=jrPsPPlIePqMYpONK4ZEimXibJHFsvp/M5Fjcx8uuLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tK9QZ2Wqdd4HF8/BxyGWBwBoVF4AHCQ+IKMHTteGddMmeYa0RmBRUBTP9lGUUlb3BfI2/BY40p0+CjVzJQHCZc/HwnlDfKnCLVGvIs5nLAUszwUnHaM38sKOaTJWUNcRaB+8pa0yfuLC0vnnlTRXuk29KUmqsOjcdME7kSbPWTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EylkTq3M; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EylkTq3M"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso4775622a12.1
        for <damon@lists.linux.dev>; Wed, 04 Sep 2024 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725469102; x=1726073902; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kMy7Qn1zaAc9/IMOhqSwwfWBQGHR6tB90Jwa2IOJx1I=;
        b=EylkTq3M+Ax+EJNhrHQ7zGAFlJw8PlQ8v/pcYGSN3tyMmmIOd70Iy6m3nS0tYpRgJu
         alcU1mvtrreLW/rkNHj4Nx0Ohv3wrjWh5py4rNHsyflKeVv8mXEkmWoj/S4IwlY5akN5
         i5ex1ApNcXdE4KMwWIWGKW6angipkk+/v5FtpCedc/nV4p6JqQLWwZ44kc6SL/VdvpQ7
         sB073Lq372Hwo+rU+wcTgiFOAOKQigoQu/SdoXAX+hQpmDm+m0FbV4z4POObaGidRQlJ
         ztQc/gYVlQCZBCsMbp3Lju3LJfEURbKa3zXxWU8fDrN4lyPln9i041ssaDaT3QUDhZXz
         ZXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725469102; x=1726073902;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMy7Qn1zaAc9/IMOhqSwwfWBQGHR6tB90Jwa2IOJx1I=;
        b=aHbnVZ4GDxmqQVc4qUFtp9BF7T//QFIud6qTRCpiJ6fRLHi513rvSmsAElrVd9ZwWO
         TkQCo76Iq43aP7BNsIMpaZRA0zkcMgKegtb1Qv6sUxwx/CXwy0z7EGvC/LlOcSLJpfNW
         oxu3KFi4BMrH6Cr03hM5p87Y6lbW40q2p9BMj60Rz/xRxf6I3Q1aGDyevOA5NtVvJuGA
         u+iq0qzlMQYDqOL8uLmpS498Gz0ovRmth3pLk3Gu/r6/Zy4A9aGumj1KSn8XsnFy6VDN
         YhSh3NuWMtnd0mLoBABr925P5POO0FrdVRaJItAwLylDa0rb2J8K1VC+irMhMHDeBZUv
         mACg==
X-Forwarded-Encrypted: i=1; AJvYcCXTUCrDIF0I7R9qvQjNm0O9lVEUbdQgTnboiuvZLVlS/JQTgmtNk7E6H0DMgvSSJ+Zdb84ayg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFkf4p9x2f4CX3TkpNrb8ovImP0CxDGDLNSJ7LyGpwm3fNCjag
	ZWAkOS7Tlkkk12jb4q4CGfYO2umUIdZl7UIW27L+TEm3pFCtfrKA
X-Google-Smtp-Source: AGHT+IG7/Tr7YqkobZcAU6j60F1cDj8e4643TsFFFzLwxv/IlYTNIaaf7jDZFBtBeELj1S/3WakAeg==
X-Received: by 2002:a05:6a21:3405:b0:1cc:e4be:5fae with SMTP id adf61e73a8af0-1cecf49ae7amr15745012637.7.1725469102108;
        Wed, 04 Sep 2024 09:58:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177853338asm1834607b3a.58.2024.09.04.09.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 09:58:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <78880ac2-f7fe-4dc1-b2cb-25942fb0cacf@roeck-us.net>
Date: Wed, 4 Sep 2024 09:58:20 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/tests/vaddr-kunit: don't use mas_lock for
 MM_MT_FLAGS-initialized maple tree
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, SeongJae Park
 <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>, damon@lists.linux.dev, linux-mm@kvack.org,
 kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240904005815.1388-1-sj@kernel.org>
 <20240904011840.973-1-sj@kernel.org>
 <whdjeq6qpccj6ms4wgiyjcnizht4nl5qbt7rbaeqfwzt67smxt@vvduwpqcuizl>
 <e83dedb2-89a3-4327-9a2f-610d3199f0e1@roeck-us.net>
 <54zu64vxrhdxr4wtmwbewga44shu4f7lz4ffx2hxhag46b56hn@qgrgfrb6mhbv>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <54zu64vxrhdxr4wtmwbewga44shu4f7lz4ffx2hxhag46b56hn@qgrgfrb6mhbv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 20:36, Liam R. Howlett wrote:
> * Guenter Roeck <linux@roeck-us.net> [240903 22:38]:
>> On 9/3/24 19:31, Liam R. Howlett wrote:
>>> * SeongJae Park <sj@kernel.org> [240903 21:18]:
>>>> On Tue,  3 Sep 2024 17:58:15 -0700 SeongJae Park <sj@kernel.org> wrote:
>>>>
>>>>> On Tue, 3 Sep 2024 20:48:53 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
>>>>>
>>>>>> * SeongJae Park <sj@kernel.org> [240903 20:45]:
>>>>>>> damon_test_three_regions_in_vmas() initializes a maple tree with
>>>>>>> MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
>>>>>>> mt_lock of the maple tree will not be used.  And therefore the maple
>>>>>>> tree initialization code skips initialization of the mt_lock.  However,
>>>>>>> __link_vmas(), which adds vmas for test to the maple tree, uses the
>>>>>>> mt_lock.  In other words, the uninitialized spinlock is used.  The
>>>>>>> problem becomes celar when spinlock debugging is turned on, since it
>>>>>>> reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
>>>>>>> as promised.
>>>>>>
>>>>>> You can't do this, lockdep will tell you this is wrong.
>>>>>
>>>>> Hmm, but lockdep was silence on my setup?
>>>>>
>>>>>> We need a lock and to use the lock for writes.
>>>>>
>>>>> This code is executed by a single-thread test code.  Do we still need the lock?
>>>>>
>>>>>>
>>>>>> I'd suggest using different flags so the spinlock is used.
>>>>>
>>>>> The reporter mentioned simply dropping MT_FLAGS_LOCK_EXTERN from the flags
>>>>> causes suspicious RCU usage message.  May I ask if you have a suggestion of
>>>>> better flags?
>>>
>>> That would be the lockdep complaining, so that's good.
>>>
>>>>
>>>> I was actually thinking replacing the mt_init_flags() with mt_init(), which
>>>> same to mt_init_flags() with zero flag, like below.
>>>
>>> Yes.  This will use the spinlock which should fix your issue, but it
>>> will use a different style of maple tree.
>>>
>>> Perhaps use MT_FLAGS_ALLOC_RANGE to use the same type of maple tree, if
>>> you ever add threading you will want the rcu flag as well
>>> (MT_FLAGS_USE_RCU).
>>>
>>> I would recommend those two and just use the spinlock.
>>>
>>
>> I tried that (MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU). it also triggers
>> the suspicious RCU usage message.
>>
> 
> I am running ./tools/testing/kunit/kunit.py run '*damon*' --arch x86_64 --raw
> with:
> CONFIG_LOCKDEP=y
> CONFIG_DEBUG_SPINLOCK=y
> 
> and I don't have any issue with locking in the existing code.  How do I
> recreate this issue?
> 

You should find everything needed to reproduce the problem at
http://server.roeck-us.net/qemu/damon/

Please let me know if you need anything else.

Thanks,
Guenter

