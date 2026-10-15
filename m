Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130F1499F00
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051824; cv=none; b=QCrSA5cpGEAi1k+zqCsoh6x+YtZyZ/eJ1Xgp8avTOOPDQQkWvtf51DltltdE/xkwPoCsllHklsaMPO4SVzYZYpp4mLfbmuRMpySk2CqV2m1xZOANV8+3t74FrAJ60xEKW8TNnz9P6fPAXMlahjDVW7GPXTNLj04oymYABbO4Ugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051824; c=relaxed/simple;
	bh=6H3gwsJhntJXJThwDhnaQMwt5chRY+N2oVYDT+NOxFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZcmqYKz270AiMeQKCETb/RgjB/PfevYJQeiy3pXitnVnFG0VZJoVWUGGmEyzDRo/l9aI4SAatnqaKcK/TP31dPuFeAbyGoWPMj97nmi0WeFMqH3bBTbB+xC+iHW6bGClhDfoAPB80E4FOuslTB4t7qZva/4vmdp0tG9CmRBxUmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OIib8AXI; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OIib8AXI"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j512y0XQszMldw;
	Thu, 15 Oct 2026 10:10:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792051818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rGIxBYcjL8R8PIe1O4VWCK/MKqmva9CjteD/loE46rs=;
	b=OIib8AXI33k88tPlZC4f3msQCy8sLnN/bj07SVtZH5FsvqcXvE+GFqzEXdYIwCsxivsOsn
	19fAdPF4EsOm9iriFR79E/VUpFeWYF1xA7MqALjHfhz60bpGVELBxItb89JRda1lFJ/h0I
	UngNBU75vd5iFgNMaXykL1sAKfi1PgLFdJ0K+VevQifMZc99Ge3B74t/dnHcNAbLCvE2OY
	x+SY0rLyDKI3U0isJC4wB9Ouj73exn7d/yuT5TLth9RVWZWvve0/LxIrduEpOgM8YX2SXp
	n3azhQxbXEmniiRaE7ElUwSkCiseXubvbWriTi2GxI5EAD4gUw3xwUc224VWhA==
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
Subject: [PATCH] mm/damon/reclaim: improve grammar and style
Date: Thu, 15 Oct 2026 10:06:23 +0200
Message-ID: <20261015080623.808458-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: c6aoxm8ipxdy74wo7dcayh8ap6qwsbmx
X-MBO-RS-ID: 19c5c96c5337cf8f5bf

Fix tenses. Replace 'set as' with 'set to'.
Rewrite complex sentences.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
@@ -113,8 +113,8 and
@@ -125,19 +125,19
This sentence was difficult to read for me. I don't know if I
improved it. Please advice.
---
 .../admin-guide/mm/damon/reclaim.rst          | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index e4e2ffa52e..d521563633 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -4,7 +4,7 @@
 DAMON-based Reclamation
 =======================
 
-DAMON-based Reclamation (DAMON_RECLAIM) is a static kernel module that aimed to
+DAMON-based Reclamation (DAMON_RECLAIM) is a static kernel module that aims to
 be used for proactive and lightweight reclamation under light memory pressure.
 It doesn't aim to replace the LRU-list based page_granularity reclamation, but
 to be selectively used for different level of memory pressure and requirements.
@@ -30,12 +30,12 @@ guests could mitigate this problem.
 How It Works?
 =============
 
-DAMON_RECLAIM finds memory regions that didn't accessed for specific time
+DAMON_RECLAIM finds memory regions that weren't accessed for specific time
 duration and page out.  To avoid it consuming too much CPU for the paging out
 operation, a speed limit can be configured.  Under the speed limit, it pages
-out memory regions that didn't accessed longer time first.  System
+out memory regions that weren't accessed longer time first.  System
 administrators can also configure under what situation this scheme should
-automatically activated and deactivated with three memory pressure watermarks.
+automatically be activated and deactivated with three memory pressure watermarks.
 
 Interface: Module Parameters
 ============================
@@ -55,10 +55,10 @@ enabled
 
 Enable or disable DAMON_RECLAIM.
 
-You can enable DAMON_RECLAIM by setting the value of this parameter as ``Y``.
-Setting it as ``N`` disables DAMON_RECLAIM.  Note that DAMON_RECLAIM could do
+You can enable DAMON_RECLAIM by setting the value of this parameter to ``Y``.
+Setting it to ``N`` disables DAMON_RECLAIM.  Note that DAMON_RECLAIM could do
 no real monitoring and reclamation due to the watermarks-based activation
-condition.  Refer to below descriptions for the watermarks parameter for this.
+condition.  Refer to below descriptions of the watermarks parameter for this.
 
 commit_inputs
 -------------
@@ -66,9 +66,9 @@ commit_inputs
 Make DAMON_RECLAIM reads the input parameters again, except ``enabled``.
 
 Input parameters that updated while DAMON_RECLAIM is running are not applied
-by default.  Once this parameter is set as ``Y``, DAMON_RECLAIM reads values
+by default.  Once this parameter is set to ``Y``, DAMON_RECLAIM reads values
 of parameters except ``enabled`` again.  Once the re-reading is done, this
-parameter is set as ``N``.  If invalid parameters are found while the
+parameter is set to ``N``.  If invalid parameters are found while the
 re-reading, DAMON_RECLAIM will be disabled.
 
 Once ``Y`` is written to this parameter, the user must not write to any
@@ -88,11 +88,11 @@ identifies the region as cold, and reclaims it.
 autotune_monitoring_intervals
 -----------------------------
 
-If this parameter is set as ``Y``, DAMON_RECLAIM automatically tunes DAMON's
+If this parameter is set to ``Y``, DAMON_RECLAIM automatically tunes DAMON's
 sampling and aggregation intervals.  The auto-tuning aims to capture meaningful
 amount of access events in each DAMON-snapshot, while keeping the sampling
-interval 5 milliseconds in minimum, and 10 seconds in maximum.  Setting this as
-``N`` disables the auto-tuning.
+interval to 5 milliseconds in minimum, and to 10 seconds in maximum.  Setting this
+to ``N`` disables the auto-tuning.
 
 Disabled by default.
 
@@ -113,8 +113,8 @@ quota_sz
 
 Limit of size of memory for the reclamation in bytes.
 
-DAMON_RECLAIM charges amount of memory which it tried to reclaim within a time
-window (quota_reset_interval_ms) and makes no more than this limit is tried.
+DAMON_RECLAIM recordes the amount of memory which it tried to reclaim within a time
+window (quota_reset_interval_ms) and stops when this memory limit is reached.
 This can be used for limiting consumption of CPU and IO.  If this value is
 zero, the limit is disabled.
 
@@ -125,19 +125,19 @@ quota_reset_interval_ms
 
 The time/size quota charge reset interval in milliseconds.
 
-The charge reset interval for the quota of time (quota_ms) and size
-(quota_sz).  That is, DAMON_RECLAIM does not try reclamation for more than
+The quota reset interval of time is quota_ms and of size is
+quota_sz.  That is, DAMON_RECLAIM does not try reclamation for more than
 quota_ms milliseconds or quota_sz bytes within quota_reset_interval_ms
 milliseconds.
 
-1 second by default.
+1000 (1 second) by default.
 
 quota_mem_pressure_us
 ---------------------
 
 Desired level of memory pressure-stall time in microseconds.
 
-While keeping the caps that set by other quotas, DAMON_RECLAIM automatically
+While keeping the caps set by other quotas, DAMON_RECLAIM automatically
 increases and decreases the effective level of the quota aiming this level of
 memory pressure is incurred.  System-wide ``some`` memory PSI in microseconds
 per quota reset interval (``quota_reset_interval_ms``) is collected and
@@ -263,7 +263,7 @@ This parameter is for setting and getting the :ref:`address unit
 
 ``monitor_region_start`` and ``monitor_region_end`` should be provided in this
 unit.  For example, let's suppose ``addr_unit``, ``monitor_region_start`` and
-``monitor_region_end`` are set as ``1024``, ``0`` and ``10``, respectively.
+``monitor_region_end`` are set to ``1024``, ``0`` and ``10``, respectively.
 Then DAMON_RECLAIM will work for 10 KiB length of physical address range that
 starts from address zero (``[0 * 1024, 10 * 1024)`` in bytes).
 
@@ -280,7 +280,7 @@ skip_anon
 
 Skip anonymous pages reclamation.
 
-If this parameter is set as ``Y``, DAMON_RECLAIM does not reclaim anonymous
+If this parameter is set to ``Y``, DAMON_RECLAIM does not reclaim anonymous
 pages.  By default, ``N``.
 
 
-- 
2.55.0

