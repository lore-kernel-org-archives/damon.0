Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE31C5D5D
	for <damon@lists.linux.dev>; Mon, 13 Jan 2025 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794417; cv=none; b=iUGdmeo7zK+9TXrv/XIuQ53LRoXCNHuW5LiL/VTfx84NTvQNq7Xz/Oaodwt9ShNg+6zGw5n3y+tsagQa//NorAiJYhVd4K9BdZ7FP7haX795t1KnLXNcpNv0udm1AiI5Ycx/3Uz648zjOWAInuzOs3LFu3CKMfzg5KNS6bJFxi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794417; c=relaxed/simple;
	bh=g6YINDG+716vImUwUonRcxfdfGGX2/B/eJsuVqmH+F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmQ8m8oTax0Ic3AUrjn7GoKbVrfBu33CDQRnXSNZrM7zeC3a4e8nEb5FsZFhHpPuZY/lXnMwrF+I0uXpIQGqGiTzJFZZsQmbMBbLNebVCqSW0zvwOax+tQGFD1oK8JAP4t2tZW9uyrxmvJ2bkdT2ijDJvcK8n/vSAbYypuYMqwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Usu2a8Op; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Usu2a8Op"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so9096161a12.2
        for <damon@lists.linux.dev>; Mon, 13 Jan 2025 10:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736794414; x=1737399214; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHwy506ywMnWLFewHx9NlRl+DZeju55iSaEizXgDMzc=;
        b=Usu2a8OpXaVbZUgFaZCjtBMBuSRIZTlxx/u/hD2JJpsN7Snr4may0jXdkA0cYAww9Y
         h1BBtZgVpAMdppHysgcZIVSa21yhOCXryakLsWrUlnrSlq+Fthio5RgvqNH1YNDDMNle
         da2AAbXJowh+KfedlFFtvEMzV0rhIK/xMWwICgl1/uvlV7HdU1qpb8yKxNTMVJm9eVSH
         fxbT5UQAYgx7mLcsqIEPjn5uG5QBdTMupw+R3WyoNsjHM0auA4DeuOiPaRKWBABfj4ia
         ol1U6xKj/frptq1CV5eB4zi1NirwbeYw//C+0s50+ufEI5TNck2KWvMBconiAdPCRMIJ
         rqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736794414; x=1737399214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHwy506ywMnWLFewHx9NlRl+DZeju55iSaEizXgDMzc=;
        b=MGz0VDtknxlsE9dffm6iX02HxEq+Jz8DiTpjvhSfH6iFQYUjDS7V4/GhlR0E93j4Aj
         H6Spq7BrWYasd4ueszVsaAAEPyDWjx5wNHCfvokfYZww2iGuCW8+YAqP1mYeKOepFI4M
         R+a5SiUmbWlBb0jDb390T5vNjXRavJhLd3ipzyCMdWDqBaGTwO83rUf2oQOvLUrFesWr
         VifxE4jMDlKkvswq1jkEeTYFMmT8w2IFizcdDdUZzUVGibaltC1JqppaoLSauA7B/Ljv
         b9t90l30POkPWBEJwQWQwoGTHwgR39XjYZna4yTINRoJuvl3mhXLg0cqIIxv7YwBjLNR
         GP4w==
X-Forwarded-Encrypted: i=1; AJvYcCV3d+N5rJHzg24I6KugRrkFwhSC9DQyD/g42BQGJTD+G4IwHqeOqd0HBfP6cPa2LKMUeq+EJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOathI05WoMqoG+4j1KC9NabMYQ/uvXLenLwleyYdthfbVJ0X6
	R/zlIhc4HzxlEEuxmj8o/Qiu/8K0vH3kfjuONpwYW2OhzzVu8yXE
X-Gm-Gg: ASbGncusV+yiEJuLNnu2swqVsMTAF+Rgf2aWDf4BJOcc+ol2Rw8jMBKgDVQcE/qCxeF
	xg2YlqsBAkYCgr/tidopfztWkCpdfndCHqAYCaq47YSpCnbCCqVjXC82EjL9/gWrO5Nzulz7l7x
	HOgDNpreUvqV2bEHt9n4Y1BpYE97blm4k6+3b0pkky+xT4vZpPAg0YYnigOivjdDMM3zPAAgcTZ
	ghplwto/mhI2uZOJe9qQK/+4dplkxuFjJ9INHw5QUQisL7ViMKSc2X2UPuHHPb5F2IWyyOZ476P
	K1X8UHKM7Z2c72+7AeZMEhUnGTOz
X-Google-Smtp-Source: AGHT+IFmLTSmhZiZC2D7ryiDKtNfefi43ec+L4XFmdgc83SneV6j0ppP8sm+x0Clrb9Won8aQh0UkA==
X-Received: by 2002:a05:6402:5244:b0:5d0:8197:7ab3 with SMTP id 4fb4d7f45d1cf-5d972dfb878mr20621516a12.3.1736794413796;
        Mon, 13 Jan 2025 10:53:33 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::6:97ef])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9904a4d49sm5026269a12.78.2025.01.13.10.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 10:53:33 -0800 (PST)
Message-ID: <8892b42c-3363-4fdf-ad3c-4bbd2a0a801b@gmail.com>
Date: Mon, 13 Jan 2025 18:53:32 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon: increment pa_stat damon address range by folio
 size
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org
References: <20250113184311.6572-1-sj@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250113184311.6572-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/01/2025 18:43, SeongJae Park wrote:
> Hi Usama,
> 
> 
> Let's use "mm/damon/paddr: " prefix for the patch title, to be more consistent
> with others.
> 
> On Mon, 13 Jan 2025 18:03:40 +0000 Usama Arif <usamaarif642@gmail.com> wrote:
> 
>> This is to take into account for folios with size > 1 page.
>> Iterating at PAGE_SIZE increment would increment sz_filter_passed
>> multiple times for the same folio by folio_size, providing incorrect
>> stats.
> 
> damon_get_folio() returns NULL if the page is a tail page.  Hence I think it
> will not increment sz_filter_passed multiple times?

ahh I didn't look at the definition of damon_get_folio! just assumed it will get
the folio irrespective of if its a tail page or not. Will change the commit message.

Just curious if returning NULL is what is expected by the user?
I see damon_get_folio used in a bunch a places. If the user limits damos action/
damon monitoring to a specific address range, and that covers some of the tail pages,
but not the head page, I guess the damos action wont be applied.
> 
>> Hence go through the folio only once.
> 
> I tink this is still nice to do, for more efficiency.  Can you post v2 of this
> patch after updating the commit message and addressing below comments?
> 
>>
>> Fixes: 6347f3385dd0 ("mm/damon/paddr: report filter-passed bytes back for DAMOS_STAT action")
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>  mm/damon/paddr.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>> index 6b4397de4199..cc789a97c6f5 100644
>> --- a/mm/damon/paddr.c
>> +++ b/mm/damon/paddr.c
>> @@ -504,7 +504,8 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
>>  	if (!damon_pa_scheme_has_filter(s))
>>  		return 0;
>>  
>> -	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
>> +	addr = r->ar.start;
>> +	while (addr < r->ar.end) {
>>  		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
>>  
>>  		if (!folio)
> 
> In this case, the code does "continue".  'addr' is not advanced, so it will
> result in an infinite loop.  Let's do 'addr += PAGE_SIZE' here, to avoid that.

Thanks! Will fix this in v2.
> 
>> @@ -515,6 +516,7 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
>>  		else
>>  			*sz_filter_passed += folio_size(folio);
>>  put_folio:
>> +		addr += folio_size(folio);
>>  		folio_put(folio);
>>  	}
>>  	return 0;
>> -- 
>> 2.43.5
> 
> 
> Thanks,
> SJ

