Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85AA847B
	for <damon@lists.linux.dev>; Thu, 22 May 2025 01:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747878811; cv=none; b=KmT2IhDBjrIOllIDbJ+wl5INEeLDHannpUrOI22ez2XkAcMi09OYwiljj0r/1BOttrkIlwQGIJNxWYL6/EjK4ECq/TzTZcWaik5m7EEPulxTLPZyAdPrVxW4wkGvLFL9U/dHRWDl8MqcD+dhQsCy/8OHfI80Cv/0qVeB0LyR9do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747878811; c=relaxed/simple;
	bh=6OwdtTVbLOu1tIMaWVgFKAemRAtHxGOIunsYNS+Qcyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UIXpy53f1QZJkDSyOkc96vjlzm/de6/QP6vJXizInLTbyLH/lckTU9jAPwtsKYMs3G2x1b0BHc2XXF06CJkf6/ESyA6PlCNO/RFB7vhkOpvVc09vBeWK7NxI7KZWl3hkRakYGO3/Q/jdLqrkOH39r2k8EPc69zQHVA2jbsc8xC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8a23922436af11f0b29709d653e92f7d-20250522
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c821cea4-a355-4b44-99d3-0bcf64062b11,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:c821cea4-a355-4b44-99d3-0bcf64062b11,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:a1461e57dd2e57e191e01e19e291a9e1,BulkI
	D:250522095322UGCVLHWK,BulkQuantity:0,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 8a23922436af11f0b29709d653e92f7d-20250522
X-User: lienze@kylinos.cn
Received: from kylin [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 280034327; Thu, 22 May 2025 09:53:21 +0800
From: Enze Li <lienze@kylinos.cn>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,  linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: make region calculations more precise
In-Reply-To: <20250521171809.45618-1-sj@kernel.org> (SeongJae Park's message
	of "Wed, 21 May 2025 10:18:09 -0700")
References: <20250521171809.45618-1-sj@kernel.org>
Date: Thu, 22 May 2025 09:53:17 +0800
Message-ID: <87bjrl9zsi.fsf@kylinos.cn>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Hi SeongJae,

On Wed, May 21 2025 at 10:18:09 AM -0700, SeongJae Park wrote:

> Hi Enze,
>
> On Wed, 21 May 2025 15:07:47 +0800 Enze Li <lienze@kylinos.cn> wrote:
>
>> The damon_sz_region() function misses counting one element when
>> calculating region size, which leads to inaccurate results.  This patch
>> corrects the size calculation by properly accounting for all elements.
>
> Thank you for this patch, but I don't think the current calculation is wrong.
> Please refer to the below comment.
>
>> 
>> Signed-off-by: Enze Li <lienze@kylinos.cn>
>> ---
>>  include/linux/damon.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index 47e36e6ea203..70473863f7fe 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -808,7 +808,7 @@ static inline struct damon_region *damon_first_region(struct damon_target *t)
>>  
>>  static inline unsigned long damon_sz_region(struct damon_region *r)
>>  {
>> -	return r->ar.end - r->ar.start;
>> +	return r->ar.end - r->ar.start + 1;
>>  }
>
> 'ar' here is 'struct damon_addr_range' which is for a half-open range.  Refer
> to the comment on 'struct damon_addr_range' definition on include/linux/damon.h
> for detail.  So I don't think the current calculation is wrong.

Thanks for pointing out this - I overlooked it :(

>
> If you think this function also deserves a short comment for clarifying this,
> your patch for that wil be welcomed :)

Since this is already documented in the definition, repeating it here
would be redundant.  If someone submits a similar patch for this in the
future, we can consider adding comments then.

Thanks,
Enze

[...]

>
> Please let me know if I'm missing something.
>
>
> Thanks,
> SJ
>
> [...]
