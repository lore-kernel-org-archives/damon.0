Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF66244682
	for <damon@lists.linux.dev>; Thu, 29 May 2025 03:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488343; cv=none; b=fmnrEtmN0EfUN57PD3mreiVLDD3aLr/9GRHfR7Ui3Ip3v3xVb9nSrJr93AVvQn4E2JtA1eqpQUVfY9ARYTTZM5yDSdYXx975/444us8J5cdi6d6FtuGhlvClmwj/6egXRBVf0wH3gD7E8ojIMYe4LXKSW1BEei5MQBxvBajhvXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488343; c=relaxed/simple;
	bh=G1ubmSmlgIIg8z9v8LwHuesFX011If3nx8FIgggMVoU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gs9k4re+5PNSmPezOdzvHzq8ptcv/3eKukMwXB54nMUraFv+GAPOeGV2HxOHjBe+XgVgj5Kn2/GY1bxkEmL5xeHXkep79blOPkiqww/V+gwcjZFLeRQL/a1ctREL+XqAHOLiDMqYqWB2Or/BXz4FSSVqJKmJNLhxYqQEIWpWJso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201604.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202505291112148271;
        Thu, 29 May 2025 11:12:14 +0800
Received: from jtjnmail201604.home.langchao.com (10.100.2.4) by
 jtjnmail201604.home.langchao.com (10.100.2.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 May 2025 11:12:14 +0800
Received: from jtjnmail201604.home.langchao.com ([fe80::2830:53ee:1228:5322])
 by jtjnmail201604.home.langchao.com ([fe80::2830:53ee:1228:5322%5]) with mapi
 id 15.01.2507.039; Thu, 29 May 2025 11:12:14 +0800
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
	<damon@lists.linux.dev>
Subject: Re: [PATCH 2/2] mm/damon/sysfs-schemes: add use_nodes_of_tier on
 sysfs-schemes
Thread-Topic: [PATCH 2/2] mm/damon/sysfs-schemes: add use_nodes_of_tier on
 sysfs-schemes
Thread-Index: AdvQR2UA5T86Vzy5jEWqO1rgtF0few==
Date: Thu, 29 May 2025 03:12:13 +0000
Message-ID: <a3f041d817534652a3e1e6545432016b@inspur.com>
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
tUid: 2025529111215b4a5fc5a49b7eb564c936dfce3c5c05b
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

PiA+IFRoaXMgcGF0Y2ggYWRkcyB1c2Vfbm9kZXNfb2ZfdGllciB1bmRlcg0KPiA+DQo+IC9zeXMv
a2VybmVsL21tL2RhbW9uL2FkbWluL2tkYW1vbmRzLzxOPi9jb250ZXh0cy88Tj4vc2NoZW1lcy88
Tj4vDQo+ID4NCj4gPiBUaGUgJ3VzZV9ub2Rlc19vZl90aWVyJyBjYW4gYmUgdXNlZCB0byBzZWxl
Y3Qgbm9kZXMgd2l0aGluIHRoZSBzYW1lDQo+ID4gbWVtb3J5IHRpZXIgb2YgdGFyZ2V0X25pZCBm
b3IgREFNT1MgYWN0aW9ucyBzdWNoIGFzDQo+IERBTU9TX01JR1JBVEVfe0hPVCxDT0xEfS4NCj4g
DQo+IENvdWxkIHlvdSBwbGVhc2UgZWxhYm9yYXRlIGluIHdoYXQgc2V0dXAgeW91IHRoaW5rIHRo
aXMgb3B0aW9uIGlzIHVzZWZ1bCwgYW5kDQo+IG1lYXN1cmVtZW50IG9mIHRoZSB1c2VmdWxuZXNz
IGlmIHlvdSBoYXZlPw0KPiANCj4gSSdtIGFza2luZyB0aGUgYWJvdmUgcXVlc3Rpb24gYmVjYXVz
ZSBvZiBiZWxvdyByZWFzb25zLiAgTXkgYW50aWNpYXB0ZWQNCj4gdXNhZ2Ugb2YgREFNT1NfTUlH
UkFURV97SE9ULENPTER9IGlzIGZvciBub3Qgb25seSBtZW1vcnkgdGllcmluZyBidXQNCj4gZ2Vu
ZXJpYyBOVU1BIG5vZGUgbWFuYWdlbWVudC4gIEFuZCBteSBwcm9wb3NlZCB1c2FnZSBvZiB0aGVz
ZSBmb3INCj4gbWVtb3J5IHRpZXJpbmcgaXMgbWFraW5nIHBlci1ub2RlIHByb21vdGlvbi9kZW1v
dGlvbiBmb3IgZ3JhZHVhbGx5DQo+IHByb21vdGluZyBhbmQgZGVtb3RpbmcgcGFnZXMgc3RlcCBi
eSBzdGVwIGJldHdlZW4gbm9kZS4gIEl0IGNvdWxkIGJlIHNsb3cNCj4gYnV0IEkgYW50aWNpcGF0
ZSBzdWNoIHNsb3cgYnV0IGNvbnRpbnVlZCBwcm9tb3Rpb24vZGVtb3Rpb24gaXMgbW9yZQ0KPiBp
bXBvcnRhbnQgZm9yIHJlbGlhYmxlIHBlcmZvcm1hbmNlIG9uIHByb2R1Y3Rpb24gc3lzdGVtcyBv
ZiBsYXJnZSB0aW1lIHNjYWxlLg0KPiBBbmQgSSBiZWxpZXZlIHRoZSBhcHByb2FjaCBjYW4gYmUg
YXBwbGllZCB0byBnZW5lcmFsIE5VTUEgbm9kZXMNCj4gbWFuYWdlbWVudCwgb25jZSBEQU1PTiBp
cyBleHRlbmRlZCBmb3IgcGVyLUNQVSBhY2Nlc3MgbW9uaXRvcmluZy4NCj4gDQo+IEknbSBub3Qg
c2F5aW5nIHRoaXMgY2hhbmdlIGlzIG5vdCB1c2VmdWwsIGJ1dCBhc2tpbmcgeW91IHRvIGdpdmUg
bWUgYSBjaGFuY2UgdG8NCj4gbGVhcm4geW91ciBjaGFuZ2VzLCBiZXR0ZXIuDQoNCkkgYmVsaWV2
ZSBzb21lIHVzZXJzIG1heSB3YW50IHRvIOKAi+KAi3VzZSBvbmx5IHRoZSB0YXJnZXQgbm9kZSdz
IG1lbW9yeeKAi+KAiyBhbmQgcmVzZXJ2ZSBvdGhlciBub2RlcyBpbiB0aGUgc2FtZSB0aWVyIGZv
ciBzcGVjaWZpYyBhcHBsaWNhdGlvbnMuIFRoZXJlZm9yZSwgSSBhZGRlZCBhIHN3aXRjaCBmaWxl
IHVzZV9ub2Rlc19vZl90aWVyLiBJIHRoaW5rIGl0IG1pZ2h0IGJlIGJldHRlciB0byBzZXQgdGhl
IGRlZmF1bHQgdmFsdWUgb2YgdXNlX25vZGVzX29mX3RpZXIgdG8gdHJ1ZSAoaS5lLiwgYWxsb3cg
dXNpbmcgZmFsbGJhY2sgbm9kZXMpLiBXaGF0IGRvIHlvdSB0aGluaw0KDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiB3YW5nY2h1YW5ndW8gPHdhbmdjaHVhbmd1b0BpbnNwdXIuY29tPg0KPiA+IC0t
LQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2RhbW9uLmggICAgICAgIHwgIDkgKysrKysrKystDQo+ID4g
IGluY2x1ZGUvbGludXgvbWVtb3J5LXRpZXJzLmggfCAgNSArKysrKw0KPiA+ICBtbS9kYW1vbi9j
b3JlLmMgICAgICAgICAgICAgIHwgIDYgKysrKy0tDQo+ID4gIG1tL2RhbW9uL2xydV9zb3J0LmMg
ICAgICAgICAgfCAgMyArKy0NCj4gPiAgbW0vZGFtb24vcGFkZHIuYyAgICAgICAgICAgICB8IDE5
ICsrKysrKysrKysrKy0tLS0tLS0NCj4gPiAgbW0vZGFtb24vcmVjbGFpbS5jICAgICAgICAgICB8
ICAzICsrLQ0KPiA+ICBtbS9kYW1vbi9zeXNmcy1zY2hlbWVzLmMgICAgIHwgMzENCj4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICBtbS9tZW1vcnktdGllcnMuYyAgICAgICAg
ICAgIHwgMTMgKysrKysrKysrKysrKw0KPiA+ICBzYW1wbGVzL2RhbW9uL210aWVyLmMgICAgICAg
IHwgIDMgKystDQo+ID4gIHNhbXBsZXMvZGFtb24vcHJjbC5jICAgICAgICAgfCAgMyArKy0NCj4g
PiAgMTAgZmlsZXMgY2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+
IA0KPiBDYW4gd2UgcGxlYXNlIG1ha2UgdGhpcyBjaGFuZ2UgbW9yZSBzZXBhcmF0ZWQ/ICBNYXli
ZSB3ZSBjYW4gc3BsaXQgdGhlDQo+IGNoYW5nZSBmb3IgbWVtb3J5LXRpZXJzLmMsIERBTU9OIGNv
cmUgbGF5ZXIsIGFuZCBEQU1PTiBzeXNmcyBpbnRlcmZhY2UuDQo+IFRoYXQgd2lsbCBtYWtlIHJl
dmlldyBtdWNoIGVhc2llci4NCg0KWWVzLEknbGwgc3BsaXQgdGhpcyBwYXRjaCB0byBiZSAyIHBh
dGNoZXMuDQoNCg0KPiBJJ2xsIGFkZCBtb3JlIGNvbW1lbnRzIGZvciBkZXRhaWxzIGFmdGVyIGFi
b3ZlIGhpZ2ggbGV2ZWwgZGlzY3Vzc2lvbiBpcyBkb25lLg0KPiANCj4gDQo+IFRoYW5rcywNCj4g
U0oNCj4gDQo+IFsuLi5dDQo=
