Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B675643AB3
	for <damon@lists.linux.dev>; Wed, 25 Sep 2024 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285908; cv=none; b=bdg2rBDlCjsfdPQcZORzfZKAKi/+pcOiLuGcNqbxzNwokg2xxX3ovlBkVu7ygPJaV7672cyESH9z+zT0aYs3u34I9LvWzPsfarR75/fqjGNt+V1KQpRHg4pkb3LmS61W0fAM3bJClQ3t5t79mbkPnDOPLiRo86sbfqkkRGl5Fcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285908; c=relaxed/simple;
	bh=2fB7VvK7p0djAFGCZ76lqlK/kuK8c5cj0cutAXqoIjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ar0X0qO9ewbgEd0Rb0RoCIHW/4lgOPzUeRlnJekYaTBxJndDTkpMV/CYGBhwiO3mcKGKnsHgxiK7wu7tTKhOxKaeGoGYBMCP9batv2WpNUfnMgl+vyiJPchjH579p3qCPKTT4SQ/DJ+0ey5fkw20qRVuWQ5AoczAHy6Nme3BgYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a8l/XSPQ; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a8l/XSPQ"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8323b555a6aso4547739f.3
        for <damon@lists.linux.dev>; Wed, 25 Sep 2024 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727285906; x=1727890706; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNYWYybui2SML08bFfCURSR7y1d30yyf7w7yHJdDw1c=;
        b=a8l/XSPQIixNTIEO2Xux7u07Z7EOxqX89orth6GGy0JC5FGk2Nu6zJnq0BS03jpxeB
         XXKaeUeR9+Pum+JurViiOccAjwRT7/J7Cwso3uWAmu/qv18c4UD5D1VU/snFGNUUaXlt
         /9BuxUi6959/xjG1xwysqeXD1OBtK+lEmJrrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285906; x=1727890706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNYWYybui2SML08bFfCURSR7y1d30yyf7w7yHJdDw1c=;
        b=cZI+sDKCMN3akoTYk6ykS2R8NaxJiCGdCmovoNo5CV5UE13WkK8w5ipj8z3ECMkG9q
         PYqpId9NbVyTkQTH0sBvSmxf4qycan0pf663m51tmHVWRt7sFDBYOfHYpzTqWzGIZKEo
         +XUSWZkZnToobAkukjF3fV38kq1UVmxr2rZBqZkbxD9xrgETLpJXOn1g89eprv+P10M3
         ZpgqSNTkPEfrrTPC7JnLZ98Ity6iKa/OGJnQ5W5yjeklaizboeIvqaNwFPWDZjV8z6kM
         PJNC0DxVRYEZ754c/gEFsTubMhu6Wu7p4yJYi2qu2zIOTTMPp1ErpJo3el2t/5kEmhgK
         A9ig==
X-Forwarded-Encrypted: i=1; AJvYcCXEOBrcQMMWiS7Un6oUbp5I/l/0GrRjvHAZds4YPpqtotUDRMBC5GMpp1HlnBMaQWYD2jB1Dw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlhZhXfGnjC5XtyTKovyrokm9yRzEtVI2FshKfU5pC7zZdSceA
	Dd3orOXi6xZckWs/5utBQj+9OMrjfvsLFio0wVSKhQkH0Hxq5vn2rl8rL2zv8qo=
X-Google-Smtp-Source: AGHT+IHZ3ppibItV5anfklTtvBV2C9TosOmUhdY+PswnvNpRUpKDmlGyfnqpFLEIOKom3Ru8FHVDmA==
X-Received: by 2002:a05:6602:1608:b0:82c:ed57:ebd9 with SMTP id ca18e2360f4ac-83247e6017amr433444039f.10.1727285905713;
        Wed, 25 Sep 2024 10:38:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f0e92fesm1210088173.25.2024.09.25.10.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 10:38:25 -0700 (PDT)
Message-ID: <74d8ff47-60b0-41b2-a22a-1077e9687717@linuxfoundation.org>
Date: Wed, 25 Sep 2024 11:38:24 -0600
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/damon/access_memory_even: remove unused
 variables
To: Ba Jing <bajing@cmss.chinamobile.com>, sj@kernel.org
Cc: shuah@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240924021426.1980-1-bajing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240924021426.1980-1-bajing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 20:14, Ba Jing wrote:
> By reading the code, I found these variables are never
> referenced in the code. Just remove them.
> 
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---
> Notes:
> v1: https://lore.kernel.org/all/20240903034300.10443-1-bajing@cmss.chinamobile.com/
> 
> v2: Modify the commit subject and commit log.

Thank you.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
