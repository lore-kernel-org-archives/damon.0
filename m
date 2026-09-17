Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F971582BBB
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656253; cv=none; b=hYwdT402y5HzLMCOpPpEUFQO2E7ZJkhkjmOSAw4QzSJlJzLZn8bB75fF94FvnJFV1eMWm8KRlNUbEpREcQKox0lXXlheIyQwmIRlTwpvEKuJWqu5DesCn7bID70/j5WRqHiBSKVL16CUPtwxmir0hU3SIMhCEAtUpun2XorMbDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656253; c=relaxed/simple;
	bh=a9oG9p/Bko5qkIijYL5aVyIVSfS6p/cRhZj/6rGymsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z6vRIfNfkAkz+BUsb1mKbpY7Ji+9ckoXBMUXce828lTFrbiukfx3FiPeTx57rpE8gGRDpnRlMDhZLdHdp2+F54fORkTzdxweLn9SrPIEP9PpfX2S+7m4GeloqGAgSBJAfO3NcQDvYjqNjsFkYmL3Q/xNjq26zXoXlOAriD7Vs9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=ENdtwNl6; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="ENdtwNl6"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eN/fpov6PZomGcIc0BH4XcakhyNs65CVNspNQIZgj8o=;
	b=ENdtwNl6Of5Mw57sPbnSS8ZNCnLxCM4htviuYxG42735NSvgDOlnelUkYKOqaV9TwdNxNHVpf
	ehmU7WThGPKyGJaIPk/w+1QivaLeXDOILENbiPsoiyLb56CnfK5Sb0exEagBIiM/gI8F1iIDm7i
	nPdZDok57MBhsDPOdmIV/Lo=
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hlz543pkvzJ46fh;
	Thu, 17 Sep 2026 22:43:04 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id D35484058E;
	Thu, 17 Sep 2026 22:44:00 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 17:44:00 +0300
Message-ID: <e07def52-eb4b-4c98-96ba-0a9f263d45ab@huawei-partners.com>
Date: Thu, 17 Sep 2026 17:43:59 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] mm/damon/core: use abs_diff() in
 damon_feed_loop_next_input()
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: <damon@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260917142210.90829-1-sj@kernel.org>
 <20260917142210.90829-3-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260917142210.90829-3-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 9/17/2026 5:22 PM, SJ Park wrote:
> damon_feed_loop_next_input() is open-coding absolute diff calculation
> instead of the dedicated helper, abs_diff(), for no good reason.  Use
> the dedicated helper.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 444c97c184027..de46072dc1a2f 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2926,10 +2926,7 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
>  	if (score >= goal * 2)
>  		return min_input;
>  
> -	if (over_achieving)
> -		score_goal_diff = score - goal;
> -	else
> -		score_goal_diff = goal - score;
> +	score_goal_diff = abs_diff(score, goal);
>  
>  	if (last_input < ULONG_MAX / score_goal_diff)
>  		compensation = last_input * score_goal_diff / goal;
LGTM

Reviewed-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
-- 
Asier Gutierrez
Huawei

