Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7F1EFF8A
	for <damon@lists.linux.dev>; Tue, 22 Apr 2025 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745302169; cv=none; b=aorvEx/a6nUH4zWGWm9a/gux/bVbYwyRW2mQW/y12GHuI9gYW3HKuNmIwFrNhCnwQahl8j9BXlke5P5Ciq8kPgM3+tBrDntUgbGkXcdEHSEHqi7JK3qPcrlyI+6euYhhBHKnZf86+eOj5c+QCD2fbzyOOMA4ZGxfF1Bu1YSwTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745302169; c=relaxed/simple;
	bh=/x5v9llbYg6qALaYmh43bF6k3g3EbebNJbFBgph6gtE=;
	h=From:To:Cc:Subject:In-Reply-To:Message-ID:References:Date:
	 MIME-Version:Content-Type; b=pcaynwWtx6fWO2qi59ig+b7i/sBy0AlvKNFF11HGoMo2anxFjrCvT5hPA8oBHBnHmarzQ7OxL/BtGgVdx1FM05v9xnZ1cwALwSR4sbhDlcmubaLokD2JBsSUQGEdhVcK4E9vUXQeLnkNhMiuX2xdvZAqfcr5RJdHrEaL//gKCVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5012a6821f4011f0a216b1d71e6e1362-20250422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:aa9ad765-83ac-4d1a-a81e-3136aa869d49,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.45,REQID:aa9ad765-83ac-4d1a-a81e-3136aa869d49,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:6493067,CLOUDID:0f3968b63d1f3943b7aa0ec74ea2fc11,BulkI
	D:250422140914EGXGE33J,BulkQuantity:0,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 5012a6821f4011f0a216b1d71e6e1362-20250422
X-User: lienze@kylinos.cn
Received: from kylin [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1109057265; Tue, 22 Apr 2025 14:09:13 +0800
From: Enze Li <lienze@kylinos.cn>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org,  damon@lists.linux.dev,  linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: Initialize sampling_addr in
 damon_new_region()
In-Reply-To: <20250421165526.8517-1-sj@kernel.org> (SeongJae Park's message of
	"Mon, 21 Apr 2025 09:55:25 -0700")
Message-ID: <87plh46gf1.fsf@kylinos.cn>
References: <20250421165526.8517-1-sj@kernel.org>
Date: Tue, 22 Apr 2025 14:09:09 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hi SeongJae,

Thanks for your review!  When examining this function, I instinctively
verified the initialization of all member variables.  Personally, I'm
quite partial to the practice of initializing all fields when creating
an object - though I fully acknowledge that initializing sampling_addr
may currently have no practical consequences.  This patch serves purely
as a preventive measure, so please don't hesitate to drop it if you
consider it superfluous.

Best Regards,
Enze

On Mon, Apr 21 2025 at 09:55:25 AM -0700, SeongJae Park wrote:
> On Mon, 21 Apr 2025 11:39:19 +0800 Enze Li <lienze@kylinos.cn> wrote:
>
>> Since sampling_addr is used across vaddr and paddr modules, initialize
>> it in damon_new_region().
>> 
>> Signed-off-by: Enze Li <lienze@kylinos.cn>
>> ---
>>  mm/damon/core.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index f0c1676f0599..d197a5e3901c 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -128,6 +128,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
>>  
>>  	region->ar.start = start;
>>  	region->ar.end = end;
>> +	region->sampling_addr = 0;
>>  	region->nr_accesses = 0;
>>  	region->nr_accesses_bp = 0;
>>  	INIT_LIST_HEAD(&region->list);
>
> I unfortunately cannot find why this is required.  Is there a use case that
> reads uninitialized sampling_addr or any problem that comes from the fact that
> damon_new_regions() is not initializing the field?
>
> Only operations set implementations write and read damon_region->sampling_addr,
> so I was thinking not initializing the field on the core layer is no problem.
> I will be happy to be corrected if I'm missing something.
>
>
> Thanks,
> SJ
>
>> 
>> base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
>> -- 
>> 2.43.0
