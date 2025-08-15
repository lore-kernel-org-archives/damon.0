Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14BD26E708
	for <damon@lists.linux.dev>; Fri, 15 Aug 2025 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249380; cv=none; b=uE7NV9tF432HekeqfwpiGgn+MPSLuVfRsOJoE6vvZJszPerkpFXKsZBezhy4pjCDkR94yRLxkwUBYEKMdTbcim+gyypEotYQfrl6lyByRiwT7b0GhZXkDq1kDKOpDjZKqyxW1i0VJVYz9uGzaLqlQSfwF3M84oeDLiovorU9xLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249380; c=relaxed/simple;
	bh=4G15cvbcMZaRqYdGdHMkisXsqQxUmVHS+bP5MLokZQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lQWGoMDNrRCmsd/DDAPq0LzYYaJVX4FkJzGdhcG/z/TpTv0XzItd9cyIADCBeVtVN7nVcbiCLKfi/gRHFHoWOXo9TDkEPNCibzMUQOmRKZVgz/GSHZfs6sORHiP+CsdBcRzeWehhHmkyesifclfPhJ3ZrsYCQdezJUm9wUP08pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 761695a079b811f0b29709d653e92f7d-20250815
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f11915a3-68c4-4069-9eb1-1092cd56b60d,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:f11915a3-68c4-4069-9eb1-1092cd56b60d,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:638da975861fe3bbe853ae5512f271c7,BulkI
	D:250815002500R9UDT29E,BulkQuantity:1,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 761695a079b811f0b29709d653e92f7d-20250815
X-User: lienze@kylinos.cn
Received: from kylin [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 380113571; Fri, 15 Aug 2025 17:16:01 +0800
From: Enze Li <lienze@kylinos.cn>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org,  damon@lists.linux.dev,  linux-mm@kvack.org,
  enze.li@gmx.com
Subject: Re: [PATCH] mm/damon/Kconfig: enforce DAMON_STAT when
 DAMON_STAT_ENABLED_DEFAULT is selected
In-Reply-To: <20250814162446.69575-1-sj@kernel.org> (SeongJae Park's message
	of "Thu, 14 Aug 2025 09:24:46 -0700")
References: <20250814162446.69575-1-sj@kernel.org>
Date: Fri, 15 Aug 2025 17:15:54 +0800
Message-ID: <87a541c5dh.fsf@kylinos.cn>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hi SJ,

On Thu, Aug 14 2025 at 09:24:46 AM -0700, SeongJae Park wrote:

> Hi Enze,
>
> On Thu, 14 Aug 2025 20:17:03 +0800 Enze Li <lienze@kylinos.cn> wrote:
>
>> The DAMON_STAT_ENABLED_DEFAULT option is strongly tied to
>> DAMON_STAT -- enabling it alone is meaningless.
>
> Nice catch, thank you Enze!
>
>> This patch modifies the
>> logic to automatically enable DAMON_STAT whenever
>> DAMON_STAT_ENABLED_DEFAULT is selected, ensuring functional consistency.
>> 
>> Signed-off-by: Enze Li <lienze@kylinos.cn>
>> ---
>>  mm/damon/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
>> index b3171f9406c1..5bc71354e6f3 100644
>> --- a/mm/damon/Kconfig
>> +++ b/mm/damon/Kconfig
>> @@ -105,7 +105,7 @@ config DAMON_STAT
>>  config DAMON_STAT_ENABLED_DEFAULT
>>  	bool "Enable DAMON_STAT by default"
>>  	depends on DAMON_PADDR
>> -	default DAMON_STAT
>> +	select DAMON_STAT

Thanks for your review.  I've updated the patch addressing all your
comments below.  And I'll send the new version to the list shortly.

>
> I don't think we need to drop 'default DAMON_STAT', though.
>
> To me, it seems the problem is the wrong dependency.  What about making
> DAMON_STAT_ENABLED_DEFAULT depends on DAMON_STAT, like below?
>
> """
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> index ecbdb3e2ae58..d5f8db812dd3 100644
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -104,7 +104,7 @@ config DAMON_STAT
>
>  config DAMON_STAT_ENABLED_DEFAULT
>         bool "Enable DAMON_STAT by default"
> -       depends on DAMON_PADDR
> +       depends on DAMON_STAT
>         default DAMON_STAT
>         help
>           Whether to enable DAMON_STAT by default.  Users can disable it in
> """
>
> Also, the subject sounds like a bit strong tone ("enforce").  How about
>
> "mm/damon/Kconfig: make DAMON_STAT_ENABLED_DEFAULT depends on DAMON_STAT" ?
>

Best Regards,
Enze
