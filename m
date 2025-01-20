Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CCB1E9900
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737403108; cv=none; b=KPlkHMjlHC3zcpRAxQq9vV61wfZWnpT92kPVzUeAiAb+z0Bu64dEYP5Qaj6FHt+dqrh3R2Jvm2SB8UnNx7PN9yCBKZKnmGpmhwsKYakJcHOiB+JkssiEvXRDUP1RZuexrFBesbI7ooR6dkRaTOuhtPsVLDDQ2ajvimZfPPqi0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737403108; c=relaxed/simple;
	bh=SpebInzmVuXCcIPyhmtFppjXQcZaXgzWDZ2sNSB3I/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+LumP8OfFpBYpVF5iOQEI1NysL0jEifWmHe6BO75Hjy0Dl9hHdeTBrgJjxfoqdZN6YO63C+lSY9BksQPCf1WzCTiYPIRH3hWrODs/GUrTkwgM6WyhxBCtexnAj4fZjjAK3U+5yy9g4YhlSviTH6DuJlzw2u4leRCDvyePrKR7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUWJCxsE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUWJCxsE"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361c705434so34753715e9.3
        for <damon@lists.linux.dev>; Mon, 20 Jan 2025 11:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737403105; x=1738007905; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eNwTgvblIXqUyPc7mK/O3md4cgLWoRIPuqtdilgqwyw=;
        b=MUWJCxsEz/k6dPzIuMPlQR1QBrSb6Nlor5NSckYRRPWQIPEqCJS+X2LKxrYCir3qc6
         YDv6gNc0d+P3sKTAfYo1dpRgOvWMOCjj0NJapykxCXIRarXCGfmE1ub8nLLvum5QmcKy
         i+dylkSWyuhkp16ozmhZwmmjigaFhY4KsTtKFuvh5FBG1PM2xyDDaaxF+BaK5T4ZYbqW
         ntzdCCs7V2iaYCPiT5grcpXXG3AL/mBI5CsEwS2odxzoq6ENvKH9wGI5lSbyubR2sJcF
         lhzBgYYmLvZhrlWqOz0r6AHaRpONEfuAfB0RqVFb8TrvCXwQ1FFIQeg4nEl16vcyOa5Y
         V6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737403105; x=1738007905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eNwTgvblIXqUyPc7mK/O3md4cgLWoRIPuqtdilgqwyw=;
        b=KOEwfL4xkkR9gz2pmILVSGafB3jft9mp7/zqf8hhCbVNxw+fH2TAFCVgu0dm8C13TM
         nE1IlJ/Bo9ybKpq3bKFsILYy5IxMgnkYyNGp2juLLpxhNGoVHaDPueQHJVAGWE5j0T2Q
         SAKaj1TFzfvo5P6nneJ1uXNEuLycktenfFuMoTehi1Zn6a16HkvfOzzYJ/ubDybQYIwG
         zwLLOG3AcY7ztaVdbCMzitHgPN1U1+qDJCbISwJUAbMk0Gp/Ns3OoPsGPOMD0rsTSG6N
         t0RI5nBxlHyOe8xx+fcHQiRAdKmWbbMf1UUn7uXUd1gDWPdkrg25tPjpO/A4snyCRV7P
         aNGA==
X-Forwarded-Encrypted: i=1; AJvYcCW+HltlNN49SuV72m/oUJP/bSKjI6DJjJPpHxlej6AdSKd1G3Pe76HvhnZnaSxjUriweVObCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+A+wBPsZpxTnx5Gz5iDadzgytxmFEOnM/+0zKVJqNES1TYNBR
	jRmFBeLBovSDAkhBc7yD88OckSDDMCqnV8dVXiuby2fDDzZRSllJ
X-Gm-Gg: ASbGncv1jZT1/BylozTn59wT86SLTvnkv5f86CcNTIUDVlXGTpU4F3pilnjXK87EAOy
	NbDqRANee0Q/X7shzQPVPFMNdJO/1pAqHeKLy/Q45CL45WF6J4jXLGus199+Xv1IJrvQsC1tIWx
	uMDey29cqdfjvN3HPS8ZK06tfR6nP3BGY5pw7PcDTo7mgeHqv9WEBUOl5KBsLo2cwMhOFb7vBFa
	oyjjtgAA8e9pCQpc/2QAaW422x8t7EQ6Eh9qEJ987a2MM0LKbkNcvnDUU0ncGUcpVdEbZmC/khG
	IU7jhLApv0QSK+VZBWEAk4w7Ieoh/4G4aonlyokrf12sNROVuO0Dy1qoxYk92fw=
X-Google-Smtp-Source: AGHT+IES1vFbC8JEv/m8I2R6/D+UPpqV5H59IGLii8I4aWuKOJjnIGt4yCCngYKpUZ3AjzL4SGrXog==
X-Received: by 2002:a05:600c:4f48:b0:42c:b16e:7a22 with SMTP id 5b1f17b1804b1-438913cb740mr147762525e9.12.1737403105265;
        Mon, 20 Jan 2025 11:58:25 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d752:5f00:c46:86ac:45ea:7590? ([2a02:6b67:d752:5f00:c46:86ac:45ea:7590])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c1664e8dsm164208845e9.1.2025.01.20.11.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 11:58:25 -0800 (PST)
Message-ID: <3b461f19-45b7-4e74-969d-1cdf4d324353@gmail.com>
Date: Mon, 20 Jan 2025 19:58:24 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm/damon: introduce DAMOS filter type hugepage
To: SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org
References: <20250120193015.38753-1-sj@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250120193015.38753-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/01/2025 19:30, SeongJae Park wrote:
> On Mon, 20 Jan 2025 20:23:20 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 20.01.25 20:16, SeongJae Park wrote:
>>> On Mon, 20 Jan 2025 19:57:10 +0100 David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> On 20.01.25 19:19, Usama Arif wrote:
> [...]
>>>>> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
>>>>> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
>>>>> +		matched = folio_size(folio) == HPAGE_PMD_SIZE;
>>>>
>>>>
>>>> Can we directly embed in the name and the comments/docs that we are only
>>>> talking about PMD size (both, THP and hugetlb)?
>>>>
>>>> DAMOS_FILTER_TYPE_PMD_HUGEPAGE or sth. like that.
>>>
>>> Nice suggestion, thank you!  And we might later add more filter types for
>>> different size huge pages.  What about extending this to handle more general
>>> case, though?  That is, we can let the filter receives a range of the folio
>>> size to match, like DAMOS_FILTER_TYPE_ADDR does.  Then, the filter could be
>>> used for any size of interest.
>>
>> That would probably be future proof: either a range or explicitly 
>> specified sizes (ranges?).
> 
> DAMON supports installing multiple DAMOS filters.  So multiple DAMOS filters
> that each matching single range can be used for the multiple sizes or ranges
> use case.
> 
> 

Does creating something like schemes/<N>/access_pattern/page_size/{min,max}
sound good? with the default value being pmd size?


