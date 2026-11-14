Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640246;
	b=KGPinyTCbjyBEYG9RyVFDkL2YKdo5434pamNunvfRWChHLeU1gU9VWPA3BFU7yJeI4PI
	 YnvUm3kzoZ1gd+PDsDZReqjg+mqhPqiTvWuHHuYT2DZFDdErgAGhbONHYjDew9BT8TdQV
	 uA7pd1iyMRbr+HRYlXY7zuE+l1vLwwv93Kc77bbZ/T1RKbX+qg6XgbYmAPLc7SkoMzGnx
	 KOlibY4vWPskwZFn4vTP0CJo4uNxr4MZF1Nhgt9pWFVYt424cu3Ez6oo9PpGKfLa1NH2u
	 AAIBTAsA8n4cVe4ZU5gLbp16eutksJBUIjqsVONyB1eT5VGC7RD7Tub5/OzHBRlEOHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YEak+iwgBd7H+tAUDcNraVIKxkIkqE3kGPmkcYQNtnc=;
	b=T2OU703/qISR+msj3/uQyB34ZZOQpT7mUOo8nOwOOMxHQcRhzvHeHFozxO2FdhAKihUQ
	 HHGkc1Vtrk2uw2EpNSXcr5L6DTRVxjniR22WDF5hGbKqXJ8k69uA9InhXomzaq8/isr6d
	 u/K/K0x6r5UoAqybxWMWSUC/lDTnZZ3Pl0SN0oAKX8hMB5fy3WHMhqFDP3RsAQQu8nmO/
	 9oI7BYc3113tZ9viMHse/t1+i04qC4AzYrErNCjhXvAuxsyIzVY4hMCUQ93TsX6VT+jK1
	 IgxBRKo05eeUhbL6NzqWk9Jzql58mmG8gvR2sPvMomFlgnYzPpa7m/QxSnawRIGlnUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=R7uTHpSj;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A1606C0FF
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD2A1606C0FF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=R7uTHpSj
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c847584b8so29377816d6.0
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640245; x=1795245045; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YEak+iwgBd7H+tAUDcNraVIKxkIkqE3kGPmkcYQNtnc=;
        b=R7uTHpSjLpuYx2p7l1lOw5ERxOimCIAHAOSS0WSHajP3oE/NdyUA6BpRUNx0OJElK6
         5eeWy4SplAleru1AvbmU6z5Q7uYGztYGj73XL4d+miXZOsEOhAQIcQh9EI6ohiYJcjcL
         VYaIAabKNiK0hvs0kJzyWPGvTRXNXFhHtULWxn/qRQVuutG0QIWRV1A5nrO/VAD2zdsw
         MzmZWf0+q8lEPimJ33c8zv3WHFgpSn2PytOpgS6AuqFZzg4v3il5Tx9J8LgbB0koMyIE
         tjxHn82++u9q+haKIENxyjqY0r+XqbQOfwLMGNfeTWCByKBgJxP3DYLiD1MPQBDYmaUw
         lD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640245; x=1795245045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YEak+iwgBd7H+tAUDcNraVIKxkIkqE3kGPmkcYQNtnc=;
        b=mPhx+uPjA+flfbrFqTAK5T/ozj+kOSav7dSZST/y06LkKLXK2fpUJ3njrBtmijhzJQ
         BmTV4TuRZ+Xnz5sIKJmIpGP+pqqYIawkaoTOtM5trTJo/gT5fFIKAvps8WwtCMiWyHSS
         wGecoyocmXHgQKuQWxNj2SXrXj5iWnOg7eB9kFerskaQl/jZKctR4fpKrMSs0gxpqz9L
         z+vioZfBFCVTcc2M3/ks8ak2ZIWRgnsiW7AdIdweZ5zgp7+MUfKVktXjmSRNDrY2rjhW
         wTSkKgtOyceH8Nb5WYNswr1mDJmWHhBWv1KjiikbylscoR1xfTHGFB9nl+p6pH5nlluU
         5hjQ==
X-Forwarded-Encrypted: i=1; AL+hErGCi+vtaCEiRj7NSZX6ZrpB8uht/aOYT8lQDf8Hw/jQBhPvI2Zto1gsN7hifw3HUo3ipkaFwg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/vCYTuRf/aocYor9hbNMTFWWftzIv4krdYzi1zj2ygzFSdfYj1
	lATlxndpLoEPq8UXyEoSbRu0+uSD6ijFLS1mtGNbcQJTCpXQsGydwVSnP+LKHaeKTW4=
X-Gm-Gg: AYBFou3oS9YB3/BrCZAC0y8lmcus5amNgMHatOMgIn0uwUcki/eUvRWS4T3CY+ezCdS
	qcifM6XUw9eGgHU6M5zxCf/kqHQOkdOgq+34eGxMGhf3kv5qExLPDnaldXaJucQmVKH2bqvTiW8
	XLh6ZRCuvtcSrwVvOTVWCfGdqRYfbFFTSltMDfSOGr+trU1q2lc7tzu/XrqNuAy+05Ej9bP1Mj7
	xeBeiAz1WdmGOaRyYVJirAJGXwQ0u0/J/MALYUcMzU46ncyqJ9OrThSs25/URhOFJy+YGMGRkes
	U59GmXRuZhVSwEzA9AaveDC033iXbyjNYhYPdOQ5bQiFWLS7AnzyiRS++ngvMNuR7tCfByiryYT
	PMKt2kuORcFm3vljtVa0wRdFQK9Zkg7xuVXaEHTqBnV/eBXwxlZxwZjyCQH+yE9riZqVRJFWC6f
	Gvfu/RVTHx0N62SwMdiZvExd7pNX4GH3ChtKeS8ugKyuTFPg0MUXvgpYEXdvxg+q0WhpmvYU/N5
	JC4HTyZ6jbOerwWVvIP8MJdYdGVO07kr9O/WaA+PSkSSXpCu+8M0IWpClCxjuRVO+RP8XHeuHbX
	JNHMO+XYbr8Lo5pZl/ZmvsNkUOqw9bdd58YCSVfT5kT5B+eUJE7ZH+403dRu3ld7fZDq1LGS9aO
	/8hw8GukeI09nYGM=
X-Received: by 2002:a05:6214:2f93:b0:91e:b7fd:8ce7 with SMTP id 6a1803df08f44-91f2425d524mr70448086d6.28.1794640244861;
        Fri, 13 Nov 2026 23:10:44 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:44 -0800 (PST)
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
Subject: [PATCH 19/22] mm/migrate: restrict move_pages() destinations to common memory
Date: Sat, 14 Nov 2026 02:09:56 -0500
Message-ID: <20261114070959.3490008-20-gourry@gourry.net>
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

move_pages(2) places user memory on a node the caller picks. As with
memory policies, the destination should be general purpose memory.

Reject a destination outside N_MEMORY_COMMON with -ENODEV, exactly
the same as a node without memory is rejected today.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 28a8d7734735b..fed910c9ba9ee 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2400,7 +2400,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		err = -ENODEV;
 		if (node < 0 || node >= MAX_NUMNODES)
 			goto out_flush;
-		if (!node_state(node, N_MEMORY))
+		if (!node_state(node, N_MEMORY_COMMON))
 			goto out_flush;
 
 		err = -EACCES;
-- 
2.53.1-Meta

