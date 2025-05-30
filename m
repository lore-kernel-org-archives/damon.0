Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF6BD27E
	for <damon@lists.linux.dev>; Fri, 30 May 2025 01:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748570269; cv=none; b=ZkZyhSKXYp/aakPcLHj4t+Qx1jmBCycx/scQEzJaCujIiPHG0GxSsd0xlsu7LNakZTA5pxZ3Zb7I1G2BPiF05xQIpDbvdBCZdN+SunF4gwG3OnBkKAHRRtVP2sIZXduFUN99fpnboryPN9lG8X4P6Mucdtf8FA1iG/eUUR1vI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748570269; c=relaxed/simple;
	bh=pu/OcY81RBtAl3n/R0OjB5D2YC6MUuixLSY70+as4QA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YjwYFcLqyUC+ZWLWjArXGbH1qXZcCCP+fsiLtPKcSw1dRsllq+uNuUMM/LjwT8ZcFSpRrrq1unsiSXtNfzetQkp8vNRM+BPBgsdTg/ExGVELcrS+9lawMnxZIxijvGGlsFD+BWf7q1HsrMB84bmTvY/TdwK5oxDx9AHrdOcyu5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 74e38d103cf911f0b29709d653e92f7d-20250530
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a51e0a33-8f11-44e6-83e6-685fd3ab070f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:a51e0a33-8f11-44e6-83e6-685fd3ab070f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:150ad003dd3e19c2581831ffb30615a7,BulkI
	D:250525002921A3G68U33,BulkQuantity:4,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 74e38d103cf911f0b29709d653e92f7d-20250530
X-User: lienze@kylinos.cn
Received: from kylin [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 42566546; Fri, 30 May 2025 09:57:35 +0800
From: Enze Li <lienze@kylinos.cn>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org,  damon@lists.linux.dev,  linux-mm@kvack.org,
  enze.li@gmx.com
Subject: Re: [PATCH] mm/damon: rename primitives to operations
In-Reply-To: <20250526180921.2932-1-sj@kernel.org> (SeongJae Park's message of
	"Mon, 26 May 2025 11:09:21 -0700")
References: <20250526180921.2932-1-sj@kernel.org>
Date: Fri, 30 May 2025 09:57:31 +0800
Message-ID: <87h612yi5w.fsf@kylinos.cn>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 26 2025 at 11:09:21 AM -0700, SeongJae Park wrote:

> On Mon, 26 May 2025 14:25:40 +0800 Enze Li <lienze@kylinos.cn> wrote:
>
>> Hi SeongJae,
>> 
>> On Sat, May 24 2025 at 09:29:10 AM -0700, SeongJae Park wrote:
> [...]
>> >
>> > Could you please revise as abovely suggested and resend?
>> 
>> I've sent a v2 to the current thread,
>
> I think it is more common to send new versions of a patch as a new thread,
> rather than as a reply to an old version.  Please do so from next time, for a
> consistency.

Noted -- I'll keep that in mind.

BR,
Enze

[...]
