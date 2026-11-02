Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632089;
	b=Sk2HMFFTMDCa8eDnLpWo6rt2/KvQ80kgjFgRpZ8mO6W2n0icEzDGMcH7JDeEKyVRtstJ
	 iCHkUdKLq9erxEfxdCnabo7YWU4XrcdXFThAZRDGk+bMdqWWL54SPpTKoDrbPUHwTH5xb
	 +HEvsiZSRdEWCUlrpdgmAyPWvJpEfHRuI1SdZt3JlagnxzGyv0xuSG9i9VYpP7ztB9aod
	 1U3UF3BLgcy+wUDLEKQll/5P5fR+xTKSJTCfk8bAf5xQWWCARKaGK8ta+mTza0nBW2Y4+
	 E0Kk2P84OLvaoCF6ST07BzgXovnhHFUmjcBJzAhBDDYv6/Ri+e/bOfPODEc+Sm+jITQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632089;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kvp3OkVy+SszLWIFkSYWY+dzg8k2mauBxngEG2KoUsA=;
	b=4PCxK387B7MIssddeiXCJQIV8/8C3saylXA++B3W4zdsfw/ebjkyJUFMCEh/6p+XlCKD
	 3+caBHm4y4tMsgIM+snTnr2x0QEVQTjgk7VuUeSTLtog5eBSKdzG//BCCGmqeEE9lHqjI
	 FEaheAOGHcF8ey0unP5ww00ysFzzm6zQ+9dKVafHeD3mbdD/fxoLVTtlDGSyAA5KbaNNl
	 61SoND5aXUVO/hoW1tT5JCBrNVDq4F25JOQntiBicDlcGopKnSpWPn6C4v+azBVk+LliE
	 vZBuKfKx6uQW1B+JmsSlPJA4ueTCbiLKeLAh7MAH57DVS4U/HRZkXBPLtFICydFFLvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oyLAaRP3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18C060A1DA0;
	Mon,  2 Nov 2026 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oyLAaRP3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A1B1F00A1B;
	Mon,  2 Nov 2026 15:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632088;
	bh=kvp3OkVy+SszLWIFkSYWY+dzg8k2mauBxngEG2KoUsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oyLAaRP3btENumHrPX+z5xEXxdOZy/pbIuW1M7gRdMClADSjHftUTdFQVTHd6hMzx
	 lQruDhXPqS6HtZoJ/AS++mGj2vX2HHiTS8EN3GusMgiLvdXCe2LyDNg9yFWNyWW/q2
	 QKfAA/X2jroapwUQKX9br3DZHeICSCAIdW1KhIyYGSzj38xPmT5tpZtf0IE3biQ/Zm
	 8/2Z93d1VpMCbaYgjWh3xQacoJ7PIe8uozlQmxvjzE+E+lmG8E1xzyH+7mCkbM+u3C
	 b0ywrUC+hmI8O7NnKmTL6WyRTJ0Yup5MbVyzkIU/3yF0LueXd9oWJAZnL09UKztDh+
	 cHpyUwtYwcsAA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 8/9] Docs/admin-guide/mm/damon/lru_sort: fix grammar and stlye
Date: Mon,  2 Nov 2026 07:07:55 -0800
Message-ID: <20261102150757.93058-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102150757.93058-1-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
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

From: Manuel Ebner <manuelebnerli@mailbox.org>

Fix tenses. Split long sentences thereby imporove readability.  Replace
'set as' with 'set to'. Replace [] with () to make the file uniform.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v3
- v3: https://lore.kernel.org/20261017083535.1261388-2-manuelebnerli@mailbox.org
- Rebase to latest mm-new.

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
index b93ca9b0853d2..f1eeb6389c377 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -5,20 +5,19 @@ DAMON-based LRU-lists Sorting
 =============================
 
 DAMON-based LRU-lists Sorting (DAMON_LRU_SORT) is a static kernel module that
-aimed to be used for proactive and lightweight data access pattern based
+aims to be used for proactive and lightweight data access pattern based
 (de)prioritization of pages on their LRU-lists for making LRU-lists a more
 trusworthy data access pattern source.
 
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
2.47.3
