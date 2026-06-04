Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF21B22F388
	for <damon@lists.linux.dev>; Thu,  4 Jun 2026 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780546209; cv=none; b=tNIyRjIK2VI0iTfnUs7QvScZaNEfWyM7UHzJfVJFfCbscyBDYA2SV5P4pCOUhC4tSgZ9bxiB3Tv4zdf3TLRwShtmHjzC9dJxp7J6xeFNft96DHetn8vEqJup4VOTqEi8RiiN9Q5z6sebqBG6aTUfhrUgNLfoqUQtl7ezBe2omr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780546209; c=relaxed/simple;
	bh=9xHUWu+ueJwDAqCzNRAWtgDl/FFIr4o2B+xgWFyawyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lrDph/+ocSgBuD2xfphRmbg4dVgcry3eGm2jqI6sRkKGxFzWtJU/WiYnNZeaiS1raJIn8boa2mezkhiOMKWdeVZbNxmUr4apt8bM+vJPf7bYYNkEKKnyhwjvFIzzpz0HvtPepq+kDRznIeHf/5gt+bEXWW57bXyqzHSfz/ygh4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW006-1.hihonor.com (unknown [10.77.215.153])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4gW9zC444ZzYkxb0;
	Thu,  4 Jun 2026 12:08:23 +0800 (CST)
Received: from TA005-1.hihonor.com (10.77.216.68) by TW006-1.hihonor.com
 (10.77.215.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 12:10:05 +0800
Received: from TA003.hihonor.com (10.72.0.43) by TA005-1.hihonor.com
 (10.77.216.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 4 Jun
 2026 12:10:01 +0800
Received: from TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1]) by
 TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1%7]) with mapi id
 15.02.2562.037; Thu, 4 Jun 2026 12:10:04 +0800
From: wangtao <tao.wangtao@honor.com>
To: "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>, "david@kernel.org"
	<david@kernel.org>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"willy@infradead.org" <willy@infradead.org>, "sj@kernel.org" <sj@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>, "luizcap@redhat.com"
	<luizcap@redhat.com>, "zhangjiao2@cmss.chinamobile.com"
	<zhangjiao2@cmss.chinamobile.com>, "kas@kernel.org" <kas@kernel.org>,
	"ljs@kernel.org" <ljs@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
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
	<lance.yang@linux.dev>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "nao.horiguchi@gmail.com"
	<nao.horiguchi@gmail.com>, "matthew.brost@intel.com"
	<matthew.brost@intel.com>, "joshua.hahnjy@gmail.com"
	<joshua.hahnjy@gmail.com>, "rakie.kim@sk.com" <rakie.kim@sk.com>,
	"byungchul@sk.com" <byungchul@sk.com>, "gourry@gourry.net"
	<gourry@gourry.net>, "ying.huang@linux.alibaba.com"
	<ying.huang@linux.alibaba.com>, "apopple@nvidia.com" <apopple@nvidia.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryncsn@gmail.com" <ryncsn@gmail.com>,
	"dvander@google.com" <dvander@google.com>, wangzicheng
	<wangzicheng@honor.com>
Subject: RE: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Thread-Topic: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Thread-Index: AQHc7cjw5r5ki6LAJ0S2mW/rJEfblbYszHKAgABxS4CAAJTosA==
Date: Thu, 4 Jun 2026 04:10:04 +0000
Message-ID: <32e89429f8ca4d4ebd04b1303897eaed@honor.com>
References: 20260527110147.17815-1-tao.wangtao@honor.com,70377626-500d-46f2-a3f5-a0d2914ce365@kernel.org
 <20260604111035154Lk-9ZgwKY4Nlk4zz30U1t@zte.com.cn>
In-Reply-To: <20260604111035154Lk-9ZgwKY4Nlk4zz30U1t@zte.com.cn>
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

PiA+DQo+ID4gRXZlbiBpZiB3ZSBjb3VsZCBiZSBjb252aW5jZWQgdGhhdCBtb3N0IG9mIHRoaXMg
aGVyZSBpcyBjb3JyZWN0LCBob3cNCj4gPiBzaG91bGQgd2UgcmVhc29uYWJseSBtYWludGFpbiB0
aGlzIGluY3JlYXNpbmcgbGV2ZWwgb2YgY29tcGxleGl0eSBoZXJlPw0KPiANCj4gSW5kZWVkLCBp
dCdzIHZlcnkgY29tcGxleCwgYnV0IGhhdmluZyB0aGUgY2hhbmdlcyBvZiAxNSBwYXRjaGVzIHNj
YXR0ZXJlZA0KPiBhY3Jvc3MgdmFyaW91cyBzdWJzeXN0ZW1zIGlzIHJlYWxseSBmcnVzdHJhdGlu
ZyBmb3IgcmV2aWV3ZXJzLiBJdCB0b29rIG1lIGENCj4gd2hvbGUgZGF5IHRvIHJlYWQgdGhyb3Vn
aCB0aGUgZW50aXJlIHBhdGNoIHNldCwgd2hpY2ggbWFkZSBhbiBhbHJlYWR5DQo+IGNvbXBsaWNh
dGVkIG1hdHRlciBldmVuIG1vcmUgY29tcGxleCAobWFpbnRhaW5pbmcgc3VjaCBjb21wbGV4IGNv
ZGUgaW4NCj4gdGhlIGZ1dHVyZSB3aWxsIGJlIGEgcGFpbikuDQo+IA0KPiBIb3dldmVyLCBvdmVy
YWxsLCBJIHRoaW5rIHRoZSBvcmlnaW5hbCBpbnRlbnRpb24gYmVoaW5kIFRhbydzIHBhdGNoIGlz
DQo+IGlubm92YXRpdmUgYW5kIHZhbHVhYmxlLCBhbmQgVGFvIGNvdWxkIGRlZmluaXRlbHkgbWFr
ZSB0aGlzIHBhdGNoIHNldCBzaW1wbGVyDQo+IGFuZCBtb3JlIHJlYWRhYmxlLCBiZWNhdXNlIHRo
ZSBjb3JlIGNoYW5nZXMgYWN0dWFsbHkgc3RhcnQgZnJvbSBQQVRDSCAxMC4NCj4gDQpZZXMsIGlu
aXRpYWxseSBpdCB3YXMgYmFzaWNhbGx5IHBhdGNoZXMgOSwgMTAsIGFuZCAxMy4gQmVjYXVzZSB3
aXRob3V0DQpkaXN0aW5ndWlzaGluZyB0aGUgYW5vbl9ybWFwIGFuZCBhbm9uX3ZtYSB0b3BvbG9n
eSwgc29tZSBmdW5kYW1lbnRhbCBjb2RlDQpsb2dpYyBpcyBoYXJkIHRvIHVuZGVyc3RhbmQsIEkg
YWRkZWQgdGhlc2UgdHdvIGxvZ2ljYWwgbGF5ZXJzIHdoZW4NCnByZXBhcmluZyB0byBzdWJtaXQg
aXQgdG8gdGhlIGNvbW11bml0eS4gSG93ZXZlciwgdGhpcyBhbHNvIHNpZ25pZmljYW50bHkNCmlu
Y3JlYXNlZCB0aGUgYW1vdW50IG9mIGNvZGUsIHdoaWNoIGlzIG5vdCBpZGVhbC4NCg0KPiBJIGJl
bGlldmUgdGhhdCBpZiBUYW8gaGFkIGRvbmUgdGhlIGZvbGxvd2luZywgdGhpbmdzIG1pZ2h0IGhh
dmUgZ29uZSBiZXR0ZXINCj4gYW5kIGVhc2llciBmb3IgcmV2aWV3aW5nLiBJbiBmYWN0LCBJIHVu
ZGVyc3RhbmQgdGhlIG1vdGl2YXRpb24gYmVoaW5kIHRoZQ0KPiBwYXRjaCBpcyBxdWl0ZSBzaW1w
bGUgYXQgaXRzIGNvcmUgKGp1c3Qgd2FudGluZyB0byBhdm9pZCBhbGxvY2F0aW5nIHRoZQ0KPiBh
bm9uX3ZtYSBzdHJ1Y3R1cmUgd2hlbiBhIFZNQSBoYXNuJ3QgYmVlbiB0cnVseSBmb3JrZWQsIGFu
ZCBpbnN0ZWFkIHB1dA0KPiB0aGUgVk1BIGluZm9ybWF0aW9uIGRpcmVjdGx5IGludG8gZm9saW8t
Pm1hcHBpbmcpOg0KPiANCj4gMSkgWW91IGNvdWxkIGFjdHVhbGx5IHNpbXBsaWZ5IHlvdXIgcGF0
Y2ggc2lnbmlmaWNhbnRseSDigJQgd2l0aG91dCBhZGRpbmcgYSBsb3QNCj4gb2Ygd3JhcHBlcnMg
YW5kIGhlbHBlciBmdW5jdGlvbnMgdGhhdCBpbnRyb2R1Y2UgZXh0cmEgcmV2aWV3IG92ZXJoZWFk
IOKAlA0KPiBhbmQga2VlcCBvbmx5IHRoZSBtb3N0IGVzc2VudGlhbCBlbGVtZW50cy4NCj4gDQo+
IDIpIFByb3ZpZGUgY29tcGxldGUgdGVzdCBjb2RlIChpbiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0
KSB0aGF0IGNvdmVycyB0aGUNCj4gYWZmZWN0ZWQgZnVuY3Rpb25hbGl0eSwgc3VjaCBhcyBWTUEs
IGh1Z2UgcGFnZXMsIEtTTSwgZXRjLg0KPiANCj4gMykgVXNlIHRoZSBSRkMgdGFnIHRvIHN0YXJ0
IGEgZGlzY3Vzc2lvbi4NCj4gDQo+IA0KPiBJIHdvdWxkIGJlIHZlcnkgZ2xhZCB0byBzZWUgaWYg
VGFvIGNvdWxkIHBvc3QgYSBzaW1wbGVyIHYyIHZlcnNpb24gdGhhdCBkb2VzDQo+IG5vdCBhbHRl
ciB0aGUgcm1hcCBjb3JlIGRhdGEgc3RydWN0dXJlcyB0b28gbXVjaCBhbmQgZG9lcyBub3QgaW50
cm9kdWNlDQo+IGV4Y2Vzc2l2ZSBjb21wbGV4aXR5LCBubyBtYXR0ZXIgd2hldGhlciBpdCBjYW4g
YmUgbWVyZ2VkIGZpbmFseS4NCg==
