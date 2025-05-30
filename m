Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D728E7
	for <damon@lists.linux.dev>; Fri, 30 May 2025 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748584093; cv=none; b=IG/J7r2WSqyUgaaGX+8lmcrnRz803NozykaKFnHSSOKaruvQtvhJ1id+oF+7UnE/mxqxCwlK58pkskNHLsGgiGgrT2FdQR+/kt6SUdO3bCTldr3PbGx3a7dHc6lkDhVCmYdloBbB0oLfAEsAXVYuyEveiSyZf4BRkhbR+4+cIAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748584093; c=relaxed/simple;
	bh=G43bIx4p2duaYMALuzvfq819SzZLLuOaUYPg98TLiZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dk5gFfvqukqSJKH5MEU5jTnOqtazNCa7gTfZVMAFlinNt0ZMvd81xVey5uL8CdHTn2YQ5OoIyjQKaATtIfTue3oxVFTiw1BDzH6ZRloCsqcTMJ5fDHS5ydU2duiYDuqm9NGdUbw2BinQZMlyA9YMcVvZiNRx8FVo/0Cp8rq8Is4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a79a296a3d1911f0b29709d653e92f7d-20250530
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:4377c0d8-d712-442b-999d-7ab530df9c28,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:4377c0d8-d712-442b-999d-7ab530df9c28,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:2b542cda65b2a2464b48f809680049d5,BulkI
	D:250525002921A3G68U33,BulkQuantity:5,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:ni
	l,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,B
	RR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,
	TF_CID_SPAM_FAS
X-UUID: a79a296a3d1911f0b29709d653e92f7d-20250530
X-User: lienze@kylinos.cn
Received: from kylin [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1968929961; Fri, 30 May 2025 13:48:04 +0800
From: Enze Li <lienze@kylinos.cn>
To: SeongJae Park <sj@kernel.org>
Cc: David Hildenbrand <david@redhat.com>,  akpm@linux-foundation.org,
  damon@lists.linux.dev,  linux-mm@kvack.org,  enze.li@gmx.com
Subject: Re: [PATCH] mm/damon: rename primitives to operations
In-Reply-To: <20250529172647.38178-1-sj@kernel.org> (SeongJae Park's message
	of "Thu, 29 May 2025 10:26:47 -0700")
References: <20250529172647.38178-1-sj@kernel.org>
Date: Fri, 30 May 2025 13:47:59 +0800
Message-ID: <87cybqy7hs.fsf@kylinos.cn>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Hi SeongJae,

On Thu, May 29 2025 at 10:26:47 AM -0700, SeongJae Park wrote:

> On Mon, 26 May 2025 10:55:24 -0700 SeongJae Park <sj@kernel.org> wrote:
>
> [...]
>> Maybe "mm/damon: s/primitives/code/ on comments" could also be a simple and not
>> that bad title?
>
> I understand we found no real concern on this. :)  Thanks to all discussion
> participants and their patience.  Of course, just add more comments if you just
> forgot posting it and I'm rushing.
>
> Enze, could you please post v3 with the updated title?

I've sent the v3 here [1].  Thank you for reviewing, and my appreciation
to David as well.

[1] https://lore.kernel.org/all/20250530053115.153238-1-lienze@kylinos.cn/

BR,
Enze

[...]
