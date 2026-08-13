Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6AF44780B
	for <damon@lists.linux.dev>; Thu, 13 Aug 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611139; cv=none; b=QbxaqSIlySHHf7e/ed0iiOTDfmS0m5hnlohtO9/HWhq9OUl+tiCUAVUfbYwtvDxNmY7KxXU36eNp0c5Qp8WbR4Q0idYtHzMcRpWSoFdpRvwm4hO71EOjthpc9MxaQoaPsez3Ro18c/C4x4dsHDl3nsWfTxboBXRYl2UvpGtpAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611139; c=relaxed/simple;
	bh=KasM8M71jIcp6hmX0Olmezk4XkHHsu0bhVSuAVxaucE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kEPFUVFIRTfxSrim40GxIo5fcajImQwyWnKyUALf9ORAHY0pi/IbDhgR1fMh8stEIctuKa8VJoB/UXdEHf9P4VDuvdIzPo4ZnCXiEi0WJJHK8j6GiCOyksZDNZgJaXOaK+av5G8x2J52QpGIvprMEGtJZcNBpL1EXudoMBkpq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=h2XNmB6e; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="h2XNmB6e"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=v5SXwN8z4wJfjren0Th1ktpv7Vbq6Vy95XZXPb5aTWM=;
	b=h2XNmB6ez+mJE4tHecLxLbI2QLj9IQVV7GxkpNC3b63p+jVJBly3ALeziIaWQLF2IiOsh8fL/
	jFbMKJVizf+RLFVGQdqyyHIy8ltt3no8YmthIcJJ63qV6RaybjTNhSTPd3dwm6FXpatZO3GBzeg
	JGmiMPnAPjYP0tO3XftqSzI=
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hLJX761SlzHnGch;
	Thu, 13 Aug 2026 16:32:55 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 434DA40575;
	Thu, 13 Aug 2026 16:33:03 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 11:33:02 +0300
Message-ID: <ed32d112-2873-4e29-9d4b-d5bc72b70f52@huawei-partners.com>
Date: Thu, 13 Aug 2026 11:33:01 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm/damon/core: handle NULL ctx parameter in
 damon_call()
To: SJ Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20260813035001.97364-1-sj@kernel.org>
 <20260813035001.97364-2-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260813035001.97364-2-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SJ,

On 8/13/2026 6:49 AM, SJ Park wrote:
> When NULL damon_ctx pointer parameter is passed, damon_call() could do
> NULL dereference.  The caller is responsible to avoid that.  It is easy
> to forget, and there are many damon_call() callers.  Meanwhile,
> damon_call() is never meant to be performance critical.  It uses mutex
> and completion.  Add the NULL pointer check inside damon_call() so that
> callers can pass the parameter without NULL checks.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 92631a36d7b51..5882f9c94c47f 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2188,6 +2188,8 @@ int damon_kdamond_pid(struct damon_ctx *ctx)
>   */
>  int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
>  {
> +	if (!ctx)
> +		return -EINVAL;
>  	if (!control->repeat)
>  		init_completion(&control->completion);
>  	control->canceled = false;

I know that this is a minor optimization, but how about moving INIT_LIST_HEAD(&control->list)
to right before list_add_tail?

It doesn't make sense to initialize the list before checking call_controls_obsolete.

Maybe this suggestion should go in a different patch.

-- 
Asier Gutierrez
Huawei

