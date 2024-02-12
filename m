Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBD4C627
	for <damon@lists.linux.dev>; Mon, 12 Feb 2024 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768460; cv=none; b=gWANuSDve7Ujmzew/rN7PQBi5WC9WBw9ta1qMPWAHTBK7OT0CXgAmfweUXH2SgRS6lpeqJZzqtLVnnStbKtOLw2W9pR/sPfo2dAGjWU2jRnA709uI5OuPRc9myfmlmk3xkMujsJHfy4EHuc0SAusw5gd64eio+aZpLGuFm9KLqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768460; c=relaxed/simple;
	bh=tQQift5LfRYMBN5EkewDff6150iLifRgZR9xWKCnQZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWOoW+Am2RidqCak10nzWZ3nsrtZRBEGAvLUNbZ1RSiFDFDvUMvQ57lBXag/xiAZ6P6IQtLGXl0QLUtpn+r71z4TM/FxdepBcAITi1QcRM1jKOEVI4qfCjebO6L+5Pm+nPYLhtD30wF+7BKfr3k480Ug5+Cc2zxZIJMNAe6dEGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWpqE0x7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWpqE0x7"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so467914666b.1
        for <damon@lists.linux.dev>; Mon, 12 Feb 2024 12:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707768457; x=1708373257; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zs68NSeXbrdOJSL/Frd8RI1CL1CBaz7sRpwcD3iAyMo=;
        b=IWpqE0x7kUW1W5idgXqBuGBct+ey8qzsfbblrCeHJSs64KRgR8jy8nTSZsI26+q1oJ
         GhGh1aP6SKhOyQsPYKqqpeVCLZA+p2XBxdJ2runBFW7XOenq3tBWt7Rb+4bFveOuTg2i
         5BwKzzfU54QGNb3EPLr5L9Cbf7iFFYvRwVBpL2wi0zexIUA5NKwsQrQCrU7fZQC15LbA
         724uuoUURjmjNIJQrz03U+tpTo7koCZjhM8ZOEn+hRf6lHyd+ER4YmdpssauLchRTjV5
         KnVQtctdVNUtDjLxnmsTO1WkBaoV5YBHwnuD3YwiBbAGzVLx4SvC8g9g/aqEDryJp90d
         ZQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707768457; x=1708373257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zs68NSeXbrdOJSL/Frd8RI1CL1CBaz7sRpwcD3iAyMo=;
        b=jeQXuPWoEJ/u92y1fA2vPRrhj29VRaNSoi8En5bUxFjPBezkhxiS4XD0Ak7LwMsHc2
         +vG/YAItyXr8gxr8PgIONQh0ojPtosh7LwrR4/w2y25T/JdNK82TLFcyjIJR7tClhnG6
         zGEdcRZNsh809t1bI7ZZMnSZ6GaXJ7BBJsUV7FHX78hTXcD3YZL4maxbqnC3qeHUTPxZ
         4T0HKyKCeLh44rFUCLsrrUllyZQ53g76ubYAZ462FokZF4cw/caVmrfS4hEEBGsfAzqn
         qDXdGHYHiibeVMw5V8J5+s1BptGIdWfAbcdafaPe1cA5vhROhfJrAphRNpKOADprxFcP
         HNbA==
X-Forwarded-Encrypted: i=1; AJvYcCWclsxToq+8yhySiC/4ARuNfcG2yCVhcnFwaNPInlxL9Yq/WUZA4cmlH/tTRM1oawSnzwJFDOMqrh8BCUGVviewtQzny34=
X-Gm-Message-State: AOJu0YxBy6w8s+qIY/UYPKTD5bOGJUOkog/i80MPFFZxYC3lgVh/uxmY
	EOjZBuTq0ideJzvsWMx1vH9g6BISa35Vfjt5JAZZUqAbyC/Dr0si
X-Google-Smtp-Source: AGHT+IFZNrIdyPlOojmPw/Vtneu8i5ljKX7bOkxoN/8q79yM7pVvigpgwQs0cCSV9cTuLRKXJsYomw==
X-Received: by 2002:a17:906:5f86:b0:a36:f314:d8be with SMTP id a6-20020a1709065f8600b00a36f314d8bemr5074626eju.38.1707768456866;
        Mon, 12 Feb 2024 12:07:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxcwKeZlo0/7vxs9xbplYLDnaPVyoYNMvATTccD+tfjvZ5Jwm4BWKhRBppge8PXaCts6wbUC/OUDdjNE5yJqURt1tQfcTEIdmWvhwl+C+uOzKeQ311uvxo8TMk4RqS8VW76sopORO6+LvJECrTKTCFCQXRRF2i61lrp2VzO+liZ4rZBbZLgaG5fHWJlPtPaQ6r7CMo8GQb3hKBRuyq7Sq39+JtuWxHDltCEHqn6bjgDf/Tdg==
Received: from ?IPV6:2a02:8389:41cf:e200:8e14:1b8e:d285:8c63? (2a02-8389-41cf-e200-8e14-1b8e-d285-8c63.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:8e14:1b8e:d285:8c63])
        by smtp.gmail.com with ESMTPSA id cf11-20020a170906b2cb00b00a37ad2c72dasm522798ejb.183.2024.02.12.12.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 12:07:36 -0800 (PST)
Message-ID: <34986860-41e5-4d03-a0c5-72af12e7e97c@gmail.com>
Date: Mon, 12 Feb 2024 21:07:34 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] selftests: damon: add access_memory to .gitignore
To: SeongJae Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Bernd Edlinger
 <bernd.edlinger@hotmail.de>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, damon@lists.linux.dev, linux-mm@kvack.org
References: <20240212195328.73406-1-sj@kernel.org>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240212195328.73406-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12.02.24 20:53, SeongJae Park wrote:
> Hello,
> 
> On Mon, 12 Feb 2024 20:43:39 +0100 Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> This binary is missing in the .gitignore and stays as an untracked file.
>>
>> Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> 'checkpatch.pl' complains as below:
> 
>     WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
>     #11:
>     Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
>     Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> I guess the 'Closes:' could this link?
> https://lore.kernel.org/r/AS8P193MB1285C963658008F1B2702AF7E4792@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
>

I will add the Closes tag with the right link, thank you.

> Also, note that this conflicts on mm-unstable.

Should I use mm-unstable as basis to make sure no conflicts are introduced?

> 
> Other than those,
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> 
> Thanks,
> SJ
> 
> 
>> ---
>>  tools/testing/selftests/damon/.gitignore | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
>> index c6c2965a6607..79b32e30fce3 100644
>> --- a/tools/testing/selftests/damon/.gitignore
>> +++ b/tools/testing/selftests/damon/.gitignore
>> @@ -1,2 +1,3 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  huge_count_read_write
>> +access_memory
>>
>> -- 
>> 2.40.1

Best regards,
Javier Carrasco
