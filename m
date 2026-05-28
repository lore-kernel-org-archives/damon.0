Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1A0332EDE
	for <damon@lists.linux.dev>; Thu, 28 May 2026 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779950714; cv=none; b=YzX+R7hCtl9bSNiNKZxEpsxcyasCke7GQGFCQYrs55tLJPAEeUDtPhGoWXJbKkizfONM6LOyj11i39qYSA6KZ65FFrBflK2dXlWk2GSjYyovKZAwOqyVtb0Z1rtFvVgC0NwSVe6j26wNnYU/YwCkrg4FqfYReatQ4po+kyK/ZiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779950714; c=relaxed/simple;
	bh=Ot6OpxNNyOBX4pLscljD46ptWQMXAD5xf9iVqPL3Rhs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eT7oskJeC8J9lR5K2g1ZQ/vln3nsnUD87PU24upiehezpnpzYNeWgaAr4WuW1rTXmi4KMW/8ZyEP7gO+oW89AZEaWHj8y6tJR9iXEeiHgQimz8SdcCSvZKjRjZDPnGE4eThNG+kD8XnfC1KBmcV6y/TQzDbXVchIjOa1weUnFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW003.hihonor.com (unknown [10.77.199.161])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4gQxld3QdDzYnVHF;
	Thu, 28 May 2026 14:43:41 +0800 (CST)
Received: from TA005-1.hihonor.com (10.77.216.68) by TW003.hihonor.com
 (10.77.199.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 14:45:04 +0800
Received: from TA003.hihonor.com (10.72.0.43) by TA005-1.hihonor.com
 (10.77.216.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 28 May
 2026 14:45:05 +0800
Received: from TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1]) by
 TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1%7]) with mapi id
 15.02.2562.037; Thu, 28 May 2026 14:45:07 +0800
From: wangtao <tao.wangtao@honor.com>
To: Pedro Falcato <pfalcato@suse.de>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@kernel.org" <david@kernel.org>, "willy@infradead.org"
	<willy@infradead.org>, "sj@kernel.org" <sj@kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, "luizcap@redhat.com" <luizcap@redhat.com>,
	"zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>,
	"kas@kernel.org" <kas@kernel.org>, "ljs@kernel.org" <ljs@kernel.org>,
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
	"baohua@kernel.org" <baohua@kernel.org>, "lance.yang@linux.dev"
	<lance.yang@linux.dev>, "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
	"matthew.brost@intel.com" <matthew.brost@intel.com>,
	"joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>, "rakie.kim@sk.com"
	<rakie.kim@sk.com>, "byungchul@sk.com" <byungchul@sk.com>,
	"gourry@gourry.net" <gourry@gourry.net>, "ying.huang@linux.alibaba.com"
	<ying.huang@linux.alibaba.com>, "apopple@nvidia.com" <apopple@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryncsn@gmail.com" <ryncsn@gmail.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "jparsana@google.com"
	<jparsana@google.com>, "dvander@google.com" <dvander@google.com>, zhangji
	<zhangji1@honor.com>, wangzicheng <wangzicheng@honor.com>
Subject: RE: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Thread-Topic: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Thread-Index: AQHc7cjw5r5ki6LAJ0S2mW/rJEfblbYhNMwAgAHH2gA=
Date: Thu, 28 May 2026 06:45:07 +0000
Message-ID: <800d894e9a54440fa1d7f7b76e50a45b@honor.com>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <ahbSwczOpsBKby7o@pedro-suse>
In-Reply-To: <ahbSwczOpsBKby7o@pedro-suse>
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

> >
> > Feedback and suggestions are welcome.
>=20
> I'm afraid, per previous discussions[1], that no one is really willing to=
 maintain
> extra complexity for the current state of anon rmap and anon vmas.
> Sorry :/
>=20
> Also, please don't send series this large without previous discussion and=
 _at
> least_ an RFC tag.
>=20
> [1] https://lore.kernel.org/all/aec533b2-37a7-4f44-a279-
> c4aa604206ac@lucifer.local/
>=20
> --
> Pedro

Thank you very much for your reply.

As I am not very good at english, I haven't participated much in community =
discussions before and I'm still not very familiar with the usual process.
I realize now that I should probably have started with a discussion thread =
first, and that this patch series would have been more appropriate with an =
RFC tag.=20
I apologize for that.

I will read the discussion in [1] more carefully. I also noticed the relate=
d code here:
https://git.kernel.org/pub/scm/linux/kernel/git/ljs/linux.git/log/?h=3Dproj=
ect/cow-context

Many years ago I had already noticed that data structures such as vma, page=
_table, and anon_vma consume a significant amount of memory.
However, since the mm subsystem is quite complex, I didn't look into it in =
depth at the time.
Recently, with memory costs increasing, I revisited these structures and an=
alyzed their memory usage again.=20
Since anon_vma seems to have a relatively smaller impact compared to vma an=
d page tables, I started by exploring possible optimizations for anon_vma f=
irst.

Although anon_vma is relatively simple, there are still quite a few uncerta=
inties.
So I waited until the basic functionality was implemented before sending th=
e patches for discussion.

Thanks again for taking the time to reply.

--
Tao

