Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44CD41AAC
	for <damon@lists.linux.dev>; Sun, 17 Aug 2025 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755426052; cv=none; b=f0dSMxyT9ENDJl3fZCfllww86CiBKXAuPjRGctSElKsWUq/90KTaXCPQIby+5xtikSL9AR0L/kYfDVfxz0fmgy0cUBwk9mYVo32PsjZgC/jplmwh3/Wvrz58IcQD4KLB8MBYJrMSKLvNQJVacKPgRsGGHbMNDBUIm38fjpHi5uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755426052; c=relaxed/simple;
	bh=EMuUloXzQZDsoKtMmsiBfBCd1Ta2o+QNVkOAiJSb4BA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kuyq30KJSVB+Ny7/uZj83nqtf9LROJhN7yFx0aSosJu1AjWCMjlVx+CJdo0yC90RDaV/LCoTHIwZa/VKqOoIIhjJdcVvnGdBCBBfG+rt/VIifvfOM4wAWA0E1tB42mltAM59sZYUsD7vd9yAqAGL2LHnkE9/O0zWrk5UY+csQYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d0a0082a7b5311f0b29709d653e92f7d-20250817
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:686dcfc2-a478-4d8e-9e7f-90bd4e72deb2,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:686dcfc2-a478-4d8e-9e7f-90bd4e72deb2,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:46a523637ac374c5b6c75a7463417c09,BulkI
	D:25081600591436S1C0WD,BulkQuantity:1,Recheck:0,SF:17|19|23|43|64|66|74|78
	|80|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:ni
	l,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,B
	RR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: d0a0082a7b5311f0b29709d653e92f7d-20250817
X-User: lienze@kylinos.cn
Received: from suse [(111.193.138.233)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1885358352; Sun, 17 Aug 2025 18:20:36 +0800
From: Enze Li <lienze@kylinos.cn>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org,  damon@lists.linux.dev,  linux-mm@kvack.org,
  enze.li@gmx.com
Subject: Re: [PATCH v2] mm/damon/Kconfig: make DAMON_STAT_ENABLED_DEFAULT
 depend on DAMON_STAT
In-Reply-To: <20250815165903.13330-1-sj@kernel.org> (SeongJae Park's message
	of "Fri, 15 Aug 2025 09:59:03 -0700")
References: <20250815165903.13330-1-sj@kernel.org>
Date: Sun, 17 Aug 2025 18:20:31 +0800
Message-ID: <bjoel05s.fsf@kylinos.cn>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hi SJ,

On Fri, Aug 15 2025 at 09:59:03 AM -0700, SeongJae Park wrote:

> On Fri, 15 Aug 2025 17:21:10 +0800 Enze Li <lienze@kylinos.cn> wrote:
>
>> The DAMON_STAT_ENABLED_DEFAULT option is strongly tied to DAMON_STAT
>> option -- enabling it alone is meaningless.  This patch makes
>> DAMON_STAT_ENABLED_DEFAULT depend on DAMON_STAT, ensuring functional
>
> s/depend/depends/ ?

I'm not well-versed in grammar, but using 'depends on' here feels a bit
weird to me.  After consulting grammar references, it seems to me that
I've found the answer.

In *Collins COBUILD English Grammar 4th* (Section 3.210, titled
transitive verbs with an infinitive without _to_), it says:

> A few verbs are followed by an object and an infinitive without to,
> not an -ing participle or a to-infinitive.  They are let, make, and
> have in the sense of cause to happen or experience.

It's somewhat like what we often call 'make the machine *work*'.  This
is my understanding.  If I misunderstood or missed something, please let
me know, I would be happy to submit v3 of the patch to fix the typo.

Best Regards,
Enze

[...]
