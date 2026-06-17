Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA40481673
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712777; cv=none; b=CM7iwheOveBu0Rj8LZF6N4/W+7rJRKzhlKuEApgZRYmhZQHzYHnANuKKRP57uMFwoFWlIgLLgPzQ2J3G3ZTWjOve8EIhH7YMUbfJDbWjHiNxU3ezFbz40LHPS39NeTaQdPIiFU0l2eXMeBtz7qCMmicBrPoU3YW8cHyWVBvqIHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712777; c=relaxed/simple;
	bh=YmCuNi+WgCJs0v2d2mIjibCuCVIkzm5F42aS9GdTisg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vABSV941sUOY+mS5mk79QqloZfeaeepjXu8JbtQoVUxIZyTZ1PsjidSsXmk5Kcle+QyVD8OWQBOpNH8hwgDvc8o38/FRff89d5BeuZsgi6yVFAA/Yw5TGuXsKTU9lIMiOmq1Cp0c0yRwmhYhx/8/9sN6DZJ1faUQDfLhm5TObc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OujmCm8p; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OujmCm8p"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b12270b3so36853125e9.1
        for <damon@lists.linux.dev>; Wed, 17 Jun 2026 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781712767; x=1782317567; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=X0zBBw2mHLX44ib/ur8vL9yTzE1JcardieVVBx4eSzY=;
        b=OujmCm8p7HsMnOAjf8BJXsk4bpbjXtiZhkYij8eIit8GdS042JYHv0E1ZS0ld046dU
         xNsQ4GuXZIEhwfoRN6GCNEOp3ye9V1kge45DD2zaKk7q427vfj1o3rLlqrV1J/aNiNkk
         KwYGvMxO10Wc9K+zj5L7Q6nSfSnrfnzziJ4Gec8TfB3IK1wHibOc5pDRGXiertHgokh7
         wTCp92ZLHog52oVLPZOAr8iXtS+75+NHIug/+hT/EVrJr3xsFd0GoTNj6FY6notgxEp/
         jJ0B77w6EKNigZ5gjKzFGA4okXRHuVnoXyQtixYhLcWDstZ4RD6CuYoxUYtyoXW6CfD8
         C+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781712767; x=1782317567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0zBBw2mHLX44ib/ur8vL9yTzE1JcardieVVBx4eSzY=;
        b=kB8zBIbA+1flmzKj76gSOPQWTukt63vD5Cnl2oTNyHoeMcds3u/VhR+7g2dB3pFC06
         HoRMUehpfy5R5erjFatIxdbB/CI9T6ZjWV1UBOX0ujiAdr9lgfSj0ORNpDFb4EW7azr3
         w4tKouWTw47SBYSdKnC+ErPP1ob/3g2ZwfRuRiW6jrY803qHbRLMoHlBFbTXG/CI7w6t
         5+iOWCupJ6p2JPLRSR38SG20NWkP2768vtR//qqzQOfvww6wjfbx8la6uh4YJc6G0NKe
         0nt93uc5AnNG1Ngqr71zDUZGhbDt7qSvw4LVN8YYHTHdxiA5aPqaROqSdbc/hsmNLWiu
         fMIA==
X-Forwarded-Encrypted: i=1; AFNElJ8rK2zg2JUXucOx8YeQl3HJsKYEUIJ0L8pvc8X0JTHJ6dBBo8gZvmvy7fvbTVJSYbXBcS0VaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNzpHh5Dp2XqyOuOFhbnwfJ0IToW8VuzavAas96FT/ozKJptxr
	cGDdL28UpqrLyR0v8vnSpGseMsoke+BqN+BMnWl1fte2MpR9q/fkk8Cg
X-Gm-Gg: Acq92OEWW3IYvu2yZsqGCJqXWu2CvAWovwsi3N1HvgPcZeTCZ1xWFUyJgvLXJZu8Bu0
	2qpOu5J+pPq5KvSMlH9BJt0p+dcuP9a630kLOUa0evilnX9HRXkevf45wDP7Yt2Z9W+AfOKerh6
	xGPx9UMctNurEFQ6W30LrXpWYOrwezWDlXEgOwGNyGgkU+N8Q8resUH9bs8sjK2n+bzdvFe6elT
	61GCHcPRmxPrlKOQmQLJn4iqTy06HLj5jnDUaAhfAFLnBsrJ9H9q+LUSEhc4v7kL+gdRdWIjRrk
	kazsM5OFfJfVF/GE7yqrwvGmiOSwHYk3p8RbQ+ERBgOLUXn0p9cBxzRpgUAE9aGPca1qhplgew3
	GMcAsfrpjzLvHZaBzfRdU4oIb5MPMvcn6EdthuoB4WGRkDCpCe568YWuWyaPl8IRjej8uav3hXx
	36Zj7bDlJh/7hRcr0iUmYcVMdUXJOQpbIlmxQlJBS/gzD6tJOGhCnSxwdLoTrF6pdf1f2EpPwKE
	n+oeVq2KZ5hd+mDiQ==
X-Received: by 2002:a05:600c:6b69:b0:490:a1dc:e542 with SMTP id 5b1f17b1804b1-49234100c1fmr46844735e9.6.1781712767174;
        Wed, 17 Jun 2026 09:12:47 -0700 (PDT)
Received: from [10.128.11.42] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2ce361sm52357251f8f.31.2026.06.17.09.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 09:12:46 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <39bf837e-d3c3-4b9b-b118-063caadcb700@gmail.com>
Date: Wed, 17 Jun 2026 17:12:45 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] mm/damon: introduce DAMON_HUGEPAGE for hot region
 hugepage collapsing
To: gutierrez.asier@huawei-partners.com, artem.kuzin@huawei.com,
 stepanov.anatoly@huawei.com, wangkefeng.wang@huawei.com,
 yanquanmin1@huawei.com, zuoze1@huawei.com, damon@lists.linux.dev,
 sj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20260616150316.580819-1-gutierrez.asier@huawei-partners.com>
 <20260616150316.580819-3-gutierrez.asier@huawei-partners.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260616150316.580819-3-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Asier,

On 6/16/26 16:03, gutierrez.asier@huawei-partners.com wrote:

> +config SAMPLE_DAMON_HPAGE
> +	bool "Build DAMON-based collapse of hot regions (SAMPLE_DAMON_HPAGE)"
> +	depends on DAMON && DAMON_VADDR && TRANSPARENT_HUGEPAGE
The dependency on DAMON is unnecessary because you already depend on
DAMON_VADDR.

- Julian Braha
