Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707276;
	b=nSYQBHDyv+hLO066C4ZLiE4Ooe1VS/aP/SWdMNyj+D5QFsjsNBqAzYgtNNBKodk7lHSy
	 3ptB5C6POg3SHRy+o71hrmS1WTl1VobEppGVasH1cJ5n1elNJcHX/lhC9yljixLL9cRui
	 +7UZM5/WEaB6X9BJpuf/+q1xFlLZsa14rrrTIGGTNGPvpwX+OD4pay7gkRLtORKnSxSkN
	 P1YsbLKcVL9dYTAk+p7cdh3JSz/RZddl7BrIzOJ77W/Lp3XWU9kFC4AIcdmtiDP4QdSe+
	 7V3jaDKuzF1rN+OpKcRTfrquOVTzf+NFVF0Y0pt6sPOV79aHIjLFEhHZbO6CC6Iy1Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707276;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID;
	bh=O9atIHlIh/2xYLtt0bx0cLcke1aRGKizVOlpIySp6oE=;
	b=MK6xgD/zrz7RMKBTy8DkSYNU4m7bYBdBiroot6wslrhvbEH7g3NPOcUS090fIBWaiNSU
	 EkZvuY476C5c5WwehjXKfvhlITBAhTkj/ZusbvdbXuc2XPx8TN9eGgmsT0K9DXKTod4CH
	 fUPfQtf4AtLvFIoYJg+1qM2wBHWKIxxs+hOYEVgVlviD523Gal8iXzgG7IW446ku2jslu
	 4T3TE/sTuNze42KrGuSxebAGFmUhJoqeCPwPbCnmBFG5yIMzRLJuas3MKmjCZuldOb0Ux
	 Aa7BYw6FJ0Vcj2R5Plnj3SbrkI/yZ+gr+ls+nyZli1h9t28ma1y6PJYwIWiBOOXUnAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=oCXj5qzc;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72969606A329
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 12:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72969606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=oCXj5qzc
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jJnGY6bz6zKn9C;
	Tue, 03 Nov 2026 13:01:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793707270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O9atIHlIh/2xYLtt0bx0cLcke1aRGKizVOlpIySp6oE=;
	b=oCXj5qzcbMvjvKJrNYqY/ioBLqSxBa8G++IgdAp07ig/AVYcNGqwEe4Y6mQkXYvgsKOXzJ
	GybBTvDJS6n3WSv17sx/I5Uz8wOH9A8A2IBuUi8sAfhX2zu59xuiMdL82HRoN+Re+92qne
	bjrHB2o1AL8uqVUQACYmtHtwZzP4pLb5Fp0+DBUy31knEtICxt+YnvkXsPoS9Q5ZizX2ee
	ltWAOLhXw5fMVXOWuit38T+sgLCWqxhwE0ej6hVYjJY08Cwv1j6OPct5qPxeiUMItLS0FG
	jhxCfU9CaCApLp3vMlNICA9dp6nymGO8ZJwpHQHRt4aO0WwsUZBG1HOz0vdjMQ==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	Aveline Noir <jm5905938@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Docs/admin-guide/mm/damon/reclaim: improve language
Date: Tue,  3 Nov 2026 13:00:42 +0100
Message-ID: <20261103120043.100887-2-manuelebnerli@mailbox.org>
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
X-MBO-RS-META: gbwzquqe8o7tfnmr3pdwjcxfgqjuyrdj
X-MBO-RS-ID: 2971e257b0a29a79e8f

Fix upper case.  Fix tenses.  Replace 'set as' with 'set to'.  Add space after
sentence to make it double space.  Rewrite and refine complex sentences.

CC: Aveline Noir <jm5905938@gmail.com>
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
That's the final version.

[v3]
 Combine both patches into one
 Incorporate SJ's feedback

[v2]
 https://lore.kernel.org/all/20261027185938.2526259-2-manuelebnerli@mailbox.org/
 Include suggestions from SJ and Aveline
 Split [v1] into
  [1/2 v2] Docs/admin-guide/mm/damon/reclaim: improve grammar and style
  [2/2 v2] Docs/admin-guide/mm/damon/reclaim: rewrite complex parts
 Fixed an upper case and a missing double space -> [1/2 v2]

[v1]
 https://lore.kernel.org/all/20261015080623.808458-2-manuelebnerli@mailbox.org/
---
 .../admin-guide/mm/damon/reclaim.rst          | 43 ++++++++++---------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index e4e2ffa52e..789db7099d 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -4,7 +4,7 @@
 DAMON-based Reclamation
 =======================
 
-DAMON-based Reclamation (DAMON_RECLAIM) is a static kernel module that aimed to
+DAMON-based reclamation (DAMON_RECLAIM) is a static kernel module that aimes to
 be used for proactive and lightweight reclamation under light memory pressure.
 It doesn't aim to replace the LRU-list based page_granularity reclamation, but
 to be selectively used for different level of memory pressure and requirements.
@@ -30,12 +30,13 @@ guests could mitigate this problem.
 How It Works?
 =============
 
-DAMON_RECLAIM finds memory regions that didn't accessed for specific time
-duration and page out.  To avoid it consuming too much CPU for the paging out
-operation, a speed limit can be configured.  Under the speed limit, it pages
-out memory regions that didn't accessed longer time first.  System
-administrators can also configure under what situation this scheme should
-automatically activated and deactivated with three memory pressure watermarks.
+DAMON_RECLAIM finds memory regions that have not been accessed for a
+specified period and attempts to page out those.  To avoid it consuming
+too much CPU for the paging out operation, a speed limit can be configured.
+Within the configured speed limit, it prioritizes regions that have been
+idle longer for reclamation.  System administrators can also configure under
+what situation this scheme should automatically be activated and deactivated
+with three memory pressure watermarks.
 
 Interface: Module Parameters
 ============================
@@ -55,10 +56,10 @@ enabled
 
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
@@ -66,9 +67,9 @@ commit_inputs
 Make DAMON_RECLAIM reads the input parameters again, except ``enabled``.
 
 Input parameters that updated while DAMON_RECLAIM is running are not applied
-by default.  Once this parameter is set as ``Y``, DAMON_RECLAIM reads values
+by default.  Once this parameter is set to ``Y``, DAMON_RECLAIM reads values
 of parameters except ``enabled`` again.  Once the re-reading is done, this
-parameter is set as ``N``.  If invalid parameters are found while the
+parameter is set to ``N``.  If invalid parameters are found while the
 re-reading, DAMON_RECLAIM will be disabled.
 
 Once ``Y`` is written to this parameter, the user must not write to any
@@ -88,7 +89,7 @@ identifies the region as cold, and reclaims it.
 autotune_monitoring_intervals
 -----------------------------
 
-If this parameter is set as ``Y``, DAMON_RECLAIM automatically tunes DAMON's
+If this parameter is set to ``Y``, DAMON_RECLAIM automatically tunes DAMON's
 sampling and aggregation intervals.  The auto-tuning aims to capture meaningful
 amount of access events in each DAMON-snapshot, while keeping the sampling
 interval 5 milliseconds in minimum, and 10 seconds in maximum.  Setting this as
@@ -113,10 +114,10 @@ quota_sz
 
 Limit of size of memory for the reclamation in bytes.
 
-DAMON_RECLAIM charges amount of memory which it tried to reclaim within a time
-window (quota_reset_interval_ms) and makes no more than this limit is tried.
-This can be used for limiting consumption of CPU and IO.  If this value is
-zero, the limit is disabled.
+DAMON_RECLAIM charges the amount of memory which it tried to reclaim within a time
+window (quota_reset_interval_ms) and stops trying to reclaim memory when this limit
+is reached.  This can be used for limiting consumption of CPU and IO.  If this value
+is zero, the limit is disabled.
 
 128 MiB by default.
 
@@ -137,7 +138,7 @@ quota_mem_pressure_us
 
 Desired level of memory pressure-stall time in microseconds.
 
-While keeping the caps that set by other quotas, DAMON_RECLAIM automatically
+While keeping the caps that are set by other quotas, DAMON_RECLAIM automatically
 increases and decreases the effective level of the quota aiming this level of
 memory pressure is incurred.  System-wide ``some`` memory PSI in microseconds
 per quota reset interval (``quota_reset_interval_ms``) is collected and
@@ -219,7 +220,7 @@ monitoring.  This can be used to set lower-bound of the monitoring quality.
 But, setting this too high could result in increased monitoring overhead.
 Please refer to the DAMON documentation (:doc:`usage`) for more detail.
 
-Note that this must be 3 or higher. Please refer to the :ref:`Monitoring
+Note that this must be 3 or higher.  Please refer to the :ref:`Monitoring
 <damon_design_monitoring>` section of the design document for the rationale
 behind this lower bound.
 
@@ -263,7 +264,7 @@ This parameter is for setting and getting the :ref:`address unit
 
 ``monitor_region_start`` and ``monitor_region_end`` should be provided in this
 unit.  For example, let's suppose ``addr_unit``, ``monitor_region_start`` and
-``monitor_region_end`` are set as ``1024``, ``0`` and ``10``, respectively.
+``monitor_region_end`` are set to ``1024``, ``0`` and ``10``, respectively.
 Then DAMON_RECLAIM will work for 10 KiB length of physical address range that
 starts from address zero (``[0 * 1024, 10 * 1024)`` in bytes).
 
@@ -280,7 +281,7 @@ skip_anon
 
 Skip anonymous pages reclamation.
 
-If this parameter is set as ``Y``, DAMON_RECLAIM does not reclaim anonymous
+If this parameter is set to ``Y``, DAMON_RECLAIM does not reclaim anonymous
 pages.  By default, ``N``.
 
 
-- 
2.55.0

