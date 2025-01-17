Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D11F7577
	for <damon@lists.linux.dev>; Fri, 17 Jan 2025 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111730; cv=none; b=ugS+jxsv67RwrFizdNrudv+i4mQ30CYEA/P7V+PZIUCTiUt85cSUbKoZNIfHLp0xbzazYUc2H5CKTe7sNvSCbsl6JRb0w9Q9vFAX+3wdIsqcDnU69K22vFbkWX8JwYQvAoCoXLqVd/a2fEGSLYmX+rU8DOeBEDLdxsjc0yw+e1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111730; c=relaxed/simple;
	bh=lw3CLYoKAEDlGPH5kMUNX09s884sp6/tTO9azdbJrOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJzG75FKS1BKnMYc4wvf6VUn4t+DXP4nQPSV0wrJdfOEXu+OapMekzhrUgj1HvD2tmgqvxdIycEsTNJtXhWp16I7uqBW4pxtXCmK/tKPDNgqHkx4EIq3QyQgFa5Wi5E6SehP9kpaVTfcg/liLj9LXhrjNJV71t/GHotBC5OkCBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Memq/Y91; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Memq/Y91"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so3394303a12.2
        for <damon@lists.linux.dev>; Fri, 17 Jan 2025 03:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737111727; x=1737716527; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EA5M3bAfFnzDsmtQjt8A8lchVa11A3dw+btjzntpGUM=;
        b=Memq/Y91Nbb/QZxeJp7PjzSDx8xQqAE55F9ty8Y9DiaM8d1bJsT/XNX6jiEx+PT04y
         GezEfFTBs1jh9TTlPo/Togb+flU83f/fY5eUTYxMh0vMayKfSal18PMB20/8gv0WYSTI
         FFNTlr1kfAjsb3HWmqKoeD9UVADy3NfouWUSHS56GtEshsLVLap7JjQy2UHFP+jQEspX
         QELzVwrJq/ucB8Nb+eI7lwuP/V+qUyyDHgGME698HebdMZwBPlYSf88u5feH7Us665Wp
         aUy6tDwpA/oSpyv/do8oxBQIqw9RfBaLdJrD/YOVmyXJ3KcVa2AWO4jK1qGzRKBBzKs9
         Y8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737111727; x=1737716527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EA5M3bAfFnzDsmtQjt8A8lchVa11A3dw+btjzntpGUM=;
        b=NB1+BkLPNe6WK7zybimD9xdNt+pd7lrqvR4+8vNCqjgkR157njHyz+VBqYg5vyopli
         8up2AlPEcLhumFkP62z09VxmMZ+4/c+NZfbMLTN95wc45ckVppF+CItQp4cmN7N92OEG
         j4XnWpo3sJAiToND406QdCjVkOQKhRz2+Y2eKS+UsHOYzVCUfTk9symH2tdNKXANCsyU
         NwXaJeTu1xISBQSy9u4aZcdikdOw08QRcxzAz+SxnIih6QELK54AkUtduqgiVRbWYU/8
         0/0OUp/Nn0/++Sa9XitZ3I/QgTpvJqVM+uF1PeMcXt392ZShHOGtywnQSmdpWXwCWJmQ
         I2xw==
X-Forwarded-Encrypted: i=1; AJvYcCVCAQUPgl+jzyUXh7BfV4wkovBOZL/rUXUG6DSjVtSRynnh2aN0rB9imzFEW6EEhgbLABCG/g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzb2vJzu5k8+1dYW6obc7Z5Aj/ckuf4kwidBZwZGAGcfp32hHGJ
	fnd8EtDLpgDGz2P7Tjbv8jL9jisvz7gC66ayC/d2zv212pbhM+Rj
X-Gm-Gg: ASbGnctb/MIeumPUPdk8KiGLitXFOJk67DlQrrEwoRfJhR+JbwoBlSgzfAxnSbVJYtX
	K26dRiOEgwUumTr9jiwz+GtlrG8jHFnhKKWT20zhQ/TyQR0Gn1ghcL2yqDm3X2HcIw70auH7ETT
	jwBlnwL4IR+u5RmNPGL6Ef3rZy5/IiFsMsbqpt8tpcd9fmALhQtvGOKbRlXLuiKX/WibppdVvag
	TspFCICDNqUCb9YMNCJsmKIgybFDcWhQ4PFhfc5mkNm4lewc+xF5hRVBh84oeLuoO391xgSGIHX
	fFoDltm5HWr6R05AoGYBLfLB0tc=
X-Google-Smtp-Source: AGHT+IEGC1ZgARi46+pC7dCZTldk4y179bi/5kRfniOiHqeArKAwsMI4uPcGua64Xo+9gL6bJpqkzw==
X-Received: by 2002:a17:907:1b1b:b0:aac:619:e914 with SMTP id a640c23a62f3a-ab38b10cf76mr214477366b.16.1737111726555;
        Fri, 17 Jan 2025 03:02:06 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::7:c5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f87d7bsm149916266b.128.2025.01.17.03.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 03:02:06 -0800 (PST)
Message-ID: <cc2aa18d-c494-4b50-b695-3cb84a1ee87c@gmail.com>
Date: Fri, 17 Jan 2025 11:02:05 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 2/2] mm/damon: introduce DAMOS filter type hugepage
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org
References: <20250116190538.60331-1-sj@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250116190538.60331-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 16/01/2025 19:05, SeongJae Park wrote:
> On Thu, 16 Jan 2025 14:44:36 +0000 Usama Arif <usamaarif642@gmail.com> wrote:
> 
>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>> index c0ccf4fade24..a9e69179d45c 100644
>> --- a/mm/damon/paddr.c
>> +++ b/mm/damon/paddr.c
>> @@ -222,6 +222,9 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
>>  		if (matched)
>>  			damon_folio_mkold(folio);
>>  		break;
>> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
>> +		matched = folio_size(folio) == HPAGE_PMD_SIZE;
>> +		break;
> 
> This will make build fails when CONFIG_PGTABLE_HAS_HUGE_LEAVES is not set, like
> below:
> 
>  /include/linux/compiler_types.h:542:45: error: call to ‘__compiletime_assert_321’ declared with attribute error: BUILD_BUG failed
>    542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |                                             ^
> [...]
>  /include/linux/huge_mm.h:111:35: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
>    111 | #define HPAGE_PMD_SIZE  ((1UL) << HPAGE_PMD_SHIFT)
>        |                                   ^~~~~~~~~~~~~~~
>  /mm/damon/paddr.c:321:48: note: in expansion of macro ‘HPAGE_PMD_SIZE’
>    321 |                 matched = folio_size(folio) == HPAGE_PMD_SIZE;
>        |                                                ^~~~~~~~~~~~~~
> 
> 
> This simple test might help you reproducing it:
> https://github.com/damonitor/damon-tests/blob/master/corr/tests/build_i386.sh
> 
> What about enclosing the entire case with
> 
>     #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLB_PAGE) ?
> 

Ah Thanks for pointing this out! Would 

#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)

be better?


