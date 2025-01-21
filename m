Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D64185920
	for <damon@lists.linux.dev>; Tue, 21 Jan 2025 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737484751; cv=none; b=YpYaQso6pkstQbZArkiE160iKYgZJZQvoBFso1ouZ4n1G38cqszKGXjS1iTCNjmQttSuRO91Y0v1pGwmp2qpjqPMmkcns+dCANAv5zv2szD37QaaHC7CzYXryMyTPS3xHIxBMQwiiDCfDRrPKvh7Y9251VH9ju93Z3BC4X3OcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737484751; c=relaxed/simple;
	bh=HAZwCAFBlvDYjZlU7jDBhtOuszzo9c8jY4JFh1riTNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOSDv7SbCu+Jqwk/0rtX7YBl5hIMHemYyr/M2/nEd6nplNereZ0fuvRRTYey8+6FdzGqX4t/HWjVEf6ITyRyy59cl5NTLNneSK98azMWEUXJafYlLRXx3rDZwJ+ga7DbxbcWPdBLfoxoHj6IxNWhHcCQjCJY4qyW5RYt6kuzsPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMBFwzq5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMBFwzq5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737484748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H4N4JMCG9++GTpITpYBzd8Vd01mtwfNvPlcVMGG/Lpc=;
	b=aMBFwzq5IR+C5vaKKpi4w6Fi2gBgJktyLKc4nkA4d6vFtStgTC06hQSqbpw7rSuc6/xEsg
	BuO+UW3P5BAj5Lz5Ndo+C95cCUFeTAOLDPEseB6xF+xZvS6hjU7IjXLz27X/9NhSrOFqmc
	tqFmFqtF5CNf4zGhqSIUm1gV2fxNbUs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-OcbMKYh7OCuS6qlQRCkhaQ-1; Tue, 21 Jan 2025 13:39:07 -0500
X-MC-Unique: OcbMKYh7OCuS6qlQRCkhaQ-1
X-Mimecast-MFC-AGG-ID: OcbMKYh7OCuS6qlQRCkhaQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385d52591d6so15214f8f.1
        for <damon@lists.linux.dev>; Tue, 21 Jan 2025 10:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737484744; x=1738089544;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H4N4JMCG9++GTpITpYBzd8Vd01mtwfNvPlcVMGG/Lpc=;
        b=BJMUnW60HHo/zCx+fR2GFESum5cjkJL+0Fs3I9zbT/XIBJfJD8gqv7lCoch2FrGG2r
         sH4tUmoono+DMxzkpH/KzrU8l16201Wv12jJE21yqx29RzJd/UmOYdhI3vxftOhgbQ58
         fPND6mGufSwOx1uC4U6r/gsqk6hVOic+TdJFsyQ95WLrUGAKs7sUEYFsPZQcKfUzYmKP
         htpOkNq2FEY8CAglPUi9F3bW1i7pVoy1j9/vstfDaaD1F8uWq43lonnosS09t/vTQ1jz
         +JyEOW7/Naaod8zg66S+RMymvKFy7q+GdphEyiqqpsw3No5Rv+KtcWTl9ZXgP8igk1Cs
         d08Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+YafG2J/P5f+H7+Zo4ID5NHHFNiglAx/8gTXt2tO9LytsRgzvEwdpJe3vq5KNwj/Q3emISw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0j9BlB93P6f3KeqscxCWMNbLLfi4ZKZh4Qaq6AGFNhiA6KCtR
	D8ZkOCnAHoiaaYtJsV9ToDvwRFCd8ApZ499/ycPYxQ3WCQ97dxDzsnf5yCfW/Bqe3jlbfBG5YMa
	i3MN/FvdQXNZ8AxFvLaAGWV69QccXg4DcJy2p73pS9y385+vBQtGm
X-Gm-Gg: ASbGnctvKoF0a8iF71fhwxQxDw1R7gJSkxdZtMp8DxWA7YeiLNdyFNcOCL+R4sw6vAW
	LuQ9Kq3JuZRPiQk2C/bMOKeuEY90UvTr7fdj0LFJkPSWnwCXplIoC5rLeLw5+spKsstjoPp58XC
	TH3Bp4dCuR0zK4iulpP16oqdV5zV4PQSjHsXT40NVG2uW8qKmGUr5Ac+uld29Ekoj3D7Q3Fxf6d
	6M6m1GC+dNIj78zOE8LXnqneZID0fLezHORormCcPUNDQHsvAH1NP3Pqp5eIvRaFsRLvyzH3C60
	ZaZRvdp651Y8iEKa7TN3oyHTIhDvGGeCUqdHLlxx3mmYMkRIplhDKt3ZcgSGna4+2EdlAk44vh3
	gH7Au34KyFWfXHzu6KafLwg==
X-Received: by 2002:a5d:5f4d:0:b0:38a:a117:3db0 with SMTP id ffacd0b85a97d-38bec4f5f5bmr19777257f8f.3.1737484744516;
        Tue, 21 Jan 2025 10:39:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWiaT66IYOwIFvcUglTIiyBPRnrtA9D0AyrHekT9SYse7BCB3BF1lX3piBTGBLvjSmLPIYMQ==
X-Received: by 2002:a5d:5f4d:0:b0:38a:a117:3db0 with SMTP id ffacd0b85a97d-38bec4f5f5bmr19777250f8f.3.1737484744174;
        Tue, 21 Jan 2025 10:39:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:6200:16ba:af70:999d:6a1a? (p200300cbc709620016baaf70999d6a1a.dip0.t-ipconnect.de. [2003:cb:c709:6200:16ba:af70:999d:6a1a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327556dsm14108133f8f.71.2025.01.21.10.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 10:39:02 -0800 (PST)
Message-ID: <c2fad5c2-8929-456d-a6f9-286478b93372@redhat.com>
Date: Tue, 21 Jan 2025 19:39:01 +0100
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
References: <20250121175259.42535-1-sj@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250121175259.42535-1-sj@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ejWB271dna34UBx1BuGH6DXByiRYA2s6zZ24uWXOtOA_1737484744
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.01.25 18:52, SeongJae Park wrote:
> On Mon, 20 Jan 2025 21:03:05 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 20.01.25 20:58, Usama Arif wrote:
>>>
>>>
>>> On 20/01/2025 19:30, SeongJae Park wrote:
>>>> On Mon, 20 Jan 2025 20:23:20 +0100 David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>>> On 20.01.25 20:16, SeongJae Park wrote:
>>>>>> On Mon, 20 Jan 2025 19:57:10 +0100 David Hildenbrand <david@redhat.com> wrote:
>>>>>>
>>>>>>> On 20.01.25 19:19, Usama Arif wrote:
>>>> [...]
>>>>>>>> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
>>>>>>>> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
>>>>>>>> +		matched = folio_size(folio) == HPAGE_PMD_SIZE;
>>>>>>>
>>>>>>>
>>>>>>> Can we directly embed in the name and the comments/docs that we are only
>>>>>>> talking about PMD size (both, THP and hugetlb)?
>>>>>>>
>>>>>>> DAMOS_FILTER_TYPE_PMD_HUGEPAGE or sth. like that.
>>>>>>
>>>>>> Nice suggestion, thank you!  And we might later add more filter types for
>>>>>> different size huge pages.  What about extending this to handle more general
>>>>>> case, though?  That is, we can let the filter receives a range of the folio
>>>>>> size to match, like DAMOS_FILTER_TYPE_ADDR does.  Then, the filter could be
>>>>>> used for any size of interest.
>>>>>
>>>>> That would probably be future proof: either a range or explicitly
>>>>> specified sizes (ranges?).
>>>>
>>>> DAMON supports installing multiple DAMOS filters.  So multiple DAMOS filters
>>>> that each matching single range can be used for the multiple sizes or ranges
>>>> use case.
>>>>
>>>>
>>>
>>> Does creating something like schemes/<N>/access_pattern/page_size/{min,max}
>>> sound good? with the default value being pmd size?
>>
>> "page_size" might be misleading.
> 
> Good point.  I'm suggesting to add the files on another directory, and
> apparently Usama agrees[1].  So the term "page_size" will not be used.
> 
>> Not sure if we want to use the word
>> "folio_size" here, so far it's more an internal detail that evolved from
>> compound pages.
>>
>> "hugepage_size" would at least match /sys/kernel/mm/hugepages/ and
>> /sys/kernel/mm/transparent_hugepage/.
>>
>> But if you would also support "single page" == e.g., 4K, "hugepage"
>> would be wrong.
> 
> Again, nice points, thank you for letting us aware of this.  We could error
> users if they try to set <=PAGE_SIZE filter range.  FYI, DAMOS filters supports
> making the filtering in/out action for not only condition-matching memory, but
> also not-matching memory, so it will still be able to be used for filtering
> in/out base pages.
> 
> That said, I now think "folio_size" might be a better term that allows simple
> implementation and flexible usages.

The issue with "folio" is that it is mostly a kernel-internal name for 
how we currently manage metadata for all pages and compound pages. In 
the future, some of what we call folio today will no longer be called 
folios ... as soon as we dynamically allocate "struct folio".

-- 
Cheers,

David / dhildenb

