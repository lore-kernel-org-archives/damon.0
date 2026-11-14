Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640229;
	b=nYV8+FrnAgP4EH867jraMETIqR7UGpjcXfx0NQrePm+vevf1XsM65cip3jqQqTadC7VG
	 2wuiTXvf8+/Ps9+uPbiSreFQ95cVtsiWtrjeAOGwyb/PVahjgf+lXATEGxIsMzdnfMEoZ
	 sUh7jIVsYaAQ8ZI0T7nGyRVWKyfBKxkl55/WfCREJruXIe0xj81dAtRC75La6ioPRt/kL
	 WRkkPImfXUpQnRvVZhKEAsRk1Ab5vA6hUtdEbMnWxrXB8ctQPV2vYin77L9g/Mtn5z6Er
	 A4DwrYugKJZET3n+WndLuVoRd1YadrMQeQatz9Ct3XBnOHh8HM9ArcTw72/5wYum3KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ug/CLwAsG6XPyYIr9OCoTcVisBprjwnxP+sIccpst3I=;
	b=SWiTNTcXRUuNRyqUk3LgdPQ1KRmiJREnoIHffpb6yWrUeoZl+HdrP/YkydJh1vgEke8J
	 E+rIRfdGIUF+Aeylk+nrGhB3w7HKJYLWHdKQz3X8wnX6wZrLFu3+bWZb3l1AK7onMLFr9
	 qMvtValD82qW0hoSv8TNlUnSSwLiJZy6LF5cwPFIeomC+ihqXlaHjc3v4DrnNiCsTYbvN
	 5ArwurK31OdGS6+6aAzAi1z1mlT60+1ONxRqHJ1j0GchPKqKI0NwNtF6Xz5w4mWWUrwzq
	 wPnhLDWsKVEvEE0KmJ1fk2gIdclaIyyj3AsO9Hs+yflrk9DQmrkk3CtIygghSa/wrQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=rlOWu8ua;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6151C60A6F41
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6151C60A6F41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=rlOWu8ua
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91f2b826fe9so19623136d6.1
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640227; x=1795245027; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ug/CLwAsG6XPyYIr9OCoTcVisBprjwnxP+sIccpst3I=;
        b=rlOWu8ua6+5H5YIJssqxtDxUtQ30Wa+5xmPhyOOAJp0YxsXw/bOtooKZgSU5ALVORH
         TO9IfKh5g4O0FQwxW1GoyRWvvtTVwn7pXn55B3tq8y1U1AddL0729n0KoM1B6Z2IIyn+
         Frk+c31C/gdkP4ApzwHB85pvlj+AWXpgYMrb4t3YFPAlXE/YAMGMUGJuCyjbhfzrlaTL
         myNrEX0q/jTNt7V+h0A/zkgrZmHaXZxgOPsdskp+I3lI6+EwCxqFwcPks2fQW1cDtiDY
         4Y0n5LI07dgUngiiL6Vc1RTFWKdHVyggMHbiC9ehqkun4AZkhBkWbcceI00ZJ+IVtl5W
         C02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640227; x=1795245027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ug/CLwAsG6XPyYIr9OCoTcVisBprjwnxP+sIccpst3I=;
        b=0uqvPGPSuPz09miUZdndHmPnS9kaSKlKvSxkLfE9SZb4yyoryCdAiMnuOCimg5X2Tu
         2jcKuO1+611URkI/UlcUAgaWiDgSLU2aQ2vOxjau/36ocQ+reAudAzLveDZRTrxCd9iR
         h+7UrjaQ8NB/beVz2BPtZmd5eJB6Ro5M3qs4hb56qGTMVqlU2YFO7O9iidPnjPHpWCey
         4xtycSCYUT80vfC1KYLPniB3wytMUX25entG0xM0g/QYsPFZpDh2oMWrosmZT/I45yXc
         5f4oAX9wygxP/J3hmcdmVPZWHMaH8E9KSeFZPlkFzz+2N+jv1s6PqzOT5NcaLLiCGguT
         Gb0g==
X-Forwarded-Encrypted: i=1; AL+hErED9r+mQBw6VDkb8YpwwbOmJhc9ApsJBFDRz8er4UqCfHZwsFWZQKllCAcitU+8i3shb2I4rg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8KWxEzDuBR32tqwp4irEA6FXsf7mk+oWpDwFBak0X4g2GpJ4fY
	Svug4mV8LI3Mp9sMgI1P+Zubsjgrwk+jqNx9iavG6tjNBu1Ipbv4j/jnh32h9jHqgZc=
X-Gm-Gg: AYBFou3wzDdcjFgR7OtA6bHWBKOu0nYWmnYwLGo4wv5bGiekCEmianA5NJqjrxGM3Rv
	6s4qv/WcBK3cOnwphLjfy2KURK59i0uD4YTRYJN0zjr7cGQHTrY/AkCUKFJZUKI6wzAYcKCRgtA
	emG9lfjO8HahoxurJpO+FOfCOHuF48TSz4GsWqSlF89mDqhQLuIc1Vrcjx3wVCM7nkFLU9ui4ZH
	cth77Mp+iaYExE4M3f/FGmR6+fMDhz8fOfOxaE87Rm3fiIdwfV1xfP+TPeGpeA6zj6i6aI6Pc2g
	xG9fAXEoI201TcJgMD7dqm6zClt30/9B/r62SYrEhUXF9T1/+az3dzkIbwvrp9LSPmMWGn23I+u
	PXJsVmAYHxtHNTQUTrXZI1n7UySaYvFsGxvx2CiZ/yMtsakRM8wKRbIRWMR6X0GkN56QFM6qa4B
	E3nS5AUThpN56EJXqLdt3osN4dugdx+I58k2U5Bt7QpWvgl4yg678YR/intd0YZxOicryPQYVm2
	cbRmTZKgmD7vRI32Vyz1BB0ZCFpKG5Mpeo4WKg9LaRY5r+K1PsOhuLJEKR+33LGzBdewism8oYf
	6OX8T+gV31o6Z1Me8Ww6q40A0Ql0Kh2yuOLbTNgSu/5R4sB9FPXSlmGZdt34GIWB+BJjZ5dgLVl
	X/RVhOprfPu/OSMo=
X-Received: by 2002:a05:6214:dc1:b0:91f:1bc7:b779 with SMTP id 6a1803df08f44-91f24251f4dmr78714166d6.56.1794640227399;
        Fri, 13 Nov 2026 23:10:27 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:27 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 11/22] mm/mempolicy: don't NUMA-hint folios outside common memory
Date: Sat, 14 Nov 2026 02:09:48 -0500
Message-ID: <20261114070959.3490008-12-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NUMA balancing scanner installs PROT_NONE only on folios that
balancing may migrate.

folio_can_map_prot_numa() already skips ZONE_DEVICE folios. Skip folios
outside the common memory pool (N_MEMORY_COMMON) as well. Do not inject
hint faults on those folios or migrate them.

Convert the zone_device check to a common memory check (which includes
the zone device check explicitly).

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 662ab420fe03c..619970f0eb954 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -863,7 +863,7 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 {
 	int nid;
 
-	if (!folio || folio_is_zone_device(folio) || folio_test_ksm(folio))
+	if (!folio || !folio_is_common_memory(folio) || folio_test_ksm(folio))
 		return false;
 
 	/* Also skip shared copy-on-write folios */
-- 
2.53.1-Meta

