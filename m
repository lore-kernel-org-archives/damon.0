Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F861F130E
	for <damon@lists.linux.dev>; Thu, 22 May 2025 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893354; cv=none; b=XaQi6uH6qjEDtrzCrvqrPcIqfGZRSuAS1hkwE2Ck7QUIgIvK1dcbi4MhmKsCh2ET+oZ9gK9g5iN1+YW8wL5F7KM9I88rLsQRlwpZV69DzQqTE7SfQmjuLRb4c3Ba6/8S/E4WyeTe6KQYF+4YIsip/ElMO4rvaWIyBNXNV2zaOIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893354; c=relaxed/simple;
	bh=eaPQ5tlfp3WTenA4wusw9SWHS4vbRJXn3V5pTkR5FvU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oQkW9mx7RuSmEHff63DlGY0PqHuyf4mAmGm9LeFi2acUBarBf10tVDKPsd7NlqHayLm13/ZbqqbtBXIyavsP/S/InRUBsughMyEfbou8aWZq33iyGsjDE9cTauopA/U/6DJxIDQClyBBpYZl//sEQAR4Ep0jANHqncY7KKCNRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-c7-682ebc65e99b
Message-ID: <574262b0-6dd1-4e0e-a2c0-0e22aa885c6e@sk.com>
Date: Thu, 22 May 2025 14:55:49 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, damon@lists.linux.dev, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/damon/Kconfig: enable CONFIG_DAMON by default
Content-Language: ko
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20250521042755.39653-1-sj@kernel.org>
 <20250521042755.39653-3-sj@kernel.org>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250521042755.39653-3-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsXC9ZZnkW7qHr0MgyeXrC3mrF/DZvHk/29W
	i30XgazLu+awWdxb85/V4vDXN0wObB6bVnUCiU+T2D1OzPjN4vFi80xGj3MXKzw+b5ILYIvi
	sklJzcksSy3St0vgyvj4uo2t4AxPxZy7v1gbGDu4uhg5OSQETCQun93K1sXIAWYfe1UDEuYV
	sJR4d7KdDcRmEVCVmHD3GxtEXFDi5MwnLCC2qIC8xP1bM9hBbGaBGolZl1ewgtjCAp4S5yY8
	ZIaIi0jM7mxjBhkvIuAj0bI8ESQsJBAt8ffdNLAxbAJqEldeTmICsTkFjCWe7DjHCtFqJtG1
	tYsRwpaX2P52DtAYLqArd7BJXNn6iQXifEmJgytusExgFJyF5LxZSFbPQjJrFpJZCxhZVjEK
	ZeaV5SZm5pjoZVTmZVboJefnbmIERsKy2j/ROxg/XQg+xCjAwajEw+twQDdDiDWxrLgy9xCj
	BAezkghv7AqdDCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtSi2CyTByc
	Ug2M/vaqzzOMHPJWmU3P1DG7pxZ+Zwvj0Wlm9VNEj+8U3/CxXL956ezsaW+/LWqJCvtxaC27
	pfdD3wuPtX4Y+wZYbLtg/ekzYzm3IfeDSFvf82vrglTzk3U7+l00/bqW8XPzWu3r8nuxvT01
	YiOTxS+vWQmOCy09Uo2TVSovlzr8sJnbzL5jg48SS3FGoqEWc1FxIgAdkgNFgAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXCNUNLTzd1j16GwcOfWhZz1q9hs3jy/zer
	xb6LQNbhuSdZLS7vmsNmcW/Nf1aLw1/fMDmwe2xa1cnmsenTJHaPEzN+s3i82DyT0ePcxQqP
	xS8+MHl83iQXwB7FZZOSmpNZllqkb5fAlfHxdRtbwRmeijl3f7E2MHZwdTFycEgImEgce1XT
	xcjJwStgKfHuZDsbiM0ioCox4e43Noi4oMTJmU9YQGxRAXmJ+7dmsIPYzAI1ErMur2AFsYUF
	PCXOTXjIDBEXkZjd2cYMMl5EwEeiZXkiSFhIIFri77tpYGPYBNQkrrycxARicwoYSzzZcY4V
	otVMomtrFyOELS+x/e0c5gmMfLOQXDELyYZZSFpmIWlZwMiyilEkM68sNzEzx1SvODujMi+z
	Qi85P3cTIzCsl9X+mbiD8ctl90OMAhyMSjy8Dgd0M4RYE8uKK3MPMUpwMCuJ8Mau0MkQ4k1J
	rKxKLcqPLyrNSS0+xCjNwaIkzusVnpogJJCeWJKanZpakFoEk2Xi4JRqYDywu+9mYsXkpyuk
	l9TfOlJ2wjrqjS/PU05FX9YLznvncBouCrhqMuO1z9Fq/X9K4lUGG0u8YybKy856b+F8wCeo
	yraudpX4pG2bNs8/+02nfd3aFbPtTjX96cpeKjHJL77p1tNJnGpzFgqss/saujIt6nrQovVn
	Z24p3KAe3L5oY7FM8KKpkn5KLMUZiYZazEXFiQCJH8O7ZwIAAA==
X-CFilter-Loop: Reflected



On 5/21/2025 1:27 PM, SeongJae Park wrote:
> As of this writing, multiple major distros including Alma, Amazon,
> Android, CentOS, Debian, Fedora, and Oracle are build-enabling DAMON
> (set CONFIG_DAMON[1]).  Enabling it by default will save configuration
> setup time for the current and future DAMON users.
> 
> Build-enabling DAMON does not introduce a real risk since it makes no
> behavioral change by default.  It requires explicit user requests to do
> anything.  Only one potential risk is making the size of the kernel a
> little bit larger.  On a production-purpose configuration, it increases
> the resulting kernel package size by about 0.1 % of the final package
> file.  I believe that's too small to be a real problem in common setups.
> 
> Hence, the benefit of enabling CONFIG_DAMON outweighs the potential
> risk.  Set CONFIG_DAMON by default.

Agreed.

> [1] https://oracle.github.io/kconfigs/?config=UTS_RELEASE&config=DAMON
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>   mm/damon/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> index c93d0c56b963..551745df011b 100644
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -4,6 +4,7 @@ menu "Data Access Monitoring"
>   
>   config DAMON
>   	bool "DAMON: Data Access Monitoring Framework"
> +	default y
>   	help
>   	  This builds a framework that allows kernel subsystems to monitor
>   	  access frequency of each memory region. The information can be useful

     Acked-by: Honggyu Kim <honggyu.kim@sk.com>

Thanks,
Honggyu
