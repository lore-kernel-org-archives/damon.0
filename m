Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C1632860B
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416031; cv=none; b=AxBEyQQ8vG9LCp+wtJZZi1Mxev4lJU3RyaQ6HGs/eDRvGpz1YP08nsiaSRY6SnEw7ekSZkGJK8vdC2XJHeQfI1++Pd917j2LFHibE6woSMiWi0ug4IuqX4+sQBLof4ePqbTupTwQ3qq0jHjd7inERRXbHn+XMC4NhQLOCkCBto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416031; c=relaxed/simple;
	bh=J25m0TwW8o74ZimHAzHNjY7M1tg1RLD5s4C8q+gek5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VfMq3PTZ1ZnHZvOf6W4PZvgnbv+79m6cWY8gja0Mq6NkWN6isyu0V5DPICYoc9Y9We4mE1KArifmdYDlXl5k6l1qe/qftkJQHuv1UkJHGoeIM5qaynnCJDaJvSHxLWAPBr8exjbfXl9OsF4ysZ66jgWaBiJHpQlYzuy0lRKV7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW002-1.hihonor.com (unknown [10.72.0.137])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4gvbL11GHLzYmBHn;
	Tue,  7 Jul 2026 17:20:25 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW002-1.hihonor.com
 (10.72.0.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 17:20:24 +0800
Received: from TA003.hihonor.com (10.72.0.43) by TA003.hihonor.com
 (10.72.0.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 17:20:24 +0800
Received: from TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1]) by
 TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1%7]) with mapi id
 15.02.2562.037; Tue, 7 Jul 2026 17:20:24 +0800
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
Thread-Index: AQHdDdtOKxyL+IwP/0+o3I4bi0Jgh7ZhGu0AgACbXoD//33xgIAAiIWw
Date: Tue, 7 Jul 2026 09:20:24 +0000
Message-ID: <f640c89d9722462098bf1b7a0a6854c2@honor.com>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <08c001ab-320f-4676-830b-8e4ba6a05dee@kernel.org>
 <b00a03d62c53430ca22b3f3c5e5327b5@honor.com>
 <0e8e5a28-1111-4b81-b04f-b81e749eb3dd@kernel.org>
In-Reply-To: <0e8e5a28-1111-4b81-b04f-b81e749eb3dd@kernel.org>
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

PiA+PiBPbiA3LzcvMjYgMDg6MzIsIHRhbyB3cm90ZToNCj4gPj4+IEhpIGFsbCwNCj4gPj4+DQo+
ID4+PiBTaW5jZSB2MSB3YXMgcmVsYXRpdmVseSBjb21wbGV4IGFuZCBkaWZmaWN1bHQgdG8gZXh0
ZW5kLCB0aGlzDQo+ID4+PiB2ZXJzaW9uIGFkb3B0cyBhIHNpbXBsZXIgYW5vbl92bWEgaW1wbGVt
ZW50YXRpb24gYXBwcm9hY2guDQo+ID4+DQo+ID4+IEkgcmVhbGx5IGhhdGUgdG8gcmVwZWF0IG15
c2VsZiwgYnV0IHlvdSBzZWVtZWQgdG8gaGF2ZSBtaXNzZWQgbXkgbWFpbg0KPiA+PiBwb2ludCBb
MV0NCj4gPj4NCj4gPiBJIHNhdyBpdCwgYW5kIEnigJl2ZSB3YWl0ZWQgZm9yIGEgd2hpbGUgYXMg
d2VsbC4NCj4gDQo+IEFwcGFyZW50bHkgeW91IHNhdyBpdCBidXQgeW91IGRpZG4ndCByZWFkIG15
IHJlcGx5IGFib3V0IHNsYXBwaW5nIG1vcmUNCj4gY29tcGxleGl0eSBvbiBzb21ldGhpbmcgY29t
cGxpY2F0ZWQuDQpUaGlzIHYyIGlzIGEgY29tcGxldGUgcmV3cml0ZSByZXBsYWNpbmcgdGhlIG9y
aWdpbmFsIGFub25fdm1hIGFuZCBhbm9ueW1vdXMtcGFnZQ0KcmV2ZXJzZS1tYXBwaW5nIHRyYXZl
cnNhbC4NCg0KVGhlIG5ldyBhbm9uX3ZtYSBoaWVyYXJjaHkgaXMgcmVwcmVzZW50ZWQgdXNpbmcg
YSBzaW1wbGUgZG91Ymx5IGxpbmtlZCBsaXN0IHdpdGggZGVwdGggaW5mb3JtYXRpb24sDQpyZXBs
YWNpbmcgdGhlIGNvbXBsZXggdG9wb2xvZ3kgb2YgcmVkLWJsYWNrIHRyZWVzIG1haW50YWluZWQg
YnkgZWFjaCBhbm9uX3ZtYSBpbiB0aGUgb3JpZ2luYWwgZGVzaWduLA0KYW5kIGFsc28gcmVtb3Zp
bmcgYW5vbl92bWFfY2hhaW4uDQoNCkV4Y2x1ZGluZyBwYXRjaCAxMSwgd2hpY2ggb3B0aW1pemVz
IGxlYWYgVk1BIHJtYXAgd2l0aCBQVkwsIGFuZCBwYXRjaCAxMiwgd2hpY2ggb3B0aW1pemVzIG1l
bW9yeQ0KdXNhZ2UgdGhyb3VnaCBzaGFyZWQgc2VtYXBob3JlcywgdGhlIGJhc2UgdmVyc2lvbiBj
b250YWlucyByb3VnaGx5IDgwMCBsaW5lcyBvZiBjb2RlLCBpbmNsdWRpbmcgdGhlDQpjb21wYXRp
YmlsaXR5IHBhcnQgcmVwbGFjaW5nIHRoZSBvcmlnaW5hbCBhbm9uX3ZtYSBpbXBsZW1lbnRhdGlv
bi4NCg0KPiANCj4gIDEyIGZpbGVzIGNoYW5nZWQsIDEwNTYgaW5zZXJ0aW9ucygrKSwgNTQgZGVs
ZXRpb25zKC0pDQo+IA0KPiA+DQo+ID4gSWYgdGhlcmUgYXJlIHRlY2huaWNhbCBpc3N1ZXMsIHBs
ZWFzZSBwb2ludCB0aGVtIG91dCBkaXJlY3RseS4NCj4gPiBPciBpcyB0aGlzIHNpbXBseSBob3cg
dGVjaG5pY2FsIGRpc2N1c3Npb25zIGFyZSB1c3VhbGx5IGNvbmR1Y3RlZCBpbiB0aGUNCj4gTGlu
dXggY29tbXVuaXR5IG9yIHRoZSBtbSBzdWJzeXN0ZW0/DQo+IA0KPiBJIHN1Z2dlc3QgeW91IGdv
IGJhY2sgYW5kIHJlYWQgbXkgZW1haWwuDQoNCkF0IGZpcnN0LCBJIHRob3VnaHQgSSB3YXMgdGhl
IG9ubHkgb25lIHdobyBmb3VuZCBhbm9uX3ZtYSBoYXJkIHRvIHVuZGVyc3RhbmQuIEFmdGVyIHJl
YWRpbmcgeW91ciBlYXJsaWVyIGVtYWlsLA0KSSByZWFsaXplZCB0aGF0IG1hbnkgcGVvcGxlIGFs
c28gY29uc2lkZXIgaXQgZGlmZmljdWx0IHRvIGZvbGxvdy4gU28gSSB0cmllZCBhIGRpZmZlcmVu
dCBhcHByb2FjaCBhbmQgaW1wbGVtZW50ZWQNCmFub25fdm1hIHJtYXAgdXNpbmcgYSBzaW1wbGVy
IGRvdWJseSBsaW5rZWQgbGlzdCBwbHVzIGRlcHRoIG1lY2hhbmlzbS4NCg0KVGhhbmtzLA0KVGFv
DQoNCj4gLS0NCj4gQ2hlZXJzLA0KPiANCj4gRGF2aWQNCg==
