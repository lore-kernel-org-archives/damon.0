Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667590;
	b=h3dk/6JSJiw7UiLbbHEWk+fYZVVtmAbVI3qML90psMaFej3MNPKGQcI8HDVHcZx/ZczN
	 Q9Gw8XA+dLOL5PSn5RXCiZp1oiEiMIWw4jjL6GX12RDeeuKF+YDJqrYQVKM+FBELr2/Hi
	 WlRWd4KliO1vaWylzl14qvjgaQ0+K4m4Tzh5AWkiqpaB1TZkE7r42YhbS9OxBr29U7GmG
	 gY6NSRLWFJZoxXmowA8UPZyRdPJ6JXYOn5SnpIp6mjT1LOgHIDASk05yVVCPyMGyyDJF/
	 SpBOWDRJd07vyHhLDsKUKuGr1Hv5IcMaLBxfJx9ZwxdmW7Yqcx4bfUwyUGK5hA2qkqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667590;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z1ZlDl54vy7oXT8lslczE9b+B9mUQeT7lKAv+hG8SGg=;
	b=gP66zYOH4yw2SvNBFChe/C+RbTegrrvHJwQ+8ueO6bKk83U5dLc/kHCCsrRYJ3WCJut+
	 kPfZzx+S2y0uMjeHWPWJkHHA6EfelIfZ0eExcggqf5eDNf5E53tGzvizIDRjXbcjuzvGf
	 2gX3soW+PU0iurF05dGj3a43pldUUSJDbxSArdoUtQ7J/EiXyiQw+/AY6Sjz+FyveYwkJ
	 otrnKN8NBO5sXzJmbmjXdUTyK8HQ+m3Vr5rS090Ijm4urgGcw5Hk1t86RlI6aDo87MJ/O
	 HBy66HaXv0tinxUv3gbR8Xo7Me1V0d0rgrojuBGIUSHBjGaC18PIcAHU507kzZd27ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jazplH8Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEDE606A335;
	Tue,  3 Nov 2026 00:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jazplH8Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066621F00A18;
	Tue,  3 Nov 2026 00:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667590;
	bh=Z1ZlDl54vy7oXT8lslczE9b+B9mUQeT7lKAv+hG8SGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jazplH8Q4+HMTuyyZaVjxs1U13KiD2GjrY9G4xDQH56o3nlczZiz4JAVvot3IgDfx
	 GCC4Btk10IWcK+3iG78kQThpETV3woyhE4z8AR5Ir+Bu/peZQjRYsMXQeWjpNaGhOe
	 V8ApWwohjex7+gv2ecavvBmeoUPRolzmTvMj/tk2vrSK99tQMNHEGztUrpw9OYWj/N
	 sJzk/JJw1Jc0G38kEWTzEIEhLyYuwd25038XO+LqSvLnbfpGLLmIFw3mVAv5Cbbpo/
	 2fLZwdpN5KVpGtyZFY+WkCFggkPj9XCgsGZShw+N71ejt932frK+t4EquSnmiFv5IK
	 6oViV6BL0d+9g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Manuel Ebner <manuelebnerli@mailbox.org>
Subject: [PATCH v2 4/8] Docs/admin-guide/mm/damon/lru_sort: fix remaining grammar
Date: Mon,  2 Nov 2026 16:59:34 -0800
Message-ID: <20261103005940.91432-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103005940.91432-1-sj@kernel.org>
References: <20261103005940.91432-1-sj@kernel.org>
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

From: Aveline Noir <jm5905938@gmail.com>

Manuel's recent grammar fix for this file, now in damon/next, covered a
good part of it.  This should take care of the few mistakes that are
left, like "should automatically activated" and "Make DAMON_LRU_SORT
reads".  Rewrap where the lines got too long.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Manuel Ebner <manuelebnerli@mailbox.org>
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Manuel Ebner <manuelebnerli@mailbox.org>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 .../admin-guide/mm/damon/lru_sort.rst         | 45 ++++++++++---------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index aa4cc90ca57c6..6b2cdb48fabe6 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -35,7 +35,7 @@ deprioritizing cold pages on their LRU-lists.  To avoid it consuming too much
 CPU for the prioritizations, a CPU time usage limit can be configured.  Under
 the limit, it prioritizes and deprioritizes more hot and cold pages first,
 respectively.  System administrators can also configure under what situation
-this scheme should automatically activated and deactivated with three memory
+this scheme should be automatically activated and deactivated with three memory
 pressure watermarks.
 
 Its default parameters for hotness/coldness thresholds and CPU quota limit are
@@ -55,7 +55,7 @@ DAMON_LRU_SORT utilizes module parameters.  That is, you can put
 ``damon_lru_sort.<parameter>=<value>`` on the kernel boot command line or write
 proper values to ``/sys/module/damon_lru_sort/parameters/<parameter>`` files.
 
-Below are the description of each parameter.
+Below are the descriptions of each parameter.
 
 enabled
 -------
@@ -70,12 +70,12 @@ condition.  Refer to below descriptions of the watermarks parameter for this.
 commit_inputs
 -------------
 
-Make DAMON_LRU_SORT reads the input parameters again, except ``enabled``.
+Make DAMON_LRU_SORT read the input parameters again, except ``enabled``.
 
-Input parameters that updated while DAMON_LRU_SORT is running are not applied
-by default.  Once this parameter is set to ``Y``, DAMON_LRU_SORT reads values
-of parameters except ``enabled`` again.  Once the re-reading is done, this
-parameter is set to ``N``.  If invalid parameters are found while the
+Input parameters that are updated while DAMON_LRU_SORT is running are not
+applied by default.  Once this parameter is set to ``Y``, DAMON_LRU_SORT reads
+values of parameters except ``enabled`` again.  Once the re-reading is done,
+this parameter is set to ``N``.  If invalid parameters are found while the
 re-reading, DAMON_LRU_SORT will be disabled.
 
 Once ``Y`` is written to this parameter, the user must not write to any
@@ -87,10 +87,11 @@ active_mem_bp
 
 Desired active to (in)active memory ratio in bp (1/10,000).
 
-While keeping the caps that set by other quotas, DAMON_LRU_SORT automatically
-increases and decreases the effective level of the quota aiming the LRU
-(de)prioritizations of the hot and cold memory resulting in this active to
-(in)active memory ratio.  Value zero means disabling this auto-tuning feature.
+While keeping the caps that are set by other quotas, DAMON_LRU_SORT
+automatically increases and decreases the effective level of the quota aiming
+the LRU (de)prioritizations of the hot and cold memory resulting in this active
+to (in)active memory ratio.  Value zero means disabling this auto-tuning
+feature.
 
 Disabled by default.
 
@@ -112,8 +113,8 @@ Filter (non-)young pages accordingly for LRU (de)prioritizations.
 
 If this is set, check page level access (youngness) once again before each
 LRU (de)prioritization operation.  LRU prioritization operation is skipped
-if the page has not accessed since the last check (not young).  LRU
-deprioritization operation is skipped if the page has accessed since the
+if the page has not been accessed since the last check (not young).  LRU
+deprioritization operation is skipped if the page has been accessed since the
 last check (young).  The feature is enabled or disabled if this parameter is
 set to ``Y`` or ``N``, respectively.
 
@@ -125,7 +126,7 @@ hot_thres_access_freq
 Access frequency threshold for hot memory regions identification in permil.
 
 If a memory region is accessed in frequency of this or higher, DAMON_LRU_SORT
-identifies the region as hot, and mark it as accessed on the LRU list, so that
+identifies the region as hot, and marks it as accessed on the LRU list, so that
 it could not be reclaimed under memory pressure.  50% by default.
 
 cold_min_age
@@ -134,7 +135,7 @@ cold_min_age
 Time threshold for cold memory regions identification in microseconds.
 
 If a memory region is not accessed for this or longer time, DAMON_LRU_SORT
-identifies the region as cold, and mark it as unaccessed on the LRU list, so
+identifies the region as cold, and marks it as unaccessed on the LRU list, so
 that it could be reclaimed first under memory pressure.  120 seconds by
 default.
 
@@ -237,7 +238,7 @@ The maximum number of monitoring regions of DAMON for the cold memory
 monitoring.  This can be used to set the upper-bound of the monitoring overhead.
 However, setting this too low could result in bad monitoring quality.  Please
 refer to the DAMON documentation (:doc:`usage`) for more detail.  1000 by
-defaults.
+default.
 
 monitor_region_start
 --------------------
@@ -310,7 +311,7 @@ Total bytes of hot memory regions that were successfully LRU-sorted.
 nr_hot_quota_exceeds
 --------------------
 
-Number of times that the time quota limit for hot regions have exceeded.
+Number of times that the time quota limit for hot regions has been exceeded.
 
 nr_lru_sort_tried_cold_regions
 ------------------------------
@@ -325,24 +326,24 @@ Total bytes of cold memory regions that tried to be LRU-sorted.
 nr_lru_sorted_cold_regions
 --------------------------
 
-Number of cold memory regions that successfully be LRU-sorted.
+Number of cold memory regions that were successfully LRU-sorted.
 
 bytes_lru_sorted_cold_regions
 -----------------------------
 
-Total bytes of cold memory regions that successfully be LRU-sorted.
+Total bytes of cold memory regions that were successfully LRU-sorted.
 
 nr_cold_quota_exceeds
 ---------------------
 
-Number of times that the time quota limit for cold regions have exceeded.
+Number of times that the time quota limit for cold regions has been exceeded.
 
 Example
 =======
 
-Below runtime example commands make DAMON_LRU_SORT to find memory regions
+Below runtime example commands make DAMON_LRU_SORT find memory regions
 having >=50% access frequency and LRU-prioritize while LRU-deprioritizing
-memory regions that not accessed for 120 seconds.  The prioritization and
+memory regions that are not accessed for 120 seconds.  The prioritization and
 deprioritization is limited to be done using only up to 1% CPU time to avoid
 DAMON_LRU_SORT consuming too much CPU time for the (de)prioritization.  It also
 asks DAMON_LRU_SORT to do nothing if the system's free memory rate is more than
-- 
2.47.3
