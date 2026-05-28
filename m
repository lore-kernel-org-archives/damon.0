Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2B636E47E
	for <damon@lists.linux.dev>; Thu, 28 May 2026 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958809; cv=none; b=DF3bNWBWDtWKuPAto5oeLarPxorBvyTfa8mdo9aWN+F3yTHYExREDWxMK950eEiKqw39eHYY3Kd0h+dtsg4s8ZhnWSzhv5706fZphhP3TyqCqALB1O0mYoOCVmgGk37OsBk4fwMUsiubv+zrdL0rWUS7odWecxnlQYQkknJInPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958809; c=relaxed/simple;
	bh=Bux8GCftyQ+aPXERCy2YSrQ8/ekfm0FLVwx50wtZDiQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bxTVMF272UU98Ma/TBx/xTcs9Q0yvYgxsb9+GgCFyVN5ajbTCAQtR9N4A2uGOoljVE4bQ8E3V4zJDujZkPqzlEvXJkrDiEqYNiDXifbiyv+AvOn6Ro71Ojrcwq5dzakU+nZX43Y75HXqRqu4qZbhSbBsPGI76XpjWQLC1EwO2+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=WASDnVpC; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="WASDnVpC"
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=XD3hORJdYdgNuk6+D4BQV8kmKZ7YLD8FvucsViATNX4=;
	b=WASDnVpCEPy/DfZY9zA6UOFUvEQqxkvnRV1po3xn/d/NwIl+ux0JVJEQSKeFAuqA5QtrueMZR
	KnRicy9kFmXVEKoIbAqhWZ4fjsIxKPwsUkbX148kjnjSzfE42VzBDj/GomPvnbh7RTocuIxyEQN
	89bvgsqsegQyYL1C3p8go+0=
Received: from TW003.hihonor.com (unknown [10.77.199.161])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4gR0lX0CxyzYkxhn;
	Thu, 28 May 2026 16:58:48 +0800 (CST)
Received: from TA002.hihonor.com (10.77.230.8) by TW003.hihonor.com
 (10.77.199.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 17:00:00 +0800
Received: from TA003.hihonor.com (10.72.0.43) by TA002.hihonor.com
 (10.77.230.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 16:59:08 +0800
Received: from TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1]) by
 TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1%7]) with mapi id
 15.02.2562.037; Thu, 28 May 2026 17:00:03 +0800
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
Subject: RE: [PATCH 03/15] mm: introduce anon_vma_tree_t for multiple anon_vma
 topologies
Thread-Topic: [PATCH 03/15] mm: introduce anon_vma_tree_t for multiple
 anon_vma topologies
Thread-Index: AQHc7ckS0nHB17pDfk6r1PTPwH0GsrYhPg2AgAHhCFA=
Date: Thu, 28 May 2026 09:00:02 +0000
Message-ID: <f53d9327cf064c87aec7c50e867b0e0d@honor.com>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <20260527110147.17815-4-tao.wangtao@honor.com> <ahbatfs3G-Qkh7Vk@lucifer>
In-Reply-To: <ahbatfs3G-Qkh7Vk@lucifer>
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

> Subject: Re: [PATCH 03/15] mm: introduce anon_vma_tree_t for multiple
> anon_vma topologies
>=20
> On Wed, May 27, 2026 at 07:01:35PM +0800, tao wrote:
> > Prepare for upcoming ANON_VMA_LAZY support and RCU-based lockless
> rmap
> > traversal by clearly separating anon_vma topology handling from the
> > anon_rmap semantics.
>=20
> RCU is not 'lockless'... and if you truly get RCU semantics you break a b=
unch
> of stuff as I found out.
>=20
RCU is required when acquiring anon_vma or vma. When calling
rmap_one, RCU lock is not required; the lock is obtained with
anon_rmap_lock_read() or folio_lock_anon_rmap_read().

For regular anon_vma, the anon_vma lock is still used. For
ANON_VMA_LAZY, there is only one vma, so the anon_vma lock is not
needed; we only need to ensure the vma is valid.

> >
> > Prepare for supporting multiple anon_vma topologies by introducing
> > lightweight abstractions used by the VMA and rmap code.
> >
> > Introduce anon_vma_tree_t as the type stored in vma->anon_vma:
> >
> >     typedef unsigned long anon_vma_tree_t;
> >
> > It represents a tagged pointer encoding a reference to the anon_vma
> > topology. The low bits are reserved as type tags to distinguish
> > different implementations (e.g. regular anon_vma and lazy anon_vma).
> > This keeps the VMA representation compact while allowing the topology
> > to evolve without changing the VMA layout.
> >
> > Signed-off-by: tao <tao.wangtao@honor.com>
>=20
> The commit message is at least better on this one, but this approach is a=
gain,
> predicated on extending a broken abstraction.
>=20
> You could have saved time and effort by coming forward with this earlier =
to
> the community.
>=20
> You're also adding a bunch more messy code on top of anon_vma. It's just
> the wrong direction.
>=20
I will update the commit message to add more explanation.

> >
> > +/* anon_vma_tree_t APIs */
> > +
> > +static inline anon_vma_tree_t make_anon_vma_tree(struct anon_vma
> > +*anon_vma) {
> > +	return (anon_vma_tree_t)anon_vma;
> > +}
>=20
> You're literally returning an unsigned long of an anon_vma here?
>=20
> Why is the anon_rmap_t a wrapped struct and this an unsigned long?
>=20
anon_vma_tree_t uses unsigned long because it is used internally
by rmap.c and vma.c. In other places it is mainly used to check
whether a fault has occurred.

> > +
> > +static inline struct anon_vma
> *anon_vma_tree_anon_vma(anon_vma_tree_t
> > +anon_tree) {
> > +	return (struct anon_vma *)anon_tree; }
>=20
> The anon_tree is an anon_vma? What?
>=20
> And it's a tagged pointer but we don't bother clearing any bits right?...=
!
>=20
When supporting ANON_VMA_LAZY, the lower bits definitions are added.
I will add comments to clarify this.

> > +static inline void anon_vma_tree_unlock_read(anon_vma_tree_t
> > +anon_tree) {
> > +	struct anon_vma *anon_vma =3D
> anon_vma_tree_anon_vma(anon_tree);
> > +
> > +	anon_vma_unlock_read(anon_vma);
> > +}
> > +
>=20
> You keep adding more and more code on top of the existing mess. This is
> NOT what we want.
>=20
Additional handling is introduced when enabling ANON_VMA_LAZY;
I will add comments to clarify this.

