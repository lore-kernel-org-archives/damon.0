Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F73D88E5;
	Mon, 20 Jul 2026 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551196; cv=none; b=X7bdHCJLwPT8ou3zoa8s9D+sqIb9BA2luLdEllxtEcWrdEmgus63hBJy7/1+/YCLKjZmi3DOAOf/h98aXHTCsKo3+NA0sLhcqlVKgTll1IX2uCYN+MS9YW1XFWwvSQjMMCgwrt3vqGCfwicSxj6qiQ/EEmCiT1+I7zahK/cQ8yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551196; c=relaxed/simple;
	bh=OuYgJoqfN2tXwSz9Zj360tBdhGj2u2duQ6eha1TEkuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdiSPFQ+z1ZDEh7yehM8HmeaYuD+wrjsNSKIIs9+1HRXJpCRUse01AsPY3U8O0arEEKABDJhGsgicM4fA6CNKMNKwhq8o9SrHY8f/KIYu93RsUP75xZk7rK7L+/mtT+Qg9Pvxp3zfNInjr16YQ8UwpTJor71aAN8Eb5WnSQc+Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1542c4d4843811f1aa26b74ffac11d73-20260720
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:98fe691b-2941-42c6-908c-9b8520f2b40a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:98fe691b-2941-42c6-908c-9b8520f2b40a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:765c68286b450e9ea7e2b2e4253f738f,BulkI
	D:260720173546778U6DTU,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1542c4d4843811f1aa26b74ffac11d73-20260720
X-User: lienze@kylinos.cn
Received: from [192.168.3.106] [(61.48.211.50)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1879139922; Mon, 20 Jul 2026 20:39:43 +0800
Message-ID: <a55c6a62-4d27-4676-90b5-0db87f795b0a@kylinos.cn>
Date: Mon, 20 Jul 2026 20:39:40 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] samples/damon/mtier: use damon_addr_range consistently
To: sashiko-reviews@lists.linux.dev
Cc: damon@lists.linux.dev
References: <20260720092355.237599-1-lienze@kylinos.cn>
 <20260720093536.E22941F000E9@smtp.kernel.org>
Content-Language: en-US
From: Enze Li <lienze@kylinos.cn>
In-Reply-To: <20260720093536.E22941F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sashiko AI,

On 2026/7/20 17:35, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The commit message incorrectly claims `struct damon_addr_range` has an identical layout to `struct region_range`, masking a physical address truncation issue on 32-bit PAE architectures.
> - [Low] The refactoring removes a custom struct but leaves a redundant local variable `range` and unnecessary field-by-field copy operations.
> --
> 
> --- Patch [1]: [PATCH] samples/damon/mtier: use damon_addr_range consistently ---
> commit 71c06f0196fa4997fb5e79c1b3b9f9f2e74eb370
> Author: Enze Li <lienze@kylinos.cn>
> 
> samples/damon/mtier: use damon_addr_range consistently
> 
> This commit removes the local struct region_range and uses struct
> damon_addr_range for unified address range management.
> 
>> The DAMON provides struct damon_addr_range for unified address range
>> management.  However, the mtier sample still defines a local struct
>> region_range with an identical layout (start and end as phys_addr_t) and
>> mixes its usage with struct damon_addr_range in
> 
> [Severity: Medium]
> Is this description of struct damon_addr_range accurate?
> 
> Looking at include/linux/damon.h, struct damon_addr_range is defined with
> unsigned long fields, not phys_addr_t:
> 
> struct damon_addr_range {
> 	unsigned long start;
> 	unsigned long end;
> };
> 
> On 32-bit architectures with PAE, phys_addr_t is 64-bit while unsigned long
> is 32-bit, meaning assignments of physical addresses via PFN_PHYS() will
> silently truncate.
> 
> Could the commit message be updated to avoid stating they have identical
> layouts?

Thanks for catching this.  The commit message is inaccurate when
describing the two structs as having "identical layout".

I'll update the commit message in v2 to remove the "identical layout"
claim and instead describe the change as replacing the local struct
with struct damon_addr_range for consistency with the DAMON API.

> 
>> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
>> index ac9c24b92ead8..67f20b52dc7bb 100644
>> --- a/samples/damon/mtier.c
>> +++ b/samples/damon/mtier.c
> [ ... ]
>> @@ -78,8 +73,7 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
>>  	struct damos *scheme;
>>  	struct damos_quota_goal *quota_goal;
>>  	struct damos_filter *filter;
>> -	struct region_range addr;
>> -	struct damon_addr_range range;
>> +	struct damon_addr_range range, addr;
> 
> [Severity: Low]
> Since addr and range are now exactly the same type, is it still necessary to
> keep the separate range variable?
> 
> Further down in damon_sample_mtier_build_ctx(), there is a field-by-field
> copy that is now redundant:
> 
> 	range.start = addr.start;
> 	range.end = addr.end;
> 
> 	ret = damon_set_regions(target, &range, 1, DAMON_MIN_REGION_SZ);
> 
> Could we remove the range variable entirely and just pass &addr directly to
> damon_set_regions() instead?

Nice catch!  Now that both variables are struct damon_addr_range, the
separate range variable and the field-by-field copy are redundant.
damon_set_regions() only reads from the ranges array and doesn't modify
it, so passing &addr directly is safe.  I'll fold this into v2.

Thanks,
Enze

<...>

