Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411623CCA02
	for <damon@lists.linux.dev>; Sat, 17 Oct 2026 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792226205; cv=none; b=PpAXkcWwWeDc3zsqdNAHGLXi/EJNCLxKSFmLbHwSeFxP+eyd05BLFsXiQXks/d4KwtGKwz5dYGl2q7NbzTZKiaIUCoW3MjX1Fc6bZbClEx1yU78WLPcP6RTBNdDlxw8Ga2Njv/wHyaMJ91Wmcm0MRyVDAt7RRB0fRgCALAdENU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792226205; c=relaxed/simple;
	bh=6SeJ4Hl24zyy4exhjtnlHcNJJiQVuN0BNii3iL9g0qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iHJH1KkbkaX7cy/X+Vv/fDBkm3HDuYczA+vQcYN5/ftCCvLLA8zKDDoe8W5ciNZEp/9xeTJOvO9+V3bSla4WSmkvSsQ7sOSzyDbEToM+cHe86vP2Euk1t6MHistkDnH+MJkehpVbhk3u9URUzUxM6cFghCB26yHzZKaECxOr29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Dc2HkLmZ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Dc2HkLmZ"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4j6FXQ0pgcz8t2h;
	Sat, 17 Oct 2026 10:36:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792226198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=daD3WZTzmfa4KXrJR0YhoGudN1Nbz0tk7iqpRXDolW0=;
	b=Dc2HkLmZUEX3jqyRHuvtVm5AB1f9xOguV/lBqT3hQMxeFhxoUQjObGYfhcBFI96gpaaq3I
	dpCv26hfqDcV14U/hRPNyIlUaOiLRMv1EBnMWhHDnVZqZJJ25TRQStQXeQQcUUvlZiW4or
	TxMnv21HtuoGkcBnLmCp4wP1zkrPlKvsDRKfkNZjuaCtZUl1wrFlg7TnLI6Tm6t1LGyd5J
	eAns+A86qi+NyaPvsx+CowrB/CWsQjD3ZjwXm9+mSsuk7VPq2P0IFPG1KJfRZ/VbupYuu/
	/KVSL0wZlhI674swou5UZPy/dHLjbV31mZuGmXMjkj3fnzERX7dMnjwg8W/4PA==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Docs/admin-guide/mm/damon/lru_sort: fix grammar and stlye
Date: Sat, 17 Oct 2026 10:35:34 +0200
Message-ID: <20261017083535.1261388-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5d8c7knged71kbud9uke1omjmz5jwanr
X-MBO-RS-ID: 1717f57581f65708ba3

Fix tenses. Split long sentences thereby imporove readability.  Replace
'set as' with 'set to'. Replace [] with () to make the file uniform.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
Reviewed-by: SJ Park <sj@kernel.org>
---
SJ, could you please replace 38b3709936fa ([v2] 'mm/damon/lru_sort: fix
grammar and stlye') with this patch? I messed up the path in the subject line.
Thanks
 Manuel

[v3]
 Split long line
 Fix path in subject / One-line summary

[v2]
 https://lore.kernel.org/20261015072947.802821-2-manuelebnerli@mailbox.org
 Collect R-b: from SJ.

[v1]
 https://lore.kernel.org/20261013191327.663331-2-manuelebnerli@mailbox.org
 Wordsmith commit message.
 Fixup a few trivial wording.


 .../admin-guide/mm/damon/lru_sort.rst         | 61 +++++++++----------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 0c04d238ed..aa4cc90ca5 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -5,20 +5,19 @@ DAMON-based LRU-lists Sorting
 =============================
 
 DAMON-based LRU-lists Sorting (DAMON_LRU_SORT) is a static kernel module that
-aimed to be used for proactive and lightweight data access pattern based
+aims to be used for proactive and lightweight data access pattern based
 (de)prioritization of pages on their LRU-lists for making LRU-lists a more
 trustworthy data access pattern source.
 
 Where Proactive LRU-lists Sorting is Required?
 ==============================================
 
-As page-granularity access checking overhead could be significant on huge
-systems, LRU lists are normally not proactively sorted but partially and
-reactively sorted for special events including specific user requests, system
-calls and memory pressure.  As a result, LRU lists are sometimes not so
-perfectly prepared to be used as a trustworthy access pattern source for some
-situations including reclamation target pages selection under sudden memory
-pressure.
+As page-granularity access checking overhead could be significant on huge systems,
+LRU lists are normally not fully nor proactively sorted but rather partially
+and reactively sorted for special events.  These events include specific user requests,
+system calls and memory pressure.  As a result, LRU lists are sometimes not
+suitable to be used as a trustworthy access pattern source.  These situations
+including reclamation target page selection under sudden memory pressure.
 
 Because DAMON can identify access patterns of best-effort accuracy while
 inducing only user-specified range of overhead, proactively running
@@ -28,9 +27,9 @@ pattern source with low and controlled overhead.
 How It Works?
 =============
 
-DAMON_LRU_SORT finds hot pages (pages of memory regions that showing access
-rates that higher than a user-specified threshold) and cold pages (pages of
-memory regions that showing no access for a time that longer than a
+DAMON_LRU_SORT finds hot pages (pages of memory regions that show access
+rates that are higher than a user-specified threshold) and cold pages (pages of
+memory regions that show no access for a duration that is longer than a
 user-specified threshold) using DAMON, and prioritizes hot pages while
 deprioritizing cold pages on their LRU-lists.  To avoid it consuming too much
 CPU for the prioritizations, a CPU time usage limit can be configured.  Under
@@ -63,10 +62,10 @@ enabled
 
 Enable or disable DAMON_LRU_SORT.
 
-You can enable DAMON_LRU_SORT by setting the value of this parameter as ``Y``.
-Setting it as ``N`` disables DAMON_LRU_SORT.  Note that DAMON_LRU_SORT could do
+You can enable DAMON_LRU_SORT by setting the value of this parameter to ``Y``.
+Setting it to ``N`` disables DAMON_LRU_SORT.  Note that DAMON_LRU_SORT could do
 no real monitoring and LRU-lists sorting due to the watermarks-based activation
-condition.  Refer to below descriptions for the watermarks parameter for this.
+condition.  Refer to below descriptions of the watermarks parameter for this.
 
 commit_inputs
 -------------
@@ -74,9 +73,9 @@ commit_inputs
 Make DAMON_LRU_SORT reads the input parameters again, except ``enabled``.
 
 Input parameters that updated while DAMON_LRU_SORT is running are not applied
-by default.  Once this parameter is set as ``Y``, DAMON_LRU_SORT reads values
+by default.  Once this parameter is set to ``Y``, DAMON_LRU_SORT reads values
 of parameters except ``enabled`` again.  Once the re-reading is done, this
-parameter is set as ``N``.  If invalid parameters are found while the
+parameter is set to ``N``.  If invalid parameters are found while the
 re-reading, DAMON_LRU_SORT will be disabled.
 
 Once ``Y`` is written to this parameter, the user must not write to any
@@ -86,37 +85,37 @@ violate this rule, the kernel may exhibit undefined behavior.
 active_mem_bp
 -------------
 
-Desired active to [in]active memory ratio in bp (1/10,000).
+Desired active to (in)active memory ratio in bp (1/10,000).
 
 While keeping the caps that set by other quotas, DAMON_LRU_SORT automatically
 increases and decreases the effective level of the quota aiming the LRU
-[de]prioritizations of the hot and cold memory resulting in this active to
-[in]active memory ratio.  Value zero means disabling this auto-tuning feature.
+(de)prioritizations of the hot and cold memory resulting in this active to
+(in)active memory ratio.  Value zero means disabling this auto-tuning feature.
 
 Disabled by default.
 
 autotune_monitoring_intervals
 -----------------------------
 
-If this parameter is set as ``Y``, DAMON_LRU_SORT automatically tunes DAMON's
+If this parameter is set to ``Y``, DAMON_LRU_SORT automatically tunes DAMON's
 sampling and aggregation intervals.  The auto-tuning aims to capture meaningful
 amount of access events in each DAMON-snapshot, while keeping the sampling
-interval 5 milliseconds in minimum, and 10 seconds in maximum.  Setting this as
-``N`` disables the auto-tuning.
+interval to 5 milliseconds in minimum, and to 10 seconds in maximum.  Setting this
+to ``N`` disables the auto-tuning.
 
 Disabled by default.
 
 filter_young_pages
 ------------------
 
-Filter [non-]young pages accordingly for LRU [de]prioritizations.
+Filter (non-)young pages accordingly for LRU (de)prioritizations.
 
 If this is set, check page level access (youngness) once again before each
-LRU [de]prioritization operation.  LRU prioritization operation is skipped
+LRU (de)prioritization operation.  LRU prioritization operation is skipped
 if the page has not accessed since the last check (not young).  LRU
 deprioritization operation is skipped if the page has accessed since the
 last check (young).  The feature is enabled or disabled if this parameter is
-set as ``Y`` or ``N``, respectively.
+set to ``Y`` or ``N``, respectively.
 
 Disabled by default.
 
@@ -235,7 +234,7 @@ max_nr_regions
 Maximum number of monitoring regions.
 
 The maximum number of monitoring regions of DAMON for the cold memory
-monitoring.  This can be used to set upper-bound of the monitoring overhead.
+monitoring.  This can be used to set the upper-bound of the monitoring overhead.
 However, setting this too low could result in bad monitoring quality.  Please
 refer to the DAMON documentation (:doc:`usage`) for more detail.  1000 by
 defaults.
@@ -268,7 +267,7 @@ This parameter is for setting and getting the :ref:`address unit
 
 ``monitor_region_start`` and ``monitor_region_end`` should be provided in this
 unit.  For example, let's suppose ``addr_unit``, ``monitor_region_start`` and
-``monitor_region_end`` are set as ``1024``, ``0`` and ``10``, respectively.
+``monitor_region_end`` are set to ``1024``, ``0`` and ``10``, respectively.
 Then DAMON_LRU_SORT will work for 10 KiB length of physical address range that
 starts from address zero (``[0 * 1024, 10 * 1024)`` in bytes).
 
@@ -291,22 +290,22 @@ If DAMON_LRU_SORT is enabled, this becomes the PID of the worker thread.  Else,
 nr_lru_sort_tried_hot_regions
 -----------------------------
 
-Number of hot memory regions that tried to be LRU-sorted.
+Number of hot memory regions that were tried to be LRU-sorted.
 
 bytes_lru_sort_tried_hot_regions
 --------------------------------
 
-Total bytes of hot memory regions that tried to be LRU-sorted.
+Total bytes of hot memory regions that were tried to be LRU-sorted.
 
 nr_lru_sorted_hot_regions
 -------------------------
 
-Number of hot memory regions that successfully be LRU-sorted.
+Number of hot memory regions that were successfully LRU-sorted.
 
 bytes_lru_sorted_hot_regions
 ----------------------------
 
-Total bytes of hot memory regions that successfully be LRU-sorted.
+Total bytes of hot memory regions that were successfully LRU-sorted.
 
 nr_hot_quota_exceeds
 --------------------
-- 
2.55.0

