Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D524E016
	for <damon@lists.linux.dev>; Thu, 29 May 2025 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488454; cv=none; b=mQx1JNUiDMvDWtXtkcV0Xqw1Z8N8jJb3+4nTV0kX+qvLmLHTfTi12bCxmJSPxwqLuawBeh0EhbetwkS0nP3Y83+cZ4Y5lXrz2frZveIzHPC7h4aJdv+1BDi4UN52wJcDdswTt1KaKj0dmej82wNSHzovGtFYP3NAXRprVATQCjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488454; c=relaxed/simple;
	bh=l2ILOuIWZObDhYLZBp79OtjUsWxZ+VElQDnKaSlu3/M=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Kus0J+QEO5IDM9X0ucrEngtgjSLX+ymK5tyf+eW0U81I9Hg0tjXWQ3uR0YkAv7fdPXiOpOmfYJr80icQL4RzQgFopp9ROzCtNMJnDuz6nUM51sN/WeCVV6CKZDi3x1Wi3YTz22pw2IGhRFbJU9bXSN4o6ElujWKd6965aV+/SuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201602.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202505291114019608;
        Thu, 29 May 2025 11:14:01 +0800
Received: from jtjnmail201604.home.langchao.com (10.100.2.4) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 May 2025 11:14:00 +0800
Received: from jtjnmail201604.home.langchao.com ([fe80::2830:53ee:1228:5322])
 by jtjnmail201604.home.langchao.com ([fe80::2830:53ee:1228:5322%5]) with mapi
 id 15.01.2507.039; Thu, 29 May 2025 11:14:00 +0800
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
Subject: Re: [PATCH 0/2] add a knob to control whether to use other nodes at
 the same tier of the target node in DAMON
Thread-Topic: [PATCH 0/2] add a knob to control whether to use other nodes at
 the same tier of the target node in DAMON
Thread-Index: AdvQR4oBL7f9x+k7rE6rF3askVsezQ==
Date: Thu, 29 May 2025 03:14:00 +0000
Message-ID: <d70d2cc058fc4a588720076200c81214@inspur.com>
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
tUid: 2025529111402363094195051e7fd047f27fa357286b0
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

DQo+IFRoYW5rIHlvdSBmb3Igc2VuZGluZyB0aGlzIHBhdGNoIHNlcmllcyENCj4gDQo+IE9uIFdl
ZCwgMjggTWF5IDIwMjUgMTk6MTA6MzYgKzA4MDAgd2FuZ2NodWFuZ3VvDQo+IDx3YW5nY2h1YW5n
dW9AaW5zcHVyLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEluIERBTU9OJ3MgbWlncmF0ZV9ob3QgYW5k
IG1pZ3JhdGVfY29sZCBmZWF0dXJlcywgdGhlIGNvZGUgd2FzDQo+ID4gaW50ZW5kZWQgdG8gbWln
cmF0ZSBwYWdlcyDigIvigItvbmx5IHRvIHRoZSBub2RlIHNwZWNpZmllZCBieSB0YXJnZXRfbmlk
4oCL4oCLLg0KPiA+IEhvd2V2ZXIsIGR1cmluZyB0ZXN0aW5nLCBpdCB3YXMgb2JzZXJ2ZWQgdGhh
dCBtZW1vcnkgYWxsb2NhdGlvbiBhbmQNCj4gPiBtaWdyYXRpb24gY291bGQgb2NjdXIgb24g4oCL
4oCLYW55IG5vZGVz4oCL4oCLLCB3aGljaCBpcyBhIEJVRy4NCj4gPiBUaGUgZmlyc3QgcGF0Y2gg
aW4gdGhpcyBQUiBmaXggdGhpcyBpc3N1ZS4NCj4gPg0KPiA+IEEgdXNlX25vZGVzX29mX3RpZXIg
ZmlsZSBoYXMgYmVlbiBhZGRlZCB1bmRlciB0aGUgZGlyZWN0b3J5DQo+ID4gL3N5cy9rZXJuZWwv
bW0vZGFtb24vYWRtaW4va2RhbW9uZHMvPE4+L2NvbnRleHRzLzxOPi9zY2hlbWVzLzxOPi8NCj4g
PiB0byBjb250cm9sIHdoZXRoZXIgdG8g4oCL4oCLdXNlIG90aGVyIG5vZGVzIGluIHRoZSBzYW1l
IHRpZXIgYXMgdGhlIHRhcmdldA0KPiA+IG5vZGXigIvigIsgZm9yIG1pZ3JhdGlvbi4NCj4gDQo+
IEkgbGVmdCBhIGZldyBjb21tZW50cyBvbiB0aGUgcGF0Y2hlcy4gIExvb2tpbmcgZm9yd2FyZCB0
byBkaXNjdXNzaW9ucyBvbg0KPiBlYWNoIHN1Yi10aHJlYWQgOikNCj4gDQo+ID4NCj4gPiB3YW5n
Y2h1YW5ndW8gKDIpOg0KPiANCj4gSSBiZWxpZXZlIHlvdXIgbmFtZSBpcyBXYW5nIENodWFuZ3Vv
PyAgU29ycnkgaWYgSSByZWFkL3dyb3RlIGl0IHdyb25nbHkuDQo+IEJ1dCB3ZSBkaXNhbGxvd1sx
XSBhbm9ueW1vdXMgY29udHJpYnV0aW9ucywgYW5kIHByZWZlciBtb3JlIGZvcm1hbA0KPiBTaWdu
ZWQtb2ZmLWJ5Og0KPiBpZiBwb3NzaWJsZS4gIENvdWxkIHlvdSBwbGVhc2UgdXNlIHN1Y2ggZm9y
bWFsIFNpZ25lZC1vZmYtYnk6IGlkZW50aXR5LCBzYXksDQo+ICJXYW5nIENodWFuZ3VvIDx3YW5n
Y2h1YW5ndW9AaW5zcHVyLmNvbT4iIGZyb20gbmV4dCB0aW1lPw0KDQpJJ20gc29ycnksIHRoaXMg
d2FzIG15IG1pc3Rha2UuIEkgd2lsbCBiZSBtb3JlIGNhcmVmdWwgbmV4dCB0aW1lLg0KDQo+IFsx
XQ0KPiBodHRwczovL2RvY3Mua2VybmVsLm9yZy9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5o
dG1sI2RldmVsb3Blci1zLWNlcnRpZmljYQ0KPiB0ZS1vZi1vcmlnaW4tMS0xDQo+IA0KPiANCj4g
VGhhbmtzLA0KPiBTSg0KPiANCj4gWy4uLl0NCg==
