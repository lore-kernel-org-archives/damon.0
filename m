Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994C2629C
	for <damon@lists.linux.dev>; Thu, 29 May 2025 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748487810; cv=none; b=udLGw2TeLZKCxQxHEsm5ZjmB13y0NjpxjkGPBi/vemaDJadVx0+s5xlzrx8r7nkZ+Y6G/rnQdPHyyRGe9WADH9K0/asT0i9oeWzOcjsISYW9SN2BBQDqQ9HZHSwPCon8zkVa+kMz0Xho81t5vVBB8VI12K+dEVs7tl71Z6AiqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748487810; c=relaxed/simple;
	bh=08/XzBLWIpvmBY8MzPKL4X/ZbJPrBVcaBnFHJnu7NCk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EX7qe/WllebDd1nmpNruipC/uX6w/mYs2mjoCeJOKKLnmjLtlVedLMCCgRRu9nO7Baug05zFNM9mKMLuqqwi3cgJP7Bdq2jk3kYdlAot7I2SEmyV2V1knzv9kcXBGgawHDT8pDpQyrlu0iW9tvSFVgsExttc4C+YuYZTHy1gAGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201602.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202505291103138957;
        Thu, 29 May 2025 11:03:13 +0800
Received: from jtjnmail201604.home.langchao.com (10.100.2.4) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 May 2025 11:03:12 +0800
Received: from jtjnmail201604.home.langchao.com ([fe80::2830:53ee:1228:5322])
 by jtjnmail201604.home.langchao.com ([fe80::2830:53ee:1228:5322%5]) with mapi
 id 15.01.2507.039; Thu, 29 May 2025 11:03:12 +0800
From: =?utf-8?B?U2ltb24gV2FuZyAo546L5Lyg5Zu9KQ==?= <wangchuanguo@inspur.com>
To: SeongJae Park <sj@kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "david@redhat.com"
	<david@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>,
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "damon@lists.linux.dev"
	<damon@lists.linux.dev>, Jagdish Gediya <jvgediya.oss@gmail.com>
Subject: Re: [PATCH 1/2] mm: migrate: restore the nmask after successfully
 allocating on the  target node
Thread-Topic: [PATCH 1/2] mm: migrate: restore the nmask after successfully
 allocating on the  target node
Thread-Index: AdvQRjVtZMhxwwSPJk6B+hEhw2gIwA==
Date: Thu, 29 May 2025 03:03:12 +0000
Message-ID: <059b42b154f04b50833743c513733089@inspur.com>
Accept-Language: zh-CN, en-US
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
tUid: 2025529110313107a323530c5d25c2247465030471052
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

DQo+ICsgSmFnZGlzaCwgc2luY2Ugc2VlbXMgdGhlIGJlaGF2aW9yIHRoYXQgdGhpcyBwYXRjaCB0
cmllcyB0byBjaGFuZ2UgaXMNCj4gYXBwYXJlbnRseSBtYWRlIGJ5IEphZ2Rpc2gncyBjb21taXQg
MzIwMDgwMjcyODkyICgibW0vZGVtb3Rpb246DQo+IGRlbW90ZSBwYWdlcyBhY2NvcmRpbmcgdG8g
YWxsb2NhdGlvbiBmYWxsYmFjayBvcmRlciIpLg0KPiANCj4gT24gV2VkLCAyOCBNYXkgMjAyNSAx
OToxMDozNyArMDgwMCB3YW5nY2h1YW5ndW8NCj4gPHdhbmdjaHVhbmd1b0BpbnNwdXIuY29tPiB3
cm90ZToNCj4gDQo+ID4gSWYgbWVtb3J5IGlzIHN1Y2Nlc3NmdWxseSBhbGxvY2F0ZWQgb24gdGhl
IHRhcmdldCBub2RlIGFuZCB0aGUNCj4gPiBmdW5jdGlvbiBkaXJlY3RseSByZXR1cm5zIHdpdGhv
dXQgdmFsdWUgcmVzdG9yZSBmb3Igbm1hc2ssIG5vbi1maXJzdA0KPiA+IG1pZ3JhdGlvbiBvcGVy
YXRpb25zIGluIG1pZ3JhdGVfcGFnZXMoKSBieSBhZ2FpbiBsYWJlbCBtYXkgaWdub3JlIHRoZQ0K
PiA+IG5tYXNrIHNldHRpbmdzLA0KPiANCj4gTmljZSBmaW5kaW5nIQ0KPiANCj4gPiB0aGVyZWJ5
IGFsbG93aW5nIG5ldyBtZW1vcnkNCj4gPiBhbGxvY2F0aW9ucyBmb3IgbWlncmF0aW9uIG9uIGFu
eSBub2RlLg0KPiANCj4gQnV0LCBpc24ndCB0aGUgY29uc2VxdWVuY2Ugb2YgdGhpcyBiZWhhdmlv
ciBpcyB0aGUgb3Bwb3NpdGU/ICBUaGF0IGlzLCBJIHRoaW5rDQo+IHRoaXMgYmVoYXZpb3IgcmVz
dHJpY3RzIHRvIHVzZSBvbmx5IHRoZSBzcGVjaWZpZWQgbm9kZSAobXRjLT5uaWQpIGluIHRoZSBj
YXNlLA0KPiBpZ25vcmluZyBtb3JlIGFsbG93ZWQgZmFsbGJhY2sgbm9kZXMgKG10Yy0+bm1hc2sp
Pw0KPiANCj4gQW55d2F5LCB0byBtZSwgdGhpcyBzZWVtcyBub3QgYW4gaW50ZW5kZWQgYmVoYXZp
b3IgYnV0IGEgYnVnLiAgQ2MtaW5nDQo+IEphZ2Rpc2gsIHdobyBhdXRob3JlZCB0aGUgY29tbWl0
IDMyMDA4MDI3Mjg5MiAoIm1tL2RlbW90aW9uOiBkZW1vdGUNCj4gcGFnZXMgYWNjb3JkaW5nIHRv
IGFsbG9jYXRpb24gZmFsbGJhY2sgb3JkZXIiKSwgd2hpY2ggYXBwYXJlbnRseSBtYWRlIHRoaXMN
Cj4gYmVoYXZpb3IgaW5pdGlhbGx5LCB0aG91Z2gsIHNpbmNlIEkgbWF5IG1pc3JlYWRpbmcgdGhl
IG9yaWdpbmFsIGF1dGhvcidzDQo+IGludGVudGlvbi4NCj4gDQoNClVuZGVyIHRoZSBvcmlnaW5h
bCBsb2dpYywgdGhlIGFsbG9jX21pZ3JhdGVfZm9saW8gZnVuY3Rpb24gd291bGQgYXR0ZW1wdCB0
byBhbGxvY2F0ZSBuZXcgbWVtb3J5IOKAi+KAi3NlcXVlbnRpYWxseSBhY3Jvc3MgYWxsIG5vZGVz
IGJhc2VkIG9uIGRpc3RhbmNl4oCL4oCLLCBldmVuIGZvciBub2RlcyBhdCB0aGUgc2FtZSB0aWVy
LCB3aGljaCBpcyBub25zZW5zaWNhbC4gRm9yIGV4YW1wbGUsIGlmIG5vZGVzIDAgYW5kIDEgYXJl
IERSQU0gbm9kZXMgYW5kIG5vZGVzIDIgYW5kIDMgYXJlIENYTCBub2RlcywgYXR0ZW1wdGluZyB0
byBwcm9tb3RlIGEgaG90IHBhZ2UgZnJvbSBub2RlIDIgdG8gbm9kZSAwIHdvdWxkIOKAi+KAi2Vy
cm9uZW91c2x5IGZhbGwgYmFjayB0byBub2RlcyAyIGFuZCAz4oCL4oCLICh0aGUgc2FtZSB0aWVy
IGFzIHRoZSBzb3VyY2Ugbm9kZSkgaWYgbm9kZXMgMCBhbmQgMSBhcmUgb3V0IG9mIHNwYWNlLiBU
aGlzIGlzIGEgQlVHLkluIOKAi+KAi1BhdGNoIDHigIvigIssIEkgZml4IHRoaXMgQlVHLiANCg0K
SW4g4oCL4oCLUGF0Y2ggMuKAi+KAiywgSSBleHRlbmQgdGhlIHRhcmdldCBub2RlIHJhbmdlIGZy
b20gbm9kZSAwIHRvIG5vZGVzIDAgYW5kIDEuIFRvIGFjY29tbW9kYXRlIHVzZXJzIHdobyByZXF1
aXJlIHN0cmljdCBtaWdyYXRpb24gKGUuZy4sIG1pZ3JhdGluZyBvbmx5IHRvIG5vZGUgMCBhbmQg
YWJvcnRpbmcgaWYgaXQgaXMgZnVsbCksIEkgYWRkZWQgYSDigIvigItzeXNmcyB0b2dnbGXigIvi
gIsgaW4gUGF0Y2ggMi4NCuKAi+KAi1F1ZXN0aW9u4oCL4oCLOiBTaG91bGQgdGhpcyBzeXNmcyB0
b2dnbGUgZGVmYXVsdCB0byB0cnVlIChhbGxvdyBmYWxsYmFjayB0byBvdGhlciBub2Rlcykgb3Ig
ZmFsc2UgKHN0cmljdCBtb2RlOiBtaWdyYXRlIG9ubHkgdG8gbm9kZSAwLCBhYm9ydCBpZiBmdWxs
KT8gSSB3b3VsZCBhcHByZWNpYXRlIHlvdXIgYWR2aWNlIG9uIHRoZSBkZWZhdWx0IHZhbHVlLCBj
b25zaWRlcmluZyBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IGFuZCB1c2UgY2FzZXMuDQoNCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IHdhbmdjaHVhbmd1byA8d2FuZ2NodWFuZ3VvQGluc3B1ci5jb20+
DQo+ID4gLS0tDQo+ID4gIG1tL3Ztc2Nhbi5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9tbS92
bXNjYW4uYyBiL21tL3Ztc2Nhbi5jIGluZGV4DQo+ID4gZjhkZmQyODY0YmJmLi5lMTNmMTcyNDQy
NzkgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vdm1zY2FuLmMNCj4gPiArKysgYi9tbS92bXNjYW4uYw0K
PiA+IEBAIC0xMDM1LDExICsxMDM1LDExIEBAIHN0cnVjdCBmb2xpbyAqYWxsb2NfbWlncmF0ZV9m
b2xpbyhzdHJ1Y3QgZm9saW8NCj4gKnNyYywgdW5zaWduZWQgbG9uZyBwcml2YXRlKQ0KPiA+ICAJ
bXRjLT5ubWFzayA9IE5VTEw7DQo+ID4gIAltdGMtPmdmcF9tYXNrIHw9IF9fR0ZQX1RISVNOT0RF
Ow0KPiA+ICAJZHN0ID0gYWxsb2NfbWlncmF0aW9uX3RhcmdldChzcmMsICh1bnNpZ25lZCBsb25n
KW10Yyk7DQo+ID4gKwltdGMtPm5tYXNrID0gYWxsb3dlZF9tYXNrOw0KPiA+ICAJaWYgKGRzdCkN
Cj4gPiAgCQlyZXR1cm4gZHN0Ow0KPiANCj4gUmVzdG9yaW5nIC0+bm1hc2sgbG9va3MgcmlnaHQg
YmVoYXZpb3IgdG8gbWUuICBCdXQsIGlmIHNvLCBzaG91bGRuJ3Qgd2UgYWxzbw0KPiByZXN0b3Jl
IC0+Z2ZwX21hc2s/DQoNClllcywgaXQncyBhIGdvb2QgaWRlYS4gSSB3aWxsIGRvIGl0Lg0KIA0K
DQo+ID4NCj4gPiAgCW10Yy0+Z2ZwX21hc2sgJj0gfl9fR0ZQX1RISVNOT0RFOw0KPiA+IC0JbXRj
LT5ubWFzayA9IGFsbG93ZWRfbWFzazsNCj4gPg0KPiA+ICAJcmV0dXJuIGFsbG9jX21pZ3JhdGlv
bl90YXJnZXQoc3JjLCAodW5zaWduZWQgbG9uZyltdGMpOyAgfQ0KPiA+IC0tDQo+ID4gMi4zOS4z
DQo+IA0KPiANCj4gVGhhbmtzLA0KPiBTSg0K
