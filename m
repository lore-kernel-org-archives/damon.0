Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272767;
	b=3/rIIao8U/3XG3VHwmai8dgAJLWbBrt+QNtLLGoBiVI48JFGSUdkm29oC4J6cLjdh3ok
	 jafNj3PpelA0+zWA2TowzalPAkdOaT6AEn5DOZlIWdhkx/QMuMBeubWI02ETMZ70LNZ5i
	 NscQj40PsS64ShiuVmhVcQ1h+cMpu92JCaqbt/nCL4odt05ZQU44LUcZ3++z33ekPbLEC
	 +ddsPQui4TFg+5OIJswjOUdIg5gDos7BrpBYCNW+jPsVasbHGiz6kapV77cWTTdLwDNSX
	 t6YM2/rk9YuMo53ojT5Jnblfrqgy3+vaVuWsw6rHfXV4OBu4U32EY8EVytWcw8jvIOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272767;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WnZqF6L3cakkpOkBPQ3GBgvr6hmKQH8Z7qMlUUiyM4U=;
	b=E8yNL+47AOHWQ/hPX0siv8fCjJ9ZawUyjH3/Jmb7Cu9vkIKcnIgd9pDyrSVUBQcswRBR
	 BddhRG4PWxLYQ/oHNIYzmzev8BxgU0Wcj20KaL8xQE0rng2ZtBQNkkNE1Qf84qp+ZFjlj
	 tIw8e0Sq8vaxuraulXvVo1GfQls7lpk5zubXTD1FSl5VFUIrZu48NsDUMDECBjXnjqGA0
	 rWsA8yJBvnvpkMJGVduZ5I6SAjL0J/5c3fwXTGdqibx2miBzlW1DsVga1qRHhojjj9TYg
	 MWMP+2qSp2m86LFchcRpJPAGUSgNV1eTtZ+VpRXuPY+bRWDIxQleM9k1DLMBkqX1iNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQ7GIrC6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C1606A326;
	Tue, 10 Nov 2026 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQ7GIrC6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425151F008A4;
	Tue, 10 Nov 2026 01:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272766;
	bh=WnZqF6L3cakkpOkBPQ3GBgvr6hmKQH8Z7qMlUUiyM4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RQ7GIrC6oQitZJAS2Cilru5She+e9VUU9yjN58IVZ8n2zsdlYUvQqqYuHEWBQbnCD
	 b3MHGaB24x5nPUUeUJrls3KIDZX/YPf25eF32VjoO99Vy12dnKbENksWixVcZeed2N
	 UpNF2TRN+95z8Ep2ilNoG9UEiLwtODLFR5JdN02vupSxq9NyfycpQiG+2AcUPvyJT5
	 cgkp8p4Jv6ymVWkzMNT6fq7JT7VNVpc4wr2d6ui/+U2tRZUoJbpNt2FrXRWy9lqlej
	 46BiC9eIEPa2UyWlEPpoqeJTdUZDOWRS8523zAxG/LasRcwGBHDnwK54OScaT9gCT/
	 VCw9s0O+WBIDQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	Aveline Noir <jm5905938@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] Docs/admin-guide/mm/damon/reclaim: improve language
Date: Mon,  9 Nov 2026 17:05:57 -0800
Message-ID: <20261110010558.104905-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110010558.104905-1-sj@kernel.org>
References: <20261110010558.104905-1-sj@kernel.org>
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

Fix upper case.  Fix tenses.  Replace 'set as' with 'set to'.  Add space
after sentence to make it double space.  Rewrite and refine complex
sentences.

Cc: Aveline Noir <jm5905938@gmail.com>
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v3
- v3: https://lore.kernel.org/20261103120043.100887-2-manuelebnerli@mailbox.org
- Apply two Sashiko suggestions.
- Collect R-b: from SJ.
- Rebase to the latest mm-new.
- Wrap commit message for 75 characters limit.

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

 .../admin-guide/mm/damon/reclaim.rst          | 45 ++++++++++---------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 028947f5da8ec..0ef784df98680 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -4,7 +4,7 @@
 DAMON-based Reclamation
 =======================
 
-DAMON-based Reclamation (DAMON_RECLAIM) is a static kernel module that aimed to
+DAMON-based reclamation (DAMON_RECLAIM) is a static kernel module that aims to
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
@@ -88,10 +89,10 @@ identifies the region as cold, and reclaims it.
 autotune_monitoring_intervals
 -----------------------------
 
-If this parameter is set as ``Y``, DAMON_RECLAIM automatically tunes DAMON's
+If this parameter is set to ``Y``, DAMON_RECLAIM automatically tunes DAMON's
 sampling and aggregation intervals.  The auto-tuning aims to capture meaningful
 amount of access events in each DAMON-snapshot, while keeping the sampling
-interval 5 milliseconds in minimum, and 10 seconds in maximum.  Setting this as
+interval 5 milliseconds in minimum, and 10 seconds in maximum.  Setting this to
 ``N`` disables the auto-tuning.
 
 Disabled by default.
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
@@ -223,7 +224,7 @@ monitoring.  This can be used to set lower-bound of the monitoring quality.
 But, setting this too high could result in increased monitoring overhead.
 Please refer to the DAMON documentation (:doc:`usage`) for more detail.
 
-Note that this must be 3 or higher. Please refer to the :ref:`Monitoring
+Note that this must be 3 or higher.  Please refer to the :ref:`Monitoring
 <damon_design_monitoring>` section of the design document for the rationale
 behind this lower bound.
 
@@ -267,7 +268,7 @@ This parameter is for setting and getting the :ref:`address unit
 
 ``monitor_region_start`` and ``monitor_region_end`` should be provided in this
 unit.  For example, let's suppose ``addr_unit``, ``monitor_region_start`` and
-``monitor_region_end`` are set as ``1024``, ``0`` and ``10``, respectively.
+``monitor_region_end`` are set to ``1024``, ``0`` and ``10``, respectively.
 Then DAMON_RECLAIM will work for 10 KiB length of physical address range that
 starts from address zero (``[0 * 1024, 10 * 1024)`` in bytes).
 
@@ -284,7 +285,7 @@ skip_anon
 
 Skip anonymous pages reclamation.
 
-If this parameter is set as ``Y``, DAMON_RECLAIM does not reclaim anonymous
+If this parameter is set to ``Y``, DAMON_RECLAIM does not reclaim anonymous
 pages.  By default, ``N``.
 
 
-- 
2.47.3
