Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C363B83F0;
	Mon, 29 Jun 2026 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744416; cv=none; b=kBzAder+PmUPNbPzFOnjpH4RizEK0UfukcpXqShMLsHwqWqu415W1+5Md8afJUTKwF+CegJe3Z9Pcf0VQSCs61B71SF4sHwI3SfpI5Ivz5ppjWDACYLCv8i2my2Tra8IgYQ5nsqo6KykMJKUkSrgbrZthkUI65bF4XlzZ/fbsBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744416; c=relaxed/simple;
	bh=8lx1Mk1E4OrpjUwlZ9ImKTDYsezmwBzoc5GIwwU07wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1LgFHeNPeb4gf15XSrVDC/bDH+YqOdYXKk+GX1mwIZzFo9nYwRHfLE4MaDTIhnhMh7RsIyqGd9AG/1XLnBjLSXnKtvVpDsvIVbOJw8fBVpNUIpRhkVaLAfIQuMmZ0fV4KbyJpWbhBiYY8IEsnKmR1Lu0Qq2NH3yyhqq2D41peA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu34g0+O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu34g0+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F5E1F00A3A;
	Mon, 29 Jun 2026 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744414;
	bh=IAWztPSYLWcu2Vd7sgQJGKVU9DMgq6cTa1utFOkkV6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yu34g0+OosmK290GgyuQb1/d+G7QsfzCMdSuy82Ac6MvAdJ6tY+Luhadc40ml1Dho
	 w7mr0d5yx+TpfmEVneKK/hzkuwQo+swcuiR5LhkD4RQhzfKYV3/PFLhTItGfXsS6iK
	 b7CLa5ntbalPZn8Hw3I8BwMotfs7bos0rBI1D9aU/OiZXhiGN5IbrTHM82D0nGJxbf
	 3vyzhnRZT5OxMXxoWtGFAnaoHOAWN1Jv+gAwUThK/09hg+AIgqWgMS4dK9mv9LhmIf
	 oISgPHSlw7DrbZLvnxcqew3RrisIRjf8u30pzAcj5iSx2nXRJViSo+LnKipKR9Ia//
	 6Obpd3/gNpPtw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kunwu Chan <chentao@kylinos.cn>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Wang Lian <lianux.mm@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 1/3] selftests/damon: prevent cross-context state pollution in DamonCtx
Date: Mon, 29 Jun 2026 07:46:44 -0700
Message-ID: <20260629144648.134092-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629144648.134092-1-sj@kernel.org>
References: <20260629144648.134092-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <chentao@kylinos.cn>

DamonCtx.__init__() uses mutable default values for
monitoring_attrs, targets, and schemes.  In Python these are
evaluated once at function definition time, so multiple
DamonCtx instances can unintentionally share the same lists
and DamonAttrs instance.

Replace the mutable defaults with None sentinels and
initialize the objects when needed.

Link: https://lore.kernel.org/20260601032314.424013-2-kunwu.chan@linux.dev
Co-developed-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <chentao@kylinos.cn>
Cc: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 8b12cc0484405..2f6f2699db256 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -624,17 +624,23 @@ class DamonCtx:
     pause = None
     idx = None
 
-    def __init__(self, ops='paddr', monitoring_attrs=DamonAttrs(), targets=[],
-            schemes=[], pause=False):
+    def __init__(self, ops='paddr', monitoring_attrs=None, targets=None,
+            schemes=None, pause=False):
         self.ops = ops
+        if monitoring_attrs is None:
+            monitoring_attrs = DamonAttrs()
         self.monitoring_attrs = monitoring_attrs
         self.monitoring_attrs.context = self
 
+        if targets is None:
+            targets = []
         self.targets = targets
         for idx, target in enumerate(self.targets):
             target.idx = idx
             target.context = self
 
+        if schemes is None:
+            schemes = []
         self.schemes = schemes
         for idx, scheme in enumerate(self.schemes):
             scheme.idx = idx
-- 
2.47.3
