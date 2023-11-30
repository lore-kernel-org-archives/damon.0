Received: from invmail3.skhynix.com (exvmail3.hynix.com [166.125.252.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7CB14F8D
	for <damon@lists.linux.dev>; Thu, 30 Nov 2023 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-AuditID: a67dfc59-bd5ff7000001c92b-f5-65682da95e6d
Received: from hymail05.hynixad.com (10.156.135.35) by hymail04.hynixad.com
 (10.156.135.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.986.42; Thu, 30 Nov
 2023 15:37:29 +0900
Received: from hymail05.hynixad.com ([10.156.135.35]) by hymail05.hynixad.com
 ([10.156.135.35]) with mapi id 15.02.0986.042; Thu, 30 Nov 2023 15:37:29
 +0900
From: "honggyu.kim@sk.com" <honggyu.kim@sk.com>
To: "sj@kernel.org" <sj@kernel.org>
CC: "damon@lists.linux.dev" <damon@lists.linux.dev>, "hyeongtak.ji@sk.com"
	<hyeongtak.ji@sk.com>, "byungchul@sk.com" <byungchul@sk.com>,
	"hokyoon.lee@sk.com" <hokyoon.lee@sk.com>
Subject: Re: [PATCH] mm/damon/core.c: avoid unintentional filtering out of
 schemes
Thread-Topic: Re: [PATCH] mm/damon/core.c: avoid unintentional filtering out
 of schemes
Thread-Index: AdojVwNwogcjIaHSRS6ioZESP2SpMw==
Date: Thu, 30 Nov 2023 06:37:29 +0000
Message-ID: <1a2cc229c06c486db7177e12b5b4d601@sk.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
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
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsXC9ZZnoe5K3YxUg19brC2e/P/NanH46xsm
	ByaPTas62TxebJ7JGMAUxWWTkpqTWZZapG+XwJWx8vcktoJjTBUd7UINjHuYuhg5OSQETCQO
	/vvE2sXIxSEk8JpRovvTbCYIZwGjxOTrG1lAqtgE9CU2ne9gA7FFBJQlerfMZwYpYhbYxiix
	4/J3RpCEsECIxP4fc1ggiiIlTvaeZYew9ST6f+xjBbFZBFQlFnz6yQxi8wqYSrw+9AoozsHB
	KCArcfWaDEiYWUBcYvHXa8wQ1wlILNlzHsoWlXj5+B9YuYSAgkT7jzAQk1lAU2L9Ln2ITkWJ
	Kd0P2SGGC0qcnPmEBaJTUuLgihssExhFZiFZMAuhexaS7llIuhcwsqxiFMnMK8tNzMwx1ivO
	zqjMy6zQS87P3cQIjINltX8idzB+uxB8iFGAg1GJh/eFV3qqEGtiWXFl7iFGCQ5mJRHe60+B
	QrwpiZVVqUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhiVlogV9Nl+
	fdD6K4FhZTLTuos9i9/+n+i81cPNvy9/XfrBT6Lz9VkWbq2xOObhtvzqUjaBmV+NruzOci/7
	mnCUdckJkzqVN7HZJT2PzmZ/FEr+aZ7gmHLNVjBtQsO579dreHe+9VM6dl/SjP/Z7WM7Vtco
	PW402sIqlcy1SnPStj9mJ3vyliUosRRnJBpqMRcVJwIA/0mrrH8CAAA=

SGkgU2VvbmdKYWUsDQoNCj4+IFNpZ25lZC1vZmYtYnk6IEh5ZW9uZ3RhayBKaSA8aHllb25ndGFr
LmppQHNrLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBTZW9uZ0phZSBQYXJrIDxzakBrZXJuZWwu
b3JnPg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuIEknbSBqdXN0IHNlbmRpbmcgdGhpcyB3aGV0
aGVyIHRoaXMgbWVzc2FnZSBpcyBjb3JyZWN0bHkgc2hvd24gaW4gTEtNTC4NCg0KVGhhbmtzLA0K
SG9uZ2d5dQ0K
