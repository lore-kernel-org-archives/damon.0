Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83864A08
	for <damon@lists.linux.dev>; Wed, 15 Oct 2025 02:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496420; cv=none; b=YH5hVbah0Oaraok//dcCQ0HdRZcZOSr3wwjV6GVfrdDeBk0V+mc5sOvd+neSBL6NIwlC4+4PonZr91Qub5tVNC80P1FDbkpItKDCxKpFGsGsoMlZ9JE6Z63tQy6f9SEFFaFbTLHv9paMSfxJLZVx9dMeTCIaeBiTIfkP8iMVrtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496420; c=relaxed/simple;
	bh=XS+3nK1BnRvOIp4LKu6oXf90Fy391rdzNFFb9ba3C/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EJ0rm3gUq2NLDy/r959bvsQJBWm8sZjp2eGA7fxu3ERPDZc94snHtbr8ZL7vClyg8fjstvrKnBwCn8WcFMBu5ukKZUuHtPUIezlX39ZwFsmRcKyOvmgPrjB7DNAvRNj+jHsL6PMr7JFE13GmAC3aXwU5oUUsy7LyDuFanK/Xmqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 33614046a97111f0a38c85956e01ac42-20251015
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_MISS, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:9de399e0-e403-4388-8d89-3a9026aa03b2,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-5
X-CID-INFO: VERSION:1.3.6,REQID:9de399e0-e403-4388-8d89-3a9026aa03b2,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:f7674e290a18d7778a8da14655b245f1,BulkI
	D:25101510465334PBUK1N,BulkQuantity:0,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841|850,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:n
	il,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 33614046a97111f0a38c85956e01ac42-20251015
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1506227250; Wed, 15 Oct 2025 10:46:50 +0800
From: Enze Li <lienze@kylinos.cn>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org,  damon@lists.linux.dev,  linux-mm@kvack.org,
  enze.li@gmx.com, lienze@kylinos.cn
Subject: Re: [PATCH] mm/damon/core: fix potential memory leak by cleaning
 ops_filter in damon_destroy_scheme
In-Reply-To: <20251014182539.50115-1-sj@kernel.org> (SeongJae Park's message
	of "Tue, 14 Oct 2025 11:25:38 -0700")
References: <20251014182539.50115-1-sj@kernel.org>
Date: Wed, 15 Oct 2025 10:46:47 +0800
Message-ID: <87jz0wg9uw.fsf@>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hi SJ,

On Tue, Oct 14 2025 at 11:25:38 AM -0700, SeongJae Park wrote:

> On Tue, 14 Oct 2025 16:42:25 +0800 Enze Li <lienze@kylinos.cn> wrote:
>
>> Currently, damon_destroy_scheme() only cleans up the filter list but
>> leaves ops_filter untouched, which could lead to memory leaks when
>> a scheme is destroyed.
>> 
>> This patch ensures both filter and ops_filter are properly freed in
>> damon_destroy_scheme(), preventing potential memory leaks.
>
> Thank you for fixing this!
>
> FYI the leak is not only potential but can easily be reproduced using the ops
> damos filters.  For example, I was able to reproduce it using DAMON user-space
> tool (damo), like below.
>
>     $ sudo ./damo start
>     $ sudo ./damo report access --snapshot_damos_filter allow anon
>
> After the above steps I confirmed it leaks the memory using kmemleak.

Thank you for the review.

Considering that similar memory leak issues might occur elsewhere in the
future, should we consider exploring the introduction of Rust for
certain modules as a proactive measure?

My search through the mailing list archives didn't reveal similar
discussions, though I might have missed them.  Would you be open to
sharing your insights on this matter?

Best Regards,
Enze

<...>
