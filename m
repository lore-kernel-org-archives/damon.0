Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014059;
	b=cViRFB+mws0R3+i5j+urqh8Ep84pcdG6KbOVrQdur8tGTRwK/MDW476LM6K1OS5QChMO
	 VkHFul9jvaVA9EGYdEkaY6T4RwZNSecf9lvBqh1p76m4ZpGAGTzJnb/2LkmfRYjUXPe9A
	 NLRdV5AxneTKbBijBsiO20NMYGo+MWKLY8v1rGZN3WjyqiseefG77buvqKohO63lw2RB6
	 z2q/LR5M5rTQ6O3VByx3damZJY569n90wuUa+Qsk03JWsz7LKyqrIwP/0wwXPIYSBJlZ7
	 3wm5IwdMCTnrEovUNa5tmc4pl06vgH3p7kgiPCy1vRlSX0WHFRBJJpMBG4+g7wXJN2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:References;
	bh=pTjWS3+ZRB465NndO+clOkv+MUj94hyH9IhI9lFDqUc=;
	b=HCNqIFgEkxehT8GfaM2FRRJkmgEX/PLfxT0tFsSKNOsZbWgDkZTyoDk3/zjZpHm0sPQy
	 AaGIKmQPyXe4uOcNZsuyjx8AuHOwpQLLpTDqMCCtrXSZ6Z1F91c4jqOujP7O81Drz+E/A
	 WYVVJN9zCMCjYQdWMaOwff9vE0sKxfncYceO+03GbDMMfDQKOFHPlZeJCC65GDKIccian
	 AW5HeySc3FRIHkExIxc2ovXCFRQs5xXEmbe+Q3CtjPjRdGTc3kECUmZqThoUTVLWMT9aH
	 e6X4lHdPos6dC2O4z8BLOspARpxAhu49UpOoPnV3nWNnot6pyYIh7hdP8TPKCK4BPqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gv0A7oyR;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A27606A31A
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 11:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09A27606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gv0A7oyR
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac5f801d7cso547753a91.0
        for <damon@lists.linux.dev>; Mon, 26 Oct 2026 04:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793014058; x=1793618858; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:content-transfer-encoding
         :content-type:mime-version:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pTjWS3+ZRB465NndO+clOkv+MUj94hyH9IhI9lFDqUc=;
        b=gv0A7oyRvOvEadBY3w3LCqJij1S1bHCAVcqD3zf0dYK3vFmyv+shHpu9KV6FByuKyZ
         gZZ5pZoOj8dl3VwSIsnSmHJFhWPBefnpeK8enCu/P9yEVQn2LXgMnmAArlb+qP3t8bNc
         PaCt+25UgjQrRChFQGw/i74TC3JnaSkNsmQEU8zRyVPPMI6dbrynVsUf3m6JgJXcl5Yx
         bttIWSpyJNtr0bbIvIij4IkmeYUPOghEm9dNVVLcWIl/pIlhP5ATx/IgsprRQ4GKq4DR
         nQGA3fJP4w9nrCzQXmYagV+XE7I8BTMVbYHPHwX9k7WRR/ftrWO8maRq17uJb0zE4QqI
         L+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014058; x=1793618858;
        h=references:in-reply-to:message-id:date:content-transfer-encoding
         :content-type:mime-version:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pTjWS3+ZRB465NndO+clOkv+MUj94hyH9IhI9lFDqUc=;
        b=hFkK5ujI7b0CGu7ZcqpPK6DgmY7/emJdtbPYk9VdMNnD+vQe71DRIxxczNrFGePzsT
         i45hmpE5yzbUHTJ8Uen8oRpM7VOjFqxTqKvoGCmNBtShet0bhJrYn+vs41XiUL6q5fTd
         yL9D1WnXMNR7QUFVuxZkctZ5uo7lEsxNz1kg5Xr8VJn9ceIibkiNwg7Uuun8jO21D+Xw
         oVdZH0NZ2PM2GE4QTWVVX5bpRqLare0yl2IXUyhDBuRvSFQsyP6oRfSrOFPBT97UBUG7
         xko7NTiZLmy8qulK88084sj8Ycm9ToJkLK0xSf/YgUGFM6O1CjBX/qCFZ9BHIaTnSXEu
         QifQ==
X-Forwarded-Encrypted: i=1; AKwUvByo9UTGhTOYMA1UxzMkgKuWSkmrTaTzKlqV5s2yF1soIL7ykB2v15ImmYDMSGaaFXphPSDL9A==@lists.linux.dev
X-Gm-Message-State: AFq9FYLz52pIKvtai6Wfr2H3L6KnoB3HOK6xp1WGubmyV01NdujB4vZi
	ZfQx+fYJiebW/Y4GAX0XV9PtEfqQtYdbageqwY1MiL9wItcP38gSprZo
X-Gm-Gg: AYBFou2tnloD3m2Q/z6G7TDm/3B9Pb1q23dmBCRw13YybfImU52XOw/Ozn+JD6sRtYJ
	0sFCo6tAvuZnV2QEJFToLk6XxSZnV1oP+kEIwAHobiEUJK74FAkC9HwZkf6jSlvdhTLNsbXD0b5
	M3MUWL1PtwJNibgfOzRgLp4cjM9JLjfr0DgqU2H6WOPGPmoFyXdSM3ovcr4XpH6XStxM3b1K5ZW
	FxfJWyn+QJSUQNAVFvQGuDvGMzgw1ivbfBxKVnn9zsRshvlqiBOfj02Az+Vgev9YHUfD6iwhGOn
	idBQk3kDEJC3yeH74qrxl5zOZXNCKuH48R++as8FsQnpCIvSxo5yEOPyn7hqQYH+4gNoWW7DfAl
	RLp968UG2sANo800EDVDMzxQpTYUB7oBX4Uqfj4tguLiD3M//Oq8pi1zIEdCmaffEseqWlJh4Ng
	LY9Ccb3lPvtWHE1c5btpGtve3hLjCwmpeEhgu2XFPhyTfBedykQRjZjmfoMqZC+v+7fn2UuuuSv
	OWgW0bZAkZQwQ86Hd+SIckldbpmjNX1vokUev787T+1R3IlCWNmme/FJNa4R1U9wcLV8pPxdIVQ
	J+C8uSANVs2ldLWFa9pbAZzfRbG8QEKdWdvmsbQtqxRMvBcq/FXB3w==
X-Received: by 2002:a17:90b:2745:b0:3ab:c674:cad1 with SMTP id 98e67ed59e1d1-3adeafd682bmr5302506a91.50.1793014058211;
        Mon, 26 Oct 2026 04:27:38 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc20fe8sm1495402a12.5.2026.10.26.04.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:27:37 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Manuel Ebner <manuelebnerli@mailbox.org>,
 damon@lists.linux.dev,
 linux-mm@kvack.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] Docs/mm/damon/monitoring_intervals_tuning_example: fix grammar and typos
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Mon, 26 Oct 2026 22:14:40 +1100
Message-ID: <179301327249.2.2968995103662294177.damon-docs-grammar-8@gmail.com>
In-Reply-To: <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>
References: <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>

Fix a few typos, including "Moniting" in the title, and some grammar in
the interval tuning example.

"starts looking degrading" should be "start looking degraded for", as I
think the sentence means the cold region detection starts to look worse.
Rewrap where the lines got too long.

Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 .../monitoring_intervals_tuning_example.rst   | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/mm/damon/monitoring_intervals_tuning_example.rst b/Documentation/mm/damon/monitoring_intervals_tuning_example.rst
index 7207cbed591f..367b031ce55a 100644
--- a/Documentation/mm/damon/monitoring_intervals_tuning_example.rst
+++ b/Documentation/mm/damon/monitoring_intervals_tuning_example.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=================================================
-DAMON Moniting Interval Parameters Tuning Example
-=================================================
+===================================================
+DAMON Monitoring Interval Parameters Tuning Example
+===================================================
 
 DAMON's monitoring parameters need tuning based on given workload and the
 monitoring purpose.  There is a :ref:`tuning guide
@@ -38,7 +38,7 @@ access-hotness of a region.  It is calculated as a weighted sum of the access
 frequency and the age of the region.  If the access frequency is 0 %, the
 temperature is multiplied by minus one.  That is, if a region is not accessed,
 it gets minus temperature and it gets lower as not accessed for longer time.
-The sorting is in temperature-ascendint order, so the region at the top of the
+The sorting is in temperature-ascending order, so the region at the top of the
 list is the coldest, and the one at the bottom is the hottest one. ::
 
     # damo report access --sort_regions_by temperature
@@ -56,7 +56,7 @@ list is the coldest, and the one at the bottom is the hottest one. ::
     total size: 62.000 GiB
 
 The list shows not seemingly hot regions, and only minimum access pattern
-diversity.  Every region has zero access frequency.  The number of region is
+diversity.  Every region has zero access frequency.  The number of regions is
 10, which is the default ``min_nr_regions value``.  Size of each region is also
 nearly identical.  We can suspect this is because “adaptive regions adjustment”
 mechanism was not well working.  As the guide suggested, we can get relative
@@ -91,7 +91,7 @@ aggregation interval.
 100ms/2s intervals: Starts Showing Small Hot Regions
 ====================================================
 
-Following the guide, increase the interval 20 times (100 milliseocnds and 2
+Following the guide, increase the interval 20 times (100 milliseconds and 2
 seconds for sampling and aggregation intervals, respectively). ::
 
     # damo start -s 100ms -a 2s
@@ -129,17 +129,17 @@ seconds for sampling and aggregation intervals, respectively). ::
     [50,400,010,000, 59,720,011,000)   4.000 KiB  |*                   |
     total size: 62.000 GiB
 
-DAMON found two distinct 4 KiB regions that pretty hot.  The regions are also
-well aged.  The hottest 4 KiB region was keeping the access frequency for about
-8 minutes, and the coldest region was keeping no access for about 7 minutes.
-The distribution on the histogram also looks like having a pattern.
+DAMON found two distinct 4 KiB regions that are pretty hot.  The regions are
+also well aged.  The hottest 4 KiB region was keeping the access frequency for
+about 8 minutes, and the coldest region was keeping no access for about 7
+minutes.  The distribution on the histogram also looks like having a pattern.
 
 Especially, the finding of the 4 KiB regions among the 62 GiB total memory
 shows DAMON’s adaptive regions adjustment is working as designed.
 
 Still the number of regions is close to the ``min_nr_regions``, and sizes of
 cold regions are similar, though.  Apparently it is improved, but it still has
-rooms to improve.
+room to improve.
 
 400ms/8s intervals: Pretty Improved Results
 ===========================================
@@ -196,8 +196,8 @@ good enough to make some meaningful memory management efficiency changes.
 =================================
 
 Further double the intervals (800 milliseconds and 16 seconds for sampling
-and aggregation intervals, respectively).  The results is more improved for the
-hot regions detection, but starts looking degrading cold regions detection. ::
+and aggregation intervals, respectively).  The results are more improved for the
+hot regions detection, but start looking degraded for cold regions detection. ::
 
     # damo start -s 800ms -a 16s
     # sleep 600
@@ -243,5 +243,5 @@ Conclusion
 ==========
 
 With the above experimental tuning results, we can conclude the theory and the
-guide makes sense to at least this workload, and could be applied to similar
+guide make sense to at least this workload, and could be applied to similar
 cases.
