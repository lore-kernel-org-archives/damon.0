Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2090.outbound.protection.outlook.com [40.107.117.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75F138F93
	for <damon@lists.linux.dev>; Mon, 18 Sep 2023 12:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYa6QSQXITk53Wuu9ZqQYwrfMxRm8138aaN145dmi4f9vXCMF1eGUjLyezM2N2luS4wGtqItxW3GsopPWXAhcjF/nEszMj+zeBJE/CgVkBZ/M63bfRG9ECCeD16PtsdDtFgcQn89NHhHNG+SazTXDwUUv3PZsV8EiWeSz5lj3LBWyOGJhaDBZYdF7dFevZlb6BJ6YM5l01IAh2UatGmuX+IyEbyAP2nUz7WT2Qktl79GBFgxOHrlh/wbnyiNw2QW4i7WPTvu4mOddy/Cd1b3q3Bf2cVrm6JGB4DO79ZFBUlYgZwKE4X3mpxKzZHq27+++oV4Z+8JFD9KDcy/2ADH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7u4c4UJqIqZtbegXLT5A8GOs3JDtCLiVmmycwxH1+Wg=;
 b=c8ry3NeP+nPfk09klX8QfFlg00d5hZ7QbhC9Mi+O4j75v3NGcg8wkuyGWzYwlhA3OfeYk7fJfj0g0CZoS7p/AVtuAMSyD/ghKJvUJcMfvJOl+h1o3PhGn8GfnTsp4rdTlkXfj0cPGFlKWr8CqDNgbMYn5znjdlVCPlJ7LpaFTDdw7DFwUiYt4pjI8nbMqanFleFNfUgdEZMwsCNDY0qO8q9JxGZAf1f3DtUgyK/KwGhdH5U0hd7fLREHiddYMISfs1dwLnHNPc2iyXxw1dLZamy+webWMTK+jHyKMS8fqvaWBSDDwfjhqtI6fuF69LMHzVoW9zWovY6J1C6y481LbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u4c4UJqIqZtbegXLT5A8GOs3JDtCLiVmmycwxH1+Wg=;
 b=cTRkLW+OnZYVjXlLnxzwDv4XymfLRV4BzQlRKOZu9lleMLK6SY3LfQckPMNxjABb50oJaATG5dYCIVCnwXNOJ1YfvkAtQYxqpCpftKLhePT6k1rOkvxT54x23CjXdkiPaAono7BYncdjYYz9AbtZlQ4xXT/jAfoAMA4uZsYBrUh7cOtb8qkaSL6ySoZoA1DAAtSUYaC2P4uRBh/5ccA/FlU7FIuPYNjaKmRyjfQKay8OaAdi36Na/nxKxH/Z6cefNi1LEbKh0Jy2AkwjaZ1mDwTyTUyhly2R+rl0bdm8nm8OuoukK4LR6uqlX22Lw3ww6b8GynHMju8E1CKnwvsreA==
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB5685.apcprd06.prod.outlook.com (2603:1096:400:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 12:12:02 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02%4]) with mapi id 15.20.6792.020; Mon, 18 Sep 2023
 12:12:02 +0000
From: =?utf-8?B?5p2o5qyi?= <link@vivo.com>
To: =?utf-8?B?5p2o5qyi?= <link@vivo.com>, SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, "open list:DATA ACCESS MONITOR"
	<damon@lists.linux.dev>, "open list:DATA ACCESS MONITOR"
	<linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject: Re: [PATCH] mm/damon/core: remove unnecessary si_meminfo invoke.
Thread-Topic: [PATCH] mm/damon/core: remove unnecessary si_meminfo invoke.
Thread-Index: AQHZ6hV5//ius9Kmr0eo1HhzjuichbAgbXmAgAAP8oCAAAESgA==
Date: Mon, 18 Sep 2023 12:12:01 +0000
Message-ID: <2feda3fb-7306-4ee7-9be3-a3990b6e9c43@vivo.com>
References: <20230918111107.85008-1-sj@kernel.org>
 <ac9ede0f-e250-4bf9-869b-9e90369f7b8e@vivo.com>
In-Reply-To: <ac9ede0f-e250-4bf9-869b-9e90369f7b8e@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5676:EE_|TYZPR06MB5685:EE_
x-ms-office365-filtering-correlation-id: a7f74a47-bfe3-403a-115a-08dbb8407717
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PE9ATYB7doNSFwt9Wir0XAsL1xGUiFmHijR02VqtaGFD5rhoapcPSCDv8Y2Fd35Dh7US3sBxeIR8iWqlsl5KTLVHewTIM9DUMK2aNOwxPMqypluqj5y8wTGUbGR5D5odN7gmdF9m0F9vhjUwXqUnnrqSErRVCol4NFqjNkgSm2bDhzh1dTr3FeAHW7ROseCuLMz4aMyWayq/XM7y3aMtw1ssjej8P6kwn8jqzuw7hgOkXIE7/OpneVbUaI/sfnRcEbvAMO4zkMZwxXq/w7jAgUaMlWMIHkGGV7fg9qBxAh/Y9ty3P+qeOM1uq56DADamFYx+FC3g9mbWdcZPQOTw5BDJBI+mTFhxgfca33yrmjS5fbhvBerIU9fr78og3GXdv2/490NEmKgbs42FIMtBdmvz0o8mcJ7iO7HOuu5oIRvX5hP7O3PRUK5Zz8pA4fXaiyoEA2ioBCg6NHZcEq0/aNv/NcmB2AxB2XwxQ/w9Yz35xRawA1CpqW5/SIh1gsktwuL/2aSkDWhBNtGdyklKdzTkQ8dBkT7WzANiADLUIliAzK9zV84wCy5stGbw+oCI5bBP21Ea+93l8Cfx+29TmeIFzetiNmLmKRtLWgliftvaPVznbGddORak13J1Cer5T6RdQ9IgyqI2DDsQkT3BsA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(366004)(136003)(376002)(346002)(1800799009)(186009)(451199024)(26005)(2616005)(8936002)(8676002)(4326008)(122000001)(107886003)(83380400001)(2906002)(85182001)(36756003)(31696002)(5660300002)(86362001)(6506007)(6486002)(478600001)(31686004)(71200400001)(316002)(54906003)(6512007)(76116006)(91956017)(110136005)(66946007)(66446008)(64756008)(66476007)(38070700005)(41300700001)(66556008)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWxRamUvRFFrN21UM1puV1NZSXRjNXNhb240TmN6NTRSZGYxdThQQm1uN2ZE?=
 =?utf-8?B?L3BaY3hzcGcxVHJlbU92c1FPWFZVZUNxQnl3ZlhvK2xUaFU4djl1ZVh2NUh0?=
 =?utf-8?B?aG04SjIrSnYzSHJEWXZVS2hkb0NITzNIVlc0dE1ycnFMUTN4TFFuclkrVFJm?=
 =?utf-8?B?Q0ltL3J0b0FzUnlGa0YxbldqYkdVUE9seno0R2h0Y0tYc1BKYXlkQmo2SlZq?=
 =?utf-8?B?bFdUTTFGVXZrYjZmYkQydkRmaC9JaThSMmNxVmphN2N0MGgzcXB4ZzFJVWVI?=
 =?utf-8?B?V3lHR1FORnEvazR4WEE5VFVVNXhXVndWWnc3MmM5VkdMejF6U2dHQ0hwdytu?=
 =?utf-8?B?VjByWkhPbFdnSUhLeTBLdjNrenNGWGdybHBOdDJpeC9tOVNTTElIUmh5YWcx?=
 =?utf-8?B?Zkszb2RocGhXM3pGZDNBWmVzYlRKQ1BtYyszSlRURHlRZjhKWTZoeUowRTds?=
 =?utf-8?B?RmxnaVc2QW5RVWJZamhMYTU5MUhSNHBGS04rSmxPNWxxQVYvbDlPVkJ5czN5?=
 =?utf-8?B?OXRGa1JVcEwzUEh4YWxjcForaC9QSGNEUE82b25wN2ZvMDFXS2lGLzVGbXNa?=
 =?utf-8?B?blRHZ2V3RmkvUjVxMkZtUG00Ry9vcThtZTg2bGdQS2tkZFVMSDBlSnRMSFVM?=
 =?utf-8?B?RGNPVnIrWWZzeUFnUVhEaTFSeldzc3luUG42dTBCaXV5MVlDRFN5dUdhRzJC?=
 =?utf-8?B?OU9kMW83VDVFbG9FV0U5TWI2RDlsQ3Q1K1F3M3lDOC9JcjhJakpWMlFhdkVU?=
 =?utf-8?B?ak1JcWVtaXJnai9KT2dmcEJiK1FsdjlWRC9Eb0ZVTllaRlJmZkZmVkdWUWJ3?=
 =?utf-8?B?bEFLYjJPd2hqVXg2YzcrQ0NCRHovcFNNNWJTdS91ODJoeWxDamcza3hRRC9M?=
 =?utf-8?B?MTF2YkR1L0l2MDBrN0dvUFB2Yi9EOHluOFQybFlocGwvclI2UVFDL1BmREF5?=
 =?utf-8?B?MXhxYmw1Ukt4bWJINGtRWko3SVBmNDM3czB2eWp3NE9iTGQ3ZGo0L2d1NXdu?=
 =?utf-8?B?YnRkQlFtbFZhc2ZFTW94VzFGVk5jT0I3Ly9DMkE2enJiZ3Z4eG5sZStsT0VC?=
 =?utf-8?B?SnAyNjZDeHRaTklnOWt0djZ6cEtFOWMwcTdDa0Vwang0NW9KR2RlWm5nbmJa?=
 =?utf-8?B?R2x2RE5rV1NXbFlrZXRMbW5pQUZKZk5RSXBCN1ZqSDRIWXpQbkZPc2FGV3gw?=
 =?utf-8?B?YzRsSGk5NlVZRktWb2JSSGdvODNuVFlndk96QjJnMjNKVDRabThYMmhjckd1?=
 =?utf-8?B?Sm5CNVU5dndyK2pSOFM5Y3NUaERNQzAvQXd1VXdGSW44WmZKdENVeW9IOG9j?=
 =?utf-8?B?MGZ1NVRpZ2JjemJxbk96cmN5TVQxY0lCQlZvSWwrclhjMFU3MGtjRXZ2Yzg0?=
 =?utf-8?B?OUJNVGlBWmw4cDRQWDZMR3k1bzc1N2d4elJLNTEvVFpMcndibDRQOVJyZnJ5?=
 =?utf-8?B?RFdIUWpnTkZKSVdDajRoQmNxQUJ0VWRmQ2FBcjh0UzhnbzRTblYzQXBYZVp4?=
 =?utf-8?B?cHBpdWlySVdpeGlraHpZcTlSalN4TTVieHpwdTVGYVROTFZHNXRnOGJNZmd5?=
 =?utf-8?B?MWRLSHVIYkZMQTh4VTY2ZVc2RlpuQlJkV0RsOXNyaElNTm5jNjBFR0o2RkRO?=
 =?utf-8?B?Y215aG1uZUM0OWRIa0cwdHlIUmNDMGxPT09jemFFZ2pNaDROWnY3UTd3bEhy?=
 =?utf-8?B?bnlWMm9rTWJxUVgvNlpQZkxvUlNEWkJsRXA5Y0tNQ3VURjJkU0svaERjY29E?=
 =?utf-8?B?bkM1S2pUYVQvb2RZdURRWDhHVS91bkNXaHpkUTI4aXNpVnhWNjRrVHczQnhT?=
 =?utf-8?B?TEpORmM1Mk9IOEh2SStZNC9zODBvY3pFaEVIa29yeVFSK2pQQ2FCM1pwUjVV?=
 =?utf-8?B?OU1KL0RFWHVLYzZLUE5ZYjk1N2xZelI4T0NkK0VJUTlOc2RLNnBYYmFOQ3BR?=
 =?utf-8?B?U084anpvWlpQdnl0REtxRmJsVE95Ulk0Mm5qQmkvUmtTS1ZXYkVFSjQwcnNn?=
 =?utf-8?B?RjdhQU5PUTdXbHpibS8vc1dydHMzWWNrMjhZeVZMVmZ4cGgrNjgyZ3g1M3N6?=
 =?utf-8?B?TE4rWHFFRkJwbmR5KzNVNmJjak51cWtBS09aTFVVWE1DU1dlTExoQzYrVmlT?=
 =?utf-8?Q?K9n8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C13F98E99F80A4B92BCE52124ADDB51@apcprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f74a47-bfe3-403a-115a-08dbb8407717
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 12:12:01.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CwUbQljA8Fks/u9EHizA5EeJXw+yDcejNsKlgN9eb4CVTXfZtzJVZf9Kg6x1ey6YGHupNXpVbMKPql9GTQzTSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5685

5ZyoIDIwMjMvOS8xOCAyMDowOCwg5p2o5qyiIOWGmemBkzoNCj4g5ZyoIDIwMjMvOS8xOCAxOTox
MSwgU2VvbmdKYWUgUGFyayDlhpnpgZM6DQo+PiBIaSBIdWFuLA0KPj4NCj4+IE9uIE1vbiwgMTgg
U2VwIDIwMjMgMTc6NDk6MzQgKzA4MDAgSHVhbiBZYW5nIDxsaW5rQHZpdm8uY29tPiB3cm90ZToN
Cj4+DQo+Pj4gc2lfbWVtaW5mbygpIHdpbGwgcmVhZCBhbmQgYXNzaWduIG1vcmUgaW5mbyBub3Qg
anVzdCBmcmVlL3JhbSBwYWdlcy4NCj4+IE5pY2UgY2F0Y2ggOikNCj4+DQo+Pj4gRm9yIGp1c3Qg
REFNT1NfV01BUktfRlJFRV9NRU1fUkFURSB1c2UsIG9ubHkgZ2V0IGZyZWUgYW5kIHJhbSBwYWdl
cw0KPj4+IGlzIG9rIHRvIHNhdmUgY3B1Lg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogSHVhbiBZ
YW5nIDxsaW5rQHZpdm8uY29tPg0KPj4+IC0tLQ0KPj4+ICAgIG1tL2RhbW9uL2NvcmUuYyB8IDEw
ICsrKysrKy0tLS0NCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL21tL2RhbW9uL2NvcmUuYyBiL21tL2Rh
bW9uL2NvcmUuYw0KPj4+IGluZGV4IGJjZDJiZDlkNmMxMC4uMWNkZGVlOWFlNzNiIDEwMDY0NA0K
Pj4+IC0tLSBhL21tL2RhbW9uL2NvcmUuYw0KPj4+ICsrKyBiL21tL2RhbW9uL2NvcmUuYw0KPj4+
IEBAIC0xMjc4LDE0ICsxMjc4LDE2IEBAIHN0YXRpYyBib29sIGtkYW1vbmRfbmVlZF9zdG9wKHN0
cnVjdCBkYW1vbl9jdHggKmN0eCkNCj4+PiAgICAJcmV0dXJuIHRydWU7DQo+Pj4gICAgfQ0KPj4+
ICAgIA0KPj4+IC1zdGF0aWMgdW5zaWduZWQgbG9uZyBkYW1vc193bWFya19tZXRyaWNfdmFsdWUo
ZW51bSBkYW1vc193bWFya19tZXRyaWMgbWV0cmljKQ0KPj4+ICtzdGF0aWMgdW5zaWduZWQgbG9u
ZyBfX2RhbW9uc19nZXRfd21hcmtfZnJlZV9tZW1fcmF0ZSh2b2lkKQ0KPj4gTml0LiAgcy9kYW1v
bnMvZGFtb3MvIHdvdWxkIGxvb2sgbW9yZSBjb25zaXN0ZW50bHksIGluIG15IG9waW5pb24/DQo+
IEhJLCBTSiwgc29ycnksIHdoYXQncyB0aGlzIG1lYW4/DQoNCkhhaGEsIEkgZ2V0LCB5ZXMsIGRh
bW9zIGlzIGJldHRlci4gSWYgeW91IGFncmVlIHdpdGggYmVsb3csIEkgd2lsbCANCnJlc2VuZCBh
IG5ldywgcmVuYW1lIHRvDQoNCl9fZGFtb3NfZ2V0X3dtYXJrX2ZyZWVfbWVtX3JhdGUuDQoNCj4+
PiAgICB7DQo+Pj4gLQlzdHJ1Y3Qgc3lzaW5mbyBpOw0KPj4+ICsJcmV0dXJuIGdsb2JhbF96b25l
X3BhZ2Vfc3RhdGUoTlJfRlJFRV9QQUdFUykgKiAxMDAwIC8gdG90YWxyYW1fcGFnZXMoKTsNCj4+
PiArfQ0KPj4+ICAgIA0KPj4+ICtzdGF0aWMgdW5zaWduZWQgbG9uZyBkYW1vc193bWFya19tZXRy
aWNfdmFsdWUoZW51bSBkYW1vc193bWFya19tZXRyaWMgbWV0cmljKQ0KPj4+ICt7DQo+Pj4gICAg
CXN3aXRjaCAobWV0cmljKSB7DQo+Pj4gICAgCWNhc2UgREFNT1NfV01BUktfRlJFRV9NRU1fUkFU
RToNCj4+PiAtCQlzaV9tZW1pbmZvKCZpKTsNCj4+PiAtCQlyZXR1cm4gaS5mcmVlcmFtICogMTAw
MCAvIGkudG90YWxyYW07DQo+Pj4gKwkJcmV0dXJuIF9fZGFtb25zX2dldF93bWFya19mcmVlX21l
bV9yYXRlKCk7DQo+PiBTaW5jZSBfX2RhbW9uc19nZXRfd21hcmtfZnJlZV9tZW1fcmF0ZSgpIGlz
IGp1c3Qgb25lIGxpbmUgZnVuY3Rpb24gYW5kDQo+PiBkYW1vc193bWFya19tZXRyaWNfdmFsdWUo
KSBpcyB0aGUgb25seSB1c2VyIG9mIHRoZSBjb2RlLCBJIHRoaW5rIHdlIGNvdWxkIGp1c3QNCj4+
IHdyaXQgdGhlIGNvZGUgaGVyZT8NCj4gSSBkbyB0aGlzIGluIG1pbmUgZmlyc3QgcGF0Y2gsIGJ1
dCB0aGVuLCBJIGZvbGQgdGhpcyBpbnRvDQo+ICJfX2RhbW9uc19nZXRfd21hcmtfZnJlZV9tZW1f
cmF0ZSINCj4NCj4gZHVlIHRvIEkgdGhpbmsgdGhlICJfX2RhbW9uc19nZXRfd21hcmtfZnJlZV9t
ZW1fcmF0ZSIgbWF5IGNoYW5nZSB0aGUNCj4gbWVhbmluZyBmb3IgZnVydHVyZSwNCj4NCj4gYW5k
IG1heSBzaV9tZW1pbmZvIHdpbGwgY29tZSBiYWNrIHNvb24/KElmIHdlIG5lZWQgbW9yZSBpbmZv
IHRvIGdldCB0aGUNCj4gcmF0ZT8pLiBBbmQsIGFsc28sIHRoZQ0KPg0KPiBzdGF0aWMgZnVuY3Rp
b24gSWYganVzdCBzb21lIHVzZXIgdXNlLCBpdCB3aWxsIGJlIGlubGluZSwgc28sIEkganVzdA0K
PiB0aGluayBmb2xkIGl0IHdpbGwgYmUgYmV0dGVyLg0KPg0KPiBEbyB5b3UgdGhpbmsgc28/DQo+
DQo+IFRoYW5rcywNCj4NCj4gSHVhbg0KPg0KPj4+ICAgIAlkZWZhdWx0Og0KPj4+ICAgIAkJYnJl
YWs7DQo+Pj4gICAgCX0NCj4+PiAtLSANCj4+PiAyLjM0LjENCj4+IFRoYW5rcywNCj4+IFNKDQo+
DQoNCg==
