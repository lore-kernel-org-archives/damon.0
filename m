Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824250;
	b=RGYc1zTFvs6jhq+mnZd6F1ihRE15gRhCu8xT+D4371XxTMC9uA7G8fc/xyWyI0LHxYf8
	 sMzMke0ULUcWylSQ3KfsP8MhCcBKEWSRZ19mU+d5qa2OxxKB+d87dgF32FxWyv2Xpj2fX
	 rwO8i+FzVSScAvO+/L20oUTn/pCvLzz+1QkMeuH/8Jfk/fpLMsnrs4Dl6c85LedscX0XT
	 nk+0jdUc8X1o723zREl3iDH5kysy4Aq/pqmVNoU8+ShN9etxDgJUIqJnnoV0Lv/p0V3sz
	 yuOk+7Su5fYN1/DuNsGskx9bLfJ2eiibJ2+xYpTB8oPNuUrbNRFKqauo47FTFi4FVFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824250;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META;
	bh=JIMiU9y0vbuCD/B9Q5lvFFGjmQ5GlwLyj7wmrnkHlyg=;
	b=4sMdM7IRFdF2gERtef2VwCG4vIeG7xGNElSVMOnPGDhdsuS72ryEkQzF7bc5frKqr5Nn
	 mxUBK90QFdD605rMSOj+mAVWkgn9sO+E0f7AX5wdifpqTs5OKGo3D/dXLCUI9ieqWJYes
	 e3CXCF07tnBiFBrTQYrqOd4XnSAO4W06rWGF8Y2RE7Kykfp/0ZN2KG0uuxef9RMEKpwgn
	 DuiJvL5rAtgfpfQa1xZAmhdoz++I3RZcEftvn4LvK4YP5QUSdmnqc9oaGZ3ZCyZvkB4Vs
	 aOIFH0UcEGY3A39SjKWoeOOgMMaHAltIsoA00M8AuehJ6AJDWfMLTl0hyBUuORCt2Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=B2jez2gn;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC18606A84F
	for <damon@lists.linux.dev>; Wed,  4 Nov 2026 20:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BC18606A84F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=B2jez2gn
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jKcX50jDBzMlCp;
	Wed, 04 Nov 2026 21:30:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793824245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JIMiU9y0vbuCD/B9Q5lvFFGjmQ5GlwLyj7wmrnkHlyg=;
	b=B2jez2gnt5yTgJFBiUcy3vBZd4MMeVLOjZ1E+S0wNg18H1AxJ9ZNSzbcaNEKjgXwITvTho
	s82bYij3bzAz6GSJtqSYYZXXxu8DoB8zDo6Mgiv00t3tupNFo9UX31hBjUyhVKway+P4yn
	0utTnn5NiRMNI+Ua+WuaOhKojsK+odEB0DMvUyeqdap7AkQaB1I3Ud1N+UgPpVkPTdH+Hh
	tP2zgupLJciwpgyUGSpe5+X+2bcXHEpIbIvMpc6i8+agi01uDUAn+TWM++R26ubWJwcCHB
	4YNQ8UVRLnPOniFkG1efNIqO2yCzMP3zLtu9UY4a0b3em/LYvz8gIop5PegiAw==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	Daniel Pereira <danielmaraboo@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] Docs/admin-guide/mm/damon/lru_sort: fix grammar and style
Date: Wed,  4 Nov 2026 21:29:58 +0100
Message-ID: <20261104202959.128646-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.55.0
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
X-MBO-RS-ID: 8310e9f3ba41376803e
X-MBO-RS-META: q14mur6h1s4sx8s85bqojgytr34moh6g

Fix tenses. Split long sentences thereby improve readability.  Replace
'set as' with 'set to'. Replace [] with () to make the file uniform.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
Reviewed-by: SJ Park <sj@kernel.org>
CC: Daniel Pereira <danielmaraboo@gmail.com>
---
Daniel thanks for the Feedback.
SJ, could you please reapply this patch, if you think it's worth it.
Thanks
 Manuel

[v4]
 Fixed issues pointed out by Daniel Pereira
  typos in subject, log message and diff
  https://lore.kernel.org/all/CAMAsx6epLXuUjaV3J0=SWAuLvajr4h58DTM9gL+LMmaCyjcxUg@mail.gmail.com/
 trusworthy -> trustworthy
  I think this is in another patch.

[v3]
 https://lore.kernel.org/all/20261017083535.1261388-2-manuelebnerli@mailbox.org/
 Split long line
 Fix path in subject / One-line summary

[v2]
 https://lore.kernel.org/20261015072947.802821-2-manuelebnerli@mailbox.org
 Collect R-b: from SJ.

[v1]
 https://lore.kernel.org/20261013191327.663331-2-manuelebnerli@mailbox.org
 Wordsmith commit message.
 Fixup a few trivial wording.
---
 .../admin-guide/mm/damon/lru_sort.rst         | 63 +++++++++----------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index b93ca9b085..90a6cff893 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -5,20 +5,19 @@ DAMON-based LRU-lists Sorting
 =============================
 
 DAMON-based LRU-lists Sorting (DAMON_LRU_SORT) is a static kernel module that
-aimed to be used for proactive and lightweight data access pattern based
+aims to be used for proactive and lightweight data access pattern based
 (de)prioritization of pages on their LRU-lists for making LRU-lists a more
-trusworthy data access pattern source.
+trustworthy data access pattern source.
 
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
+include reclamation target page selection under sudden memory pressure.
 
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

