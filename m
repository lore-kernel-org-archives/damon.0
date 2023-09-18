Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2104.outbound.protection.outlook.com [40.107.117.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781B214AA2
	for <damon@lists.linux.dev>; Mon, 18 Sep 2023 12:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm55OqZBlUdyrBy6ikNwQ8psP8seiukVX9NT8L2y+f86Z5yrUBuOGSmVmZXQMN+dXc3UZNSKk3UOCg3MxXowN0A+wDZZN0nhhnOhCEOgDJBBUIMwhaWk1GqWvtNF3tgkadIvsCfGdKd5FpvPKRLTvd24fmTyjDNv9pTOYKpDfzACN9GXokJfciC911Vs63lxIWjldn0nuWi+oNHQuc8SDfJY7GDBNnjjHS2VknbRlqd1KCXKCvxjMZf2bzwmaZjPhKHu5R0T+begnBSJ6y5NaZWrBJXgMBh9y/+iRZejyhDItS+8ufq+NPMDiIFkL4cu7KScZE3NsxIDHHiRW4LT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoffOoUyYTIywwSD08FdD1N/VEhu7+G4fKdGtpymksE=;
 b=XVfEBEH2sEL7JF2pN6T8o9YZ0OnIvYo93+0+fSrMAeZkPrC9FH53kbvN+O1gEMcnan8QeDyzGeFfcGGVCjW3NvWNevJTo1Q696IdCa5PVXqNcCKmSyO6pT1F6Lg2GacbYSEVfZJ6TM5gA8zvX1ewq9BWueKKY+j1VZRD7rNdJC/fGl3D9grwPtFjeqoEmMMN5pMvN897ubJLATZ2Hqp7BuJOuVeTWL2nuJK1xZpXOx5FzwApNIcESVB6T3/ygdFcQG6qwV2+zdkNTDR3PJYo1d4Szn9NLgw5+Sq/VI5Y7xX9m5fidSuC7QWF/9wFxqvPNUkJVyCga/sTl5JdR7D9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoffOoUyYTIywwSD08FdD1N/VEhu7+G4fKdGtpymksE=;
 b=AbYCQ1M3E5kn5PizkWWzTmVjlBlPAT4IqDHRwFTLUINQbWEYO6FlnKEO6YqrVKaW5KCLUScxbr7KeIPme8w/Ss4+6E1nD3Y4cyN3ISIHBt1u9IUNQvgyHRez0TzZ4qFLRJ8dMAROJqCIa6bbQA5OH2+GKDGIlqYO3tjpI9u5QIqveDWCNrPulfhZ3R/CwgFFLv2xItSYDn/QZ82JC05ibbUU/tYuIjVVE1iw5EPv6p1kZtRcxNvj4/z/lZ8wbmmtkkT8Q2rZGxp31zXIfWS19CvyAvOgiARgSHtWMvRXQBOiAsUdusVN7rQq/t1atQqZoxftec2ohBBO/rws7NFYeQ==
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by PUZPR06MB5933.apcprd06.prod.outlook.com (2603:1096:301:11a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 12:08:12 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02%4]) with mapi id 15.20.6792.020; Mon, 18 Sep 2023
 12:08:12 +0000
From: =?utf-8?B?5p2o5qyi?= <link@vivo.com>
To: SeongJae Park <sj@kernel.org>, =?utf-8?B?5p2o5qyi?= <link@vivo.com>
CC: Andrew Morton <akpm@linux-foundation.org>, "open list:DATA ACCESS MONITOR"
	<damon@lists.linux.dev>, "open list:DATA ACCESS MONITOR"
	<linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject: Re: [PATCH] mm/damon/core: remove unnecessary si_meminfo invoke.
Thread-Topic: [PATCH] mm/damon/core: remove unnecessary si_meminfo invoke.
Thread-Index: AQHZ6hV5//ius9Kmr0eo1HhzjuichbAgbXmAgAAP8oA=
Date: Mon, 18 Sep 2023 12:08:11 +0000
Message-ID: <ac9ede0f-e250-4bf9-869b-9e90369f7b8e@vivo.com>
References: <20230918111107.85008-1-sj@kernel.org>
In-Reply-To: <20230918111107.85008-1-sj@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5676:EE_|PUZPR06MB5933:EE_
x-ms-office365-filtering-correlation-id: 0f2ab2f7-ceb5-43a5-370a-08dbb83fee12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 njT/Yz3gvB27cqGwlexAfvWt5g1+V2L6zU2+bMZE3UJs91bAwm6OvGlhJEutN2NEoWmDy4TChKZKoM8b/m8uIhVt5L+IvXJptkvkxkgqYJRAl01OefqsPJCoVjZuGJnFRGT0K+cL7MdlYoYdLdh6/GsJPB26CWxpJqmskPlX1cihLzN0SLGtoDFDGTqpiqJdA9MpUO+X/YNZcq9pUJEco1bH8rslRMiHc4LSSiDrOwpbbf1cp+gXkn+SliIMYTlYlF0yoIzWNNlZSbRN+m5ZMrzsr9nnTYrRf9Pxbf2XL4g1y4yRcZjV3oqUKkybGlF+GcP+6MuOv+sWW/ZyxeBffNnrov+S30tdBNva9f0aPEKLrVKCP+PLBvMbvKXfpuIbB30HUcnNvbKcdZCcAqoMWJdaXe4rtAiq70Ff7ykc842UupkwHozcKHKE0eQa/TXyrwD4CfckWzh7cZ94tZ9+Vv5mVY9cUUrfTq83vLqIK5VloxFPcCYIH3yOFHWg6IihhLampm7+0Tf+mD2Cpe4Z+X7Z9gG0y11K96z6ghdeAPlbvmMpZB+X2Oz68P+YqG3NbTDNUjUYDR1pU4URMyekV6r1XkGttNwIQf8yFhko76dGEcKmtinIN2CJ2KKgqTl9sqC9iKLfxCr+hC5kxgH9qQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(6506007)(6486002)(71200400001)(6512007)(478600001)(83380400001)(26005)(2616005)(107886003)(2906002)(66556008)(54906003)(66446008)(76116006)(66476007)(316002)(66946007)(64756008)(110136005)(91956017)(5660300002)(8676002)(4326008)(8936002)(41300700001)(36756003)(86362001)(85182001)(31696002)(38100700002)(38070700005)(122000001)(31686004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXZmWDhPWVJIQ2JLSnpUZFlrZkxxT0ZSMFBFejhKdFV0aWhhQWljZ3M2a2kv?=
 =?utf-8?B?UVZhaVBnNGtIUWFYZlRjNSt6Rktmay8rSkF2WmJJU013eURRTE4rai9HV0M5?=
 =?utf-8?B?U3pkQlBTY0QwM0hIcWFaSWNkcFJzVFZzb3dqYVI0dVU3Y2dxUTZZMTkrTFNp?=
 =?utf-8?B?K09nTi84Y2M2RFlOYndYcmRUbXFlQTEyZUJEV3hmS3Z1ODZWVy9Ld3UxcVll?=
 =?utf-8?B?ZHgvQUVMTHJ5akw0QVVPK3AybUJaUHp4Zkp6SXdiU2hRQXFnbzM4SnB5cGNu?=
 =?utf-8?B?Vng5anlNUTFlUG01cEZqY09taWZKMDYzcGZ5TU5RRWlCaWFWQ29qaUExck5r?=
 =?utf-8?B?K3FNMUlJYXhVUStsSmNXYkMyT3BKUUh1ZzZrYW1HWC9aUUdKZTlZcTIrT2tu?=
 =?utf-8?B?SEdYSHh5dEgyc3p2NEc4LzJVMlZuRUF0dGhDNk85OEYrekplOTF4eDc4blZW?=
 =?utf-8?B?M0pJeUl1YWRPZGRibjVocld5NUFPSFZjbHlkK2h0Zldsd00wWGNLSWs5QlI4?=
 =?utf-8?B?WEdQVURiQjBtNCtNRFFqN0VkUDlhS083QmI4SUpueXd5elhSTjV3a3VKaVVC?=
 =?utf-8?B?Y0dxeUgxTG5rVEo0YVhYMk5aOGNQN1JFRGZzOXNoK3h5dFJZc0U2UzdrQ21p?=
 =?utf-8?B?YXR3Q05SdndyRUhVdEhhd0pZMTE2QUV0amNKeVRCTGRFSWlBUTF3TnFka0hO?=
 =?utf-8?B?S0o5VTJvNVJzUExwN2owbnh2Um9rWC9zblcrL1doVEhkaTJzc29VelZiYXVw?=
 =?utf-8?B?K09yRk1xN1M0RFgweEhHenAxbS9WVWNuSzVXaDM4RmdYQVNuUEd0RWlXeFky?=
 =?utf-8?B?TlE1WnBmeEd5ZzhJMUk0SVBxOVo2OUQ4OWY3SmVON2x5eFQvcllmYTRlNTVE?=
 =?utf-8?B?dnVEVWhFR3l1Tk5XLzJua1RZVkNkZXZFT2NBcTZoTENhQ0ozckdmalF1Qk54?=
 =?utf-8?B?TFhSTGowanBkUUFMdmprUHZhdlR2RWFTclVCYU9zZFNsaXRZQ1NaY05EaFpL?=
 =?utf-8?B?L1NTMHdIbzNMaHBMaW4zaTdDcGVSVnRVNkpYWjE1dWlPYzBqMW1vMkVQd25G?=
 =?utf-8?B?Qm40czZTTEZuZEU3a2tYQ3E4Z3A1SmpRZkpySnhINi9FTmVBbktDVXowTFVU?=
 =?utf-8?B?T2E4UkF0WldoM0FnZTlCOXU5ZlRndEFvT3pxQ2FuK0lSMzhwOG9Ya2NXQXdJ?=
 =?utf-8?B?NlJ1a2FDSWFYRFdSdnAzbXg3WWVwVkRnY3hXckN0Z0hMRGxGTU5wNndVVkJQ?=
 =?utf-8?B?U3JDajQ4OVpzQ3BuMkRUcHZ2aituUnh4eERBU1J5emhwRjNyMTk1YmVvZjJJ?=
 =?utf-8?B?VW9lQ0kzZDFIaW9iRUlmUVEyRTVaQlJMQmJkUGtXeWQ0RzFvUTg1U2FPMnlN?=
 =?utf-8?B?bHdLdjRnbGFlRGhOeHdYZnBnUGlzMzZVZXMvTE9STkpndndBVzF0b1RyR2tn?=
 =?utf-8?B?TlAzR2srczB0dkNySGMrUTRDWlVBc2s3V2JwUjhaMWNhMnoyZUFlTDdDdDFQ?=
 =?utf-8?B?a1JHdkEzZE42eXh5d2UyM3J0YXhibVBBdzlpK1lYZGZBdU1rV2dFSGdHbnRm?=
 =?utf-8?B?MEtzZnltN1NtSWpYMEE1NnVRWlh6L2JwUklGSEpJOFhMaW1VeGYrSE1QZ2oz?=
 =?utf-8?B?ck9JeExwSTB6Um9uZkhJZkhxcnZBN09mRms2cXhjVzdIU2hDOWxIQzRldWp0?=
 =?utf-8?B?NDUyZ1Mva0FTTGNnekFRWnBsRyt4NjVsSUZrTHg0VUtvZHk2dEV5cTFyWWtn?=
 =?utf-8?B?M0kzMWNsVjVEUk4xR0loM0pEc09ZWVVRSjhRWkNLYVprYkt2Z0ErQVppeGM0?=
 =?utf-8?B?czNVOVdHKzAweHRHUzQ4SHBSdEw5aDl3R1dXVUt6dzNnUDhPQUM0V1Rna3VI?=
 =?utf-8?B?a0hUN3k3TTdDYXpQN0VmeStPbjNnb3ZsRW9ZK3EvQzJrOTZ3Z0RBVVNyNTcy?=
 =?utf-8?B?MHFiTmJMbUhpNkRGbkpxRzBKU0d2d1pSbU5hWGk0bE5CZVJjSnNJWFhHeW1M?=
 =?utf-8?B?Y0ExQzIyZmhUWUZ0VFBORVdqQ2hSQmZXbk9DcG9BOE9ZSGpXQjRQeHBVVDZw?=
 =?utf-8?B?R0FjUEpOTmxCc0o2VmJJZi92TWd6SDFDVnc0VklVTnBQV1hhWG84cDk3MkdT?=
 =?utf-8?Q?gb3Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9133525E15C1F546A4A538BDC0506FB5@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2ab2f7-ceb5-43a5-370a-08dbb83fee12
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 12:08:11.9545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYuP3Ajgs4ZOUJBzhZgDQmFUfSHXypFZFB3VJdL7vxMTMP/2wKh3x7IvN7hhIHD7iolekaPzPlnHTgGITo2RsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5933

5ZyoIDIwMjMvOS8xOCAxOToxMSwgU2VvbmdKYWUgUGFyayDlhpnpgZM6DQo+IEhpIEh1YW4sDQo+
DQo+IE9uIE1vbiwgMTggU2VwIDIwMjMgMTc6NDk6MzQgKzA4MDAgSHVhbiBZYW5nIDxsaW5rQHZp
dm8uY29tPiB3cm90ZToNCj4NCj4+IHNpX21lbWluZm8oKSB3aWxsIHJlYWQgYW5kIGFzc2lnbiBt
b3JlIGluZm8gbm90IGp1c3QgZnJlZS9yYW0gcGFnZXMuDQo+IE5pY2UgY2F0Y2ggOikNCj4NCj4+
IEZvciBqdXN0IERBTU9TX1dNQVJLX0ZSRUVfTUVNX1JBVEUgdXNlLCBvbmx5IGdldCBmcmVlIGFu
ZCByYW0gcGFnZXMNCj4+IGlzIG9rIHRvIHNhdmUgY3B1Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IEh1YW4gWWFuZyA8bGlua0B2aXZvLmNvbT4NCj4+IC0tLQ0KPj4gICBtbS9kYW1vbi9jb3JlLmMg
fCAxMCArKysrKystLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL21tL2RhbW9uL2NvcmUuYyBiL21tL2Rh
bW9uL2NvcmUuYw0KPj4gaW5kZXggYmNkMmJkOWQ2YzEwLi4xY2RkZWU5YWU3M2IgMTAwNjQ0DQo+
PiAtLS0gYS9tbS9kYW1vbi9jb3JlLmMNCj4+ICsrKyBiL21tL2RhbW9uL2NvcmUuYw0KPj4gQEAg
LTEyNzgsMTQgKzEyNzgsMTYgQEAgc3RhdGljIGJvb2wga2RhbW9uZF9uZWVkX3N0b3Aoc3RydWN0
IGRhbW9uX2N0eCAqY3R4KQ0KPj4gICAJcmV0dXJuIHRydWU7DQo+PiAgIH0NCj4+ICAgDQo+PiAt
c3RhdGljIHVuc2lnbmVkIGxvbmcgZGFtb3Nfd21hcmtfbWV0cmljX3ZhbHVlKGVudW0gZGFtb3Nf
d21hcmtfbWV0cmljIG1ldHJpYykNCj4+ICtzdGF0aWMgdW5zaWduZWQgbG9uZyBfX2RhbW9uc19n
ZXRfd21hcmtfZnJlZV9tZW1fcmF0ZSh2b2lkKQ0KPiBOaXQuICBzL2RhbW9ucy9kYW1vcy8gd291
bGQgbG9vayBtb3JlIGNvbnNpc3RlbnRseSwgaW4gbXkgb3Bpbmlvbj8NCkhJLCBTSiwgc29ycnks
IHdoYXQncyB0aGlzIG1lYW4/DQo+DQo+PiAgIHsNCj4+IC0Jc3RydWN0IHN5c2luZm8gaTsNCj4+
ICsJcmV0dXJuIGdsb2JhbF96b25lX3BhZ2Vfc3RhdGUoTlJfRlJFRV9QQUdFUykgKiAxMDAwIC8g
dG90YWxyYW1fcGFnZXMoKTsNCj4+ICt9DQo+PiAgIA0KPj4gK3N0YXRpYyB1bnNpZ25lZCBsb25n
IGRhbW9zX3dtYXJrX21ldHJpY192YWx1ZShlbnVtIGRhbW9zX3dtYXJrX21ldHJpYyBtZXRyaWMp
DQo+PiArew0KPj4gICAJc3dpdGNoIChtZXRyaWMpIHsNCj4+ICAgCWNhc2UgREFNT1NfV01BUktf
RlJFRV9NRU1fUkFURToNCj4+IC0JCXNpX21lbWluZm8oJmkpOw0KPj4gLQkJcmV0dXJuIGkuZnJl
ZXJhbSAqIDEwMDAgLyBpLnRvdGFscmFtOw0KPj4gKwkJcmV0dXJuIF9fZGFtb25zX2dldF93bWFy
a19mcmVlX21lbV9yYXRlKCk7DQo+IFNpbmNlIF9fZGFtb25zX2dldF93bWFya19mcmVlX21lbV9y
YXRlKCkgaXMganVzdCBvbmUgbGluZSBmdW5jdGlvbiBhbmQNCj4gZGFtb3Nfd21hcmtfbWV0cmlj
X3ZhbHVlKCkgaXMgdGhlIG9ubHkgdXNlciBvZiB0aGUgY29kZSwgSSB0aGluayB3ZSBjb3VsZCBq
dXN0DQo+IHdyaXQgdGhlIGNvZGUgaGVyZT8NCg0KSSBkbyB0aGlzIGluIG1pbmUgZmlyc3QgcGF0
Y2gsIGJ1dCB0aGVuLCBJIGZvbGQgdGhpcyBpbnRvIA0KIl9fZGFtb25zX2dldF93bWFya19mcmVl
X21lbV9yYXRlIg0KDQpkdWUgdG8gSSB0aGluayB0aGUgIl9fZGFtb25zX2dldF93bWFya19mcmVl
X21lbV9yYXRlIiBtYXkgY2hhbmdlIHRoZSANCm1lYW5pbmcgZm9yIGZ1cnR1cmUsDQoNCmFuZCBt
YXkgc2lfbWVtaW5mbyB3aWxsIGNvbWUgYmFjayBzb29uPyhJZiB3ZSBuZWVkIG1vcmUgaW5mbyB0
byBnZXQgdGhlIA0KcmF0ZT8pLiBBbmQsIGFsc28sIHRoZQ0KDQpzdGF0aWMgZnVuY3Rpb24gSWYg
anVzdCBzb21lIHVzZXIgdXNlLCBpdCB3aWxsIGJlIGlubGluZSwgc28sIEkganVzdCANCnRoaW5r
IGZvbGQgaXQgd2lsbCBiZSBiZXR0ZXIuDQoNCkRvIHlvdSB0aGluayBzbz8NCg0KVGhhbmtzLA0K
DQpIdWFuDQoNCj4NCj4+ICAgCWRlZmF1bHQ6DQo+PiAgIAkJYnJlYWs7DQo+PiAgIAl9DQo+PiAt
LSANCj4+IDIuMzQuMQ0KPg0KPiBUaGFua3MsDQo+IFNKDQoNCg0K
