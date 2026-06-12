Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE7226CFE
	for <damon@lists.linux.dev>; Fri, 12 Jun 2026 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293137; cv=none; b=igUSHYv59l+jDYqebOFLvP0mr+kYFWSaIpFG4CUFoMtgc/IMCUjDcIh+z/yv3FxD8pFSBZR7NUzdPtgb7w8MG54+PRMTnrSR0sgMEv30forCJbJ3P/itD+xVuWj5t1IYudrR89wjqXd/U9sWW5g3rq7gMPZHJKfj9Gjx1u78UHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293137; c=relaxed/simple;
	bh=EvdjveAtk2JbGoCk11+qdudzdzUtxGYuG40AE0m9EXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xo5x5P3CGC3hhd1ry623OWpk2c/VrhWbKEM3EOARLty58MgqIL+1Cbb0q9FBhE2GHC2TxjKaeYEHTZBJ2WrwA7D4W026+372CbxPSnGa26KW0gzIvbdsGq7NH8uruIwxzFpV9cbHoGYYZtpuD2Igswkc7WU57lTiBi8bia5oNgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gcVF032Z4zHnGhg;
	Sat, 13 Jun 2026 03:38:44 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E2F04058D;
	Sat, 13 Jun 2026 03:38:53 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Jun 2026 22:38:52 +0300
Message-ID: <a425fbe4-c75f-4fa9-9294-40ca39ffa0d3@huawei-partners.com>
Date: Fri, 12 Jun 2026 22:38:52 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/4] Documentation/admin-guide/mm/damon: add
 DAMON-based Hugepage Management
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260612003356.83586-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260612003356.83586-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 6/12/2026 3:33 AM, SeongJae Park wrote:
> On Thu, 11 Jun 2026 15:02:44 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> Add documentation for the DAMON-based Hugepage Management
>> (SAMPLE_DAMON_HUGEPAGE) feature, which automatically manages
>> huge pages by identifying hot memory regions and collapsing
>> them back to regular pages. The documentation covers the
>> module's features, operation, and all available module
>> parameters.
>>
>> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>> ---
>>  .../admin-guide/mm/damon/hugepage.rst (new)   | 113 ++++++++++++++++++
>>  Documentation/admin-guide/mm/damon/index.rst  |   1 +
>>  2 files changed, 114 insertions(+)
> 
> This again feels like following the non-sample DAMON module's patterns.  I
> don't think a dedicated documentation is needed for sample modules.  Could we
> drop this?
Make sense. I didn't see any documentation for other sample modules. I just
submitted this in case needed. I agree with you, I'll drop this.
> 
> 
> Thanks,
> SJ
> 
> [...]
> 

-- 
Asier Gutierrez
Huawei

