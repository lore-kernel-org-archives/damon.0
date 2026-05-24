Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E69395AFD
	for <damon@lists.linux.dev>; Sun, 24 May 2026 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779627099; cv=none; b=hLyLM+q2Oie7y3FG4pablVKxM/LYJ/3J2/g9AInLP1kleMM7oHLhShmbSlEJzZzZBdwl6PVntMha5hPDnROZEmj54tkdxPkaWIxdlq7DTCigU/MsmlKy4Prz35br+6V2c6fbQPWvrXCD8ME4S2f9FoxAtWt6zkzQvXgLFIaNeMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779627099; c=relaxed/simple;
	bh=hL+s7EbAAJiC5PDsEX+EeqlhhRUkFl41FxobbygN9B8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMTIipQC0I0pFcpzeMbjgobkqDxfkSssrwQp8/sFqJ3dKwMW6/cRXKcmIv+Xh06Of0E1UCInHDey16hOz7AbwBc3v9XHNRrxre9tfvj6QJCERLH2WvEfQSfWNHwdvv03+L9cNE8CpB1CENlJ+aD9QLtFpLM/hI++Zx9ZuZQh4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9c4pX2P; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9c4pX2P"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68852a4fc68so2774585a12.3
        for <damon@lists.linux.dev>; Sun, 24 May 2026 05:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779627096; x=1780231896; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zaac+q2wcXPmSLkezcHQ4SREpixOUlTlhddu9awVmSo=;
        b=c9c4pX2PX1I0iihbcGXv+LPcYR7xYHh0nwrIqS6Tv11+5JrS1eIXZbU6joB4FicZEx
         KiFQ0TEwMHoEaX2ipWZKXNXqSKT/yMnJZ1BdwNBrk/1HYABm2ch+9Yu+TJfX6hD+O8fJ
         qzHCfJSgRd3GsvfGyoXG2X7s75lySGYdyyTxLwJWLrSzsVBbrKOvgnKkMFxFLk3G3iLW
         JNUvBbN4sQUI1JEV+/7IpA+QOSBlLAaYFsqdNqa/T8RWguTEDoEQIPb4xDYkIPhm+kiG
         M0rDDHudaxbapaB/pg7TG46CSuyIMxKsp0nuyTQm0bBisfOb5BeG0GGoDtwgfa/yzzpw
         t8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779627096; x=1780231896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaac+q2wcXPmSLkezcHQ4SREpixOUlTlhddu9awVmSo=;
        b=NAB9E0fn2o8RPIQgCTCfSQfWpihOgo44cbrhMkEzi7/cHlI5kTkEvTVjd/QaO7pRnU
         x7S0V6MdIlEJFFceBuA1k2Hr2E6LDLPgpVROsNvCFj1MA7trj9JEOqp7OQVcG2jxeGcm
         0gO7XaPUYJ13NmhgleUBHgzuzhmTLMtB9Mb7TRg7ZKQfztbr6rumWIkUjBeUwAQhTOAK
         Ej5PHMNx3ahqr43VLs6JB7nkKru3J7ceZF6iTmqPAwdzahXyBO5vS8w7ENMa3b7W+KRZ
         I4Zy+vebfsAjTUa0DTLUBxQ9cKH/RSHrKwj8AxMYb/ZzznfXk0VUPfTqL4iaYvv/zA7R
         pPEA==
X-Forwarded-Encrypted: i=1; AFNElJ8w2GPyogNk8MpuXtSagmL0qrGF8Q/Xsj0yj3Rqq3k5FhRhU07fkBOpdh/mVxOzquO2FfvMRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMxb0ii4r2WSRlrWYPQwnDr5eWVzZg+KjsTn9VlnGo5NFPOXsw
	PKCvkYuQAw4b1fiHKaHVJbbK2RfElNvw9O5Gjg93DylT+R4crZIsx5YJ
X-Gm-Gg: Acq92OGj5VArCHvEYvIT5vKfuE9HkfmFeV7UO55iutmsNQU4i+hpaJL57U+OMpC4rrK
	08c1PHuREz572GZb0rDE68u/8vA1M813s9vKf3gxjckdrZq+0S3hkqw7+5DKpd66QJz6XuLtqdX
	v2jxgNEMd+wIw11PNoeKPm5BDDKQ4s7yJmh5cFuSPrz+tlZeu3UZLduNUY7N+sgmCz6uY8sy9eP
	iELs/KoFtxvupWLcr+XEtQTLP5R6pppp3xdY4aJLBrfu1eyHNu2xN12/VziPIXJl004pQ3AMKTK
	oHex2giO8jfCLJtfkjeJcwltKKWQB1dBUeTV6Lvgh+7K+WXeZWgCWtBveITubuIkp96IhN029/E
	YxS/V001eszEmo4pPkLGYH01uqdQI+kk7MFWHwUZdmG2R/12UcxcP9FiWXgvvcJD9uXqfbbFpQK
	SgpRb+NVfB/DjYAXip9IfFXLMP5LlTKngFP/kk+Q3n+NSSB66HHZR+jfsGnazustNfcCA=
X-Received: by 2002:a05:6402:370a:b0:680:c843:a1d0 with SMTP id 4fb4d7f45d1cf-6889c432224mr5618565a12.3.1779627095441;
        Sun, 24 May 2026 05:51:35 -0700 (PDT)
Received: from nixos.tail35a60b.ts.net (86-103-11-136.ip.tng.de. [86.103.11.136])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688b9f6084fsm3042930a12.11.2026.05.24.05.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:51:34 -0700 (PDT)
From: mattsva <mattsva.kernel@gmail.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: mattsva <mattsva.kernel@gmail.com>,
	SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	damon@lists.linux.dev (open list:DAMON),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] docs/mm: fix spelling mistakes in memory management docs
Date: Sun, 24 May 2026 14:49:21 +0200
Message-ID: <20260524124924.405071-1-mattsva.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: mattsva <mattsva.kernel@gmail.com>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 2 +-
 Documentation/admin-guide/mm/damon/reclaim.rst  | 2 +-
 Documentation/admin-guide/mm/transhuge.rst      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 14cc6b2db897..25e2f042a383 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -75,7 +75,7 @@ Make DAMON_LRU_SORT reads the input parameters again, except ``enabled``.
 
 Input parameters that updated while DAMON_LRU_SORT is running are not applied
 by default.  Once this parameter is set as ``Y``, DAMON_LRU_SORT reads values
-of parametrs except ``enabled`` again.  Once the re-reading is done, this
+of parameters except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_LRU_SORT will be disabled.
 
diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index d7a0225b4950..01a34c215b66 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -67,7 +67,7 @@ Make DAMON_RECLAIM reads the input parameters again, except ``enabled``.
 
 Input parameters that updated while DAMON_RECLAIM is running are not applied
 by default.  Once this parameter is set as ``Y``, DAMON_RECLAIM reads values
-of parametrs except ``enabled`` again.  Once the re-reading is done, this
+of parameters except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_RECLAIM will be disabled.
 
diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 5fbc3d89bb07..5d08a2a1c15f 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -210,7 +210,7 @@ PMD-mappable transparent hugepage::
 	cat /sys/kernel/mm/transparent_hugepage/hpage_pmd_size
 
 All THPs at fault and collapse time will be added to _deferred_list,
-and will therefore be split under memory presure if they are considered
+and will therefore be split under memory pressure if they are considered
 "underused". A THP is underused if the number of zero-filled pages in
 the THP is above max_ptes_none (see below). It is possible to disable
 this behaviour by writing 0 to shrink_underused, and enable it by writing
-- 
2.54.0

