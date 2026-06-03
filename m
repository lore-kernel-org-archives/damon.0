Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814E3D8117
	for <damon@lists.linux.dev>; Wed,  3 Jun 2026 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456383; cv=none; b=MQzt9tyAfEoBz0UbE5anRoWmJqq1+c5RJfGpDTQPiVldwgxd5muQDHCDXo4imXqoS7Xeogp20vRjlrMRuwVXAo/Rn38uTE5gkHftrCoMN6Fn9sMwtMq842ECjEFvUfgb0Ysvq1xYiArL8PG1ZwO6BpnhTKGWFVMKMXSt/0Ji4nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456383; c=relaxed/simple;
	bh=ELAckSMkwRGZ6DfjbRItAGTsXXdLZQbzq00xTtjjcNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WBh7xzGXRTwIIwaNdAFzcgy0syY5N23A6/h1vOJkA96kycgFCjR8UE6Evi8Tuj0JHKGTYUaLS+8Muc2KRQIhZhXf4EYezW1zkpTo+ujglnHp2Mnu7o+oD1a3XXl8Ngq3kx/w5X9wo132Kn68S+AFOAwnY2D8pkOXFvfvSL/6Zio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW004-1.hihonor.com (unknown [10.77.232.85])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4gVXlh3hQCzYl0S0;
	Wed,  3 Jun 2026 11:11:12 +0800 (CST)
Received: from TA004.hihonor.com (10.72.0.6) by TW004-1.hihonor.com
 (10.77.232.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 11:12:53 +0800
Received: from TA003.hihonor.com (10.72.0.43) by TA004.hihonor.com (10.72.0.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Wed, 3 Jun
 2026 11:12:52 +0800
Received: from TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1]) by
 TA003.hihonor.com ([fe80::998f:47ec:980d:bdf1%7]) with mapi id
 15.02.2562.037; Wed, 3 Jun 2026 11:12:52 +0800
From: wangtao <tao.wangtao@honor.com>
To: Harry Yoo <harry@kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org"
	<david@kernel.org>, "willy@infradead.org" <willy@infradead.org>,
	"sj@kernel.org" <sj@kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"luizcap@redhat.com" <luizcap@redhat.com>, "zhangjiao2@cmss.chinamobile.com"
	<zhangjiao2@cmss.chinamobile.com>, "kas@kernel.org" <kas@kernel.org>,
	"ljs@kernel.org" <ljs@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "liam@infradead.org"
	<liam@infradead.org>, "vbabka@kernel.org" <vbabka@kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz" <jack@suse.cz>,
	"riel@surriel.com" <riel@surriel.com>, "jannh@google.com" <jannh@google.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"peterx@redhat.com" <peterx@redhat.com>, "ziy@nvidia.com" <ziy@nvidia.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"npache@redhat.com" <npache@redhat.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "dev.jain@arm.com" <dev.jain@arm.com>,
	"baohua@kernel.org" <baohua@kernel.org>, "lance.yang@linux.dev"
	<lance.yang@linux.dev>, "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
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
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "jparsana@google.com"
	<jparsana@google.com>, "dvander@google.com" <dvander@google.com>, zhangji
	<zhangji1@honor.com>, wangzicheng <wangzicheng@honor.com>
Subject: RE: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Thread-Topic: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Thread-Index: AQHc7cjw5r5ki6LAJ0S2mW/rJEfblbYq8jCAgAEtZwCAABGecA==
Date: Wed, 3 Jun 2026 03:12:52 +0000
Message-ID: <2235c9949d8a4986b89c99757c5161a7@honor.com>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <0867dac0-bc48-4aa9-891f-2066a3eff989@kernel.org>
 <7319ad82f9ee4fc4b18b50b1842c9f99@honor.com>
In-Reply-To: <7319ad82f9ee4fc4b18b50b1842c9f99@honor.com>
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

PiBEdXJpbmcgcm1hcCB3ZSBjYW4gY29tcHV0ZSB0aGUgZm9saW8gYWRkcmVzcyB1c2luZyByb290
X3ZtYToNCj4gDQo+IHZtYV9hZGRyZXNzKHZtYSwgcGdvZmYsIDEpID0NCj4gICAgIHZtYS0+dm1f
c3RhcnQgKyAoKHBnb2ZmIC0gdm1hLT52bV9wZ29mZikgPDwgUEFHRV9TSElGVCkNCj4gICA9IHZt
YV9tYXBwaW5nX2Jhc2Uodm1hKSArIHBnb2ZmICogUEFHRV9TSVpFDQo+ICAgPSB2bWFfbWFwcGlu
Z19iYXNlKHJvb3Rfdm1hKSArIGZvbGlvX3Bnb2ZmICogUEFHRV9TSVpFDQo+IA0KSXQgaXMgaW5j
b25zaXN0ZW50IGhlcmUuIFRoZSBvZmZzZXQgc2hvdWxkIHJlbWFpbiBwZ29mZiB0aHJvdWdob3V0
LiBJdCBzaG91bGQgYmU6DQoNCnZtYV9hZGRyZXNzKHZtYSwgcGdvZmYsIDEpID0NCnZtYS0+dm1f
c3RhcnQgKyAoKHBnb2ZmIC0gdm1hLT52bV9wZ29mZikgPDwgUEFHRV9TSElGVCkNCj0gdm1hX21h
cHBpbmdfYmFzZSh2bWEpICsgcGdvZmYgKiBQQUdFX1NJWkUNCj0gdm1hX21hcHBpbmdfYmFzZShy
b290X3ZtYSkgKyBwZ29mZiAqIFBBR0VfU0laRQ0K
