Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07F8A49
	for <damon@lists.linux.dev>; Wed, 20 Sep 2023 01:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSnypaodulBOwTb+TATfjC99SHCp/TtDAz4X+t1YvuzgyO7CNR7Exp2japizfKSk6lriyWttruZdoTnC1haytqwqr8erp/LtJr9PQT4esevsJTVRhvAIvyNl5/7xfxmeypudbx+LV1yDs4VPIuGC1dG9KOw5C1B4OJhx2hU0Y/V8FHlaLkwHCrOTOEnzNuN38e/OlKjiRC151ddbsKg5uM7sjD5agRFJ5zm77V7sUiDpruBjuorwBV9RSxqDKsJzoi8i5z6riQNEmda7Cyr0khYJBMfFRAXQrAo5ZNY0SnbssEkyC/tlvS9D280nAygclXVBhxdVq3kzbtXerrda/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhNUa8d8Zt2nws6h5ugLpcoW7W2zhSg0v7v/8U0LkFk=;
 b=jlIcI8u3JBlpTPdzGOYx0Vo7MZTzupo4kj+mgjfhA88jrMwRCaPc0AwQCuXnR21DNtKTlg3b5Yk1NEYXrwtKYdmWOqEucjjw7kqpTluoYrir+xG/NIygmjMR5q+SbWsWFZDgXm6rVjYNdYVjygfsh47d8jE1IZ0Ozi6dqk3vPni/5AF+eUaEH4IQPD7YfqRrL5FtNd83TghBwa2xtY8AfRdhsXDVMNeskM9f4+dy8CjLlzVGs1ge7GIYVQbJpePF97H+ibVJNZKfASqIlBnPkOTXOt8BP/u3v4KAX0k2YvjgURSgIcWscZzQxsO7qarBj8wGCLCjk9iGy3LkUkxaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhNUa8d8Zt2nws6h5ugLpcoW7W2zhSg0v7v/8U0LkFk=;
 b=MuNxOxJd6mmRLnU+HGz1yHsOsHAXZ1P2+sscn9AHfgvZIVZAjjZmw2pIvmw5DFmwl8fyQNqKI0t8eh+RYyXPY0YaLvhdfUl0hdRd1YE1IPo2sa69rUchi/sUv7RKFOexj+M9bE7/jV55G4opJ/1cJ+Bk/2Z35/YI2hmtieJxFCTK+AJ4lNA5pvjlkfY8k0zlRmy1GgwF6bRI3/k2wsMiaFaEZk8U7LZH0RRq75pvLO76njVi9ljDTl9+JCvbdjZylaUl5ksm3lDhuJebHsRMDaDuer1M29MytFzm4+1qyQISkBrl3ggVJ3aajqSIdzKpIZl4Wo79nsx+JzOyU+NJrA==
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SG2PR06MB5262.apcprd06.prod.outlook.com (2603:1096:4:1d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 01:46:59 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02%4]) with mapi id 15.20.6792.020; Wed, 20 Sep 2023
 01:46:59 +0000
From: =?utf-8?B?5p2o5qyi?= <link@vivo.com>
To: SeongJae Park <sj@kernel.org>, =?utf-8?B?5p2o5qyi?= <link@vivo.com>
CC: Andrew Morton <akpm@linux-foundation.org>, "open list:DATA ACCESS MONITOR"
	<damon@lists.linux.dev>, "open list:DATA ACCESS MONITOR"
	<linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject: Re: [PATCH v2] mm/damon/core: remove unnecessary si_meminfo invoke.
Thread-Topic: [PATCH v2] mm/damon/core: remove unnecessary si_meminfo invoke.
Thread-Index: AQHZ6p0xPL5d7yqQrUy2hBfHZOjvxbAiSXEAgACqAwA=
Date: Wed, 20 Sep 2023 01:46:59 +0000
Message-ID: <7b38eb40-1d74-4308-ae9a-b6aa91a46833@vivo.com>
References: <20230919153828.8190-1-sj@kernel.org>
In-Reply-To: <20230919153828.8190-1-sj@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5676:EE_|SG2PR06MB5262:EE_
x-ms-office365-filtering-correlation-id: 72d5a3b0-ee2d-4fe4-d161-08dbb97b7a86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 U5uCkJhdStx1AEvulGvyOWRvXg6z5N6woOwp3wwa/OVGzhM83ZycW20qa14ucXK3jqyQsXcD6c8HpAeFM8L8pYGk9GUEJE30W8a63mOqEKur5qJR37vfTIb3JSxjQwYKW8sbTUBM3GhpqTS9dq2uzpjx69WrofyhZgVrpWToppin9dF5UtJepGB+3oGbrj2KvkFL4dMbf+KYE2xgJZ4dsH383UQxDaitofRyaL0PGLtnPuPF7p/fRG6hZxpt3elXk6SHqYMY0a9OEaHumtUXFgnXWtjsBw+2ENL5K/0Al7y3YfrFCkX9iAz9Q+PlHWVB4WWQSK/uVtonwmTxXJPsRcSOYgk/oVyzTcriw7e9Oq5CYI0SvUH63NHRp0zFpYXRD/MDLVDMLnpjJbRMrq+Xr9C5Xwn+RN4rwkjB9awHowFyJ1O9e49i4bQ/0jwUGVLqb5lr1L8RxmZSCMdb6AWtS++6Ypl4vlAFnESaxy7+Omwsi7bNCnR/DDIPMNToCPr6il28glg4XPVSwZ3jCWfOuUvX7FxmYURK79loEYVr5iW9gniFJoTqA3NU9OkZZoWRTTzMBZpfg46GIE867Lj49zHkAZzcqIUsGzqBk15IaTnKvcwRTsLFu7mJyZ4B33ahs1n9IsQPIylpm4XwQaVMsg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(39860400002)(396003)(186009)(451199024)(1800799009)(31686004)(6506007)(71200400001)(6512007)(38070700005)(31696002)(86362001)(122000001)(38100700002)(85182001)(36756003)(2616005)(2906002)(107886003)(966005)(5660300002)(6486002)(478600001)(26005)(4326008)(41300700001)(8936002)(316002)(110136005)(66946007)(66446008)(66476007)(54906003)(76116006)(91956017)(66556008)(83380400001)(64756008)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXdZMnJWNXd1TitJY3V1dHAxYTlYS3lJWWN1OGRHTjh4d3dJOG5BTjJXd0xO?=
 =?utf-8?B?V2J2UU13ditOQjUyN25nSGpqYjJqdC91TGF0RnZLbkVJaGJJNUp0d2cvcTBZ?=
 =?utf-8?B?azU3ZUlOMjVQSkVmczEzVkZISTRqYzZlZzRQay9EeTJLeXJRRlNyNUg1M3Fa?=
 =?utf-8?B?MW1yaUQzWmR3b0pwSHNwRGt2R1Vpa1dWaEFjaDhxR1lWdFQzMzZCMWNQVWda?=
 =?utf-8?B?Zi9PaVl6RjVBVXZxQ2FaVzhLVGFZV0R3RFpyczFMdTREeDBQdFN2WmZPV1RW?=
 =?utf-8?B?Yy9RZVFRbm1lak9rOVlONVpSVnJIY3NzTmRXYy92QW1iZDE3RFd6MmU0L0Fy?=
 =?utf-8?B?U1o1bVZmcGdVcm5PVGRnNm5jNHUzSnpKUkIvSUpqcmdpUERTVVpva1J1RDAr?=
 =?utf-8?B?S2JwN0Z2QjdLUHdRRFNlRCs3ZEVTK2taQm5Wc05yZ1RINTU2ZnN1ZlE5Z09S?=
 =?utf-8?B?azZTM3E1TXdIUm9TQkgvYlM4b2JRMmtOTG1acWcvWTFiMnFzWDJyTkUwMjYy?=
 =?utf-8?B?d05TWHk5WktiQTZYVWVOa0UrRStwMDllZXQvcDMreG1uNHN6YndIbjZEa29N?=
 =?utf-8?B?WmtvNWp4c3ZlREd6cXhkTGI0bm5uSHZNOFhzMXFRTkZhV2hvaTE5dTMvWmgr?=
 =?utf-8?B?cHhHNnM4T0FrQkNUNGtpUU5ydHFzY1g4dzNZUXlIVndTN3RwNXZ1MGtLRzc5?=
 =?utf-8?B?ZzE5YkFWVi9OaDB3bEM3VDRUU2w5TVRlR2dxdnFKb1RadlM3Y0tRUnVvVy94?=
 =?utf-8?B?VWlJTUZoWGs1NlFEWCt2R0JZcGw1cC9NQzltcEdhWjI0c3grMmd6SzlNN0Fx?=
 =?utf-8?B?blNVSXJ3QWI4VGt1eDcrNWlsQTlNa3pCK2xYVDFLTXNOMlN1YkJzTm0xY2dn?=
 =?utf-8?B?YkgwRENKOEZQQmtmaFMxOEhZUXFxSFpEMzVpTHIwb1ZPT0tobDlCandabnM4?=
 =?utf-8?B?SjFVVnV1SWdHcGFuM0dTV3BTc3paRmJ4aXNaUGFJK1llTFZaM2N2bk1CVWxZ?=
 =?utf-8?B?eVBJU1d2TGxOcWU1QU12OXpLM0hkem1KbWlRcGsyMlFzWTBHUis5V2huOTFJ?=
 =?utf-8?B?Y2RBMi9iNGhpWWZqTERMTE1ieUVRaC9QV3FjVFdSRTNGOXJMVkt5WUlaZTZp?=
 =?utf-8?B?WnF6VEdLS0k1RWtmcllaM3dpdit4SWozSTcrYjhTU052WXBMQks0T3NVMUg5?=
 =?utf-8?B?bkRzTk1USkJ0alFFb090Ymxidy9VNkkwZUUwYWpEZEU0bldwcHhFY2pSeHVh?=
 =?utf-8?B?MHk4cXBQV0srTTNaaEVnVmlJQi9HaXhUcThEcm1Fb1NPOFpRMlVsalNMdjlL?=
 =?utf-8?B?OWNzQ1UxU0ZERDlNZ3E5K2w5SkVxcVhOUUlTQ2VPR0xzdWZKc2NNa0xoSURT?=
 =?utf-8?B?Zk92YkM4WVI0VTRjTXhqL1RFNWJmMzdOcnYwdDJUUFdnNHdqZEVTQmZZR3JN?=
 =?utf-8?B?bUF2eHM5cXpTWDd1NW5sekg1dGxqYkhES0dtSkJjN0Rla0Ntb3BwOGlJSTM3?=
 =?utf-8?B?N0J6MVVjN0dnWUYvbFVKaVNrVFhuVTJ2eEtVdGJBRHJJakhIR2RLNGNCYTU3?=
 =?utf-8?B?SDRaSlNsMTFDSDJLdFY0ckMrTS9yUVQvV21RaTl0cG5CR1FtT2x4dkUrMWUz?=
 =?utf-8?B?eGVZd2VGUytHcXZuemhNSnhCeWtDVnh6RlpoVmdmZ3pTbThBb25JVzZudWps?=
 =?utf-8?B?OVVEdDlIYUpjUS81ZVNTQXIxZ1NJRnQwR0IxdmI3dzlONm1IbDljMk9lSEpI?=
 =?utf-8?B?cnlYYVZNclhlZ2pvT25icmpzSzIxenBjdVVQdnd1VFlLU1Z5a2JvMXdrdGo1?=
 =?utf-8?B?UGdLdGliSGp3TUt2Q2M3M1BrMUFtUWFXUUxZeVpuSmhsU1lPWlg4NVdqMlVi?=
 =?utf-8?B?bkEzMFJNZUZ4OG5SbTI5SDV0RmNiZmw4ZGhRY3dqczZ1cE9zNWRNYS9Hekw4?=
 =?utf-8?B?N0ZlNExJVHRSMUR6dkZvOGRZai9IRFRYdFpaZEFDNlpJK21nd09DNDcxZTla?=
 =?utf-8?B?amZVQW9qVzl0dkFWQ0RCUEFHbTFYOTlSblJMTlZHNDRoT0xxczJrTEVBdjZ5?=
 =?utf-8?B?UGs1QVRKRDJ1TllHVmtabHh1dXpPTE41K1dmdUNDUnJ3SXorbnFjeDZ4SlRj?=
 =?utf-8?Q?ekzA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E80C8C7CB589FF418807328BDE0AA74A@apcprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d5a3b0-ee2d-4fe4-d161-08dbb97b7a86
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 01:46:59.0329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tjzQq2r4Gk9pWLXe86FETdgroMOp1a6zD8a6F7ZZwVTiRZdHBLZTQz/91fMuwTObTubG83SA3oMdP0JZCKwy9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5262

5ZyoIDIwMjMvOS8xOSAyMzozOCwgU2VvbmdKYWUgUGFyayDlhpnpgZM6DQo+IFtTb21lIHBlb3Bs
ZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHNq
QGtlcm5lbC5vcmcuIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5t
cy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPg0KPiBIaSBIdWFuLA0KPg0KPiBP
biBUdWUsIDE5IFNlcCAyMDIzIDEwOjAwOjU3ICswODAwIEh1YW4gWWFuZyA8bGlua0B2aXZvLmNv
bT4gd3JvdGU6DQo+DQo+PiBzaV9tZW1pbmZvKCkgd2lsbCByZWFkIGFuZCBhc3NpZ24gbW9yZSBp
bmZvIG5vdCBqdXN0IGZyZWUvcmFtIHBhZ2VzLg0KPj4gRm9yIGp1c3QgREFNT1NfV01BUktfRlJF
RV9NRU1fUkFURSB1c2UsIG9ubHkgZ2V0IGZyZWUgYW5kIHJhbSBwYWdlcw0KPj4gaXMgb2sgdG8g
c2F2ZSBjcHUuDQo+Pg0KPj4gQ2hhbmdlIGZyb20gdjE6DQo+PiB2MSBmb2xkIGZyZWUgbWVtIHJh
dGUgbG9naWMgaW50byBfX2RhbW9zX2dldF93bWFya19mcmVlX21lbV9yYXRlIGFuZCBub3QNCj4+
IGludm9rZSBzaV9tZW1pbmZvLCBqdXN0IGdldCBmcmVlL3JhbV9wYWdlcyBpbiBnbG9iYWwuDQo+
PiB2MiBjYW5jZWwgdGhpcyBfX2RhbW9zX2dldF93bWFya19mcmVlX21lbV9yYXRlIGFuZCBqdXN0
IGNhbGN1bGF0ZSByYXRlDQo+PiBpbiBkYW1vc193bWFya19tZXRyaWNfdmFsdWUgdG8ga2VlcCBp
dCBzaW1wbGUuDQo+IFRoYW5rIHlvdSBmb3IgYWNjZXB0aW5nIG15IHN1Z2dlc3Rpb24gYW5kIG1h
a2luZyB0aGlzIGNoYW5nZS4gIE5ldmVydGhlbGVzcywgd2UNCj4gdXN1YWxseSBub3Qga2VlcCBw
YXRjaCBjaGFuZ2Vsb2dzIG9uIGNvbW1pdCBtZXNzYWdlIGJ1dCBhZnRlciB0aGUgJy0tLScNCj4g
bGluZVsxXS4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IEh1YW4gWWFuZyA8bGlua0B2aXZvLmNvbT4N
Cj4gT3RoZXIgdGhhbiBhYm92ZSBhbmQgYmVsb3cgdHJpdmlhbCBjb21tZW50cywNCj4NCj4gUmV2
aWV3ZWQtYnk6IFNlb25nSmFlIFBhcmsgPHNqQGtlcm5lbC5vcmc+DQo+DQo+PiAtLS0NCj4gVGhp
cyBpcyB1c3VhbCBwbGFjZSBmb3IgcGF0Y2ggY2hhbmdlbG9ncy4NCkhpIFNKLCBPSywgSSdsbCBj
aGFuZ2UgdGhpcy4NCj4NCj4NCj4+ICAgbW0vZGFtb24vY29yZS5jIHwgNSArLS0tLQ0KPj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL21tL2RhbW9uL2NvcmUuYyBiL21tL2RhbW9uL2NvcmUuYw0KPj4gaW5kZXggYmNk
MmJkOWQ2YzEwLi5hM2Y4MTJkNzgyNjcgMTAwNjQ0DQo+PiAtLS0gYS9tbS9kYW1vbi9jb3JlLmMN
Cj4+ICsrKyBiL21tL2RhbW9uL2NvcmUuYw0KPj4gQEAgLTEyODAsMTIgKzEyODAsOSBAQCBzdGF0
aWMgYm9vbCBrZGFtb25kX25lZWRfc3RvcChzdHJ1Y3QgZGFtb25fY3R4ICpjdHgpDQo+Pg0KPj4g
ICBzdGF0aWMgdW5zaWduZWQgbG9uZyBkYW1vc193bWFya19tZXRyaWNfdmFsdWUoZW51bSBkYW1v
c193bWFya19tZXRyaWMgbWV0cmljKQ0KPj4gICB7DQo+PiAtICAgICBzdHJ1Y3Qgc3lzaW5mbyBp
Ow0KPj4gLQ0KPj4gICAgICAgIHN3aXRjaCAobWV0cmljKSB7DQo+PiAgICAgICAgY2FzZSBEQU1P
U19XTUFSS19GUkVFX01FTV9SQVRFOg0KPj4gLSAgICAgICAgICAgICBzaV9tZW1pbmZvKCZpKTsN
Cj4+IC0gICAgICAgICAgICAgcmV0dXJuIGkuZnJlZXJhbSAqIDEwMDAgLyBpLnRvdGFscmFtOw0K
Pj4gKyAgICAgICAgICAgICByZXR1cm4gZ2xvYmFsX3pvbmVfcGFnZV9zdGF0ZShOUl9GUkVFX1BB
R0VTKSAqIDEwMDAgLyB0b3RhbHJhbV9wYWdlcygpOw0KPiBEQU1PTiBjb2RlIHN0aWxsIHByZWZl
ciA4MCBjb2x1bW5zIGxpbWl0WzJdIChzb3JyeSBmb3IgYmVpbmcgc3R1YmJvcm4pLiAgQ291bGQN
Cj4geW91IHBsZWFzZSBicmVhayB0aGlzIGxpbmUgZm9yIHRoYXQ/DQpTb3JyeSBmb3IgYnJlYWsg
Zm9ybWF0IHJ1bGUsIEknbGwgY2hhbmdlIGl0Lg0KPg0KPj4gICAgICAgIGRlZmF1bHQ6DQo+PiAg
ICAgICAgICAgICAgICBicmVhazsNCj4+ICAgICAgICB9DQo+PiAtLQ0KPj4gMi4zNC4xDQo+Pg0K
PiBbMV0gaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMu
aHRtbCN0aGUtY2Fub25pY2FsLXBhdGNoLWZvcm1hdA0KPiBbMl0gaHR0cHM6Ly9kb2NzLmtlcm5l
bC5vcmcvcHJvY2Vzcy9jb2Rpbmctc3R5bGUuaHRtbCNpbmRlbnRhdGlvbg0KPg0KPiBUaGFua3Ms
DQo+IFNKDQoNCg0K
