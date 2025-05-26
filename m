Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638151DD0D4
	for <damon@lists.linux.dev>; Mon, 26 May 2025 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748240756; cv=none; b=UK+dt04FTjqQSoRMBd4QB9JgluPgVkMMOoNgOX2BT+3OXxeA5zV8fv0BzUVn4B6mOhDojS0nnbPBTvu3oPBZRCct/hbmI3i1EIXo7xT8Q7+hnbXoXrHigvElBwwk/s8D+MKh3zi6AGJNulwMcX74RTKL1UMdiUhcDMhiQ2culbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748240756; c=relaxed/simple;
	bh=1MPK523cgDXGxmxGVzEA0EV7x60bRPN62N4ix/A8lok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EnG2JQk4chkdAmxMMEUb5TgU7D6rxlIaafuXfCcw3vbWCGKNI71zZerQJnE76Qwgqivt/CSehXNTNQ1Z1A+cFgXo0YSKfQi1VLXWCKWd7TAW3bZvorNG+w66mbjGOqT29NZAqbt7Syf7u2AmC6MAzBYCk1z2SsMrXCurmdBsffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 40defaf639fa11f0b29709d653e92f7d-20250526
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0ef67ac9-50ff-43d7-a514-de6e4e3b6474,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:0ef67ac9-50ff-43d7-a514-de6e4e3b6474,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:0df382a171e0d4dcff09dddc0bf4a5bc,BulkI
	D:250525002921A3G68U33,BulkQuantity:1,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 40defaf639fa11f0b29709d653e92f7d-20250526
X-User: lienze@kylinos.cn
Received: from kylin [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1241588134; Mon, 26 May 2025 14:25:44 +0800
From: Enze Li <lienze@kylinos.cn>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org,  damon@lists.linux.dev,  linux-mm@kvack.org,
  enze.li@gmx.com
Subject: Re: [PATCH] mm/damon: rename primitives to operations
In-Reply-To: <20250524162910.67889-1-sj@kernel.org> (SeongJae Park's message
	of "Sat, 24 May 2025 09:29:10 -0700")
References: <20250524162910.67889-1-sj@kernel.org>
Date: Mon, 26 May 2025 14:25:40 +0800
Message-ID: <87o6vfj3bv.fsf@kylinos.cn>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hi SeongJae,

On Sat, May 24 2025 at 09:29:10 AM -0700, SeongJae Park wrote:

> Hi Enze,
>
> On Sat, 24 May 2025 20:55:36 +0800 Enze Li <lienze@kylinos.cn> wrote:
>
>> The word 'primitive' is not explicit and has been deprecated in DAMON's
>> context since commit f7d911c39cbb ("mm/damon: rename damon_primitives to
>> damon_operations").  To make the code easier to be understand, this
>> commit renames remaining 'primitives' to 'operations' in header comments
>> of DAMON source files.
>
> Thank you for this patch!  The description makes sense to me.
>
> The title makes me bit confused, though.  By reading it, I was assuming this
> patch is changing some code.  But this is changing only comments.  Could you
> please make the title more clearly specify that?  E.g., "fix outdated comments
> for monitoring primitives"?
>
>> 
>> Fixes: f7d911c39cbb ("mm/damon: rename damon_primitives to damon_operations")
>> Signed-off-by: Enze Li <lienze@kylinos.cn>
>> ---
>>  mm/damon/modules-common.c | 2 +-
>>  mm/damon/modules-common.h | 2 +-
>>  mm/damon/ops-common.c     | 2 +-
>>  mm/damon/ops-common.h     | 2 +-
>>  mm/damon/paddr.c          | 2 +-
>>  mm/damon/sysfs-common.c   | 2 +-
>>  mm/damon/sysfs-common.h   | 2 +-
>>  mm/damon/vaddr.c          | 2 +-
>>  8 files changed, 8 insertions(+), 8 deletions(-)
>
> But, the term (primitives) on the comments of the files means the DAMON
> monitoring primitives (old name of DAMON operations) only in {p,v}addr.c files.
> On the comment of other files, the term means code for basic and common uses.
>
> Using 'Operations' term on the files look ok to me.  But in the case, the
> commit message may better to slightly be updated to clarify this.
>
> Just keeping those files to use 'Primitives' term, or using a more neutral
> term, say, Code (e.g., Common Code for DAMON Modules) could also be options, in
> my opinion.
>
> I have no strong preference among these three options.  Please pick what you
> prefer.

Thanks for your suggestion.  It seems to me that using 'Code' term is a
reasonable choice.

>
> Could you please revise as abovely suggested and resend?

I've sent a v2 to the current thread, many thanks for your review and
suggestions!  Please let me know if further adjustments are needed.

BR,
Enze

>
>
> Thanks,
> SJ
>
> [...]
