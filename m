Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2120.outbound.protection.outlook.com [40.107.215.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AACA399
	for <damon@lists.linux.dev>; Tue, 19 Sep 2023 01:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gbn/RpFF1n6i0PDAqAl24sBefAxeTeOioZypXb1SZgJbdHgxnOq51hMAlu08UR0UalQ59KP9er//FwtKWGiIjtnuZ+N6jQtHgBOaqApT0dKRxVgtk4qCBrzfEkGfK1AkiBbru4Lv7jzcfhzWxoxm/LEe3Frx761wLpYAWxEhJITwLY8Lv7Q6Tr8ArqRA0+RYngtkFO6ZmQXKGrmZCNqdZvFz+VZtHUATE8SOGvxRiI2Mq5gx9I6RUzUUVumSC0HT3/3yKw1/2bvnPUcuhtyv9/1DQouTGXMAeSnvYNX4gc4kgl/iftZQ+BV69rt6Sz9xLX9Le17ELOj7Ctvfn3gs2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/Df+bcsR5WCQ6TavHD5oKCpMo1XG2ff17vMhKbt+7g=;
 b=ZKS7g7xesH5n4pvcnuge2GJ8n67+Btw/R21i58qwFjtYpB8RXg4gJIkebR/f3kfyyaSeM9UuZ/dhOfvSFOIDuX8lnWYBiqzXX5hWzUhEEVuQo4v/Qtjyr79+QcGNH2z9Bb5nwLweM+1xEF9I4OZ/rzwV2h3M0Z4ypkyHPcGqe/yP4Z7bveGLrShVoTgpvhMOXToid2SrA0CakDkaaFva4flVnkh8DLgRCo+rZN+e6frD+nwXnm7VJM9Uu/SPo7ImXL7ZjYURkJSPEvzrWqmuxG17CpE1SarXq07uAytUPea37+3BMpPK9kvIpmLbOLvQIU7kdzogHVgiytmx3GSrVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/Df+bcsR5WCQ6TavHD5oKCpMo1XG2ff17vMhKbt+7g=;
 b=nUoRiWBa6c1Qahnn/APBgVkbgsUI8k8HjP02mYo2RyswnOqCmZrIfsibzSZAuwQm0xvMWOLec4xjxO32vWFzqT59H0Bk/ML033dn2+cy7DAVyqkw/yTjdk595aKD+j40o/inaKrGLDM9lDuQcVtz7sra4XS6qVlud/r8x8p6yyAkyj+0vJV3QMBxNnH6HLh4UbxDm6nsRXYWIDSF98oBt2EMfsJiDRTqwMqUSs7TUM/iy6qQCr3tK70pcxhcUdebhQxhXA736TFE39KtWrY2DBbkih/OmIxx4YihVdJLJSrFI4FNxucBCMZ0WrtawpCcxO5OmpMvEdzy+1FULfwycg==
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR0601MB5750.apcprd06.prod.outlook.com (2603:1096:820:b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 01:48:25 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02%4]) with mapi id 15.20.6792.020; Tue, 19 Sep 2023
 01:48:25 +0000
From: =?utf-8?B?5p2o5qyi?= <link@vivo.com>
To: SeongJae Park <sj@kernel.org>, =?utf-8?B?5p2o5qyi?= <link@vivo.com>
CC: Andrew Morton <akpm@linux-foundation.org>, "open list:DATA ACCESS MONITOR"
	<damon@lists.linux.dev>, "open list:DATA ACCESS MONITOR"
	<linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject: Re: [PATCH] mm/damon/core: remove unnecessary si_meminfo invoke.
Thread-Topic: [PATCH] mm/damon/core: remove unnecessary si_meminfo invoke.
Thread-Index: AQHZ6hV5//ius9Kmr0eo1HhzjuichbAgbXmAgAAP8oCAAAESgIAAvGGAgAAntwA=
Date: Tue, 19 Sep 2023 01:48:25 +0000
Message-ID: <2b587774-4741-42d2-baff-eed2b032aaf1@vivo.com>
References: <20230918232615.60499-1-sj@kernel.org>
In-Reply-To: <20230918232615.60499-1-sj@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5676:EE_|KL1PR0601MB5750:EE_
x-ms-office365-filtering-correlation-id: 846c2733-4fad-4549-4d4b-08dbb8b28378
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 U8WOZknwpKyIcpiJSoMFXzUAfK/SQI3LDm8326KL/5uPgENShk9Ti78ckarJIBp7bsZ81O/RMhi3dGRszKGPviWx+dcchsiUGsIQgv1QmhJ/zIeyRHrIe6bHtr+E2A1xzqBAIjM/D3dJ07nggj/VdaqaDyiz9vsVxt7T/v3wmtjKPYQpP5AnEHTcufVoxKtrz0Z87pXIqVw3//n3C3LSVlbeDfisxuKQ2wrHXMNTulBUfWGIE0067Fc29qkn9hV6GIMlK06Saq9efG5DoHAAgTVWbYjCb+i7/4pUBIHcw/II7MvsFh40VKfAXW4T1uOFUTq31sQUYF5tERW3D0C3ulRLZh9eEZj3ynkEUqcxyk+y4Bqq7GUxF31FUWQHEZFiw+gnVj69oaWp066wTg6eAoaR3if7qoiNto/DrVa7UJ11VlLQ8buCdnjm4ym27zsulI0coEM7Ggew6zY/QgI7siORrod9UY/ImrEf779NA3QHpVXAP4OrS+FVtD7jthXKh7oAR6y71VRWQiDPENxxiLhsQnZogFWhhP3gASri+wzRCsS4WRL5gS4/Sz3TK7tWx+QQbEs9MveJE9U/b2uSaKUDSSlbNrCQmShWxVIa7IYzz8XeQJnU+tj5vkklIRf01BhY2X7z91DiRnJfoRmqLg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(186009)(1800799009)(451199024)(6512007)(6486002)(6506007)(71200400001)(83380400001)(38070700005)(122000001)(86362001)(31696002)(38100700002)(36756003)(2616005)(85182001)(107886003)(26005)(110136005)(76116006)(91956017)(54906003)(64756008)(66946007)(66556008)(41300700001)(66476007)(66446008)(316002)(2906002)(5660300002)(4326008)(8936002)(8676002)(31686004)(478600001)(966005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TU9yelluWWE1enIxb2NKTjVEWGUxcld6ZHpRcnczLy9tdWxEanJ2R2ViaUdH?=
 =?utf-8?B?VmRHS3dKNjhES25ycmtiTFhBMWc4NVZseFNsa1Izd3kzdVFCSlV4NE9lRWxP?=
 =?utf-8?B?OC9RUVBxaTJSNmRzSlVzNnVWN3ROWldpNGVidkllcEhJTnZsSzF6YjF0VlpH?=
 =?utf-8?B?ZTAyRElIQmsrTUFoSEo5ZDFETjRMNG8rODc0U2ZBZkhHcTg5Y09lM3lBN2V5?=
 =?utf-8?B?Q0xUSS9QMVZlWDlQM3dPdUg5K0k3OSt3VkRHY3JUNmtyZW9sMkRzamprYmhO?=
 =?utf-8?B?Q2djSko4U3FObWlybXFrd2hGNXBKYk11UWFzTFlTTmt4OTJlUi9rbEVtUkE0?=
 =?utf-8?B?VjdnK09KUzExNityQWZkMEV0cllVQzB4YTM2OHVvYWZzWEMwRWNEUWNYY3dM?=
 =?utf-8?B?T3ljaHVaMjB0N2s3Nmh3SVU5WXltWTRVd251Z3ZDbHFWTUNIcFZyTzRoVDVD?=
 =?utf-8?B?d1VwZFRKdnQzWWhxMHNSUlJOUFQvSldPR3BTbitLRDF1cFQwRUNwbnBMNkFr?=
 =?utf-8?B?d1k4MTFYWHZYcWN3bldZV3RCMlhTWEdtaUQ0K1pYSUJSbWlXUFVOSnpaNDNQ?=
 =?utf-8?B?d2xGY3ZCcUUxYjJXajNpSldqY2pTcm1wQnBQelg4cDlra2djSjQrTkdmcFk1?=
 =?utf-8?B?aEt5UmtiSkI2aHduamdONGJJRWdpMzBvV0FjUmJ5dm5QcmlvYlh1d3c3SVZZ?=
 =?utf-8?B?VWpDQTVXdUZVZ2RTOEhVaWoyTEpheXF1WGY2OG9lc0lhMWwyZ1RSMzA0UHNS?=
 =?utf-8?B?aWNPVGNURUU5VmczWkJDVmFZNGxrTXBrWURZMVZIaGlSL28zT3psdUJHVksv?=
 =?utf-8?B?NUdBSU53dmhNZjRMa0FZVHpKTFlFVlN0RzM4RlFsUzBrSXl5SkhaWnJOY1ZO?=
 =?utf-8?B?T2dJV0NSa3V3Q051a0J2Snd6SXZ6TXdxQTB4RUtlcHVkZGdVNjRCUStpZE02?=
 =?utf-8?B?Y2kraHBWTDlwZUtKQWp0cUllSnNwRitZRUZ6Z3dVMEJxaTI3Z1RpT05HUUtL?=
 =?utf-8?B?NVhxMitvL1ZONFE3U05iMzV0UzhQMFRGRzE5NFFLdXU2VlVYQWVvMjJLTUpy?=
 =?utf-8?B?THM5MWVPY2p6eVZaa0hCNy8wRXNJOEVseUV2OVRkaEVySzRXK0QrR2k5Nnhl?=
 =?utf-8?B?bEErQnJYMko1b2o0Vnlla3F5TmdwVzdFYittcWRBZWE5UEFvcXdha1dRdjFF?=
 =?utf-8?B?NjFLSTBnNDg1RDE5Y1VoYllYN21yRVA2cEZNaXAxTEFqeFpDMzhSWFI2dzcy?=
 =?utf-8?B?dXBKSHEwM09sTk9XMkVLdFNDU2hHUnI4ZkpTZUlEa2xjTG52RjZNTTlFaTUy?=
 =?utf-8?B?U1B1aEdGbmhJNHk3bURoVWZObkxHVGd4M3ROcm5OMmlmNVVGZzFYUEdaSEdu?=
 =?utf-8?B?UmtSUkRZbm1EQnZKOW5xVlBHdTVxZWM1c1JWbnpvd0NpKzJYUDNPZks1VWFX?=
 =?utf-8?B?Vm51STZpcEx2N2xUcDZic0xmSURTWkNDblltd3ZLTEMwOUg0MklGd1JBOFFm?=
 =?utf-8?B?T1NsWXlkb2JuQmJ3WHlsNlNvRXBMSE1ZT0JpQlA1ODhoSDMwSE9pbzVkbU5s?=
 =?utf-8?B?QldMaVNPZkF3c0l1b3dvZUY1WDZFV1hBN3JmVU0xS3oyNFRQdUVEK01Zbzh1?=
 =?utf-8?B?ZWVsTmIzYTlaMVVoNWlQdUhRRmdiaFRxbXZCV0RJeEJ1N3JObC9nWDhleHVS?=
 =?utf-8?B?Q1dtNVMxOFc4ZXJjdmUrL2grM0Nqak13bVhYVHRtSEgzaXQwdEtTaUhuaCsv?=
 =?utf-8?B?Y0tpZlRwSGFYc0ZCa1pkM1RkYjRsa0UzUHBwcHpSck92RVR4UTRaNktKd3No?=
 =?utf-8?B?aDVOK0o1OVNJSmRPcGZtNFp4T01FVkpiRkpzZkpObHZyeCtBb0FCYUNSWWhS?=
 =?utf-8?B?N1Zhc016aTdiTmpCcFZOWDlIWll5Tm1lYlFYYm1NZDgySy90WWtUK2hObG1K?=
 =?utf-8?B?Z2lBSGFzRTFLTXEweVZlTThYbDU2My9CNC9SNkNJNjhpQU5PVmR2Tkw2dHpx?=
 =?utf-8?B?S1hnM2ROQkFMVE1WYXJ6Q1hJMGZxWUkyRHgrUGJ2cEVPNGJBUmFTY2tHcjRQ?=
 =?utf-8?B?b3JFcDZaTy93eFp1TWllbzFlSU1PbWdldmJJUjBHbVNwcnB2UzdlS0xocllE?=
 =?utf-8?Q?VaJE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33A2DDF92E70074AB3AAD0D5B8CCD66F@apcprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 846c2733-4fad-4549-4d4b-08dbb8b28378
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 01:48:25.2086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: va/6VrW0GIw2cW+ZoCCeKqnd8mQJxBsyZFe7rzf3fDBEKl6cMfzR4tulDCRvi/xsS4jwmbmCDM/cI2x+xgY/VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5750

5ZyoIDIwMjMvOS8xOSA3OjI2LCBTZW9uZ0phZSBQYXJrIOWGmemBkzoNCj4gW1NvbWUgcGVvcGxl
IHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gc2pA
a2VybmVsLm9yZy4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1z
L0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IEhpIEh1YW4sDQo+DQo+IE9u
IE1vbiwgMTggU2VwIDIwMjMgMTI6MTI6MDEgKzAwMDAg5p2o5qyiIDxsaW5rQHZpdm8uY29tPiB3
cm90ZToNCj4NCj4+IOWcqCAyMDIzLzkvMTggMjA6MDgsIOadqOasoiDlhpnpgZM6DQo+Pj4g5Zyo
IDIwMjMvOS8xOCAxOToxMSwgU2VvbmdKYWUgUGFyayDlhpnpgZM6DQo+Pj4+IEhpIEh1YW4sDQo+
Pj4+DQo+Pj4+IE9uIE1vbiwgMTggU2VwIDIwMjMgMTc6NDk6MzQgKzA4MDAgSHVhbiBZYW5nIDxs
aW5rQHZpdm8uY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4+IHNpX21lbWluZm8oKSB3aWxsIHJlYWQg
YW5kIGFzc2lnbiBtb3JlIGluZm8gbm90IGp1c3QgZnJlZS9yYW0gcGFnZXMuDQo+Pj4+IE5pY2Ug
Y2F0Y2ggOikNCj4+Pj4NCj4+Pj4+IEZvciBqdXN0IERBTU9TX1dNQVJLX0ZSRUVfTUVNX1JBVEUg
dXNlLCBvbmx5IGdldCBmcmVlIGFuZCByYW0gcGFnZXMNCj4+Pj4+IGlzIG9rIHRvIHNhdmUgY3B1
Lg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEh1YW4gWWFuZyA8bGlua0B2aXZvLmNvbT4N
Cj4+Pj4+IC0tLQ0KPj4+Pj4gICAgIG1tL2RhbW9uL2NvcmUuYyB8IDEwICsrKysrKy0tLS0NCj4+
Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
Pj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9tbS9kYW1vbi9jb3JlLmMgYi9tbS9kYW1vbi9jb3Jl
LmMNCj4+Pj4+IGluZGV4IGJjZDJiZDlkNmMxMC4uMWNkZGVlOWFlNzNiIDEwMDY0NA0KPj4+Pj4g
LS0tIGEvbW0vZGFtb24vY29yZS5jDQo+Pj4+PiArKysgYi9tbS9kYW1vbi9jb3JlLmMNCj4+Pj4+
IEBAIC0xMjc4LDE0ICsxMjc4LDE2IEBAIHN0YXRpYyBib29sIGtkYW1vbmRfbmVlZF9zdG9wKHN0
cnVjdCBkYW1vbl9jdHggKmN0eCkNCj4+Pj4+ICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+Pj4+
PiAgICAgfQ0KPj4+Pj4NCj4+Pj4+IC1zdGF0aWMgdW5zaWduZWQgbG9uZyBkYW1vc193bWFya19t
ZXRyaWNfdmFsdWUoZW51bSBkYW1vc193bWFya19tZXRyaWMgbWV0cmljKQ0KPj4+Pj4gK3N0YXRp
YyB1bnNpZ25lZCBsb25nIF9fZGFtb25zX2dldF93bWFya19mcmVlX21lbV9yYXRlKHZvaWQpDQo+
Pj4+IE5pdC4gIHMvZGFtb25zL2RhbW9zLyB3b3VsZCBsb29rIG1vcmUgY29uc2lzdGVudGx5LCBp
biBteSBvcGluaW9uPw0KPj4+IEhJLCBTSiwgc29ycnksIHdoYXQncyB0aGlzIG1lYW4/DQo+PiBI
YWhhLCBJIGdldCwgeWVzLCBkYW1vcyBpcyBiZXR0ZXIuIElmIHlvdSBhZ3JlZSB3aXRoIGJlbG93
LCBJIHdpbGwNCj4+IHJlc2VuZCBhIG5ldywgcmVuYW1lIHRvDQo+Pg0KPj4gX19kYW1vc19nZXRf
d21hcmtfZnJlZV9tZW1fcmF0ZS4NCj4+DQo+Pj4+PiAgICAgew0KPj4+Pj4gLSBzdHJ1Y3Qgc3lz
aW5mbyBpOw0KPj4+Pj4gKyByZXR1cm4gZ2xvYmFsX3pvbmVfcGFnZV9zdGF0ZShOUl9GUkVFX1BB
R0VTKSAqIDEwMDAgLyB0b3RhbHJhbV9wYWdlcygpOw0KPj4+Pj4gK30NCj4+Pj4+DQo+Pj4+PiAr
c3RhdGljIHVuc2lnbmVkIGxvbmcgZGFtb3Nfd21hcmtfbWV0cmljX3ZhbHVlKGVudW0gZGFtb3Nf
d21hcmtfbWV0cmljIG1ldHJpYykNCj4+Pj4+ICt7DQo+Pj4+PiAgICAgICAgICAgIHN3aXRjaCAo
bWV0cmljKSB7DQo+Pj4+PiAgICAgICAgICAgIGNhc2UgREFNT1NfV01BUktfRlJFRV9NRU1fUkFU
RToNCj4+Pj4+IC0gICAgICAgICBzaV9tZW1pbmZvKCZpKTsNCj4+Pj4+IC0gICAgICAgICByZXR1
cm4gaS5mcmVlcmFtICogMTAwMCAvIGkudG90YWxyYW07DQo+Pj4+PiArICAgICAgICAgcmV0dXJu
IF9fZGFtb25zX2dldF93bWFya19mcmVlX21lbV9yYXRlKCk7DQo+Pj4+IFNpbmNlIF9fZGFtb25z
X2dldF93bWFya19mcmVlX21lbV9yYXRlKCkgaXMganVzdCBvbmUgbGluZSBmdW5jdGlvbiBhbmQN
Cj4+Pj4gZGFtb3Nfd21hcmtfbWV0cmljX3ZhbHVlKCkgaXMgdGhlIG9ubHkgdXNlciBvZiB0aGUg
Y29kZSwgSSB0aGluayB3ZSBjb3VsZCBqdXN0DQo+Pj4+IHdyaXQgdGhlIGNvZGUgaGVyZT8NCj4+
PiBJIGRvIHRoaXMgaW4gbWluZSBmaXJzdCBwYXRjaCwgYnV0IHRoZW4sIEkgZm9sZCB0aGlzIGlu
dG8NCj4+PiAiX19kYW1vbnNfZ2V0X3dtYXJrX2ZyZWVfbWVtX3JhdGUiDQo+Pj4NCj4+PiBkdWUg
dG8gSSB0aGluayB0aGUgIl9fZGFtb25zX2dldF93bWFya19mcmVlX21lbV9yYXRlIiBtYXkgY2hh
bmdlIHRoZQ0KPj4+IG1lYW5pbmcgZm9yIGZ1cnR1cmUsDQo+Pj4NCj4+PiBhbmQgbWF5IHNpX21l
bWluZm8gd2lsbCBjb21lIGJhY2sgc29vbj8oSWYgd2UgbmVlZCBtb3JlIGluZm8gdG8gZ2V0IHRo
ZQ0KPj4+IHJhdGU/KS4gQW5kLCBhbHNvLCB0aGUNCj4+Pg0KPj4+IHN0YXRpYyBmdW5jdGlvbiBJ
ZiBqdXN0IHNvbWUgdXNlciB1c2UsIGl0IHdpbGwgYmUgaW5saW5lLCBzbywgSSBqdXN0DQo+Pj4g
dGhpbmsgZm9sZCBpdCB3aWxsIGJlIGJldHRlci4NCj4+Pg0KPj4+IERvIHlvdSB0aGluayBzbz8N
Cj4gVW5mb3J0dW5hdGVseSBJIGRvbid0IHRoaW5rIHNvLiAgV2hhdCB3b3VsZCBiZSB0aGUgZnV0
dXJlIHVzZSBjYXNlIHRoYXQgd291bGQNCj4gcmVxdWlyZSBjaGFuZ2luZyB0aGUgbWVhbmluZyBv
ZiB0aGUgbWV0cmljPyAgSSBjYW5ub3QgaW1hZ2luZSB0aG9zZSBvZmYgdGhlIHRvcA0KTWF5YmUg
Y2FyZSBhYm91dCBbbWluLCBsb3csIGhpZ2hdIHdhdGVybWFyaz8gT3Igc29tZXRpbmcuIEJ1dCwN
Cj4gb2YgbXkgaGVhZC4gIEV2ZW4gaWYgc3VjaCB1c2UgY2FzZSBpcyBmb3VuZCwgc3VjaCBjaGFu
Z2Ugd291bGQgYmUgYQ0KPiB1c2VyLXZpc2libGUgYmVoYXZpb3JhbCBjaGFuZ2UsIHdoaWNoIHdl
IHdvdWxkIGxpa2UgdG8gYXZvaWQuICBJZiBzdWNoIGNoYW5nZQ0KPiBpcyByZWFsbHkgbmVlZGVk
LCBJIHRoaW5rIHdlIHdvdWxkIGtlZXAgdGhlIGN1cnJlbnQgbWV0cmljIGFzIGlzIGFuZCBjcmVh
dGUgYW4NCj4gYWx0ZXJuYXRpdmUgbWV0cmljIHRoYXQgaGF2aW5nIHRoZSBuZXcgbWVhbmluZy4g
IEFueXdheSwgd2UgY2FuIHRoaW5rIGFib3V0DQo+IHN1Y2ggY2FzZSB3aGVuIGl0IHJlYWxseSBo
YXBwZW5lZC4NClllcywgeW91IGFyZSByaWdodCwgaWYgbmVlZCBhIG5ldyBjYXNlLCBqdXN0IGNy
ZWF0ZSBhbiBhbHRlcm5hdGl2ZSBtZXRyaWMuDQo+DQo+IEFsc28sIHRoZSBjdXJyZW50IGNvZGUg
aXMgZG9pbmcgdGhlIGNhbGN1bGF0aW9uIGluIGRhbW9zX3dtYXJrX21ldHJpY192YWx1ZSgpLg0K
PiBJZiB0aGVyZSBpcyBubyBzcGVjaWZpYyByZWFzb24gdG8gc3BsaXQgdGhlIGxvZ2ljIG91dCB0
byBhIG5ldyBmdW5jdGlvbiwgSSdkDQo+IHByZWZlciBrZWVwaW5nIHRoZSBvdmVyYWxsIHN0cnVj
dHVyZSBhcyBzaW1pbGFyIGFzIGlzIG5vdy4NCj4NCj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIEkn
bSBtaXNzaW5nIHNvbWV0aGluZy4NCg0KTm8gc3VyZSByZWFzb24gdG8gc3BsaXQgaXQgaW50byBm
dW5jdGlvbiwga2VlcCBpdCBpbiANCmRhbW9zX3dtYXJrX21ldHJpY192YWx1ZSgpIGlzDQoNCmJl
dHRlci4NCg0KDQpJJ2xsIHNlbmQgbmV3IHBhdGNoLg0KDQoNClRoYW5rcywNCg0KSHVhbg0KDQo+
DQo+DQo+IFRoYW5rcywNCj4gU0oNCj4NCj4+PiBUaGFua3MsDQo+Pj4NCj4+PiBIdWFuDQo+Pj4N
Cj4+Pj4+ICAgICAgICAgICAgZGVmYXVsdDoNCj4+Pj4+ICAgICAgICAgICAgICAgICAgICBicmVh
azsNCj4+Pj4+ICAgICAgICAgICAgfQ0KPj4+Pj4gLS0NCj4+Pj4+IDIuMzQuMQ0KPj4+PiBUaGFu
a3MsDQo+Pj4+IFNKDQo+Pg0KDQo=
