Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5DC38A71F
	for <damon@lists.linux.dev>; Thu, 28 May 2026 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958508; cv=none; b=ZDFY4XQybS8jkhq3U0SNq1EbQJC7vnh4UKGL+tin+J2/AbQJN2vT7G4Ep9XISTQtJdXpRZw2g6XX5UFsc0crKGuGXqn9Ht6IFyDxAU3A30++Zpkox7pHjUy85eLQb/xikI/HQuRcmOFz7J0v/2qclYb+G+QnjkdqG0jqRRil/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958508; c=relaxed/simple;
	bh=uMbNQmckTp5QaMoElcMoTyXu3ymd3LQP1tSw7Oj8rW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BLOzfiAZ5i+eJ7ylfXCyWPr+J0ixqP1on8uIjR5oWVsZCdehYvoho8JPJfFkg5v7pX2moD5l4fCEjmT2nNvgDb1n0PCUaAt+eTfJtvtwnEZpyLuU6qUEnn4PbjUsNzFlmicrUgBvcb07FJY376gCd0IEj4QAoOtmjeiOfqEciRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW001.hihonor.com (unknown [10.77.229.151])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4gR0dK5BqmzYkxql;
	Thu, 28 May 2026 16:53:25 +0800 (CST)
Received: from TA004.hihonor.com (10.72.0.6) by TW001.hihonor.com
 (10.77.229.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 16:55:02 +0800
Received: from TA003.hihonor.com (10.72.0.43) by TA004.hihonor.com (10.72.0.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Thu, 28 May
 2026 16:55:02 +0800
Received: from TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1]) by
 TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1%7]) with mapi id
 15.02.2562.037; Thu, 28 May 2026 16:55:02 +0800
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
Subject: RE: [PATCH 02/15] mm: convert anon_vma rmap APIs to anon_rmap
Thread-Topic: [PATCH 02/15] mm: convert anon_vma rmap APIs to anon_rmap
Thread-Index: AQHc7ckSlLO6TLjg1UCiENwGiuHKtrYhPCKAgAHl8fA=
Date: Thu, 28 May 2026 08:55:01 +0000
Message-ID: <e55c557e85a64e439194d0fc5ea27aaf@honor.com>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <20260527110147.17815-3-tao.wangtao@honor.com> <ahbZdWDiqTCWU77K@lucifer>
In-Reply-To: <ahbZdWDiqTCWU77K@lucifer>
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

> Subject: Re: [PATCH 02/15] mm: convert anon_vma rmap APIs to anon_rmap
>=20
> On Wed, May 27, 2026 at 07:01:34PM +0800, tao wrote:
> > Convert the rmap anon_vma interfaces to anon_rmap APIs to clarify the
> > semantics of anonymous rmap operations and prepare for upcoming
> > ANON_VMA_LAZY support and RCU-based lockless rmap traversal.
> >
> > Replace folio_anon_vma(), folio_get_anon_vma(),
> > folio_lock_anon_vma_read(), anon_vma_trylock_read(),
> > anon_vma_lock_read(), anon_vma_unlock_read(),
> > anon_vma_trylock_write(), anon_vma_lock_write(),
> anon_vma_unlock_write(), and vma_interval_tree_foreach() with the
> anon_rmap APIs.
>=20
> This is another worthless commit message. You're again just writing what =
you
> did not why or what for. This gives no help whatsoever.
>=20
I will update the commit message to add more explanation.

> >
> > No functional change intended.
>=20
> Err, there is a functional change, since you're literally changing how th=
ings
> iterate?
>=20
> >
> > Signed-off-by: tao <tao.wangtao@honor.com>
>=20
> All of this is terrible, you're replacing a broken abstraction with somet=
hing
> that assumes something completely broken with zero explanation.
>=20
> No to this.
>=20
Before supporting ANON_VMA_LAZY, these were indeed just simple wrappers.

> >  /*
> > @@ -3035,9 +3040,10 @@ static struct anon_vma
> > *rmap_walk_anon_lock(const struct folio *folio,  static void
> rmap_walk_anon(struct folio *folio,
> >  		struct rmap_walk_control *rwc, bool locked)  {
> > -	struct anon_vma *anon_vma;
> > +	anon_rmap_t anon_rmap;
> >  	pgoff_t pgoff_start, pgoff_end;
> >  	struct anon_vma_chain *avc;
> > +	struct vm_area_struct *vma;
>=20
> I have no idea why you put the VMA at this scope...

The vma is used in anon_rmap_foreach_vma().

>=20
> >
> >  	/*
> >  	 * The folio lock ensures that folio->mapping can't be changed under
> > us @@ -3046,20 +3052,19 @@ static void rmap_walk_anon(struct folio
> *folio,
> >  	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> >
> >  	if (locked) {
> > -		anon_vma =3D folio_anon_vma(folio);
> > +		anon_rmap =3D folio_anon_rmap(folio);
> >  		/* anon_vma disappear under us? */
> > -		VM_BUG_ON_FOLIO(!anon_vma, folio);
> > +		VM_BUG_ON_FOLIO(!anon_rmap_value(anon_rmap), folio);
> >  	} else {
> > -		anon_vma =3D rmap_walk_anon_lock(folio, rwc);
> > +		anon_rmap =3D rmap_walk_anon_lock(folio, rwc);
> >  	}
> > -	if (!anon_vma)
> > +	if (!anon_rmap_value(anon_rmap))
> >  		return;
> >
> >  	pgoff_start =3D folio_pgoff(folio);
> >  	pgoff_end =3D pgoff_start + folio_nr_pages(folio) - 1;
> > -	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
> > +	anon_rmap_foreach_vma(vma, avc, anon_rmap,
> >  			pgoff_start, pgoff_end) {
> > -		struct vm_area_struct *vma =3D avc->vma;
>=20
> Don't throw random changes like this in with a general replacement patch.

These were replaced carefully, but there may still be omissions or mistakes=
. Please point them out specifically.
>=20
> >  		unsigned long address =3D vma_address(vma, pgoff_start,
> >  				folio_nr_pages(folio));
> >
> > @@ -3076,7 +3081,7 @@ static void rmap_walk_anon(struct folio *folio,
> >  	}
> >
> >  	if (!locked)
> > -		anon_vma_unlock_read(anon_vma);
> > +		anon_rmap_unlock_read(anon_rmap);
> >  }
> >
> >  /**
> > --
> > 2.17.1
> >
