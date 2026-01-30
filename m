Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000907E0E8
	for <damon@lists.linux.dev>; Fri, 30 Jan 2026 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740020; cv=none; b=kQBVuG2/pRCX9FyVKn9aZUv7WEAufUOKluqqEMoChlIdVdYv8d2FkOGSoeBkfbhdGv8S7hdsG/lRA8wfLWZNwTEIvnZaHVrErExie/xee2DTKv/EkqJd0g1XjkeU6EVujZvV2TtTAI3Wz2nPJow0eEid5kptTjanINpXYCJ7VF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740020; c=relaxed/simple;
	bh=6bKYx9muOkjLP7DquBkGRLLEyS1dKC/fIQ0rkH0OFo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hUG0dWpRsds1MZeoGz4zkGFu+6zdzMrq+w8qiBdZmbcFRKjaqw0FP5Xmkufv7INjxEccKDkjh0UtOb51cyaTtGVmYATlxGr02qcl/PdIq5njcvAsWWPEFGyb6DzfWumzzvccBwB9nrcspcjIDFSIA9WuJZEjjN18sosfcIKxDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ut3ycEYo; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ut3ycEYo"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oX5hyRJHR6Lithb+eoy4CxIJ3KMmionEVlpg+rommN4=;
	b=ut3ycEYoJmVAo6Qx+NQKqYKGkKnkLAnn9jaG7L45bmFmL0lQtBsrZa3YmfldSSmg4SVIAvFG+
	Ej3b6AcXRgYa7/wIRM8KMGksV6LGfVK+znI8jMo6cOqVRiPqegvS5lx2x3vsE1R0fED10ck9hBO
	isssANONAnZ15xqnvweTygo=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4f2KYp5BKSzLlXs;
	Fri, 30 Jan 2026 10:23:26 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D2DC4048B;
	Fri, 30 Jan 2026 10:26:55 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Jan 2026 10:26:54 +0800
Message-ID: <d6f2b111-bb42-4437-9711-bf06cf9afefa@huawei.com>
Date: Fri, 30 Jan 2026 10:26:53 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon: unify address range representation with
 damon_addr_range
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <enze.li@gmx.com>, <sunnanyong@huawei.com>, Enze Li
	<lienze@kylinos.cn>
References: <20260129161029.48991-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20260129161029.48991-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Hi SJ,

[...]

> Actually, there is another bug that need to be fixed.  Nonetheless, that's
> orthogonal to this patch, so it is not a blocker of this patch in my opinion.

Are you referring to the scenario where, on a 32-bit system with LPAE 
support, the biggest System RAM address found exceeds the range of 
unsigned long? Actually, DAMON only actively searches for the biggest 
System RAM address when the user does not set a monitoring region. In 
this case, we always reset addr_unit to 1, which essentially restricts 
DAMON’s monitorable address range to 0–UL. Therefore, the described 
situation does not occur. For details, please refer to commit [1]. 
However, we could perhaps further optimize this by finding any biggest 
System RAM address, setting damon_addr_range, and dynamically adjusting 
addr_unit. However, there are currently no specific requirements for 
this, so this work has been temporarily put on hold. [1] commit 
dfc02531f413 ("mm/damon/reclaim: use min_sz_region for core address 
alignment when setting regions") Thanks, Quanmin Yan

[...]

