Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949F19046E
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284261; cv=none; b=EKOfnohteLBrlsKjkG/oFDwP47zPZagDqhLNIv/fRr4jQXG9VF9C7Fmk+0n5HNxuekzNx503H+OH8Xs20ywYAVIG/oadKPc/5GQnO7HWDQLsD5cNjPzKDdc4296D0kvIIXXl96vamdY1/9hA4kDp22PaL3fjtHjBYlU6ed5dd5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284261; c=relaxed/simple;
	bh=DGxVSbQst1w2I4LgcHpwOumpFk1YxGjQUD9BOEiqh4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwSYWlH3qklGVtaYgLijEe/2iC4+nboAmCyOIJc8BEw0OUUi7kBtz3rDlyDVaNxfDvh88B1PU/FDj4sn1EMfaLNABoyKBms4NpHmDMAaRka6jB8MWixM/2p/gCZbi8LMbmwlGfBrr86thLw8JYyU3aE/nknE7UlJeT6zm/BGScQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hl2Ut3C4; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hl2Ut3C4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780284258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A0eHW6gzjNPUtuJqQkMXg8OwcF2zJjUTNGVxRHFSBI0=;
	b=Hl2Ut3C4+vuq5qP49vk5424zEavISwmgYSN5PlBHStrCTykZ5stliQKvKHa655/N4sn9aC
	iXrpzrqtww4g72H49h3pQON10mwAHF7AHINgPIhHYdA41MabgcfoI5jV6NbxkiwveV3qt2
	1TfWbS6iB+tUXAwXAflfGHKM8bzYrNc=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: sj@kernel.org,
	shuah@kernel.org
Cc: damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Wang Lian <lianux.mm@gmail.com>
Subject: [PATCH v2 1/3] selftests/damon: prevent cross-context state pollution in DamonCtx
Date: Mon,  1 Jun 2026 11:23:12 +0800
Message-ID: <20260601032314.424013-2-kunwu.chan@linux.dev>
In-Reply-To: <20260601032314.424013-1-kunwu.chan@linux.dev>
References: <20260601032314.424013-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

DamonCtx.__init__() uses mutable default values for
monitoring_attrs, targets, and schemes.  In Python these are
evaluated once at function definition time, so multiple
DamonCtx instances can unintentionally share the same lists
and DamonAttrs instance.

Replace the mutable defaults with None sentinels and
initialize the objects when needed.

Co-developed-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 8b12cc048440..2f6f2699db25 100644
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
2.43.0

