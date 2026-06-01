Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE66187346
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780278385; cv=none; b=HJzJtmr1T5gvJ5wvPu/Lnv8eUxzuKbrppt3OEG9cvItjM6zYBBs2M6Pjr4qjAA/Z+3Og8sBRuLrdwbG2zjBMntARk8cZA/JRhIoMK55esB7APmAKOXUHugY+GE6XZ0GmauEvu9S3I7YW+m8MuuDgHspxMuW61oE2Hy41Kpz+IDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780278385; c=relaxed/simple;
	bh=FkJk4eI44HDzOGZFIGth9gQlOvPgscM82zTqXXI4GkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QrMCGyvQFAOQMjKBbBHJ5GtdyYc8S6veRrZxv9svDzHhhH7HsQM3AhX8ASV5wtrEecngsU6pgG48M8hYA9JqtLr5DOlvFVxVi1MJ9XUb8dJp3oflYUJB9azvNlPP0p5j+wEjKQ/LR6o51ey6TAGclToRzKEn3/c+FzwnFJGT3hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW004-1.hihonor.com (unknown [10.77.232.85])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4gTGwg2flLzYvXcX;
	Mon,  1 Jun 2026 09:44:35 +0800 (CST)
Received: from TA006-1.hihonor.com (10.77.232.151) by TW004-1.hihonor.com
 (10.77.232.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 09:46:14 +0800
Received: from TA003.hihonor.com (10.72.0.43) by TA006-1.hihonor.com
 (10.77.232.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Jun
 2026 09:45:33 +0800
Received: from TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1]) by
 TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1%7]) with mapi id
 15.02.2562.037; Mon, 1 Jun 2026 09:46:14 +0800
From: wangtao <tao.wangtao@honor.com>
To: Lorenzo Stoakes <ljs@kernel.org>
CC: Barry Song <baohua@kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org"
	<david@kernel.org>, "willy@infradead.org" <willy@infradead.org>,
	"sj@kernel.org" <sj@kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"luizcap@redhat.com" <luizcap@redhat.com>, "zhangjiao2@cmss.chinamobile.com"
	<zhangjiao2@cmss.chinamobile.com>, "kas@kernel.org" <kas@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "liam@infradead.org" <liam@infradead.org>,
	"vbabka@kernel.org" <vbabka@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>,
	"surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"jack@suse.cz" <jack@suse.cz>, "riel@surriel.com" <riel@surriel.com>,
	"harry@kernel.org" <harry@kernel.org>, "jannh@google.com" <jannh@google.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"peterx@redhat.com" <peterx@redhat.com>, "ziy@nvidia.com" <ziy@nvidia.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"npache@redhat.com" <npache@redhat.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "dev.jain@arm.com" <dev.jain@arm.com>,
	"lance.yang@linux.dev" <lance.yang@linux.dev>, "xu.xin16@zte.com.cn"
	<xu.xin16@zte.com.cn>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
	"matthew.brost@intel.com" <matthew.brost@intel.com>,
	"joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>, "rakie.kim@sk.com"
	<rakie.kim@sk.com>, "byungchul@sk.com" <byungchul@sk.com>,
	"gourry@gourry.net" <gourry@gourry.net>, "ying.huang@linux.alibaba.com"
	<ying.huang@linux.alibaba.com>, "apopple@nvidia.com" <apopple@nvidia.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryncsn@gmail.com" <ryncsn@gmail.com>,
	"jparsana@google.com" <jparsana@google.com>, "dvander@google.com"
	<dvander@google.com>, zhangji <zhangji1@honor.com>, wangzicheng
	<wangzicheng@honor.com>
Subject: RE: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Thread-Topic: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Thread-Index: AQHc7cjw5r5ki6LAJ0S2mW/rJEfblbYhaeaAgAGnM1D//4FNAIABAA8AgAEgmrD//7GxAIAEjCKQ
Date: Mon, 1 Jun 2026 01:46:14 +0000
Message-ID: <a90bcb0fa3a044588350e92a78258a09@honor.com>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <ahcANgFDFwfC0v1q@lucifer> <b24b4a8198ba412f8b8b42c43dccd058@honor.com>
 <ahf2mJg9OOWvu0jA@lucifer>
 <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>
 <99dfc4a50f3643a6bef6deaeccfcf115@honor.com> <ahlzj--3Gm5pD9ge@lucifer>
In-Reply-To: <ahlzj--3Gm5pD9ge@lucifer>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

> > Previously, I also considered converting anon_vma's rb_tree to a
> > mapletree. If one entry records a single VMA, the average overhead
> > could be less than two longs per VMA.
> >
> > However, unlike rb_tree, mapletree does not support storing multiple
> > elements under a single key. The key would need to look like
> > (vma_id/mm_id + pgoff). On 32-bit platforms, since 64-bit mapletree
> > keys are not supported yet, the remaining
> > 12 bits are not enough for vma_id/mm_id.
> >
> > Because of this limitation, I later started thinking about ways to
> > reduce anon_vma allocations instead.
> >
> > I will try to find some time next week to analyze the cow-context
> > design and code more thoroughly, and then write up a summary.
>=20
> Tao,
>=20
> This response is so full of misunderstandings it's not really worth me
> responding to any of it. You've even hallucinated an imaginary field whic=
h is
> REALLY suspicious.
>=20
> You've no mm expertise or history and came up with this in a few hours. I
> asked Claude to analyse it and it puts it at 75-80% chance of being solel=
y LLM-
> generated from cow_context.c.
>=20
> I simply don't have the time to deal with this, so unfortunately I'm goin=
g to
> have to withdraw the suggestion of further discussion with you on this to=
pic.
>=20
> I am working on the scalable CoW project and will solicit opinions of tho=
se
> with relevant expertise.
>=20
> We are not interested in your approach or analysis.
>=20
> Thanks, Lorenzo

You said discussion was welcome, yet when someone offered even a =20
small comment, you refused to continue the discussion.

If I had known you would be this inconsistent, I would not have =20
replied to you in the first place.

This will be my last reply to you. I will not respond again.

Consider the following test case:
Process P creates 1000 VMAs with mmap, named vma_1, vma_2, ..., =20
vma_1000.

Then it forks child processes C_1, C_2, ..., C_1000. Each child =20
process C_k keeps only vma_k and munmaps all other vma_i.

With the current anon_vma, reclaim walking each page only needs =20
to handle two VMAs (vma_k in process P and vma_k in process C_k).

But under the CoW approach, reclaiming each page needs to walk =20
1000 processes, then spend O(log(#remap_entries)) time to check =20
whether a remap_entry exists, and then O(log(#vmas)) time to =20
locate the VMA.

Both the code complexity and the time complexity of the reverse =20
walk are much higher than the current anon_vma approach.
=20
