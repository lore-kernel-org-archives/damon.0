Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABBC1E868
	for <damon@lists.linux.dev>; Thu, 14 Aug 2025 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176356; cv=none; b=UZjy4tB4jd3szGWxrNi8Smhl7Bekz04UyXXilTwp97vb5Yzic/+G+nIZjdWwo5SvJbQ48c6DOJgDb87aPy6lDvOK7s9PgtlLatiJIRE8rKDKzzEDK5QXcZio6y5aC016cv5jzMlwRoyVAlAg934344/wCpoagzZujT2VLaodZw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176356; c=relaxed/simple;
	bh=yyE3sDMl7Q83UnadmUpBLmIBWuoxrdPriBGILHoUJjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aqdbdGz39CXEYCvzHq8Iqys5a3Mi9RimtUxf3bLXhHXtxb9rLdRqPxIt7zKmAjat/EDUPynI+njO/TAj+mlbFOa1uQ2ozt8NH9JuQRZrrlAmPF9C0XnlnJydxNoZVqs2bjtbIhA+f3xMdz+iu04jeVjIRGbesj2KRsfof63VNG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c2lZF5kdDzdcLx;
	Thu, 14 Aug 2025 20:54:45 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E7B0180B62;
	Thu, 14 Aug 2025 20:59:06 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 20:59:05 +0800
Message-ID: <39e07350-2510-49fe-ae4a-e5d10b69291c@huawei.com>
Date: Thu, 14 Aug 2025 20:59:04 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 11/16] mm/damon: add addr_unit for DAMON_RECLAIM
 and LRU_SORT
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
References: <20250813163656.5611-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250813163656.5611-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf200018.china.huawei.com (7.185.36.31)


在 2025/8/14 0:36, SeongJae Park 写道:
> On Wed, 13 Aug 2025 13:07:01 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>
>> In module DAMON_RECLAIM and DAMON_LRU_SORT, the damon_ctx is
>> independent of the core, necessitating dedicated addr_unit
>> integration for these features.
>> Additionally, if the input monitor_region_start and monitor_region_end
>> are both 0 while addr_unit is set to a non-zero valuethe default
>> system RAM range should be divided by addr_unit.
> Do you plan to, and need to use DAMON_RECLAIM and DAMON_LRU_SORT on LPAE-ARM32
> environments?  Can't you use DAMON sysfs interface instead?  If need to use the
> modules, this change looks good to me in high level.  But if not, I'd like to
> skip this change, and wait until someone requests it.
>
> I'll review the code change in depth after the above question is answered.
>
Hi SJ,

Yes, we need to use these modules in an LPAE-ARM32 environment. The modular
approach often provides more flexibility in our workflow, so we would greatly
appreciate it if you could take some time to review the code!🙂

Thanks,
Quanmin Yan

>
> Thanks,
> SJ
>
> [...]
>
