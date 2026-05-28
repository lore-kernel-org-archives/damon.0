Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B488358373
	for <damon@lists.linux.dev>; Thu, 28 May 2026 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955068; cv=none; b=snYGTIs6BLznwHXUT5rCEqVLmXox0no7KsgJ0RVHG7eL8I7RBhxPCofBA2TO5g0Ex6WSPVP59+TF1h1lD4vCUs+PprsQWI9Hj97xQCbV6ZUG3UirJX4wBy7rjTNUMB96mEm3aFa2190Ob7sm6/6XfBq8vmZhk7ISsE+UXwB/LbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955068; c=relaxed/simple;
	bh=q91cpL+t5mN4xLdLsyeOw4a9kRHo4YYKKrYt3uKuKLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ci4h0lm5Xd8D4JCGtUve0X1FwH6s2bobrrCjkZ12o1XZGmhkoAjHCBhJahbxSAJRLH2bsOIXoiJQFyYuQhb+iwwVJdomhAr3dGlcnSkm1KynA/SEoriuoSzT8ByqRmdylSQclEqApOnG4RTOYWEGjIbKJ2HPN/bv9DRw5GtHjbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW005.hihonor.com (unknown [10.72.0.123])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4gQzM86sgQzYmnW2;
	Thu, 28 May 2026 15:56:04 +0800 (CST)
Received: from TA001.hihonor.com (10.77.210.32) by TW005.hihonor.com
 (10.72.0.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 15:57:41 +0800
Received: from TA003.hihonor.com (10.72.0.43) by TA001.hihonor.com
 (10.77.210.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 15:57:45 +0800
Received: from TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1]) by
 TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1%7]) with mapi id
 15.02.2562.037; Thu, 28 May 2026 15:57:31 +0800
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
Thread-Index: AQHc7cjw5r5ki6LAJ0S2mW/rJEfblbYhaeaAgAGnM1A=
Date: Thu, 28 May 2026 07:57:31 +0000
Message-ID: <b24b4a8198ba412f8b8b42c43dccd058@honor.com>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <ahcANgFDFwfC0v1q@lucifer>
In-Reply-To: <ahcANgFDFwfC0v1q@lucifer>
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
> OK I've had a look through more thoroughly now and:
>=20
> NAK and NAK any approach like this.
>=20
>=20
> Not only is this structurally all wrong, it does some insane stuff (pinni=
ng
> VMAs - no), the RCU usage is highly dubious and I suspect you've complete=
ly
> broken the anon rmap for things like migration, or have at least added ve=
ry
> dubious edge cases.
>=20
> You've added insane complexity, and also have failed to add even
> perfunctory tests, which is also totally unacceptable.
>=20
> The implementation is wrong, and the approach is wrong - we do not want t=
o
> extend or build on anon_vma. So this is unmergeable, or any approach like=
 it.
>=20
> I also, unfortunately, strongly suspect AI here. The turn of phrase, and =
poor
> commit messages, you doing this out of nowhere with absolutely no rmap
> experience before, your total lack of communication before.
>=20
> Claude puts the probability of heavy AI usage at 85-90%, and I'm pretty
> convinced. Either way it's utterly unmergeable but that you (likely) used=
 AI to
> generate this much work for us makes me actually pretty annoyed.
>=20
> As a result, I would strongly suggest you no longer submit patches for th=
e
> reverse mapping part of mm, as there is now a real lack of trust.
>=20
> If you wish to rebuild that, I suggest you _discuss_ concepts and ideas, =
e.g.
> send stuff on-list with a [DISCUSSION] tag, and engage with the community=
,
> and go from there.
>=20
> It's also important to synchronise - I'm working on an anon rmap replacem=
ent
> that I'm more than happy to discuss with you or anybody else which should
> achieve the same numbers in an architecturally sound way.
>=20
> You going off and, in a vacuum, generating a bunch of code with an
> unacceptable approach is not a civil way of engaging nor is it a good use=
 of
> your time, or maintainer time looking at it.
>=20
> Thanks, Lorenzo

Your email is very unfriendly. I hope you can point out the specific
problems so we can discuss how to solve them.

I am not good at English and need to use AI to translate commit
messages and comments. This reply email is also translated with AI.
However, the code is written by me. I do not know which AI you are
referring to, but the AI tools I use currently cannot effectively
write kernel code.

