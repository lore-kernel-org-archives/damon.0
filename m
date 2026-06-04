Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C2CA45
	for <damon@lists.linux.dev>; Thu,  4 Jun 2026 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558530; cv=none; b=DU20t1CrrkzQYAuYuzuqp3o+Lt5oh6Maf5+MgDzsHB5hz0BfqMDzjKBstmEUmPWIPfsaUnylxYdwuOMl3tAw8UmPaPOX5NUhhB8jCixanC2uUgqciHtKHOz4i1ehJwkgmNDSCqVnvAckz5d5Q5CdCtOdYxpKEWJRMVH8GpXBMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558530; c=relaxed/simple;
	bh=9h5MDONrlf5udMRRWdNkQZ2RCA0Oam9E19zys+QVifc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EkWpYal/XoSpdmdbSpYYjrBzJNSAH4Rzcv0y2hl5g+TJz2QSMSghiRNtM6ITUkHsn5i8o78RBgyliZXeNwAnGYh1PAFJGpf16xiR0OorCpeNudvzYU0+FJcqegjQX20HtbPDPUgMiQARs0ejCMDWX/Ri3Kp2hdlWhAmaJ5VcPbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=MAlF3fYm; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="MAlF3fYm"
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=9h5MDONrlf5udMRRWdNkQZ2RCA0Oam9E19zys+QVifc=;
	b=MAlF3fYmlZBznxMRnPOaTW9/Xu6Cl1PQpuaNrTdumG3c7d/S+iH/b0+6O9gJpaoev1YAXsgsO
	ot3OKjO7lBz608uUW/2Swz0jn/wrqpbjnfeKHGa/9iad50CBgTZfEI5ceXLRX/ZV6FQ0SyHf/CT
	KsZB3CVHnX0eapmbUDOFx4M=
Received: from TW006-1.hihonor.com (unknown [10.77.215.153])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4gWGXP33Q3zYlRXB;
	Thu,  4 Jun 2026 15:33:57 +0800 (CST)
Received: from TA006-1.hihonor.com (10.77.232.151) by TW006-1.hihonor.com
 (10.77.215.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 15:35:15 +0800
Received: from TA003.hihonor.com (10.72.0.43) by TA006-1.hihonor.com
 (10.77.232.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 4 Jun
 2026 15:34:25 +0800
Received: from TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1]) by
 TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1%7]) with mapi id
 15.02.2562.037; Thu, 4 Jun 2026 15:35:15 +0800
From: wangtao <tao.wangtao@honor.com>
To: Barry Song <21cnbao@gmail.com>
CC: "David Hildenbrand (Arm)" <david@kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
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
Thread-Index: AQHc7cjw5r5ki6LAJ0S2mW/rJEfblbYszHKAgAAenICAAOQZkP//ggoAgACqSnA=
Date: Thu, 4 Jun 2026 07:35:14 +0000
Message-ID: <3031859912bb43a7ab16ec63863914ab@honor.com>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <70377626-500d-46f2-a3f5-a0d2914ce365@kernel.org>
 <CAGsJ_4zg8+pVDwtsJtxxiC1ahJ9MR56Ue8VXCt_VrQgcXES2uQ@mail.gmail.com>
 <273d02a1af954b8c9f4da7fb74e6b4cb@honor.com>
 <CAGsJ_4xTMsV8fJVfhshDQp4=Ax2f_+b6yR873cEP11bjcEa_5Q@mail.gmail.com>
In-Reply-To: <CAGsJ_4xTMsV8fJVfhshDQp4=Ax2f_+b6yR873cEP11bjcEa_5Q@mail.gmail.com>
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

PiBbLi4uXQ0KPiA+ID4gPiBJIHdvbid0IGVjaG8gd2hhdCBoYXMgYWxyZWFkeSBiZWVuIHNhaWQg
aW4gdGhpcyB0aHJlYWQgKGFuZCBJDQo+ID4gPiA+IGRpZG4ndCBtYW5hZ2UgdG8gcmVhZCBhbGws
IHVuZm9ydHVuYXRlbHkpLCBidXQgZm9yIHN1Y2ggYmlnIGFuZA0KPiA+ID4gPiBpbnZhc2l2ZSB3
b3JrIGl0J3Mgb2Z0ZW4gYmVzdCB0byBnZXQgaW4gdG91Y2ggd2l0aCB0aGUgY29tbXVuaXR5DQo+
ID4gPiA+IGVhcmxpZXIuIE90aGVyd2lzZSwgeW91IG1pZ2h0IGVuZCB1cCB3YXN0aW5nIHlvdXIg
dGltZS4NCj4gPiA+ID4NCj4gPiA+ID4gT2ssIGFyZ3VhYmx5LCBzb21lb25lIHdobyB3cml0ZXMg
dGhhdCBjb2RlIGxlYXJucyBhIGxvdCBvbiB0aGUgd2F5Lg0KPiA+ID4gPiBBbmQgaWYgdGhpcyBj
b2RlIHJlYWxseSB3YXMgd3JpdHRlbiBieSBvbmUgZGV2ZWxvcGVyIG9ubHksIEkgdGlwDQo+ID4g
PiA+IG15IGhhdCEgSSdkIGJlIGN1cmlvdXMgaWYgdGhhdCBjb2RlIGFscmVhZHkgcmFuIHNvbWV3
aGVyZSBvbiBzb21lDQo+ID4gPiA+IEFuZHJvaWQNCj4gPiA+IGtlcm5lbCBvdXQgdGhlcmU/DQo+
ID4gPg0KPiA+ID4gSSBoZWFyZCBmcm9tIFppY2hlbmcgdGhhdCB0aGV5IGhhdmUgYmVlbiBydW5u
aW5nIHRoaXMgZm9yIG1vbnRocyBhbmQNCj4gPiA+IGl0IHNlZW1zIHJlYXNvbmFibHkgc3RhYmxl
LiBQbGVhc2UgY29ycmVjdCBtZSBpZiBJJ20gd3JvbmcsIFppY2hlbmcNCj4gPiA+IDotKS4gVGhp
cyByZWFsbHkgc2hvdWxkIGhhdmUgYmVlbiBkaXNjdXNzZWQgd2l0aCB0aGUgY29tbXVuaXR5IGVh
cmxpZXIuDQo+ID4gPg0KPiA+IEkgaW5pdGlhbGx5IGRldmVsb3BlZCBhbmQgZGVidWdnZWQgdGhp
cyBiYXNlZCBvbiB0aGUgQW5kcm9pZCBHS0kNCj4gPiBicmFuY2ggYW5kIGRpZCBzb21lIHByZWxp
bWluYXJ5IHRlc3Rpbmcgb24gYW4gQW5kcm9pZCBwaG9uZS4NCj4gPg0KPiA+IFNpbmNlIEdLSSBn
ZW5lcmFsbHkgb25seSBhY2NlcHRzIGZlYXR1cmVzIG1lcmdlZCBmcm9tIHRoZSB1cHN0cmVhbQ0K
PiA+IGNvbW11bml0eSwgYW5kIHRoaXMgbWVtb3J5IHNhdmluZyBjb3VsZCBhbHNvIGJlbmVmaXQg
dGhlIGNvbW11bml0eSwgSQ0KPiA+IHBvcnRlZCB0aGUgcGF0Y2ggdG8gdGhlIExpbnV4IG1hc3Rl
ciBicmFuY2guDQo+ID4NCj4gPiBCZWNhdXNlIG15IEVuZ2xpc2ggaXMgbm90IHZlcnkgZ29vZCBh
bmQgSSByYXJlbHkgcGFydGljaXBhdGUgaW4gdGhlDQo+ID4gY29tbXVuaXR5LCBJIGFtIG5vdCBm
YW1pbGlhciB3aXRoIHRoZSBjb21tdW5pdHkgd29ya2Zsb3cuIEkgZGlkIG5vdA0KPiA+IHNlbmQg
YW4gZW1haWwgZm9yIGRpc2N1c3Npb24gaW4gYWR2YW5jZSB3aXRoIGFuIFJGQyB0YWcuIEkgYXBv
bG9naXplIGFnYWluLg0KPiA+DQo+IA0KPiBObyB3b3JyaWVzLiBJIGtub3cgc29tZW9uZSB3aG8g
aGFzIHdvcmtlZCBvbiB0aGUgTGludXgga2VybmVsIGZvciBtYW55LA0KPiBtYW55IHllYXJzIGFu
ZCBoYXMgZXhjZWxsZW50IGtlcm5lbCBleHBlcnRpc2UsIHlldCBoYXMgbmV2ZXIgc3VibWl0dGVk
IGENCj4gcGF0Y2ggdGhyb3VnaG91dCBoaXMgY2FyZWVyIGZvciB2YXJpb3VzIHJlYXNvbnMuDQo+
IA0KPiBJIGhlYXJkIGZyb20gWmljaGVuZyB0aGF0IHlvdSBhcmUgSE9OT1IncyBrZXkgTU0gZXhw
ZXJ0IGFuZCBoYXZlIGJlZW4NCj4gZ3VpZGluZyB0aGVtIG9uIG1lbW9yeS1tYW5hZ2VtZW50IHJl
bGF0ZWQgd29yay4gVGhhdCdzIHJlYWxseSBpbXByZXNzaXZlLg0KPiBQZXJzb25hbGx5LCBJJ2Qg
bG92ZSB0byBzZWUgbW9yZSBpZGVhcyBhbmQgY29udHJpYnV0aW9ucyBmcm9tIHlvdSBpbiB0aGUg
bGludXgtDQo+IG1tIGNvbW11bml0eS4NCj4gDQo+IEJUVywgcmVnYXJkaW5nIG15IGVhcmxpZXIg
c3VnZ2VzdGlvbiBhYm91dCB1c2luZyBHS0kgaG9va3PigJRsaW1pdGluZyB0aGUNCj4gb3B0aW1p
emF0aW9uIHRvIG5ld2x5IGNyZWF0ZWQgVk1BcyBhbmQgdG8gYXBwbGljYXRpb25zIHRoYXQgbmV2
ZXIgY2FsbA0KPiBmb3JrKCnigJRkbyB5b3UgaGF2ZSBhbnkgaWRlYXMgb24gd2hhdCB0aGUgc21h
bGxlc3QgcG9zc2libGUgaG9vayBjaGFuZ2UNCj4gd291bGQgbG9vayBsaWtlPw0KRXZlbiBpZiBB
bmRyb2lkIGRvZXMgbm90IGNvbnNpZGVyIGhhbmRsaW5nIGZvciAzMi1iaXQsIEtTTSwgb3INCm1l
bW9yeS1mYWlsdXJlLCBhIGxhcmdlIG51bWJlciBvZiBob29rcyBhcmUgc3RpbGwgcmVxdWlyZWQu
DQoNCkEgZGlmZmVyZW50IGltcGxlbWVudGF0aW9uIGFwcHJvYWNoIGlzIGFsc28gbmVlZGVkLiBG
b3IgZXhhbXBsZSwgb25lDQpvciBhIHNldCBvZiBhbm9uX3ZtYV9sb2NrcyBjb3VsZCBiZSB1c2Vk
IHRvIG1hcmsgd2hldGhlciBhIFZNQSBpcw0KbGF6eSwgc28gdGhhdCB3ZSBjYW4gYXZvaWQgbW9k
aWZ5aW5nIGFsbCBwbGFjZXMgdGhhdCBkZXJlZmVyZW5jZQ0KYW5vbl92bWEuIFJlc2VydmVkIGZp
ZWxkcyBpbiB2bWEgY291bGQgYmUgdXNlZCB0byByZWNvcmQgdGhlIHJvb3Rfdm1hDQphbmQgYSBy
ZWZlcmVuY2UgY291bnQgcmVzcGVjdGl2ZWx5Lg0KDQpSb3VnaGx5LCBob29rcyB3b3VsZCBiZSBu
ZWVkZWQgaW4gdGhlIGZvbGxvd2luZyBwbGFjZXM6DQoNCjEuIF9fdm1mX2Fub25fcHJlcGFyZTog
bWFyayBsYXp5X3ZtYSBpbiB0aGUgZmF1bHQgcGF0aC4NCjIuIF9fZm9saW9fc2V0X2Fub24gYW5k
IGZvbGlvX21vdmVfYW5vbl9ybWFwOiBzZXQgbWFwcGluZyB0byBsYXp5X3ZtYS4NCjMuIHJtYXBf
d2Fsa19hbm9uOiBoYW5kbGUgcm1hcF93YWxrIGZvciBsYXp5X3ZtYS4NCjQuIGZvbGlvX2dldF9h
bm9uX3ZtYSBhbmQgcHV0X2Fub25fdm1hOiBhZGQgaG9va3MgdG8gZGlzdGluZ3Vpc2gNCiAgIGxh
enlfdm1hIGhhbmRsaW5nLg0KNS4gYW5vbl92bWFfZm9yazogZGVjaWRlIHdoZXRoZXIgdG8gdXBn
cmFkZSBwdm1hLT5hbm9uX3ZtYS4NCjYuIEFkZCBhIGhvb2sgaW4gdHJ5X2R1cF9hbm9uX3JtYXAg
dG8gdXBncmFkZSBmb2xpby0+bWFwcGluZy4NCjcuIGFub25fdm1hX2Nsb25lOiBoYW5kbGUgbGlu
a3Mgd2hlbiBzcmMgaXMgYSBsYXp5X3ZtYS4NCjguIHZtX2FyZWFfYWxsb2MgLyB2bV9hcmVhX2R1
cCAvIHZtX2FyZWFfZnJlZTogYWRkIFZNQSByZWZlcmVuY2UNCiAgIGNvdW50aW5nLg0KOS4gbXJl
bWFwOiBoYW5kbGUgdXBncmFkZXMgaW4gY29weV92bWEgYW5kIG1vdmVfcGFnZV90YWJsZXMuDQoN
CklmIHRoaXMgY2FuIGJlIHJlc3RyaWN0ZWQgdG8gYXBwcyBvbmx5IGFuZCB0aGUgYXBwIG5ldmVy
IGNhbGxzIGZvcmsoKSwNCnRoZW4gNSBhbmQgNiBjb3VsZCBhbHNvIGJlIHJlbW92ZWQuDQoNCklm
IGVhY2ggcGFnZSdzIG1hcHBpbmcgaW4gdGhlIHBhZ2UgdGFibGVzIGlzIHN5bmNocm9ub3VzbHkg
dXBkYXRlZA0Kd2hlbiB1cGdyYWRpbmcgbGF6eV92bWEsIHRoZW4gNCBhbmQgNSBjb3VsZCBiZSBt
ZXJnZWQgaW50byBvbmUuDQoNCklmIGxhenlfdm1hIGlzIHJlc3RyaWN0ZWQgdG8gYW5vbnltb3Vz
IFZNQXMgd2hlcmUNCnZtYV9tYXBwaW5nX2Jhc2Uodm1hKSA9IDAsIHRoZW4gcm9vdF92bWEgYW5k
IHRoZSBWTUEgcmVmZXJlbmNlIGNvdW50DQpjb3VsZCBhbHNvIGJlIHJlbW92ZWQuDQoNCldpdGgg
dGhpcyByZXN0cmljdGlvbiwgd2UgY291bGQgZGlyZWN0bHkgdXNlIGZvbGlvLT5tYXBwaW5nIHRv
IHJlY29yZA0KbW0sIGFuZCBsb2NhdGUgdGhlIHZtYSB1c2luZyBmb2xpby0+aW5kZXgsIHdoaWNo
IHdvdWxkIHNpbXBsaWZ5IHRoaXMNCnBhdGNoIHNlcmllcy4NCj4gDQo+IFRoYW5rcw0KPiBCYXJy
eQ0K
