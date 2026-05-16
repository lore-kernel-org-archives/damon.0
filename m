Received: from outbound.ms.icloud.com (ms-2003i-snip4-11.eps.apple.com [57.103.72.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23B7380FC5
	for <damon@lists.linux.dev>; Sat, 16 May 2026 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778924179; cv=none; b=l+RfRBznAgFAH+dpR/FOV24SqM2B3r3kkAOS+v7M6VjpJSCGbiUOQmC07r1sCk0g/MZeAGVrthIBz1fV9V8ctIMkp4VM1bWellDAqnHU8SeNBO923Lm8o2CCbKBvoBAz/mM/tfomIfS8xK3tASl7vBxXcm2UUivawcOMQiWK1TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778924179; c=relaxed/simple;
	bh=EBM96ebgjURdL7OjhBLKUpgJSgt1jtE4A6/JMcajHOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgLYu8ZzS43e/TTiKW1pQH7B6Ac41NHbsVkIQzzTCEDnSYEsCO5gc0d03nwJXM0DSkhostV12SBVGyfqN38Vge1q9ddkz3IZctObY090MuQs5NfmWm3CymZFl49OeCjvEu3G1QVfCv66ZzrU+wiGCouOVezm5bjldJsR6HpYdbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=NfuQO4iS; arc=none smtp.client-ip=57.103.72.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="NfuQO4iS"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id 8234F180010F;
	Sat, 16 May 2026 09:36:15 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhKBUMDRQBBCFYBWANLVxQEG1sIUhhXE1gTVl8OXQIwUBtfAkIPHBNWFRMLU1ZRGFwdQAhUClkVC0EFXXcCURxWDVdDVARfUEsbDlwBS1oVVRcOAkIfUB9MFldDWhgcGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKAlEcVg1XQ1QEX1BUEVdQC1kCQg9IBlwBWwtDDE0BQw9fAkQUSR4OXw5XA1wbUgZSWQtGCThaDlsERxQXG1wACUtGCUkdDgRUB10FXQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778924177; x=1781516177; bh=pLIOlW+zoMRvn3ZZV36sMbKshXXQyD52jA4AIxLVy1Y=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=NfuQO4iSJ+67M3P6Vwvb/37/aM27nrC9cvX4WXfDTNd39A6+0UHAODBI/rcYAzcJkThRuXyJUga0fHS5SRqx5xhetSoQvh/AUGlPBS89ihamDzK/Hi3rOAMEBwRL+bm/idbpbcrckjm0+3Bsk/A8MRdxYPQXDS5ls2olMGec36DlCjbYZeCjZY76BQTUkZorS1LK4K0QOgZfEk+l2PJsOHlxb0ND5pPwogQcYA8+majDfjmmqUIz6a3dNGorXVH8mtWAiZy3KnyRwuxhff9z1xbOFRMPim21URK55jdQVQxTVpN5P0bZ5rsVnL7N/GJVLQYDftZJP4huO6VXJqDm2A==
Received: from localhost.localdomain (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id 7A85E1800106;
	Sat, 16 May 2026 09:36:11 +0000 (UTC)
From: Cheesecake <cheesecake2960@icloud.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cheesecake <cheesecake2960@icloud.com>
Subject: [PATCH] docs: fix typos in design.rst
Date: Sat, 16 May 2026 18:35:37 +0900
Message-ID: <20260516093552.8404-1-cheesecake2960@icloud.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDA5MyBTYWx0ZWRfX7ZnDZ7huTtVu
 KfCCErq43Td9krDJDecIzjVvJp5O1F/91Y2cn/A61mjwTfJIAW2lMBtKL+MDgwYGFL5b2kU09kZ
 87/0HfoVj/S9grnd/hDTlEafHCuLMdUbGqgDuZ4cG7RB6h3BwUso1GKjvn4h/cQy6cymcoYE2Gr
 N7V3Ir/Mp0l8QI+Zf7EpyHICj9hHCoh7/IcvORwZh8MW/8NGLUqWP0FO1ndOrNjdwg44Fohv7D1
 btRQYFBLzYTzNEV50ZRdzgwRS1CaDjMcgAlKAS+KVL3nSrzWrNCikl/LuMy7PQDGqcjA4YWGWiQ
 eWq+bc68auZRpoqEtrBw20Z4hpNUyILtLDgYuwDplW3MDDndGf7ZOn3sVi7kec=
X-Authority-Info-Out: v=2.4 cv=O4c0fR9W c=1 sm=1 tr=0 ts=6a083a90
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=sIGCgqHK338A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=v3ZZPjhaAAAA:8 a=_08Xcmskz7rbIMj_RqsA:9
X-Proofpoint-ORIG-GUID: ajntKu6TFwtbcfSmFXvV-7uUv9Erb4R6
X-Proofpoint-GUID: ajntKu6TFwtbcfSmFXvV-7uUv9Erb4R6
X-Apple-Category-Label: MjE0Nzk4NjU5NzY6JGNhdGVnb3J5JF9QZXJzb25hbCw=

L140: "unsinged" -> "unsigned"
L371: "sampleing" -> "sampling"
L387: "multipled" -> "multiplied"

Signed-off-by: Cheesecake <cheesecake2960@icloud.com>
---
 Documentation/mm/damon/design.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index afc7d52bd..9cc70a296 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -140,7 +140,7 @@ as Idle page tracking does.
 Address Unit
 ------------
 
-DAMON core layer uses ``unsinged long`` type for monitoring target address
+DAMON core layer uses ``unsigned long`` type for monitoring target address
 ranges.  In some cases, the address space for a given operations set could be
 too large to be handled with the type.  ARM (32-bit) with large physical
 address extension is an example.  For such cases, a per-operations set
@@ -371,7 +371,7 @@ with theoretical maximum ``nr_accesses``, which can be calculated as
 ``aggregation interval / sampling interval``.
 
 The mechanism calculates the ratio of access events for ``aggrs`` aggregations,
-and increases or decrease the ``sampleing interval`` and ``aggregation
+and increases or decrease the ``sampling interval`` and ``aggregation
 interval`` in same ratio, if the observed access ratio is lower or higher than
 the target, respectively.  The ratio of the intervals change is decided in
 proportion to the distance between current samples ratio and the target ratio.
@@ -387,7 +387,7 @@ The tuning is turned off by default, and need to be set explicitly by the user.
 As a rule of thumbs and the Parreto principle, 4% access samples ratio target
 is recommended.  Note that Parreto principle (80/20 rule) has applied twice.
 That is, assumes 4% (20% of 20%) DAMON-observed access events ratio (source)
-to capture 64% (80% multipled by 80%) real access events (outcomes).
+to capture 64% (80% multiplied by 80%) real access events (outcomes).
 
 To know how user-space can use this feature via :ref:`DAMON sysfs interface
 <sysfs_interface>`, refer to :ref:`intervals_goal
-- 
2.54.0

