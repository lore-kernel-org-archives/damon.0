Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8017B51A
	for <damon@lists.linux.dev>; Thu,  5 Sep 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559495; cv=none; b=NhP1Z6oGtG/+ZLZzTAuJVM4teFYerNIM4Ou7/t7avwUM6lFpZFSCxrB09Q4Ciq8o0TU//QCNzlmftK6P6ECWz2kYU7Q7gI8yZivhcBo9Akr/qOhisJ+HDFqtwEKZGEEXkpXsCdgvtdNkHuu6j6GkOg0aVS3SJT5iZMHrG2QGM6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559495; c=relaxed/simple;
	bh=okLvMqmcJCWj5a2bfrJ4u3VZK/EH/reN/NJY4aHdHSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UE0/2nC3ibXtMDBXhoQHuFXm8aS3TH2qzE4f0moizmHhMtECGW/O/jKtFetAkUBsgl1Pt5HoilQTa0cIkyXjSI5QmAFv+CDAq+nnMA5BIhyzv74xdNCQS6etx51rlMGq3MeCMb4G0XcWT95IDCmXuQoAKc5K2X+Z5nsPvmZrq8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMjyR6uA; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMjyR6uA"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso854475a12.0
        for <damon@lists.linux.dev>; Thu, 05 Sep 2024 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725559493; x=1726164293; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P8ZVlA50YrBETGK0WdPPyCDv3j8veUMEs/KUpBrdl8I=;
        b=RMjyR6uAmYFRMPN83EDoq+VKHBlhR/i0dyiSS7bsm8NyIrsAiVs//J1cAAONzRdI3n
         f5MdO//T8wqwQO5t3hMABSXjdi/comnYta/412aVW6V8vFcbcxzfDu0wi8lvZeKo5wV7
         j4s3ltn9LeUCq/tpYgYKiPOlQpPwULe9VGhh08yqvx23l1ZXlON1RLyzx/M4Kn2RRYuo
         uQ4uafmT3upquablRHHQHaosPqf8mPvohfMCW7rYcm3f1C2AMN+zvtwYcA0XQRzriv+p
         Zi4eHo9i1npWsoasEBe+qGKYCvM+M9mnsLE3hTRTjJGFK36jWUGYRamGJUDxXk8K+uga
         Ivfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725559493; x=1726164293;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8ZVlA50YrBETGK0WdPPyCDv3j8veUMEs/KUpBrdl8I=;
        b=C/OWm3LlUyWw1cISkP7irO4lt81ShNOot5q4y0kaW9CYscAXjzvXB90x3U56HFcI90
         IDdITxalfVTrVOnhGmRVO353WDYgLJ0AI9CJNq3GFM3CVQyMtjdMzf0qCHLfmWjmi2dL
         luNMW0BVKiymCF7uwNG5X40bR+1PH/MdVzOAesF4UxJ2tMkXZn3AqYUDAmQxtpAy2Prj
         cN0GszKSiengjxBXnnG7UjcryIde6Vn1h91Av8mHjcTBnzMXaEUzJ9SacIuU+rdarTMY
         ijPmit1kokoFZQTlXXXtur2jbEmsOUARlf3Ypm2JGFpUAbXXcmLDwaDFpz+x8NfIiQUP
         9P0w==
X-Gm-Message-State: AOJu0YzlmPaAnDp2P7dsODXIorUnB0+K34ATGQRf43IJyyQJZz771By5
	w/dASEfypUodoZmuOS+3neTrOwTLJTewNf8FoAt/YDjZ4PvETLq3
X-Google-Smtp-Source: AGHT+IEQ9sxRHWiC2EI5Dnh8BJm82N0pT7GGjWU2b5M9+0VfJ1MOY1kKb5uduE/jxYZXNDNmrL0yRQ==
X-Received: by 2002:a17:902:dac9:b0:205:937f:3ac6 with SMTP id d9443c01a7336-205937f42afmr128206335ad.1.1725559492972;
        Thu, 05 Sep 2024 11:04:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae949f07sm31249585ad.68.2024.09.05.11.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 11:04:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <64f1b6bf-174f-4ac2-a43c-2783c1cd3999@roeck-us.net>
Date: Thu, 5 Sep 2024 11:04:51 -0700
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
References: <20240905173507.47124-1-sj@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240905173507.47124-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 10:35, SeongJae Park wrote:
> Hi Guenter,
> 
> On Wed, 4 Sep 2024 14:04:03 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> 
> [...]
>> Here is another problem. With all other problems fixed, when running on a 32-bit system:
>>
>>       # damon_test_feed_loop_next_input: EXPECTATION FAILED at mm/damon/core-test.h:488
>>       Expected damon_feed_loop_next_input(last_input, 200) > damon_feed_loop_next_input(last_input, 2000), but
>>           damon_feed_loop_next_input(last_input, 200) == 923006 (0xe157e)
>>           damon_feed_loop_next_input(last_input, 2000) == 1190503 (0x122a67)
>>       # damon_test_feed_loop_next_input: pass:0 fail:1 skip:0 total:1
>>       not ok 16 damon_test_feed_loop_next_input
>> # damon: pass:14 fail:1 skip:1 total:16
>>
>> Problem is that both damon_feed_loop_next_input(900000, 200) and
>> damon_feed_loop_next_input(900000, 2000) overflow on 32-bit systems.
> 
> Thank you for reporting this yet another important issue!
> 
>>
>> Also,
>>
>> static unsigned long damon_feed_loop_next_input(unsigned long last_input,
>>                   unsigned long score)
>> {
>>           const unsigned long goal = 10000;
>>           unsigned long score_goal_diff = max(goal, score) - min(goal, score);
>>           unsigned long score_goal_diff_bp = score_goal_diff * 10000 / goal;
>>                                                             ^^^^^^^^^^^^^^^
>>
>> Since goal == 10000, the last statement has no effect.
> 
> You're right, thank you.
> 
>>
>> The diff below should address the problem for the most part, though the calculations
>> may still overflow for large parameter values.
>>
>> Guenter
>>
>> ---
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index 7a87628b76ab..ab9c625ee2e0 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -10,6 +10,7 @@
>>    #include <linux/damon.h>
>>    #include <linux/delay.h>
>>    #include <linux/kthread.h>
>> +#include <linux/math64.h>
>>    #include <linux/mm.h>
>>    #include <linux/psi.h>
>>    #include <linux/slab.h>
>> @@ -1451,8 +1452,7 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
>>    {
>>           const unsigned long goal = 10000;
>>           unsigned long score_goal_diff = max(goal, score) - min(goal, score);
>> -       unsigned long score_goal_diff_bp = score_goal_diff * 10000 / goal;
>> -       unsigned long compensation = last_input * score_goal_diff_bp / 10000;
>> +       unsigned long compensation = div_u64((unsigned long long)last_input * score_goal_diff, 10000);
>>           /* Set minimum input as 10000 to avoid compensation be zero */
>>           const unsigned long min_input = 10000;
> 
> Thank you for kindly sharing this, too.  Your detailed reports of symptoms,
> root cause, and possible fix help a lot.
> 
> As you also mentioned, this function may better to be significantly re-written
> with overflows in mind.  However, I have no enough time and setup to
> sufficiently test the fix for now, due to some personal reasons.  Also, the
> issue is important, but not time-critical for now, in my humble opinion.
> Please let me know if someone has different opinions.
> 
> So, I made one possible fix off the top of my head, and posted as an RFC patch:
> https://lore.kernel.org/20240905172405.46995-1-sj@kernel.org
> 
> I only tested that against the kunit test on my 64bit machine.  After I get
> some time and setup (maybe 1-2 weeks later), I will take more time to review
> the code, do more tests, and post RFC-dropped version.
> 

No worries. I queued the RFC patch up in my testbed, so we should get results
for all targets later today (or maybe tomorrow, the testbed is busy with stable
release tests).

Guenter

