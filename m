Received: from mta1.migadu.com (out-105.mta1.migadu.com [95.215.58.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B91E49503B
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353167; cv=none; b=V2v+3mYzYVhbKOnW9VzNfkCK7uTAM/im518H15iP1Mmr6mQJXQdDrtxzqUrWaF7kZHrDXhoIkkh7Qv9WhzyX09nMpodPeJ1skQVbt2u6VAAB0kaB/I5m15xvr6JBHKL0XW9vUiNOAsdh8p0STlE0pNkXC3OV/eVnXiZI7zJ2dnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353167; c=relaxed/simple;
	bh=LIIZ67WyrJ1BbHKsYGuShJUWhBgeY1V01Hjjf2SBjxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D8U8srcb8Lib7FmNrOV/FcLrwvT2fQqAuTJlEilj/UFHP7iOOGke8Lu4Afsx5U2VukyElRvX4rNSM00wIhCVx1sRxFp0Nz4v0c4xJmMvEKvhuZhlHJHpOBuQ34D8PiEzBA3tPv7/sX5dnhk051bBnQs6veMvHgZ3MMywVU9X73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DLrKtyVC; arc=none smtp.client-ip=95.215.58.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DLrKtyVC"
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=LIIZ67WyrJ1BbHKsYGuShJUWhBgeY1V01Hjjf2SBjxc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788353162; v=1; x=1788957962;
 b=DLrKtyVCPx5vDxc+7XWqW6om1+OoqLKc9JK/HKEODrmYcmrzL+O1xpf7LsF79/KT4AR/3YOQ
 ILgODtcuiIGXLVQbo4QcIMQ0KO9+H97EV+hziHA+ZNgPeCzPmwcGfaSUfUNkzeNgrqpB9QQJMvt
 wyYO67TRevuZsU7PfWri96n8=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id f210d0b17b2194c4;
	Wed, 02 Sep 2026 12:46:02 +0000
X-Mizu-Trace-ID: f210d0b17b2194c4
X-Migadu-Flow: FLOW_OUT
From: Zenghui Yu <zenghui.yu@linux.dev>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	"Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
Subject: [PATCH] Docs/mm/damon/design: fix broken :ref: usage and a typo
Date: Wed,  2 Sep 2026 20:45:50 +0800
Message-ID: <20260902124550.31175-1-zenghui.yu@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>

The Statistics section refers readers to the DAMON sysfs interface
documentation for how to read the statistics, using a ':ref:' role.
However, the role name has a superfluous 's' appended (':ref:s' instead of
':ref:').  Moreover, its target label 'sysfs_stats' does not exist; the
correct label is 'sysfs_schemes_stats'.  Fix both.

Also fix a typo, 'frequenceis' -> 'frequencies', in the Adaptive Regions
Adjustment section.

Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
---
 Documentation/mm/damon/design.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aed6cb1cf483..08c981c1dd91 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -249,7 +249,7 @@ For each ``aggregation interval``, it compares the access frequencies
 sum of the two regions' sizes is smaller than the size of total regions divided
 by the ``minimum number of regions``, DAMON merges the two regions.  If the
 resulting number of total regions is still higher than ``maximum number of
-regions``, it repeats the merging with increasing access frequenceis difference
+regions``, it repeats the merging with increasing access frequencies difference
 threshold until the upper-limit of the number of regions is met, or the
 threshold becomes higher than possible maximum value (``aggregation interval``
 divided by ``sampling interval``).   Then, after it reports and clears the
@@ -875,7 +875,7 @@ the scheme is deactivated.  Note that, unlike watermarks, even if a scheme's
 ``nr_snapshots`` reaches ``max_nr_snapshots``, monitoring will not stop.
 
 To know how user-space can read the stats via :ref:`DAMON sysfs interface
-<sysfs_interface>`, refer to :ref:s`stats <sysfs_stats>` part of the
+<sysfs_interface>`, refer to :ref:`stats <sysfs_schemes_stats>` part of the
 documentation.
 
 Regions Walking
-- 
2.53.0

