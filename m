Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C77B
	for <damon@lists.linux.dev>; Mon,  9 May 2022 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1652091243; x=1683627243;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=6QgrGcyp4Mk+3G0VkFn4Q4LxCcjPCl+ZDoGb2wNFrMo=;
  b=JAxEJVniUBNWGAWEtEa2A8DX5Ph5e02pbEs6kBk/HDV73RI66nvbd9dl
   /UAwSbwLYRL3b7lM7RnGu8kIaSNitk+MFtzwo53iIowFSzL1o+1Aagk+t
   zk3b29k5+uNv7r1n1Y+vDWD+vqGdDP+kZW1Vuig0l5WB2uxg38p+M8oy2
   U=;
X-IronPort-AV: E=Sophos;i="5.91,211,1647302400"; 
   d="scan'208";a="196437020"
Subject: Re: [PATCH] mm/damon/reclaim: Use resource_size function on resource object
Thread-Topic: [PATCH] mm/damon/reclaim: Use resource_size function on resource object
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-5c4a15b1.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 09 May 2022 10:13:51 +0000
Received: from EX13D13EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-5c4a15b1.us-west-2.amazon.com (Postfix) with ESMTPS id 797CB416C4;
	Mon,  9 May 2022 10:13:49 +0000 (UTC)
Received: from EX13D13EUB001.ant.amazon.com (10.43.166.101) by
 EX13D13EUB001.ant.amazon.com (10.43.166.101) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Mon, 9 May 2022 10:13:48 +0000
Received: from EX13D13EUB001.ant.amazon.com ([10.43.166.101]) by
 EX13D13EUB001.ant.amazon.com ([10.43.166.101]) with mapi id 15.00.1497.033;
 Mon, 9 May 2022 10:13:48 +0000
From: "Boehme, Markus" <markubo@amazon.de>
To: "jiapeng.chong@linux.alibaba.com" <jiapeng.chong@linux.alibaba.com>,
	"sj@kernel.org" <sj@kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "damon@lists.linux.dev"
	<damon@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "abaci@linux.alibaba.com"
	<abaci@linux.alibaba.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Thread-Index: AQHYYiihB0USfzggdUSRxWlPJRltUq0WVp2A
Date: Mon, 9 May 2022 10:13:48 +0000
Message-ID: <5a9268fcd7bb829414da20aecd06d9e1d47a3489.camel@amazon.de>
References: <20220507153833.45600-1-sj@kernel.org>
In-Reply-To: <20220507153833.45600-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.180]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB10E6E853AF69478F7EAEC9785FF1D0@amazon.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: base64

KEtlZXBpbmcgU0oncyBtYWlsIGZvciBjb250ZXh0LCBzaW5jZSBvcmlnaW5hbCBwYXRjaCBzZWVt
cyB0byBub3QgaGF2ZQ0KZ29uZSB0byB0aGUgREFNT04gbGlzdC4pDQoNCk9uIFNhdCwgMjAyMi0w
NS0wNyBhdCAxNTozOCArMDAwMCwgU2VvbmdKYWUgUGFyayB3cm90ZToNCj4gT24gU2F0LCA3IE1h
eSAyMDIyIDExOjI1OjEyICswODAwIEppYXBlbmcgQ2hvbmcgPGppYXBlbmcuY2hvbmdAbGludXgu
YWxpYmFiYS5jb20+IHdyb3RlOg0KPiANCj4gPiBGaXggdGhlIGZvbGxvd2luZyBjb2NjaWNoZWNr
IHdhcm5pbmdzOg0KPiA+IA0KPiA+IC4vbW0vZGFtb24vcmVjbGFpbS5jOjI0MTozMC0zMzogV0FS
TklORzogU3VzcGljaW91cyBjb2RlLiByZXNvdXJjZV9zaXplDQo+ID4gaXMgbWF5YmUgbWlzc2lu
ZyB3aXRoIHJlcy4NCj4gDQo+IE5pdC4gIEknZCBwcmVmZXIgaGF2aW5nIHRoaXMga2luZCBvZiBw
cm9ncmFtIG91dHB1dHMgaW4gY29tbWl0IG1lc3NhZ2UgYmUNCj4gaW5kZW50ZWQgYW5kIG5vdCBi
cm9rZW4sIGxpa2UgYmVsb3c6DQo+IA0KPiAgICAgLi9tbS9kYW1vbi9yZWNsYWltLmM6MjQxOjMw
LTMzOiBXQVJOSU5HOiBTdXNwaWNpb3VzIGNvZGUuIHJlc291cmNlX3NpemUgaXMgbWF5YmUgbWlz
c2luZyB3aXRoIHJlcy4NCj4gDQo+ID4gUmVwb3J0ZWQtYnk6IEFiYWNpIFJvYm90IDxhYmFjaUBs
aW51eC5hbGliYWJhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaWFwZW5nIENob25nIDxqaWFw
ZW5nLmNob25nQGxpbnV4LmFsaWJhYmEuY29tPg0KPiANCj4gT3RoZXIgdGhhbiB0aGUgbml0LA0K
PiANCj4gUmV2aWV3ZWQtYnk6IFNlb25nSmFlIFBhcmsgPHNqQGtlcm5lbC5vcmc+DQo+IA0KPiAN
Cj4gVGhhbmtzLA0KPiBTSg0KPiANCj4gPiAtLS0NCj4gPiAgbW0vZGFtb24vcmVjbGFpbS5jIHwg
MiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbW0vZGFtb24vcmVjbGFpbS5jIGIvbW0vZGFtb24vcmVj
bGFpbS5jDQo+ID4gaW5kZXggZjM3YzVkNGIyN2ZhLi44ZWZiZmIyNGYzYTEgMTAwNjQ0DQo+ID4g
LS0tIGEvbW0vZGFtb24vcmVjbGFpbS5jDQo+ID4gKysrIGIvbW0vZGFtb24vcmVjbGFpbS5jDQo+
ID4gQEAgLTIzOCw3ICsyMzgsNyBAQCBzdGF0aWMgaW50IHdhbGtfc3lzdGVtX3JhbShzdHJ1Y3Qg
cmVzb3VyY2UgKnJlcywgdm9pZCAqYXJnKQ0KPiA+ICB7DQo+ID4gICAgICAgc3RydWN0IGRhbW9u
X3JlY2xhaW1fcmFtX3dhbGtfYXJnICphID0gYXJnOw0KPiA+IA0KPiA+IC0gICAgIGlmIChhLT5l
bmQgLSBhLT5zdGFydCA8IHJlcy0+ZW5kIC0gcmVzLT5zdGFydCkgew0KPiA+ICsgICAgIGlmIChh
LT5lbmQgLSBhLT5zdGFydCA8IHJlc291cmNlX3NpemUocmVzKSkgew0KPiA+ICAgICAgICAgICAg
ICAgYS0+c3RhcnQgPSByZXMtPnN0YXJ0Ow0KPiA+ICAgICAgICAgICAgICAgYS0+ZW5kID0gcmVz
LT5lbmQ7DQo+ID4gICAgICAgfQ0KPiA+IC0tDQo+ID4gMi4yMC4xLjcuZzE1MzE0NGMNCg0KVGhp
cyBpcyBub3QganVzdCBmaXhpbmcgdGhlIHdhcm5pbmcsIGJ1dCBjaGFuZ2luZyB0aGUgY2FsY3Vs
YXRpb24NCnNsaWdodGx5IHRvIGNvcnJlY3RseSBkZXRlcm1pbmUgc2l6ZSAocmVzLT5lbmQgbm90
IHBvaW50aW5nIG9uZSBiZXlvbmQNCnRoZSBlbmQsIGJ1dCB0byB0aGUgbGFzdCBhZGRyZXNzIGlu
IHRoZSByZWdpb24pLiBGb3IgZmluZGluZyB0aGUNCmJpZ2dlc3QgcmVnaW9uIGl0IGRvZXNuJ3Qg
bWF0dGVyIGJlaW5nIG9mZiBieSBvbmUgY29uc2lzdGVudGx5LCBidXQNCmp1c3QgZml4aW5nIG9u
ZSBzaWRlIG9mIHRoZSBjb21wYXJpc29uIGNoYW5nZXMgYmVoYXZpb3IgaW4gdGhlIHByZXNlbmNl
DQpvZiB0d28gZXF1YWwgcmVnaW9ucy4gV2hlbiBmaXhpbmcgYm90aCBzaWRlcywgdGhlICJzdHJ1
Y3QNCmRhbW9uX3JlY2xhaW1fcmFtX3dhbGtfYXJnIiBtaWdodCBqdXN0IGJlIHJlcGxhY2VkIHdp
dGggYSAic3RydWN0DQpyZXNvdXJjZSIsIHRvby4NCg0KTWFya3VzDQoKCgpBbWF6b24gRGV2ZWxv
cG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2Vz
Y2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5n
ZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIK
U2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

