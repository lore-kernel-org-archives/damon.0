Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3588CB663
	for <damon@lists.linux.dev>; Wed, 20 Aug 2025 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755684631; cv=none; b=iI2xQ4xc1Qq+1+etRdPplqL5rsFzcIrOdIB7//o8p7KLiCHhcRzmDze+iDU7hO6t2OhqZuIhBX0FWbzmwlrMjLZRlrPCHMmaxbo/lO9Vy8tTp/B2e1JalVh64Z9F8AHQZv/sdKoiKRCkNYzIjvqb+hIRBW8oZcCOk581r7eBjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755684631; c=relaxed/simple;
	bh=G1/3vTND0e39Wk46i1AHgaiZ5+Qv2s1oKEhEXZP2PAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A4MUTTIEADaJAbfAjmNJNYxBzWvsGuOnef+qQMJdu0SMxTOxAKw/rNlnm/5f8VHjIEsG0nsu8lQPB9f/w8gQkChByP03zPwx2elZb9cFrWdudd4J0US4VBTWiWKDKNZxpmawc1iEW4uplKVTDObBVRw77I6VF7vDxPyMeWA/Qjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c6Mg92sFlz27jPT;
	Wed, 20 Aug 2025 18:11:33 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 15F441A0188;
	Wed, 20 Aug 2025 18:10:28 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Aug 2025 18:10:27 +0800
Message-ID: <688958ee-4db6-4c33-8640-df69e5d87e9b@huawei.com>
Date: Wed, 20 Aug 2025 18:10:26 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 14/16] mm/damon/core: convert sz to byte units
 when updating state
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
References: <20250813170806.6251-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250813170806.6251-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Hi SJ,

在 2025/8/14 1:08, SeongJae Park 写道:
> On Wed, 13 Aug 2025 13:07:04 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>
>> After introducing ctx->addr_unit, the unit of sz might not
>> be in bytes. However, sz_applied is returned in bytes after
>> processing by paddr.
> This is not an intended behavior, but a bug of my code.  Let's update patches
> 3-6 of this series to return sz_applied as core-layer address unit, instead of
> bytes.
>
>> To maintain external consistency, sz
>> is converted to byte units when updating the state.
> Users could keep the consistency by multiplying the addr_unit, which they set
> themselves.

Thanks for the clarification! this patch has been dropped from the v2 series.

Thanks,
Quanmin Yan

