Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC681EB44
	for <damon@lists.linux.dev>; Wed,  4 Sep 2024 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475292; cv=none; b=vDwLb9besRGlzZhZBxBIQurXd3Y9Z7Ytd7THT9QU/oVfxhN4hC0ZqTFuB5qGBmbz5oyoW+fxvpaIVyJZS60q4mmUe+z9cvqApD+rK84tPzwDrNPzf+yJ9/3sFTb/3M4vXg+ZgKSzuOV5xupvR2JbcyNxxGdcB2ZLNLbIwAoH4zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475292; c=relaxed/simple;
	bh=SBBpUbxxDRSSl9DErdthU5u5S5Z6n9bH/DlvH6UnjHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QY3tGLb6hG90dMe1ae4zljcUTHawUd3B1A0jzXOx7XogKIEpA+gcO7xjzyhMowTeIbUJm1pbGcttk2jNODjMdRircbXbVmvtVKJkDbM5L4OEhfKDo7LLltWOCdV5ss6imCwiw6B/fpbfuQSb3poS8vLxOWlLRalxV/8RN47qD54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDZTjZZN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDZTjZZN"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso938645b3a.0
        for <damon@lists.linux.dev>; Wed, 04 Sep 2024 11:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725475291; x=1726080091; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AH+WLoXHA2DlYnqCw15SB7/9MwZ3oRAv3Bk4lKI0sEQ=;
        b=KDZTjZZNbNmYPY6cjPIWJhmLcsvQzdF6mMklikg7VjzcVHkryFIN2NjbK7uLk7zJtn
         YtvYjyb5MV8Ui2Z1kPn/fOZuces+Ope0oigWIl3BcaBDCzfNejq8F6oA5Y2ObYGilKtz
         9fmo2fgduHsXHCZgBoxeBibP/XPauyBk34N54weLVtAO8BvfmskNL+wE7IKMpTCGDNKU
         C5OmfaV3/L8dQAN3b3QqLdzbcyBjbmPbLRUq7ksL+uhQPbuqVCVPWtencY2yG1cmIrA1
         2Pt/BUOtXeHqY8pTeqV4Z+xSrqQ4HJf4qT0v3JBMoioOiW8HxjznOxzoHHBXbbBexy0l
         RH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725475291; x=1726080091;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AH+WLoXHA2DlYnqCw15SB7/9MwZ3oRAv3Bk4lKI0sEQ=;
        b=l3gTU7r1Rj7M5hG+EU/RfQCToND0we4k9yolhwFOp4cu2mwuZRUFMc27D6CP08gZnG
         6SKou0r6On6rsXrztxdrVaFIExbuzIbjeKKEG6nZ1kCoPxfb02LZUyllEk4/FFwli6U0
         3+CL+Jwh9Yvou54Lkj67Uc6dY9utS6ndr0A7LrmOKQ1Noy3uT1APJREtBqCZhV9r2OrD
         vEzpYqyeIQq/owcpEMNmsFmtmIogs+ZB9NsgkojV6c7CSRrtukFb38mB7y0QAFTed6QG
         oJ5YgcIfZPOwTZd2xbnx6IzproSCHRUaQqkwINlZVGJqtHLfEGbfOIAWlPB33SOPDtUB
         WBaw==
X-Forwarded-Encrypted: i=1; AJvYcCXDyHvzB84B/Qrii3lhCAB6GUeHGMtdv5rdJ4XEnNm1zGRE91758l3t1Nyh9una1CcVSlZs+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVY0Ffh5Ebhsm/dYs7ATV0PKIn3bIgIl5JvSqUoCtNaeJ4GxEP
	d2AJtZS4h8zOiIoO1rFlA3LkmixGJeEnSj9rIRjn+q1AFnXQzq0/
X-Google-Smtp-Source: AGHT+IHC8jK1yXwpDeEL1py+eCkq4NADqbKnhe0Q1HYDr33PYqUrlmaKJ12/vwdFBcnYjdOYudZhIA==
X-Received: by 2002:a05:6a21:10f:b0:1cf:1228:c175 with SMTP id adf61e73a8af0-1cf1228c29dmr764911637.8.1725475290475;
        Wed, 04 Sep 2024 11:41:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778522931sm1936293b3a.4.2024.09.04.11.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 11:41:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <34f3e9bd-9323-43cc-8371-00d8847d8664@roeck-us.net>
Date: Wed, 4 Sep 2024 11:41:28 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/damon/tests/vaddr-kunit: init maple tree without
 MT_FLAGS_LOCK_EXTERN
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>, damon@lists.linux.dev, linux-mm@kvack.org,
 kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240904172931.1284-1-sj@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240904172931.1284-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 10:29, SeongJae Park wrote:
> damon_test_three_regions_in_vmas() initializes a maple tree with
> MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
> mt_lock of the maple tree will not be used.  And therefore the maple
> tree initialization code skips initialization of the mt_lock.  However,
> __link_vmas(), which adds vmas for test to the maple tree, uses the
> mt_lock.  In other words, the uninitialized spinlock is used.  The
> problem becomes clear when spinlock debugging is turned on, since it
> reports spinlock bad magic bug.
> 
> Fix the issue by excluding MT_FLAGS_LOCK_EXTERN from the maple tree
> initialization flags.  Note that we don't use empty flags to make it
> further similar to the usage of mm maple tree, and to be prepared for
> possible future changes, as suggested by Liam.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/1453b2b2-6119-4082-ad9e-f3c5239bf87e@roeck-us.net
> Fixes: d0cf3dd47f0d ("damon: convert __damon_va_three_regions to use the VMA iterator")
> Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> Changes from v1
> (https://lore.kernel.org/20240904004534.1189-1-sj@kernel.org)
> - Keep lock usage and update the initialization flags (Liam)

Not sure I understand how this is better. Is the resulting rcu warning
considered to be irrelevant or a separate problem ?

Thanks,
Guenter

> - Fix a typo: s/celar/clear/ (Guenter)
> 
>   mm/damon/tests/vaddr-kunit.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> index 83626483f82b..a339d117150f 100644
> --- a/mm/damon/tests/vaddr-kunit.h
> +++ b/mm/damon/tests/vaddr-kunit.h
> @@ -77,7 +77,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
>   		(struct vm_area_struct) {.vm_start = 307, .vm_end = 330},
>   	};
>   
> -	mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
> +	mt_init_flags(&mm.mm_mt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU);
>   	if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
>   		kunit_skip(test, "Failed to create VMA tree");
>   

