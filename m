Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B745A5124
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657288; cv=none; b=CHXstoSjV5YT5N7Y0fyViZ1DEoK+hWAyrSJp1UUWcsZsftptPFqIsRkXrjVEOnLwXl5DJ+ckLdqX24SxH4slcnx6LP/Gh1BpM31uqmwHNpy/coPqsVYsBXMEP0KCav+9IGfg2xNouwYh03JpmKzcOv85I0SlZH9P85A+VLjrgZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657288; c=relaxed/simple;
	bh=zpjgWEDhPc2m38Ntx4OB+TI7v6pgEelo87w82EM+4jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ereoWvBw/S94lz9hmS77QIB080LZ5IWWN/CsMqOE1XHVbqOaokKvOufHtT19SPRrscZtdjKsJ3Jyr6tMYCM8WXcVuLwZFgocwKEiraYUqcEAaSvIHvxjdpYFCC4ponS09W/YSTsfRpoGwaQSpXX6fB/miY/auOq6Xjw5a6ke1mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=fTCLQKuW; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="fTCLQKuW"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=i93/h80AlAOJhM1IVnZquGXYeyAbH8OiH5T1yHv0Eug=;
	b=fTCLQKuW3z1DHdPHokT+OISreU9xFW2wXMpb/r4DFyAd2MI3J2yp/LZrWMfFxAuUWFLFgWhpT
	HVcxPAjOJqlO6Z6Am30KGV4Q8sGVR4FozZ7vT2ss0x1jcIG5b0M5ddMmJVJNcPet7e//fCgqRrX
	vIsmUp0qp2F10RsJkF3hXqI=
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hlz4r5BfGzJ46dV;
	Thu, 17 Sep 2026 22:42:52 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EA3840584;
	Thu, 17 Sep 2026 22:43:49 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 17:43:48 +0300
Message-ID: <9cc251f3-028f-471a-b12c-17c98f868ab9@huawei-partners.com>
Date: Thu, 17 Sep 2026 17:43:48 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm/damon/api: remove NR_DAMOS_FILTER_TYPES
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: <damon@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260917142210.90829-1-sj@kernel.org>
 <20260917142210.90829-2-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260917142210.90829-2-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SJ,

On 9/17/2026 5:21 PM, SJ Park wrote:
> Nobody uses NR_DAMOS_FILTER_TYPES.  Remove it.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index bbb190b474015..836353c4ab9aa 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -400,7 +400,6 @@ struct damos_stat {
>   * @DAMOS_FILTER_TYPE_ADDR:	Address range.
>   * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
>   * @DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:	probe_hits weighted sum range.
> - * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
>   *
>   * All types except &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET and
>   * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM are handled by the underlying &struct
> @@ -422,7 +421,6 @@ enum damos_filter_type {
>  	DAMOS_FILTER_TYPE_ADDR,
>  	DAMOS_FILTER_TYPE_TARGET,
>  	DAMOS_FILTER_TYPE_PROBE_HITS_WSUM,
> -	NR_DAMOS_FILTER_TYPES,
>  };
>  
>  /**

Reviewed-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

-- 
Asier Gutierrez
Huawei

