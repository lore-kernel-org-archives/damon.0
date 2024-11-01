Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9027E3BBE5
	for <damon@lists.linux.dev>; Fri,  1 Nov 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730470623; cv=none; b=d792oMSnN2/qxJT+trzlNbctkYXJYB80niHqnbk8F2h1Wohb3NFZdUQs1+ZFREIilbxsOVZZpZZg5Xvko0KgO246M8+dPfRTCAaVgJd4RxkffS5ffUi+W1JWyg0ZvI3Bs9GsBhAu/1qc7yTCLUq84A0ZIwSx59n+rYDcHAXsMsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730470623; c=relaxed/simple;
	bh=B5yKXluwcku8wYDwtxVLlM3vuc0si0gN6d5kSy+kby4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPRt8PVbTpRksQ9XE3+13tV4ug4bQZA/HnWX99YSvQiIS4ESat7TlBB0MhjZ0jQ/VArF4ki+4YH6La+InW9E3jB2MrvvJp9j5dmjVuW7TL2cXjmyiSS0FFQQN27nm4Ho3LN7hjl/XYg14WTKxzQPRnacyvFQmHgXEvjDUgabBnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU5ZpJ3z; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU5ZpJ3z"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720d01caa66so628125b3a.2
        for <damon@lists.linux.dev>; Fri, 01 Nov 2024 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730470621; x=1731075421; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NFchV1PjszL4CoLP5K130zG0LqBxt/CVi1vhj5zjfFA=;
        b=jU5ZpJ3zUY6NaYaF04Orq40wIMr9gweko87Nhdr5IsFvXvCBr+E3KYiNvi++cnS3Re
         AMumxuht4TY60Ja7p3T9PN07qfGgVzcH1Kshs/sucZAqQVxLWQEDoXhA4Eb1+MS2P25S
         bOUhLO+aTiLovS3Q3rZeBODmNbK77H8kuonYNHNI6BHi1DvU1xkQMhb8cV8sC2YF1w2I
         asdxo9B/91xNmFZgLwsOlXf7q6og7ZcrvYIk0WdmBegT9LjfgeUNQNV8b/5TgY72lMVV
         SBHrcIuNGYQZbfPVQT2AMMSAMMCf5fsiHqf4PrU1LVEHht6kua4Outh0kwgD502sLUac
         ifTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730470621; x=1731075421;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFchV1PjszL4CoLP5K130zG0LqBxt/CVi1vhj5zjfFA=;
        b=AA1TOlf+8H/yrmn5kvobR/OSY+B5eaRGaSvQ3KH9wE62MlEONZd8g3/ZnTGGc8fptc
         uujQUmJl9XJZyUsqN3vdRak8Aam255Thy6tFVxawEUARv2wZ9tyVSq2K73lBClCt9eCA
         2abivAyeKUzMR9TzftSGvLBvjQtxrtuBc65m0cYgjFt/53Mw2wpFmsv+GxZotKD2LG5+
         GdXuLP7iaGVQ97HsvPYTCQqW59gsizuZOTNxF9VcdAghltfwQFf4hEPnBFUQmEdZdNkj
         CgWVx+VL4fGM8imlnlvjiq+SbUlVe3lngeDWU98bZpNTwBF4QEQrjwznXSVL4n17oknc
         ruig==
X-Gm-Message-State: AOJu0Yw32KCMfLDmU0NRq2u4uup4zUmBcN2n7zCOs1zL7oOmba//2M9v
	0NP6yB6HjeRGkWG9uLrEpqErKl46Ccnm+WaW+29tUvdInDxpbqMZ
X-Google-Smtp-Source: AGHT+IHTl99hV0UaJza8mCwc5/j47zox+uBjZ2VwG6HPCKDS+py5HiCuDMUr5ohMbkU6Yehx0Bc+AA==
X-Received: by 2002:a05:6a21:6e4a:b0:1d4:e4a9:c126 with SMTP id adf61e73a8af0-1db91e6983bmr9692192637.32.1730470620669;
        Fri, 01 Nov 2024 07:17:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45296fc5sm2473086a12.11.2024.11.01.07.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 07:16:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <47fae3a3-3597-43ef-961b-c47558a779ab@roeck-us.net>
Date: Fri, 1 Nov 2024 07:16:57 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/damon/core: avoid overflow in
 damon_feed_loop_next_input()
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241031052113.66155-1-sj@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241031052113.66155-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/30/24 22:21, SeongJae Park wrote:
> Hi Guenter,
> 
> On Wed, 30 Oct 2024 21:18:51 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On Thu, Sep 05, 2024 at 10:24:05AM -0700, SeongJae Park wrote:
>>> damon_feed_loop_next_input() is fragile to overflows.  Rewrite code to
>>> avoid overflows.  This is not yet well tested on 32bit archs.
>>>
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>> Closes: https://lore.kernel.org/944f3d5b-9177-48e7-8ec9-7f1331a3fea3@roeck-us.net
>>> Fixes: 9294a037c015 ("mm/damon/core: implement goal-oriented feedback-driven quota auto-tuning")
>>> Signed-off-by: SeongJae Park <sj@kernel.org>
>>> ---
>>> As mentioned on the commit message, this is not yet sufficiently tested
>>> on 32bit machines.  That's why this is RFC.
>>
>> Is that patch going anywhere ? I have been testing it on a lot of 32-bit architectures,
>> and I do not see any failures.
> 
> Thank you for this nice reminder with the grateful test results, Guenter!
> 
> I was recently cleaning up the code and commit message, and testing on my own
> with test setup.  I should confess that it took more than I expected in the
> last RFC posting.  Sorry for the delay, and thank you for your patience.
> 
No worries; I just didn't want it to get lost.

> I believe the patch is now in good form, but I was waiting just a couple of
> more days before posting it, for a case that I find any mistake on it.  So
> unless I find something wrong on the patch by Tomorrow morning (Pacific Time),
> I will post it after dropping the RFC tag.
> 
> The current version of the patch to be posted is available at my patches
> queue[1].  Please let me know if you find anything suspicious on it.
> 
> Thank you again for your patience and nice reminder!
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sj/damon-hack.git/tree/patches/next/mm-damon-core-avoid-overflow-in-damon_feed_loop_next.patch?id=fb13d053bfdd5249bebdd1c253417f97cd41471e
> 

I already got that version of the patch per e-mail yesterday. I re-tested it
in my testbed last night, and it (still) works as expected. So, again, for
the record:

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

