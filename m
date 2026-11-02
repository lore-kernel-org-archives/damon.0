Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633339;
	b=X/nTcmBPbn4dijo9XLUHw2zsAQfVxXidoP9/hDmusZfp7vHpL7inACTVKJGFFqArvcXG
	 Fv4yqFk+FBvpk571K0fiHjsQdHcXNczJ04h8BLCK7zA6P9gcDC+3vina/Z30kO23eEOEU
	 c7Dexs5getYw3tYTsU7g0O7gMnXPNp+F76oMEzV/1QjEoNFzB4xjfbeSSGxafBCkeDui0
	 9ab64E/Bn0qm7mMMLcwUixNa+WxefVQVpyGuo4n+DPXNBp9l3cW7cEFhqVu6PF1AFB267
	 mVvZSZc8ueYp1Ze+I4h6JeIfUY9J32NSPlpsHLWnEjyRl11Vy7zvDQWaHO/J5TIV0ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633339;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3Iir60tzlJxsVWy2tki8NnHL4BFjO7m6tThvakIYkR8=;
	b=icgcD55lXt7i4WUC4gGOgP2KUUM09Dcs8hFZDYAc9Mw9igc8FSCA3AwUoMEA4hl3AWwS
	 j8b9E0wAoY88sTp8qfrb1mM5jd+JfWDM9PyUBX/mJZCEyUt/GwAMW4dPUyZM6Am0CbbX7
	 vQZHc6KaKfQ7jIGFxd+oOypSkDC3omktUvigR/V60l5BjMN17zwZUVTaOiXxD/d5MaLqz
	 d5pNuqAHRfJwfDYljzHGxzOTZU8rNj17UkOF+4QcCoFVpyBlID/Z06BxX9/VEJEk1lxeh
	 tF6IvaiF/ELOJlwY3AFYAfYOEUGqmLUckTBo+B4IJVXO9rCaRnQvUOogW6goKZjoFiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cIG6hYuT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645E36084420;
	Mon,  2 Nov 2026 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cIG6hYuT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7562E1F00A16;
	Mon,  2 Nov 2026 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633338;
	bh=3Iir60tzlJxsVWy2tki8NnHL4BFjO7m6tThvakIYkR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cIG6hYuTYA3oYxQcCBL1Ucgfh0dcqu88fjQmfmwEtCA4SjrZlDPVkW61bOTW2KH4O
	 TFLLgrlkBMZmCDjL9VX7XSohjkvHPp/njaI8VXWDsRRafK5UX9q7ASyatOaRpd5X7w
	 yxdJ9bBAWvyTVQsRqPOHO5ChPOLaCmiP6SueKezq2XaMNpm58M8DPC5Xg1jHNy9jwx
	 yHDfect4zO4lscvlnWSqYcVE5gwOLNakrxiVH2tR4jFMtsuW48jhNrIS0WQ18S34K6
	 ukjp5JGkFg6Q8iWhcHRkcGZBgUjH1Ut8ULXh56Ungi1YXCpzJrRAt60+rhQxuuoJJv
	 0AvhLVDaYSpgQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 1/3] Docs/admin-guide/mm/damon: fix various typos
Date: Mon,  2 Nov 2026 07:28:45 -0800
Message-ID: <20261102152849.96057-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102152849.96057-1-sj@kernel.org>
References: <20261102152849.96057-1-sj@kernel.org>
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

From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>

Fix several spelling mistakes found while reading the DAMON
documentation:
  * trusworthy -> trustworthy
  * DAMON_RCLAIM -> DAMON_RECLAIM
  * charget -> charge
  * hetmap -> heatmap
  * colun -> column
  * evelenth -> eleventh
  * idlee -> idle

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 2 +-
 Documentation/admin-guide/mm/damon/reclaim.rst  | 4 ++--
 Documentation/admin-guide/mm/damon/start.rst    | 6 +++---
 Documentation/admin-guide/mm/damon/stat.rst     | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index f1eeb6389c377..02ea694426b2c 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -7,7 +7,7 @@ DAMON-based LRU-lists Sorting
 DAMON-based LRU-lists Sorting (DAMON_LRU_SORT) is a static kernel module that
 aims to be used for proactive and lightweight data access pattern based
 (de)prioritization of pages on their LRU-lists for making LRU-lists a more
-trusworthy data access pattern source.
+trustworthy data access pattern source.
 
 Where Proactive LRU-lists Sorting is Required?
 ==============================================
diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 14f9b82b38ed9..028947f5da8ec 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -55,7 +55,7 @@ enabled
 
 Enable or disable DAMON_RECLAIM.
 
-You can enable DAMON_RCLAIM by setting the value of this parameter as ``Y``.
+You can enable DAMON_RECLAIM by setting the value of this parameter as ``Y``.
 Setting it as ``N`` disables DAMON_RECLAIM.  Note that DAMON_RECLAIM could do
 no real monitoring and reclamation due to the watermarks-based activation
 condition.  Refer to below descriptions for the watermarks parameter for this.
@@ -125,7 +125,7 @@ quota_reset_interval_ms
 
 The time/size quota charge reset interval in milliseconds.
 
-The charget reset interval for the quota of time (quota_ms) and size
+The charge reset interval for the quota of time (quota_ms) and size
 (quota_sz).  That is, DAMON_RECLAIM does not try reclamation for more than
 quota_ms milliseconds or quota_sz bytes within quota_reset_interval_ms
 milliseconds.
diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
index ec8c34b2d32f3..d98b0eb8e7713 100644
--- a/Documentation/admin-guide/mm/damon/start.rst
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -69,16 +69,16 @@ monitored access pattern of the process from DAMON and shows the pattern in a
 human readable format.
 
 The first line of the output shows the relative access temperature (hotness) of
-the regions in a single row hetmap format.  Each column on the heatmap
+the regions in a single row heatmap format.  Each column on the heatmap
 represents regions of same size on the monitored virtual address space.  The
-position of the colun on the row and the number on the column represents the
+position of the column on the row and the number on the column represents the
 relative location and access temperature of the region.  ``[...]`` means
 unmapped huge regions on the virtual address spaces.  The second line shows
 additional information for better understanding the heatmap.
 
 Each line of the output from the third line shows which virtual address range
 (``addr XX size XX``) of the process is how frequently (``access XX %``)
-accessed for how long time (``age XX``).  For example, the evelenth region of
+accessed for how long time (``age XX``).  For example, the eleventh region of
 ~9.5 MiB size is being most frequently accessed for last 3.7 seconds.  Finally,
 the fourth command stops DAMON.
 
diff --git a/Documentation/admin-guide/mm/damon/stat.rst b/Documentation/admin-guide/mm/damon/stat.rst
index 46c5dd96aa2ed..4a9db755a5265 100644
--- a/Documentation/admin-guide/mm/damon/stat.rst
+++ b/Documentation/admin-guide/mm/damon/stat.rst
@@ -81,7 +81,7 @@ Per-byte idle time (milliseconds) percentiles of the system.
 DAMON_STAT calculates how long each byte of the memory was not accessed until
 now (idle time), based on the current DAMON results snapshot.  For regions
 having access frequency (nr_accesses) larger than zero, how long the current
-access frequency level was kept multiplied by ``-1`` becomes the idlee time of
+access frequency level was kept multiplied by ``-1`` becomes the idle time of
 every byte of the region.  If a region has zero access frequency (nr_accesses),
 how long the region was keeping the zero access frequency (age) becomes the
 idle time of every byte of the region.  Then, DAMON_STAT exposes the
-- 
2.47.3
