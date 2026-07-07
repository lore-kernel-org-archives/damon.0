Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6C3101B6
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412494; cv=none; b=P3DufaoNldoOwI0deT9uaNfaW92Q0mwDo0zT9pXMYEoCtrtojcHb2oaiYHwvromRPG6Yv5J6rt80SaiqKWW/aBiLA01j9xcnuw5fSfrETYMaSr1khyv3CQoLJDryIJfSZgIb/bEtoSp9BOh1BWCa65TJei9Lgja48uxUoUfEjK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412494; c=relaxed/simple;
	bh=0qEYw/kORu+CHB2h/1PvcuGa9W8zXV/BEp8uiX+ijrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fBNU4Dk1DWDzCxPZxykBav0hsYfZG2GStuSfYw1dEhCYOGwMwk/qy18SXUKQMKbHLuqnnfLG8FGQQR3UcVRXyp4YX0CHJTl1hpZKwltTn+5RzVkX08haDdF6hViaqkwndp/szgViy/iyjkuHCAxPXCzaZaN7D8kFnfCOJaXPQs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=Pz4JCC5j; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="Pz4JCC5j"
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=0qEYw/kORu+CHB2h/1PvcuGa9W8zXV/BEp8uiX+ijrc=;
	b=Pz4JCC5jlXSi5X4B42t+HBGZjPXcu07/0QJzKOkROww8hc0n+LYFEueKq+YzBskjWdDfC7gwn
	1H8vo4WsTs7uC2COJRcfMc7GyyM70t22qbv7XheS4lp/S98A3iFUlPsg7YpllfaEsbjXdOzLvM/
	EmvokN6FPkEekmuGMpxr08g=
Received: from TW004-1.hihonor.com (unknown [10.77.232.85])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4gvZ1x4kQfzYm4Nv;
	Tue,  7 Jul 2026 16:21:25 +0800 (CST)
Received: from TA001.hihonor.com (10.77.210.32) by TW004-1.hihonor.com
 (10.77.232.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 16:21:25 +0800
Received: from TA003.hihonor.com (10.72.0.43) by TA001.hihonor.com
 (10.77.210.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 7 Jul
 2026 16:21:24 +0800
Received: from TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1]) by
 TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1%7]) with mapi id
 15.02.2562.037; Tue, 7 Jul 2026 16:21:25 +0800
From: wangtao <tao.wangtao@honor.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"willy@infradead.org" <willy@infradead.org>, "sj@kernel.org" <sj@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>, "luizcap@redhat.com"
	<luizcap@redhat.com>, "zhangjiao2@cmss.chinamobile.com"
	<zhangjiao2@cmss.chinamobile.com>, "kas@kernel.org" <kas@kernel.org>,
	"ljs@kernel.org" <ljs@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "liam@infradead.org"
	<liam@infradead.org>, "vbabka@kernel.org" <vbabka@kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz" <jack@suse.cz>,
	"riel@surriel.com" <riel@surriel.com>, "harry@kernel.org" <harry@kernel.org>,
	"jannh@google.com" <jannh@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "ziy@nvidia.com" <ziy@nvidia.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"npache@redhat.com" <npache@redhat.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "dev.jain@arm.com" <dev.jain@arm.com>,
	"baohua@kernel.org" <baohua@kernel.org>, "lance.yang@linux.dev"
	<lance.yang@linux.dev>, "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>, "baoquan.he@linux.dev"
	<baoquan.he@linux.dev>, "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
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
Subject: RE: [RFC PATCH v2 00/13] mm: rework anon_vma and remove
 anon_vma_chain
Thread-Topic: [RFC PATCH v2 00/13] mm: rework anon_vma and remove
 anon_vma_chain
Thread-Index: AQHdDdtOKxyL+IwP/0+o3I4bi0Jgh7ZhGu0AgACbXoA=
Date: Tue, 7 Jul 2026 08:21:24 +0000
Message-ID: <b00a03d62c53430ca22b3f3c5e5327b5@honor.com>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <08c001ab-320f-4676-830b-8e4ba6a05dee@kernel.org>
In-Reply-To: <08c001ab-320f-4676-830b-8e4ba6a05dee@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

PiANCj4gT24gNy83LzI2IDA4OjMyLCB0YW8gd3JvdGU6DQo+ID4gSGkgYWxsLA0KPiA+DQo+ID4g
U2luY2UgdjEgd2FzIHJlbGF0aXZlbHkgY29tcGxleCBhbmQgZGlmZmljdWx0IHRvIGV4dGVuZCwg
dGhpcyB2ZXJzaW9uDQo+ID4gYWRvcHRzIGEgc2ltcGxlciBhbm9uX3ZtYSBpbXBsZW1lbnRhdGlv
biBhcHByb2FjaC4NCj4gDQo+IEkgcmVhbGx5IGhhdGUgdG8gcmVwZWF0IG15c2VsZiwgYnV0IHlv
dSBzZWVtZWQgdG8gaGF2ZSBtaXNzZWQgbXkgbWFpbiBwb2ludA0KPiBbMV0NCj4gDQpJIHNhdyBp
dCwgYW5kIEnigJl2ZSB3YWl0ZWQgZm9yIGEgd2hpbGUgYXMgd2VsbC4NCg0KSWYgdGhlcmUgYXJl
IHRlY2huaWNhbCBpc3N1ZXMsIHBsZWFzZSBwb2ludCB0aGVtIG91dCBkaXJlY3RseS4NCk9yIGlz
IHRoaXMgc2ltcGx5IGhvdyB0ZWNobmljYWwgZGlzY3Vzc2lvbnMgYXJlIHVzdWFsbHkgY29uZHVj
dGVkIGluIHRoZSBMaW51eCBjb21tdW5pdHkgb3IgdGhlIG1tIHN1YnN5c3RlbT8NCg0KVGhhbmtz
LA0KVGFvDQoNCj4gIkxvcmVuem8gaGFzIGJlZW4gaGFyZCBhdCB3b3JrIGV4cGxvcmluZyB2YXJp
b3VzIGRlc2lnbiBvcHRpb25zIChhbmQgSSdtDQo+IGFmcmFpZCBoZSBtaWdodCBiZSBvbmUgb2Yg
dGhlIDMgcGVvcGxlIG9uIHRoaXMgcGxhbmV0IHRoYXQgdW5kZXJzdGFuZA0KPiBhbm9uX3ZtYSBp
biBmdWxsIGRldGFpbCksIHNvIEkgc3VnZ2VzdCB3ZSB3YWl0IGZvciBhIHJlZGVzaWduIHByb3Bv
c2FsIGZyb20NCj4gaGltIGFuZCBzZWUgaWYgdGhhdCBpcyBkb2FibGU/Ig0KPiANCj4gWzFdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC83MDM3NzYyNi01MDBkLTQ2ZjItYTNmNS0NCj4gYTBk
MjkxNGNlMzY1QGtlcm5lbC5vcmcvDQo+IA0KPiAtLQ0KPiBDaGVlcnMsDQo+IA0KPiBEYXZpZA0K
