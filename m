Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3425719E974
	for <damon@lists.linux.dev>; Mon, 23 Sep 2024 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109888; cv=none; b=k1M/6Vdr+qo1pRaykRrfugKwYE5IVjNWoDqaS13HkwZ61t8q1kFEux9NlDjgjJS2Z7jv6acImoCHgIb0tC1//SgVlErlmHbL/nOD3J71phVR8GiuyC+0UpXrF6KvjaZfJo+AacdN83vdpPcxToT+FELcHTq4CETV5ygx+eMk+BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109888; c=relaxed/simple;
	bh=jIzpwkBvohPZ42RJk7QZSzfZGSTG+zibn9cWdNgkWoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fECWS8Fa0t5EEZhxhi0bwXk1/0QsPuePAPlw12YyNzUEu7Cj3q2i/m4X1EtDZeB3/GnpIignGgiWQnkNPawoT6gzUVB+BQQfSJLfAbk0g/wfghwtDPCEAV67Vv9Y9FDUJeWZZwO9N5MBWdGSxxnAmyQRE8/w0PIju0fkJmbKQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KOmf87+3; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KOmf87+3"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82ce1cd2026so167117639f.3
        for <damon@lists.linux.dev>; Mon, 23 Sep 2024 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727109885; x=1727714685; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gjDcu1qjAZXv0N7bHIy/5adY2cLrLfFMbmRWe9h7RCA=;
        b=KOmf87+3EdU2XJQNoKsUIGhxOSyFJEto7z8kmDM6scIHI/Qeo08d80W2+WohU/Cs0e
         ZVI+Ry0tcBcclT0PzxcGpi3bpdA4clLkjIvfpXRn3cTNiry9dAIE+pXVWUQr7kNF6e5N
         lXqsTimeDigY3dTrl1VI8Syjr/uMsmskSX138=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727109885; x=1727714685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjDcu1qjAZXv0N7bHIy/5adY2cLrLfFMbmRWe9h7RCA=;
        b=WE3QEac92ssdkmSnhwY94CLr/yLA1hR+LhjcUnu8iYE1ylGkvLe2WceHSaHr8rZ+7F
         JpFx2Vok0Kv2AmC6bGVuJJSnlUXgTbctpjFQpLOZKHDU7bbMfpF5d0bsfdq9sjSm5QgX
         t9R8Yf89nzD0tlxgBNwPt9ElkZsgN5pHQCzJ0ep4eH/xuiGLVnktoWw9KMthJ3RUac6N
         fnfFnWndnqaqxLAAh7bQvgRbnM2Du3S/kT5BHme/OfUsr14vQzb4jfRvL20DHU8h0twq
         aUcqegH5PEVyG2rpDkT1mB37ZbMUBWedftwu2CV9Yx1iCCGN2YOUr6sArKI6Z9ATBodz
         PWMg==
X-Forwarded-Encrypted: i=1; AJvYcCU3cxxLubM0KYgXi8tYS3OYnNtSwACja3UhmO0b0lJrhnbvhNsAE082lDS6zGFjyx6YTvlydQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3gkswtTx2cHcLV7w8jK4gBfgIVFhkpoxdEYGKVDmUKCZEeVl1
	2HfFGgAoRJBtuh1yWgNknLD7Ju86gRUQJeiOn42CR0fmOoozlTI5V/0qUXiurCw=
X-Google-Smtp-Source: AGHT+IFeE7PSHtYTy6cCbJSWJ5DjlBn+o1h78m0KFuLtOxLv7/WV1afXrTm5YCgUpVC62dLJGRMTmg==
X-Received: by 2002:a05:6e02:1a67:b0:3a0:451b:ade3 with SMTP id e9e14a558f8ab-3a0c8c9e4e6mr103481185ab.10.1727109885323;
        Mon, 23 Sep 2024 09:44:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed597dfsm5222919173.166.2024.09.23.09.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 09:44:44 -0700 (PDT)
Message-ID: <6e71e7e2-5b69-488d-b3fc-e547d6b4b042@linuxfoundation.org>
Date: Mon, 23 Sep 2024 10:44:43 -0600
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] damon: access_memory_even: remove unused variables
To: Ba Jing <bajing@cmss.chinamobile.com>, sj@kernel.org
Cc: shuah@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240903034300.10443-1-bajing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240903034300.10443-1-bajing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 21:43, Ba Jing wrote:
> These variables are never referenced in the code, just remove it.

remove them?

Add details on how you found this problem in the commit log.
Send v2 with these changes.

> 
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/damon/access_memory_even.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/damon/access_memory_even.c b/tools/testing/selftests/damon/access_memory_even.c
> index 3be121487432..a9f4e9aaf3a9 100644
> --- a/tools/testing/selftests/damon/access_memory_even.c
> +++ b/tools/testing/selftests/damon/access_memory_even.c
> @@ -14,10 +14,8 @@
>   int main(int argc, char *argv[])
>   {
>   	char **regions;
> -	clock_t start_clock;
>   	int nr_regions;
>   	int sz_region;
> -	int access_time_ms;
>   	int i;
>   
>   	if (argc != 3) {

With these changes:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
