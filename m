Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276DB2E419
	for <damon@lists.linux.dev>; Thu,  3 Oct 2024 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973297; cv=none; b=V+GEKlh6uVw+MQxBxjRW89QGAR0wnlDCDSrTd/f99df1NKpwA/Dt8f/ArkcN/kZsAVBQxYA6iXCu0ufAK2O524nKuHS0HvL/DRnk6HuFQTuCG+QW0yyxiYPpsL/a48PQZjjf4OKy5qfrjzCu8A29k9At4c6wk96/fiEJnR94NdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973297; c=relaxed/simple;
	bh=1DHbz/7I29LMcyyR+1Cr2SeVMHbQVRJ321hSLEHzmQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gW70qPVSC/leN39dsOXGTkTkjVvTywPx0uyKQn37QPFdm7o9ulD+oRHBt0V/2FyE1ZpuO/mP5c2qVV/lUcJVyBcrL/Gzbo8EUGrIXqpylHP/4GLHSy1xmUID/qTwub+TU9fgu/02kLkHPTFt6UZ6i7tUrttNE31v7zfiQsg0OAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjxccY6s; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjxccY6s"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b9b35c7c3so11860275ad.3
        for <damon@lists.linux.dev>; Thu, 03 Oct 2024 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727973295; x=1728578095; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3T70GjnZtrECKRuYh+UzA3RKxDcYPOl8PnSP0CpIOMI=;
        b=hjxccY6sH8+T9jyumU68yryzsHG5FRBXqC/5/VUdEHsmx/6cflXD+f1fquDFnBmDaY
         MtWZ4gQEkelIO5Ygp+Z3RbDSjzhO9nCVzBhys6MUk2tlwAEvXkTpD1W4FA/05I8M3FT9
         cOY4/q3OZjnlUu9c0huoss0cy+gyw7R7glCUpv+dZtfbbOmlqjIyCECpKpKGLIrKmvY4
         cLaztTAYgTyPu4br4Yjv7fheaPnd9Xl7e7AOyPNZWDVjCBaBuiD1cf7ERAj4Y7eUEfti
         D7RbZ7JL//a4SZyrcR/e2IEa5s6mBkTXkkRz1xvHBlAwcTG2ANsvLxUR/TzLKZMi3sKl
         p7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727973295; x=1728578095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3T70GjnZtrECKRuYh+UzA3RKxDcYPOl8PnSP0CpIOMI=;
        b=knlD4Ry14DWvZWQKD3fmgzRN1gxsV8EeZEIUqy6kFPnNUs5YvrhL65HPcmR+SgSUEi
         6JSRI0+bDY7v2oNSYFcWkHh/5kj2FOkJp62BTFDNmiqKGTepwoFfVQo6LfnTmVRCBj+s
         PzctzDZQkKD/VN9D4PIy5TSsbFmnAL/Dg7/5D/gwKxjtXWvdZLmqTNXthfEfFqhMeV4h
         P88c9Vs0MKlT89x0JkGwVO4oPly268L9+HXtAxrjPvnWq4m4ECOXljI1iukDhGIicyDZ
         5YxIhYcUTH3R4aDRSe9CEgAmsvkLqwdTGSBtb5+5gStRHPdHQnMIu8OICWug/geeDR3e
         Pu9Q==
X-Gm-Message-State: AOJu0YxKpnYBOaZzLj50eWERAftBYpwQDGuRpnU0aQK3ASDPpHFuR/NG
	YahY9WgauhfpaTNEV4yVaGTjqedaMatoKqODcmHnZfkenv5O/fit
X-Google-Smtp-Source: AGHT+IHyVfH/8p6cEKEwioy4/0Mq6UjaXdGTh8IeYKz2doEa7lCutJWB1EwQz1cvLeKQEUsTzMcomQ==
X-Received: by 2002:a17:902:f693:b0:20b:4ea4:dd0b with SMTP id d9443c01a7336-20bc59c3d77mr96122155ad.4.1727973295377;
        Thu, 03 Oct 2024 09:34:55 -0700 (PDT)
Received: from ?IPV6:2409:40c2:801d:513:6943:ef79:1839:d8cf? ([2409:40c2:801d:513:6943:ef79:1839:d8cf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beef8eaebsm10699485ad.127.2024.10.03.09.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 09:34:54 -0700 (PDT)
Message-ID: <751bbb75-e621-439c-b5fd-03901660832d@gmail.com>
Date: Thu, 3 Oct 2024 22:04:49 +0530
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: subscribe
To: SeongJae Park <sj@kernel.org>,
 Bhagyashri Pathak <bhapathak@linux.microsoft.com>
Cc: damon@lists.linux.dev
References: <20241003160007.64618-1-sj@kernel.org>
Content-Language: en-US
From: Piyush Thange <pthange19@gmail.com>
In-Reply-To: <20241003160007.64618-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/10/24 21:30, SeongJae Park wrote:
> From: sj@kernel.org
> 
> Hi Bhagyashri,
> 
> On Thu, 3 Oct 2024 05:13:55 -0700 Bhagyashri Pathak <bhapathak@linux.microsoft.com> wrote:
> 
>> subscribe
> 
> I'm sorry but it is not easy to understand your real intention of this mail.
> But I guess you might wanted to subscribe to DAMON mailing list, following some
> deprecated mailing list control instructions?  If so, thank you for showing
> your interest, and welcome to DAMON community!
> 
> Nonetheless, this email wouldn't make you be subscribed to DAMON mailing list,
> to my understanding.  You could make the subscription following instructions on
> https://subspace.kernel.org/subscribing.html
> 
> In short, send any mail to damon+subscribe@lists.linux.dev
> 
> Pleae let me know if you have anyquestion.
> 
> 
> Thanks,
> SJ
> 

My bad, the mail just went to SJ. I'm writing it again.

Hello Bhagyashri, as I would suggest one more as follows

https://subspace.kernel.org/lists.linux.dev.html

This is a list the mailing lists, you can just hit the sub link
   and you'll be provided with the particular mail address.


Thanks,
-- Piyush
