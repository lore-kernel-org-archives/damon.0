Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127984;
	b=K1ovnJbAukX6vugyvAc6D+kNfvhyJ6rqdbdp97Aaida1uORGJHquyQmnsNmUuefqnq/W
	 du21GkPDrnSPKJCyCS0rG1KwW8eFPybKixe5zQHRtm570nkGPQAXSU5ClwBFJr8Mj8KaU
	 83V5sCQEgvC7fgxesay1FtvTgo8n6qqKDkzVqiO+2wiZ3YXWurMa7FqvG1hSCjfYTC8f8
	 JTh+CvrllQCWO/yw2kQHABuFPmvHt8K0HISvJblsiChCLfntQ06mtWkjj2yMYqLrFR82Z
	 fFadB+QwrVXtrQ/Q3TSxFVNxcV5W5eRKfS0plg+gD4cEqzvW+gM4LC9V6kVQjPW+g2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127984;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=fZwZGLOAfWKshH85BY6sKy8NaWebSZHsenr7NBQaqf0=;
	b=423bPmLIMKyIYZXwuU62GONaqu4mzW3av9RpX0RJfpttHNiLlb0fMutClA+QhJId9/1K
	 ohTaJj6Do/8e1hhuG6MsJkbXNiejnewlp7/moHI6Gmy+UGoGpthYi9xKMXAOpwm1PRdZh
	 EUD4KmnZOJAiJN0ZKFCDhVDaqoMBZPIC2gOYzDsNrOv3vFxvI5V2VM5HAq/gYqcV9tEhI
	 cUemTDkosRt4XEc4Hg2Gdtty35Xk2Sv2QhJYYcOxEa/QZEVDEEHuqTepebAgrr6MBylSe
	 BoE06NZC/FAG36HxbWkcZlGCvdSWP+1xzzQz+L6jLhJ2eqsNFyyqDW+RjaP8KDFEouw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=bqze+vGG;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF50606A31D
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 19:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AF50606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=bqze+vGG
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jDg2H0ql4zMlf8;
	Tue, 27 Oct 2026 20:06:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793127975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fZwZGLOAfWKshH85BY6sKy8NaWebSZHsenr7NBQaqf0=;
	b=bqze+vGGK3axguN3/po0M9kmYe8rux/EInQM7fauloKRr5ZKX65reg84flboGYO8812Hhp
	cpNY/v/ClsI0FBVpOfq9/4CSypLFZp8Fj7gowwGZwWxOBL87o+vRnSMZxBbaqpKGXyyZF0
	X5CpkZQCot5jAZlQgZpVn8IG73DmvcbL6i5uYqzMSHSBBRCxftsp7DLRYV76GZeYJwbHPB
	TaLi9KjDHAqOvpH7ALx5zLliDq18M+zgGEkGa2sToL0pdcIKXRUmb1qKGDFOV7WRWkj6eQ
	na0oYgj5+uEsXug2/QLBb+9hMDYmzuxC/hFzLYyj+63SwXBsh2bMVxBbBJ4Mhw==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: manuelebnerli@mailbox.org
Cc: corbet@lwn.net,
	damon@lists.linux.dev,
	jm5905938@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rdunlap@infradead.org,
	sj@kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2 1/2] Docs/admin-guide/mm/damon/reclaim: improve grammar and style
Date: Tue, 27 Oct 2026 20:05:04 +0100
Message-ID: <20261027190503.2526945-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027185938.2526259-2-manuelebnerli@mailbox.org>
References: <20261027185938.2526259-2-manuelebnerli@mailbox.org>
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
X-MBO-RS-META: xr4xmu89uyguo4usstrpc7595nkkf8po
X-MBO-RS-ID: aeb77b1cf244b61b05d

Fix upper case. Fix tenses. Replace 'set as' with 'set to'. Add space after
sentence to make it double space.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
CC: Aveline Noir <jm5905938@gmail.com>
---
@ -113,8 +113,8
Choose as you wish.

@ 20
should be:
-Free Pages Reporting [3]_ based
+Free pages reporting [3]_ based
or
+'*Free Pages Reporting'* [3]_ based
* the right kind of quoting/ kernel-doc highlighting.
Choose as you wish.
---
 .../admin-guide/mm/damon/reclaim.rst          | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index e4e2ffa52e..0bab2299ea 100644
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
@@ -88,7 +88,7 @@ identifies the region as cold, and reclaims it.
 autotune_monitoring_intervals
 -----------------------------
 
-If this parameter is set as ``Y``, DAMON_RECLAIM automatically tunes DAMON's
+If this parameter is set to ``Y``, DAMON_RECLAIM automatically tunes DAMON's
 sampling and aggregation intervals.  The auto-tuning aims to capture meaningful
 amount of access events in each DAMON-snapshot, while keeping the sampling
 interval 5 milliseconds in minimum, and 10 seconds in maximum.  Setting this as
@@ -113,10 +113,10 @@ quota_sz
 
 Limit of size of memory for the reclamation in bytes.
 
-DAMON_RECLAIM charges amount of memory which it tried to reclaim within a time
-window (quota_reset_interval_ms) and makes no more than this limit is tried.
-This can be used for limiting consumption of CPU and IO.  If this value is
-zero, the limit is disabled.
+DAMON_RECLAIM records the amount of memory which it tried to reclaim within a time
+window (quota_reset_interval_ms) and stops trying to reclaim memory when this limit
+is reached.  This can be used for limiting consumption of CPU and IO.  If this value
+is zero, the limit is disabled.
 
 128 MiB by default.
 
@@ -137,7 +137,7 @@ quota_mem_pressure_us
 
 Desired level of memory pressure-stall time in microseconds.
 
-While keeping the caps that set by other quotas, DAMON_RECLAIM automatically
+While keeping the caps that are set by other quotas, DAMON_RECLAIM automatically
 increases and decreases the effective level of the quota aiming this level of
 memory pressure is incurred.  System-wide ``some`` memory PSI in microseconds
 per quota reset interval (``quota_reset_interval_ms``) is collected and
@@ -219,7 +219,7 @@ monitoring.  This can be used to set lower-bound of the monitoring quality.
 But, setting this too high could result in increased monitoring overhead.
 Please refer to the DAMON documentation (:doc:`usage`) for more detail.
 
-Note that this must be 3 or higher. Please refer to the :ref:`Monitoring
+Note that this must be 3 or higher.  Please refer to the :ref:`Monitoring
 <damon_design_monitoring>` section of the design document for the rationale
 behind this lower bound.
 
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

