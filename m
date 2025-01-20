Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B9C14EC7E
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737403394; cv=none; b=oCHVJ+/WyDLHYm5zUVuIDxo5mPfzgSXjP+wOrgz5TuV3nbwPqyrF9Mzq7kPiAue+kQhQsyBPtiQkuTFEKf0xcKpgIPsM2/+163vmeV7CwW3GrQK6vJuUm2Q0h5V0Da3dO6H4iiXc0tFDzy2CdTDPbeiUGumUvlP7QSgFNLnAgLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737403394; c=relaxed/simple;
	bh=wvE4NJ/dgOymtA0patCc8S0g2MGgeZXWmJRR/pDkI4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mi/EbTTuLHAY5mk3U7ePTucJzpquGcgk+D3tYCDRGO57fI8ypw737I/hZACTaivoHCPe7/9rhlY8CULaJtvFXBQ9IiO6JDZ9JEt2rQQ+RUj0bi84pFGdF7luCI4vFUZvko0/63WdzGhnOwIyKCKNCc3XsDCBiGo6XYt+vFvtfKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAbz6uSk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAbz6uSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737403391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZFAY5uBJJnBWzNnEkK6XnydfXBF4X+nYIIy676o8zFY=;
	b=cAbz6uSkg6NfCl1NfiydCD+oZE9MrVbXlMgGLj70I0lmhPrE5jp4m1HOJ0huVoKSAwqrdp
	ZrNh1Sh9FtA9ed7nhtXES+h1E4jkXMA3fXq1xj3XP9fBotWeSvVTF+gBTNtvizYDDHXW8A
	mkGoltd2e7Kr60tdyiPy/kMf2kW62fo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-5GdmdKqfN32BJK4qi0GP3g-1; Mon, 20 Jan 2025 15:03:10 -0500
X-MC-Unique: 5GdmdKqfN32BJK4qi0GP3g-1
X-Mimecast-MFC-AGG-ID: 5GdmdKqfN32BJK4qi0GP3g
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38a2140a400so3745003f8f.0
        for <damon@lists.linux.dev>; Mon, 20 Jan 2025 12:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737403389; x=1738008189;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZFAY5uBJJnBWzNnEkK6XnydfXBF4X+nYIIy676o8zFY=;
        b=hjgSpq3oIUvccBIYMMBEDgo3waSJOC2NdFXIrrPp/P65232mnhGCBJgwrokECiavoJ
         9JWdH8o/0roZUffNuI8258nBBvFH3kAK6CR3HspWzKoUFyIrD3HHHWa/9LTVzlBXj/nz
         HT+Uevj1nVq9jzm52nHBiWwgAbX2U96lGYEd9fkybY+eMrp1DDNRk2h/aQ5QCskay8aC
         iRMOA7dJVf6srxY4GfvYioOK4+RwVQASiO4GK8E0VfkxEKlq1QM/eSos2TcnM+b0LOg5
         euhcIHsHevvPDkO688L0jOT4DlG4E5UM2ByaULrfX7iNMJfrErTQgo5Rl+2D75Egcrjm
         PeFg==
X-Forwarded-Encrypted: i=1; AJvYcCVIR3wTsOB0/Z5XxU23U5ngJ5kgbCrIJ4RSXFPUNx1Lx0U35Y7LcSkFFKb456+toyblDV0IaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YySgmee/58BN+E+XBp+RkUA0/Y31DDNDpMkWcVw7repm5GRmJNI
	vdGO969RnTHBzJEQEi1YQwjoc20MFXQ7kkc16HvPbny9F1BvIuMRpyFpwC0cDDqlwFVLg61WVmG
	iohWKOnJiaRDC0ETVLYK95QbDpkpDffX/Cg/pmmubB4HKecyAKKzF
X-Gm-Gg: ASbGncuuBbFt0XzCrT4UK/TnYJGlcpO5uhyd162CWAVDsJOKzD6ibTRb1EXw2jBPQrF
	CM6aPGW9brjHIXJ9BhPpZJZPs3qeRK5Z1egP39JsMj/1F4PtVOVFaUpwvC3dahN/8q3XocC26Y9
	K+VKqCBXYh7AeXQf2U1SIdlb6z0bkf+v7S1zWrEITE5uHRkFF3nPBHPTLSYosXQlBqniDrwMfQn
	wCxFV9E/tVAlRZbY6jREdLbra55IDFXCLCwAA97jz/jwFpQCIppZGOzVkVxNshkQW7lhxTogJ6I
	UwUXFbmX7tUG4lVD4MOuKQFbY1ZTpB4bgjjB+Zi0knFPWAsnVaU8QTDfzhPqSaSxOf51P+Pz+vi
	89gRCVFZXfVLMozWuGeuasQ==
X-Received: by 2002:a5d:5848:0:b0:385:e37a:2a56 with SMTP id ffacd0b85a97d-38bf57c0551mr13101359f8f.52.1737403388894;
        Mon, 20 Jan 2025 12:03:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3tIXVvaYDZzUGMIl9b8cUCq3X52IGYsbbdwLXmrBsQ70DS6pinYv9AFzYLBQBY4u2TAOhCA==
X-Received: by 2002:a5d:5848:0:b0:385:e37a:2a56 with SMTP id ffacd0b85a97d-38bf57c0551mr13101337f8f.52.1737403388551;
        Mon, 20 Jan 2025 12:03:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c72e:e400:431d:9c08:5611:693c? (p200300cbc72ee400431d9c085611693c.dip0.t-ipconnect.de. [2003:cb:c72e:e400:431d:9c08:5611:693c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389041fe29sm150701265e9.22.2025.01.20.12.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 12:03:07 -0800 (PST)
Message-ID: <6750d7d8-0b21-4f0b-88a6-c4c8ad98f9a4@redhat.com>
Date: Mon, 20 Jan 2025 21:03:05 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm/damon: introduce DAMOS filter type hugepage
To: Usama Arif <usamaarif642@gmail.com>, SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org
References: <20250120193015.38753-1-sj@kernel.org>
 <3b461f19-45b7-4e74-969d-1cdf4d324353@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3b461f19-45b7-4e74-969d-1cdf4d324353@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GVQ6a_MV3KHBZAkw-ukea7eVn1zVWQcmFgOY0keBBnw_1737403389
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.01.25 20:58, Usama Arif wrote:
> 
> 
> On 20/01/2025 19:30, SeongJae Park wrote:
>> On Mon, 20 Jan 2025 20:23:20 +0100 David Hildenbrand <david@redhat.com> wrote:
>>
>>> On 20.01.25 20:16, SeongJae Park wrote:
>>>> On Mon, 20 Jan 2025 19:57:10 +0100 David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>>> On 20.01.25 19:19, Usama Arif wrote:
>> [...]
>>>>>> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
>>>>>> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
>>>>>> +		matched = folio_size(folio) == HPAGE_PMD_SIZE;
>>>>>
>>>>>
>>>>> Can we directly embed in the name and the comments/docs that we are only
>>>>> talking about PMD size (both, THP and hugetlb)?
>>>>>
>>>>> DAMOS_FILTER_TYPE_PMD_HUGEPAGE or sth. like that.
>>>>
>>>> Nice suggestion, thank you!  And we might later add more filter types for
>>>> different size huge pages.  What about extending this to handle more general
>>>> case, though?  That is, we can let the filter receives a range of the folio
>>>> size to match, like DAMOS_FILTER_TYPE_ADDR does.  Then, the filter could be
>>>> used for any size of interest.
>>>
>>> That would probably be future proof: either a range or explicitly
>>> specified sizes (ranges?).
>>
>> DAMON supports installing multiple DAMOS filters.  So multiple DAMOS filters
>> that each matching single range can be used for the multiple sizes or ranges
>> use case.
>>
>>
> 
> Does creating something like schemes/<N>/access_pattern/page_size/{min,max}
> sound good? with the default value being pmd size?

"page_size" might be misleading. Not sure if we want to use the word 
"folio_size" here, so far it's more an internal detail that evolved from 
compound pages.

"hugepage_size" would at least match /sys/kernel/mm/hugepages/ and 
/sys/kernel/mm/transparent_hugepage/.

But if you would also support "single page" == e.g., 4K, "hugepage" 
would be wrong.

-- 
Cheers,

David / dhildenb

