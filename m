Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA6F155A52
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737404766; cv=none; b=uKmxABr/xstLcXrgL3UbZUCD8aAiBSpYMJEBaaNBK/Oj1AAbRGyEbib1zfg7fYs+oM7kq0+WiHy6upbR7MM7zj+pRfa9DrfD8dmxSwlUS3plCkuF73i73rRRAK41smwmV0EpcvQNnqRK9Yy5S6VQN8BpIGhxlwFSoys00IZWKWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737404766; c=relaxed/simple;
	bh=XkpDu3+YU6JbRRB2GoQqXjCO0tAir9b9uY2OiDOsSlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYtkV4ijpdXFZIS8rbUh+LL2MYyX46O5wojRqgtmfsew4EzoaJxSeJ00pYOM6uXwlFSY+4io84koFiKWelEHY+AV0bdGZkfMb3DsyPy/1/h6IrriQeH74Oy6ue/aXWxJr/hUGt5UFqASuMa5N5+EZhjSBhHlXNak6D2u0ej5xNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmQMPWId; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmQMPWId"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-438a39e659cso14431735e9.2
        for <damon@lists.linux.dev>; Mon, 20 Jan 2025 12:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737404763; x=1738009563; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K90lPeUvBJneY39a6ms9QUtd7QCTn8VA5QvcFc8yXKI=;
        b=LmQMPWIdmqCdmAKtHsCk7eI8NXG0MifDeRrq2pP5n3zjGZMDG1DaUwVSzX8CDLPjle
         kv1G+dlSHJ5EK/rmpt1AQi6ZaGabIifivMOCvMqGuXcUNOOtWZD6/Ed7w64B3hbNXh2k
         OZBBtdcyEbXIHs2o3hNcYUwW+2vmu6XPBn3tNbPoujt9u78igpy0XwOq1UHK0TBpPEFb
         wFL5LLvi8GMDYMKbmVFRgxMWjjN+ZUcJpTuo/3rb6zGlmz8gtCkh7/Pl2WStpIaxgTEj
         T2hzFn2AxSeOqKDYb77RklznIh0uMA2OUFYuJgs4p7Hhil9KVCmXjHZpzo5Pt2iBcB3v
         uVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737404763; x=1738009563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K90lPeUvBJneY39a6ms9QUtd7QCTn8VA5QvcFc8yXKI=;
        b=owUeHn0X+GzKnz85DBgsA1LLeXILsRq/hRVbNC7SNwTJ6M1bVOFfqNUMbtoZHVLl44
         UoJJLQiPug7bi4qe4/eljeQ2749YI+QwyGj+Xt6/JoombPHIMu2gFp0NdnquJaoabzfg
         PfggPhMr7yusw8N4ir5AcueqYkY7+tzosE3bzTrR9Uk0jrpl2wOPWyP/q4Zsh5ECE7Cg
         x9gLcpnRsa1jBZtX+LnHUnmvEJmweNyEz0qQ4MXLWWkJiaL4X+2qRAdmNwFXcmEMEsSr
         JkNhoemb1Z1UrjQZw0x/veAE2BdKAOX23LCq7wnpITlYgye4KnTROS1pWol6A07sdaTI
         4CIA==
X-Forwarded-Encrypted: i=1; AJvYcCXzDvDMMkErENlgvXNIBDes/x2jW6LoQFzRqBsE3m9kfqDTHWakNJgc5xmsqg3hnPLJkLpwpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdNVwEPbuf7DAEH76WqgftYm9jpxWyz3B4LjFw7W+Np9Qxtaja
	+pGZj2vz8LQkA0ps8bAO/gVFDU2z6NL8jIPLCMzhF1Qvh89dtyQn
X-Gm-Gg: ASbGncuw1+I/09l/FFp9LkI4K8j6u/0y0ULr49mT2K/AKFXpTaQF1x5AIQik2QbbZnx
	1VjUdobpWzW7Gr47QTw5TE0EGudsglPDM1PnrwWCeU9uAHUT6orRgACKMPMU6MRr9PpTNlYKD5z
	b3+FWBCmPZ/IIRZVYFjuj58eaixHQgteL7fN5My84pZdo4JzUsKSdVYtFfeOzGDEnHfNr8Ey8h/
	fbnQoAnu01apMghbIJNH1LRGUnEr/sCFSdgACYnPqGhr3NPaD8i1E/zw7w9aDX/q/VIcB1J/BnL
	9Du50/xT+WZH4e+TkMQZxp21NBjEAjhNxhEHssN4/f+wwvDEjuAOZWuaRjixbv8=
X-Google-Smtp-Source: AGHT+IE7G9kaJtUwQ5Nx55TkSuYnm7LDajiB+/PDfQ5/5xksw22pUJIccdOZ65F2pHINNIQVG+d/6w==
X-Received: by 2002:a05:600c:4e07:b0:434:a802:e99a with SMTP id 5b1f17b1804b1-438913bec32mr132393255e9.4.1737404762807;
        Mon, 20 Jan 2025 12:26:02 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d752:5f00:c46:86ac:45ea:7590? ([2a02:6b67:d752:5f00:c46:86ac:45ea:7590])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7525ee9sm210058125e9.32.2025.01.20.12.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 12:26:02 -0800 (PST)
Message-ID: <db16fc35-58e7-453d-9fbb-318a88a98cd1@gmail.com>
Date: Mon, 20 Jan 2025 20:26:02 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm/damon: introduce DAMOS filter type hugepage
To: SeongJae Park <sj@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 damon@lists.linux.dev, linux-mm@kvack.org
References: <20250120201214.39533-1-sj@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250120201214.39533-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/01/2025 20:12, SeongJae Park wrote:
> On Mon, 20 Jan 2025 19:58:24 +0000 Usama Arif <usamaarif642@gmail.com> wrote:
> 
>>
>>
>> On 20/01/2025 19:30, SeongJae Park wrote:
>>> On Mon, 20 Jan 2025 20:23:20 +0100 David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> On 20.01.25 20:16, SeongJae Park wrote:
>>>>> On Mon, 20 Jan 2025 19:57:10 +0100 David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>>> On 20.01.25 19:19, Usama Arif wrote:
>>> [...]
>>>>>>> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
>>>>>>> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
>>>>>>> +		matched = folio_size(folio) == HPAGE_PMD_SIZE;
>>>>>>
>>>>>>
>>>>>> Can we directly embed in the name and the comments/docs that we are only
>>>>>> talking about PMD size (both, THP and hugetlb)?
>>>>>>
>>>>>> DAMOS_FILTER_TYPE_PMD_HUGEPAGE or sth. like that.
>>>>>
>>>>> Nice suggestion, thank you!  And we might later add more filter types for
>>>>> different size huge pages.  What about extending this to handle more general
>>>>> case, though?  That is, we can let the filter receives a range of the folio
>>>>> size to match, like DAMOS_FILTER_TYPE_ADDR does.  Then, the filter could be
>>>>> used for any size of interest.
>>>>
>>>> That would probably be future proof: either a range or explicitly 
>>>> specified sizes (ranges?).
>>>
>>> DAMON supports installing multiple DAMOS filters.  So multiple DAMOS filters
>>> that each matching single range can be used for the multiple sizes or ranges
>>> use case.
>>>
>>>
>>
>> Does creating something like schemes/<N>/access_pattern/page_size/{min,max}
>> sound good? with the default value being pmd size?
> 
> For user-space ABI, like DAMOS_FILTER_TYPE_ADDR, let's use
> 'schemes/<N>/filters/<F>/' directory.  File names 'min' and 'max' look good to
> me.
> 
> For kernel-space API, again, like DAMOS_FILTER_TYPE_ADDR, let's use the union
> in 'struct damos_filter'.
> 
> If you will do the extension together with this patch, I think the default
> value is not really needed.  It will only add a bit of complexity.  So if you
> will do so, I'd recommend not having the default value.
> 
> Also, if you will revise this patch series for the extension, could you please
> split and post the first patch of this series as a separate one?  I think the
> fix is important and has no reason to be tied with this patch.
> 

Yeah I think it might be best if we get a version with flexible folio sizes merged
from the start, especially as it involves creating user ABI. I will try and send
something tomorrow.

For the first patch, do I need to resend? Or maybe Andrew could merge whats in
this v3 for patch 1, we discard patch 2 and I just send the hugepage
filter implementation separately as a new series..
