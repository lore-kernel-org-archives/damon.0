Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0101379DE
	for <damon@lists.linux.dev>; Wed,  4 Sep 2024 01:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413309; cv=none; b=p2LDpR+5jD4GPcOcCfJvmHOu1y55nyUw1PCC0FoU7JmeLAdcsa/RsWrUYqEDAYmjiMEVkf1CdwKednHjm+FwIiFmoYEkxRg7naZYhZ3ZNnms7T4PG0UvNyVDwhY97bPt39rjJSDATIxaKBXmie8M85Nt4PRndQU8QTgxsFyu5u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413309; c=relaxed/simple;
	bh=869an7QuVDta4KU4pjwwOQa6ZKA85BOLwZnAn+4njPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMBPC8BuafffuNlRV/qPpePeNn3HnauBNzsssKA4+7NgfnzWiawzMckzfyh8SOzQWvKfOSvkvf1SEl1/yhLMkxL53QeQ1/M8aypDWUS/3FAx4VeSVupZ5IfW6wie8A5QkV1XaOEawceUH1UgMPVeR31zSpwbwN9SitXrGLXFsks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHwwHn3A; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHwwHn3A"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20551e2f1f8so30141545ad.2
        for <damon@lists.linux.dev>; Tue, 03 Sep 2024 18:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725413307; x=1726018107; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKcGcLiluE4oplvfFGxfWezTU3/P7wua4OuY0w4lgrQ=;
        b=QHwwHn3A/rMqNRNbxHmlPg/cSyTF8qLVCxikoVPfOXEmHv5rdeP0AO0Svb8UmxuP0a
         39yAe4Djl+kVfvhwrQb3YRZq7LzzK7oQc+3BRp+TZ3rP6wyXqH+RCjeJp1jYIHcmz52W
         axw+1L5B6S/iqnEEWIeYGPHgBsESBNpRnsomvnhHpuegSzl7phFn27KJYGByuBcHDNkr
         z5v3YGdGuM8gaX/Zg81S6LFASJ8FCY60K5XyDC+aJbnZIqYaJzph4sgUgchNhQyLqd0c
         VDYNaU++d3Fzuslv0OLCXBS8harxXyswq2lPGsVgCZtlIyZTwXA0jJEsDWypEoKm1toX
         nY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725413307; x=1726018107;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKcGcLiluE4oplvfFGxfWezTU3/P7wua4OuY0w4lgrQ=;
        b=YPQ8eXfXJhVzk+C41qVYhRiyJvatZT3MUBnuQmD9+9vVF/Nf1YtPethT2HighIbDua
         LTZbOWjcl+OQbhlxtkTuDA0/aM5pB6WRNvP4SDV4Tvvb+UxgOXWOR63utqihH2vl5o/y
         p8vN+JWa5uONjfF4wmjQrzRDb2kjbXNYMCEhy/k4DWylLuucCWWlm9mFH1DtkmU80r4C
         1DhUkwWbfORr1IGRkU+CpmMqNoXxXHCskrpKTlk2x0C13GOoH5wSOHebJKCYJdXucIN6
         JgVyhcBR3Ch5W7isDmRJIyGx84c5mM8/HOy0bcmuGrXb8Ttw0UUJtKZMRhe6SmmrsUWS
         9w4g==
X-Forwarded-Encrypted: i=1; AJvYcCWLIstdS1oNZEnApFgP0784U6HpL548xxEEaFb+wDj8SjPwWnPKWzgdz7iPXcHEsqIg1GCeag==@lists.linux.dev
X-Gm-Message-State: AOJu0YySQvKKcxKkT3ET5x7JqONeuQ7/jo3DHbt+KNw9WzFcwMMAw6O3
	VMIpJ28xkWXdKOxdFiI1tt92IHxf1o116aFrKNuKr8dKFBkA7vrq
X-Google-Smtp-Source: AGHT+IGkiZVGShX0cNi+6EQ+b3HmkSKFDA5Zw7fxes8vn2v7cYypiVQFXqAdhtgXUN2x/ewlPt0doA==
X-Received: by 2002:a17:902:e752:b0:1fb:701b:7298 with SMTP id d9443c01a7336-205841ba17emr96382505ad.32.1725413307103;
        Tue, 03 Sep 2024 18:28:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95a51csm4067425ad.117.2024.09.03.18.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 18:28:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c51a7a9e-5d37-4c30-b1e5-c873cfb64cd5@roeck-us.net>
Date: Tue, 3 Sep 2024 18:28:24 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/tests/vaddr-kunit: don't use mas_lock for
 MM_MT_FLAGS-initialized maple tree
To: SeongJae Park <sj@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>, damon@lists.linux.dev, linux-mm@kvack.org,
 kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240904005815.1388-1-sj@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240904005815.1388-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 17:58, SeongJae Park wrote:
> On Tue, 3 Sep 2024 20:48:53 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> 
>> * SeongJae Park <sj@kernel.org> [240903 20:45]:
>>> damon_test_three_regions_in_vmas() initializes a maple tree with
>>> MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
>>> mt_lock of the maple tree will not be used.  And therefore the maple
>>> tree initialization code skips initialization of the mt_lock.  However,
>>> __link_vmas(), which adds vmas for test to the maple tree, uses the
>>> mt_lock.  In other words, the uninitialized spinlock is used.  The
>>> problem becomes celar when spinlock debugging is turned on, since it

Just in case you need to resend: s/celar/clear/

>>> reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
>>> as promised.
>>
>> You can't do this, lockdep will tell you this is wrong.
> 
> Hmm, but lockdep was silence on my setup?
> 
>> We need a lock and to use the lock for writes.
> 
> This code is executed by a single-thread test code.  Do we still need the lock?
> 
>>
>> I'd suggest using different flags so the spinlock is used.
> 
> The reporter mentioned simply dropping MT_FLAGS_LOCK_EXTERN from the flags
> causes suspicious RCU usage message.  May I ask if you have a suggestion of
> better flags?
> 

Correct. I don't see those messages with your patch. From my perspective, this is

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

