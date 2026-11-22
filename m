Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795333565;
	b=JCrcStnoXfzr54texaFCfzO752cCPaneEEIavIzctqAC1BMZfhXOzzBJ3YsHfII+/cP4
	 V9JBsq8qzJBE61l6KJZG79erQz587s1U8O+lCCSDlHZ37UGBsG/fBRa61ifq06g7arnyM
	 jceWVkx2vmZsHb9oWYIgA1z7Kjb7RBdGpOCl0uhUA9ARwvzDk0WUx8DmjiVC8Q1s2vWkR
	 ViaUU0Vu1OnbvHXX96r3hw82P5qqI761G9Xjf+NjBKqsTDGgm6pIeOqKfsOOoZBiC9Iff
	 kGjaJ8WsvMosk/QcgZWnqnPVwuHzqV26kCIHiINe3YN58jwEJoaWnqGBiCAC4joRmDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795333565;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=fjN2XrDXoDL6HaIL9EYpcjTaN40VnCpFbTbw1leaE1g=;
	b=yb+aPslVInQezokeWKW1JNhtkCa5IBUa5y3KnUsD2xQCrR5PDrEaGlNL8irMiO6pepaX
	 WlOiITNs4koFlT5dE0KAUyW8sPzWCVBVRCkoy56P3EhjFZXVC6dB4O9knJkJBmCOfUC7N
	 J8ggPFoaf/4/GJKIF/wV+93XaRpSFQUulx19LHlZOKG4qZCMg6PEY9XYKZpZHanaafsjG
	 +y6jFRikwk0ucQxpaZMqYxfXOfVSgDqNFU41C0evdX3ziWswrUJtWJpeIlo3h/QSY63+S
	 6A8lm5sRsUdjDIaP/dCLFfaM7SEVFfN6gugj8xDciTQDKS374G18gBF6ZI68kB0M/Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="Ep+qtuk/";
	arc=none smtp.remote-ip=91.218.175.60
Received: from mta0.migadu.com (out-60.mta0.migadu.com [91.218.175.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B04606A330
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 07:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1B04606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ep+qtuk/
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=fjN2XrDXoDL6HaIL9EYpcjTaN40VnCpFbTbw1leaE1g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795333562; v=1; x=1795938362;
 b=Ep+qtuk/XW/3WBXdJc2FfXG5ni5wxOG8njJc02OEXT57/3jHMHHaWIt9HvTyl8sSqIw/eG1y
 Ogd7q0XaWhZzffdm30DqHZpdTokF7+jmEAUE/7WVfOH4yPRilUe4g3YDIFma+/A+EBcnqrZ4rwM
 +njendDcKBMg+aCJ6YS+Tn5c=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 56927addac11c5be;
	Sun, 22 Nov 2026 07:46:02 +0000
X-Mizu-Trace-ID: 56927addac11c5be
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v5 02/17] mm/memcontrol: allow update of LRU statistic
 without holding LRU lock
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261119-mglru-fg-v5-2-9eee2fe97a2d@tencent.com>
Date: Sun, 22 Nov 2026 15:45:28 +0800
Cc: Muchun Song <muchun.song@linux.dev>,
 linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Qi Zheng <qi.zheng@linux.dev>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Chris Li <chrisl@kernel.org>,
 Baoquan He <baoquan.he@linux.dev>,
 Nico Pache <nico.pache@linux.dev>,
 Usama Arif <usama.arif@linux.dev>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Nhat Pham <nphamcs@gmail.com>,
 Youngjun Park <youngjun.park@lge.com>,
 Zi Yan <ziy@nvidia.com>,
 Gregory Price <gourry@gourry.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>,
 Lance Yang <lance.yang@linux.dev>,
 Hugh Dickins <hughd@google.com>,
 SJ Park <sj@kernel.org>,
 David Rientjes <rientjes@google.com>,
 Yu Zhao <yuzhao@google.com>,
 Vernon Yang <vernon2gm@gmail.com>,
 Zicheng Wang <wangzicheng@honor.com>,
 Chen Ridong <chenridong@xiaomi.com>,
 Tal Zussman <tz2294@columbia.edu>,
 Kairui Song <ryncsn@gmail.com>,
 Xiang Liu <liuxiang.277@bytedance.com>,
 Ehab Ababneh <ehab.ababneh@intel.com>,
 Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>,
 Lian Wang <lianux.mm@gmail.com>,
 Joanne Koong <joannelkoong@gmail.com>,
 Kunwu Chan <kunwu.chan@gmail.com>,
 Hui Zhu <hui.zhu@linux.dev>,
 linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 damon@lists.linux.dev,
 linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B8BCB9C4-53C8-4D47-868A-EEEA4E0EBE23@linux.dev>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-2-9eee2fe97a2d@tencent.com>
To: kasong@tencent.com
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 19, 2026, at 05:03, Kairui Song via B4 Relay =
<devnull+kasong.tencent.com@kernel.org> wrote:
>=20
> From: Kairui Song <kasong@tencent.com>
>=20
> To enable moving file pages in folio_mark_accessed directly and lazily
> for MGLRU, allow updating the LRU statistic atomically without holding =
a
> lock. It may cause temporary counter underflow, which should be fine =
as
> the counter is eventually consistent and only serves as an estimate.
>=20
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Muchun Song (ByteDance) <muchun.song@linux.dev>

Thanks.

