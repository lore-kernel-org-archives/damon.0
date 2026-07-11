Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7384086A
	for <damon@lists.linux.dev>; Sat, 11 Jul 2026 05:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783746720; cv=none; b=IqUOpA0WNt2azwRTsGj/DuGBlndLLGDIEV7ACfuKrVPYkpCDMQYIzSEQ4ogriFSetnLoagGNkAE1ax2XC30hFmvU/hlVhRO2TqU9e8B5qyhtKoFw4ah9FNP6R0d9OYncpcbly6TxWfiW3E/3RPt+Qry3vmCPI7z1sPJ7IxgQwA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783746720; c=relaxed/simple;
	bh=kU/z17lCDV8MaBIA0KgfNL7L7Xi6hXB8fGla5gr40Gw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gxoV3/J80EjhgEQg2ktQ/rwDMwORPzj/26vQP1mPNMA5kDE8asvpMAScNFk5OJzNI42ViNY1M+rksuiFRI2DNOFqqSDm+OxWr41skhSGHIGq5ytSzhUpZfXxyReZ8Pk3jw3GDN7u//Jm6uostAjVGfAQg/hRdcZTo0oWnipjNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 048ab6cc7ce711f1aa26b74ffac11d73-20260711
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_QP, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_MAILER_MTBG
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_UNTRUSTED, SN_UNFAMILIAR
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_C_CI, GTI_FG_IT, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c4f4e401-dc88-4d47-9040-54b3aed482a8,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:c4f4e401-dc88-4d47-9040-54b3aed482a8,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:a6d662c7724aa7a570282950bd995e40,BulkI
	D:260710220255YPJJGYNN,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|865|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:99|1,File:
	nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:
	0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 048ab6cc7ce711f1aa26b74ffac11d73-20260711
X-User: husong@kylinos.cn
Received: from ehlo.thunderbird.net [(223.160.130.75)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1057582826; Sat, 11 Jul 2026 13:11:48 +0800
Date: Sat, 11 Jul 2026 13:11:42 +0800
From: Song Hu <husong@kylinos.cn>
To: SJ Park <sj@kernel.org>
CC: akpm@linux-foundation.org, shu17az@gmail.com, jiayuan.chen@shopee.com,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/tests/core-kunit: test damon_nr_accesses_mvsum()
User-Agent: Thunderbird for Android
In-Reply-To: <20260710140238.24103-1-sj@kernel.org>
References:  <20260710140238.24103-1-sj@kernel.org>
Message-ID: <B4B6791A-5400-4342-B43D-FA9C7895E7BF@kylinos.cn>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E4=BA=8E 2026=E5=B9=B47=E6=9C=8810=E6=97=A5 GMT+08:00 22:02:37=EF=BC=8CSJ=
 Park <sj@kernel=2Eorg> =E5=86=99=E9=81=93=EF=BC=9A
>On Fri, 10 Jul 2026 12:15:30 +0800 Song Hu <husong@kylinos=2Ecn> wrote:
>
>> damon_nr_accesses_mvsum() wraps damon_mvsum() with the monitoring
>> intervals of the context to compute the pseudo moving sum of a region's
>> access frequency, with a special case for when the whole aggregation
>> window remains=2E damon_mvsum() itself is already covered by
>> damon_test_mvsum(), but the wrapper is not=2E
>>=20
>> Add a table-driven KUnit test that exercises the full-window-remaining
>> boundary (with both reset and not-yet-reset nr_accesses), partially
>> elapsed windows, and the no-window-remaining case=2E
>
>Nice!  Thank you!
>
>>=20
>> Signed-off-by: Song Hu <husong@kylinos=2Ecn>
>> ---
>>  mm/damon/tests/core-kunit=2Eh | 49 +++++++++++++++++++++++++++++++++++=
++
>>  1 file changed, 49 insertions(+)
>>=20
>> diff --git a/mm/damon/tests/core-kunit=2Eh b/mm/damon/tests/core-kunit=
=2Eh
>> index 0124f83b39b8=2E=2E8c030282a638 100644
>> --- a/mm/damon/tests/core-kunit=2Eh
>> +++ b/mm/damon/tests/core-kunit=2Eh
>> @@ -683,6 +683,54 @@ static void damon_test_mvsum(struct kunit *test)
>>  	}
>>  }
>> =20
>> +/*
>> + * Test damon_nr_accesses_mvsum(), which wraps damon_mvsum() with the =
monitoring
>
>Please wrap lines [1] for 80 columns limit=2E

Hi SJ,

Thanks for your review=2E This was my mistake, and I will resolve it in th=
e next patch version=2E

>
>> + * intervals of the context=2E  With a sample interval of 1 and an agg=
regation
>> + * interval of 10, an aggregation window is 10 sample intervals long=
=2E  Each row
>> + * below specifies the passed sample intervals, the next aggregation t=
ime in
>> + * sample intervals, the current and last nr_accesses of a region, and=
 the
>> + * expected return value=2E
>> + */
>> +static void damon_test_nr_accesses_mvsum(struct kunit *test)
>> +{
>> +	unsigned long input_expects[] =3D {
>> +		/* passed, next_aggr, nr_accesses, last_nr_accesses, expect */
>> +		0, 10, 5, 3, 3,		/* bp=3D10000: unreset nr_accesses ignored */
>
>I was bit confused what 'bp' means=2E  Can we just drop 'bp=3D=2E=2E=2E:'=
 part from the
>comment?
>

This explanation is just my personal guess=2E I will delete all uncertain =
content in the revised patch=2E

Thanks,
Song

>Also, let's keep the 80 columns limit=2E
>
>[=2E=2E=2E]
>
>Other than those, looks good to me!
>
>[1] https://docs=2Ekernel=2Eorg/process/coding-style=2Ehtml#breaking-long=
-lines-and-strings
>
>
>Thanks,
>SJ
