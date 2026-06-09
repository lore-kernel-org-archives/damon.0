Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DFA3F1ACC;
	Tue,  9 Jun 2026 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994497; cv=none; b=W78jeA3tRCdLlAG8zB6ayql0QY6NCwdY+odXiB1w0CUAFk5bBFlNuvcnLmUygoTGN1W/fypO82yZOU7BdeptksUTPYA53vkg5MR45J7Z6rJPKOmsY1F4XjtQdd9iMEvPXG+wOYsNNbTTqhVV+TnyC2SXBFyVwzSA7G9J1tAwqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994497; c=relaxed/simple;
	bh=4xrNWA9Ks1iv+lD9xPqAXwA3kXOGIgwDcHam3AcrKlU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WAXrmLqWHyz5E76bUBAFMd7oQ+AgBIz55aMWOGQE/HPWISEcDCQ+1+ue69KZ6p2OKr9YhvPJV8z0cEAgoz7vM92Vg2vgTN+ehjHPs618uBMRPF1oqK36Q4gNUNErAe4tNp7vvsZh6Ju8qEoLK6+DAlr0tkbIEO62JyUTCzSswyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CmS6njnl; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CmS6njnl"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ghUVemxhgRYnJ8dPOsRwXzQbm1ScEjX+fz5LyHNyjY4=;
	b=CmS6njnlw8VdOQlc2lsbvoIR9OgxjC3s9By/aZGOHNF9f2AiIk538wSHL+MaJyOKyI/vdFBeu
	2u0s8+BcawFWQKkZqJYfAZ2lMQS4BECPkJpIBhhB2NBKnPzxs7oRxWrq180h3JqHhHGGEmAXqZb
	poroy4puwS3sE7tPTGtmbC0=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gZMcv1BJSzRhRh;
	Tue,  9 Jun 2026 16:33:35 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C02A20333;
	Tue,  9 Jun 2026 16:41:28 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jun 2026 16:41:27 +0800
Subject: Re: [PATCH v2] samples/damon/mtier: fail early if address range
 parameters are invalid
To: <sashiko-reviews@lists.linux.dev>
CC: <damon@lists.linux.dev>, SeongJae Park <sj@kernel.org>
References: <20260609064653.1829-1-yuzenghui@huawei.com>
 <20260609065829.6CBAC1F00893@smtp.kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <0922dcf7-fbc5-276b-d2d5-844299b6f9ff@huawei.com>
Date: Tue, 9 Jun 2026 16:41:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260609065829.6CBAC1F00893@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk200017.china.huawei.com (7.202.194.83)

On 2026/6/9 14:58, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Memory leak of `damon_ctx` structures and potential orphaned `kdamond` threads when `damon_start()` fails.
> - [High] Incomplete fix allowing integer overflow and resulting in `WARN_ONCE()` and massive region size.
> --
> 
> commit 567b4e8a4b1811419a6203e400b62d93a47bfe84
> Author: Zenghui Yu <yuzenghui@huawei.com>
> 
> samples/damon/mtier: fail early if address range parameters are invalid
> 
> This commit adds an early check in damon_sample_mtier_build_ctx() to ensure
> the address range parameters are valid. This is intended to prevent a
> WARN_ONCE() that occurs when the node address bounds are not properly
> initialized before the module is enabled.
> 
> > diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> > index eb1143de8df17..3785b0c7ffb17 100644
> > --- a/samples/damon/mtier.c
> > +++ b/samples/damon/mtier.c
> > @@ -120,6 +120,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
> >  		addr.end = promote ? node1_end_addr : node0_end_addr;
> >  	}
> >  
> > +	if (addr.start >= addr.end)
> > +		goto free_out;
> > +
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this incomplete fix still
> allow an integer overflow?
> 
> If addr.end is set to ULONG_MAX via sysfs and addr.start is a valid address,
> this check passes. Later, damon_set_regions() calls ALIGN():
> 
> mm/damon/core.c:damon_set_regions() {
>     ...
>     ranges[i].end = ALIGN(ranges[i].end, min_region_sz);
>     ...
> }
> 
> The ALIGN macro will add min_region_sz - 1 to ULONG_MAX, causing an integer
> overflow that wraps the value to 0. This results in calling
> damon_new_region(start, 0), which triggers the exact WARN_ONCE() this
> patch intended to fix.

Yeah! I can reproduce the WARN() by: (with the "incomplete fix" applied)

    $ echo 0xffffffffffffffff > /sys/module/damon_sample_mtier/parameters/node0_end_addr
    $ echo Y > /sys/module/damon_sample_mtier/parameters/enabled
