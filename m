Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C81EF0A3
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737401009; cv=none; b=TBB5VSX1pXOhVYu/3opzvY9ADY/LsPj4e/wbBZdifEpyKKcS58rjpNgbAA/SwAnB6325p9KVINOIJ0VE0ujk/F1LlDl0l1ZVcX73DQl60abEfNqcjx1snx61GQ/xHV98+dJqBVjJ6xqrFZK/4eI2omwe404iB5vO6WJUMo1UhEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737401009; c=relaxed/simple;
	bh=1p+GE1pbn1YVwmlQsB1BHK2T0IB3/JkW9xgCXMokIr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUExG/4TBDdgbdKYMe8JJHgfCPrQky7N72z1G9QKiAie+rCb/92iZWN+r5wck3pJKxEXXiCSg9dX2CsytUKpgahR34hH6VYLqr2puD/7Rv8Rjw+CeEXyJxaHcOJlLxAHxur6JwE6jbm49zsLp0J/4NLTMRzX4narmOsPa+IcwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FjYepndu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjYepndu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737401006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g/Kot/CGWXdBkOcgzfuSXppZ8O3rmTLRkGTl8V+8sPE=;
	b=FjYepnduV16ArbTL5ic1KtaelSr5TPO6fSv+/K1YYDEAA1NxbmWdPnhNVtfX55elZWf+Pq
	5TiJyHPs+OU1U/yqEFJx5r95+j1QnxyhoOCxZn3gWeiPOEKb7uEosskFJNcKOxIhNA9qo5
	etR3Lp8UohNBqNLlVJnQqcE+adTyIV4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-xLBHIEspNhO1njTgCDHtOA-1; Mon, 20 Jan 2025 14:23:24 -0500
X-MC-Unique: xLBHIEspNhO1njTgCDHtOA-1
X-Mimecast-MFC-AGG-ID: xLBHIEspNhO1njTgCDHtOA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3860bc1d4f1so3066835f8f.2
        for <damon@lists.linux.dev>; Mon, 20 Jan 2025 11:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737401003; x=1738005803;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g/Kot/CGWXdBkOcgzfuSXppZ8O3rmTLRkGTl8V+8sPE=;
        b=dS+0YlzvoJx0BC5BEBwH2yF70BKE6NYcWilstmyWyRnpITFBR80/hRMemzQ1xIomqV
         mNhdwIjlXCkjrLWYZn90pSCs4n/87Jbii1jMmsAC8/5Rb4rP5zasspaPLZnhL1+E1qbe
         MvXT6KTwNlUw465wG7avLmBHGOjbjmHUJGdk/2puqtMknnONUQZmfZGKFiT5LCMLUyCc
         pkx9hLLVr5KlqftHnUPfpJYqx7bGV9PiKStJ51O1gIexezggNywXIiUjUaA3SWRwymd3
         v2Cjo6544S5J1cuXARcXPQwOPFj9YVWiRw31x9KoaQEYB5O1CM+rxCiqUGToEqL3FM1j
         47iA==
X-Forwarded-Encrypted: i=1; AJvYcCUyWZhtlRiRWEa1yc3AUQoUiHEM/UzSITazEID565725Mqxdwrr2uaX1jdlYonmV/M5RASZUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBOflHfeLGVJLvBIH6RpaR5y+PP4kQQWIf9DX1xJAT1WpNn5js
	TGZIk2QkQECzcDjqjbPKmNe/WQbds7kZSMj2B7v59hKu9eW1gh1QtL3mkTb++6y/kgUdKb8RpS1
	goCDW0TseVKexcZXEBslaSzAVaNWLhpvobBtonGSLfMbNrJ3Y/Rssz9KgxMQk
X-Gm-Gg: ASbGncu2c/4uCQkDM7EpSyfbW48nMUjduywY816Z4L8EQilc5FCuGmF2AnvMhzxGyvg
	np7LFt34LAv2O6VeQkMgDeYVgN4RyWmt2N8Ck2rkxPGlNzrpuvVCo2b19Gki2LKvx0UVrlrjGno
	LmxEuk7TwmZELJvUYdJCsO+XaOnvguO1eyDp8Urv1Llr3ih3DaeCypnwXFjmAHknkpOW0R2XdWp
	3FAu1Wkkgt5aE39SpR1Iptogqn9Oj/nWa8I80ysBlk5X+zfxhLbZbfu/YakdeaqyJGvccuRQOQX
	H6VYnEmeta9Z3JUm9fcuevXedL7QpcR/5hY1FhppfZRxg22PTlGsXI9FPrzhMuitheB0OZvTYO0
	AAFcccLb6HITGqIeLkD12cg==
X-Received: by 2002:a5d:5f8c:0:b0:38a:873f:e31f with SMTP id ffacd0b85a97d-38bf5677ca4mr11799276f8f.1.1737401003577;
        Mon, 20 Jan 2025 11:23:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQYuFKcdC9xIlhDBXl6f5gjSAKXxEvjwcJY1WwcbTeTdkTYQiMJYO8oYApnw9Z8X+IB29t7A==
X-Received: by 2002:a5d:5f8c:0:b0:38a:873f:e31f with SMTP id ffacd0b85a97d-38bf5677ca4mr11799256f8f.1.1737401003014;
        Mon, 20 Jan 2025 11:23:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c72e:e400:431d:9c08:5611:693c? (p200300cbc72ee400431d9c085611693c.dip0.t-ipconnect.de. [2003:cb:c72e:e400:431d:9c08:5611:693c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bfeb391ffsm8963906f8f.63.2025.01.20.11.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 11:23:21 -0800 (PST)
Message-ID: <ac40d2ef-a4e8-4b0a-a213-90296eb92dd9@redhat.com>
Date: Mon, 20 Jan 2025 20:23:20 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm/damon: introduce DAMOS filter type hugepage
To: SeongJae Park <sj@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
 damon@lists.linux.dev, linux-mm@kvack.org
References: <20250120191654.38420-1-sj@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250120191654.38420-1-sj@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ws9gb8jmIVOl5NjhaoM0GtCjZ3cH94V2j0UFDUwDWTU_1737401003
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.01.25 20:16, SeongJae Park wrote:
> On Mon, 20 Jan 2025 19:57:10 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 20.01.25 19:19, Usama Arif wrote:
>>> This is to gather statistics to check if memory regions of specific
>>> access tempratures are backed by hugepages. This includes both THPs
>>> and hugetlbfs.
>>> This filter can help to observe and prove the effectivenes of
>>> different schemes for shrinking/collapsing hugepages.
>>>
>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>> ---
>>> v2 -> v3:
>>> - expose hugepage via sysfs even if the kernel is
>>>     built without hugepage support. DAMON will just
>>>     just return 0. (SJ Park)
>>>
>>> v1 -> v2:
>>> - Wrap DAMOS_FILTER_TYPE_HUGEPAGE case with
>>>     CONFIG_PGTABLE_HAS_HUGE_LEAVES (SJ Park)
>>> ---
>>>    include/linux/damon.h    | 2 ++
>>>    mm/damon/paddr.c         | 5 +++++
>>>    mm/damon/sysfs-schemes.c | 1 +
>>>    3 files changed, 8 insertions(+)
>>>
>>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>>> index af525252b853..1d94d7d88b36 100644
>>> --- a/include/linux/damon.h
>>> +++ b/include/linux/damon.h
>>> @@ -326,6 +326,7 @@ struct damos_stat {
>>>     * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
>>>     * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
>>>     * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
>>> + * @DAMOS_FILTER_TYPE_HUGEPAGE:	Page is part of a hugepage.
>>>     * @DAMOS_FILTER_TYPE_ADDR:	Address range.
>>>     * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
>>>     * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
>>> @@ -345,6 +346,7 @@ enum damos_filter_type {
>>>    	DAMOS_FILTER_TYPE_ANON,
>>>    	DAMOS_FILTER_TYPE_MEMCG,
>>>    	DAMOS_FILTER_TYPE_YOUNG,
>>> +	DAMOS_FILTER_TYPE_HUGEPAGE,
>>>    	DAMOS_FILTER_TYPE_ADDR,
>>>    	DAMOS_FILTER_TYPE_TARGET,
>>>    	NR_DAMOS_FILTER_TYPES,
>>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>>> index c0ccf4fade24..224308140441 100644
>>> --- a/mm/damon/paddr.c
>>> +++ b/mm/damon/paddr.c
>>> @@ -222,6 +222,11 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
>>>    		if (matched)
>>>    			damon_folio_mkold(folio);
>>>    		break;
>>> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
>>> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
>>> +		matched = folio_size(folio) == HPAGE_PMD_SIZE;
>>
>>
>> Can we directly embed in the name and the comments/docs that we are only
>> talking about PMD size (both, THP and hugetlb)?
>>
>> DAMOS_FILTER_TYPE_PMD_HUGEPAGE or sth. like that.
> 
> Nice suggestion, thank you!  And we might later add more filter types for
> different size huge pages.  What about extending this to handle more general
> case, though?  That is, we can let the filter receives a range of the folio
> size to match, like DAMOS_FILTER_TYPE_ADDR does.  Then, the filter could be
> used for any size of interest.

That would probably be future proof: either a range or explicitly 
specified sizes (ranges?).

-- 
Cheers,

David / dhildenb

