Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C1F233923
	for <damon@lists.linux.dev>; Thu, 28 May 2026 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952286; cv=none; b=CpjIJqypEOfXw5d/v/l8fPO9PcHW8ZRkCizAOh90Y1oRcu7p+F4A1M/Iu42XRUUhB4m9g1k3w9aVOnCIkFevVf46zBaDB+9eeqZDib/STaegXln3KSQXzV2ET9OvIDr3yLD3T+Y3lfGO9UGKT3L8Pi+ARSOTzUi5ERPW+qZCnVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952286; c=relaxed/simple;
	bh=e56WHfRH4AwVIeOtxnRpQ/XH8nHxcWdeHjdGBWwaDqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EvyF8w1ZHVch8P6gtyZEQPyprCSb/J9sEfgLPfhzum7cPHcOSEfHoSBmbN7LeWRKoLd9dSMA0TLHsxgDURgSHXVVWWuQ6kkUcfCW5lhBfX3uSpWwbcJSePOUoCI9GISjVviRWhYuv67jOBli9xI6qK8EcL1s+qR1tSChdizDvuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW005.hihonor.com (unknown [10.72.0.123])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4gQyKs47bzzYlLKr;
	Thu, 28 May 2026 15:09:53 +0800 (CST)
Received: from TA002.hihonor.com (10.77.230.8) by TW005.hihonor.com
 (10.72.0.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 15:11:20 +0800
Received: from TA003.hihonor.com (10.72.0.43) by TA002.hihonor.com
 (10.77.230.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 15:10:24 +0800
Received: from TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1]) by
 TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1%7]) with mapi id
 15.02.2562.037; Thu, 28 May 2026 15:11:19 +0800
From: wangtao <tao.wangtao@honor.com>
To: Lorenzo Stoakes <ljs@kernel.org>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@kernel.org" <david@kernel.org>, "willy@infradead.org"
	<willy@infradead.org>, "sj@kernel.org" <sj@kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, "luizcap@redhat.com" <luizcap@redhat.com>,
	"zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>,
	"kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"liam@infradead.org" <liam@infradead.org>, "vbabka@kernel.org"
	<vbabka@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com"
	<surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz"
	<jack@suse.cz>, "riel@surriel.com" <riel@surriel.com>, "harry@kernel.org"
	<harry@kernel.org>, "jannh@google.com" <jannh@google.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
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
	"pfalcato@suse.de" <pfalcato@suse.de>, "linux-arm-kernel@lists.infradead.org"
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
Thread-Index: AQHc7cjw5r5ki6LAJ0S2mW/rJEfblbYhNsEAgAHJA7A=
Date: Thu, 28 May 2026 07:11:19 +0000
Message-ID: <288935c5d9d84794a9120893f61e670b@honor.com>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <ahbSrt0B1aQTwrk4@lucifer>
In-Reply-To: <ahbSrt0B1aQTwrk4@lucifer>
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



> Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred
> anon_vma creation
>=20
> I'm sorry but this is not how kernel development is done.
>=20
> You're sending a series that's very invasive, that you've not coordinated=
 with
> anybody else, nor have you mentioned it at a conference, nor engaged with
> in discussion with anybody else in the community in any way.
>=20
> And you've sent it without an RFC, at -rc5 is... quite something.
>=20
> We do NOT want to extend or expand or hack in anything like this on top o=
f
> the existing anon_vma machinery. It's a mess that requires replacement, n=
ot
> more hacks or expansion.
>=20
> I've been working on a replacement for the anonymous rmap, recently
> presenting at LSF/MM, and all of that has been very public.
>=20
> In fact I have engaged in recent work which reduced lock contention in
> anon_vma, it's really quite discourteous for you not to have contacted me=
 or
> the community in addition to the above.
>=20
First of all, thank you very much for your reply.

I'm also glad to learn that you have been working on optimizations
related to anon_vma. I noticed your work from another email in the
thread.

I apologize if my approach caused any inconvenience. My English is not
very good, and I have rarely participated in community discussions
before, so I'm still learning how things are usually done in the
kernel community. If anything I did came across as discourteous, please
understand that it was not my intention.

Recently, due to increasing memory costs, I revisited the memory usage
of anon_vma and found that it might be possible to reduce its
overhead.

My original intention was simply to experiment with an anon_vma_lazy
mechanism to reduce the memory footprint of anon_vma. However, while
working on it I realized that anon_vma handling is quite complex. In
particular, after multiple levels of fork the topology of anonymous
pages can become quite complicated, and it also interacts with other
subsystems such as reclaim, KSM, and migration.

Because of this, I tried separating the functionality of anon_vma
into two parts: anon_rmap_t for anonymous page reverse mapping, and
anon_vma_tree_t for topology management.

anon_rmap_t provides the reverse mapping interface used by reclaim,
KSM, migration, and similar components.

anon_vma_tree_t manages the topology internally for operations such
as fork, clone, split, and merge, and can also indicate whether a
VMA has experienced page faults.

My hope is that by separating these responsibilities, it may become
easier to reason about and further improve the anon_vma design in the
future.
