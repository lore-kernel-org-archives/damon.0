Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966242882F;
	Mon, 29 Jun 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744578; cv=none; b=B9wUfFZxXCrgRlqKjL4M44uquTxZLU23pxbWSjG3329SpiK2yW5mrK+Lta6h4ebMVCfuUf887OjztAIUlwPbxTysVIF6gICqxf9/NDCbZjgiMe7rF1btIXFTmR+97Dc/15ag9FVrDVgHc0qSmlw2yp3SCdH6kczUnwEBRRFdH4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744578; c=relaxed/simple;
	bh=QlDQTXPpIHhQBDLBaMShC0lSqglIyJ6p5rlO64NWgLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KW/mBgYmWWfBIAlFOednDCqthfVeRBPN7bvMkfBRiRLI1h4NPVjdVKZBv2D+p4a28Y6+US5NSg9setHVnh9YaHs0+QBZhN7FPkeXaQRyiWXaX9hKHRWKC8m3YpPusVb/lshVW3CT/RRqgYPgT2fA0PDiXP+pkTaoAnH6fSCbUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le6BHDP8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le6BHDP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EA41F00A3E;
	Mon, 29 Jun 2026 14:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744576;
	bh=U3trZStiezM+6sm/g9plYWwoc59rolAxRxndflOxpvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Le6BHDP8kLQkgFFLTSOq5d55t8jWttWvTorxRLRkbZJ6RNtucoYQFdNqMVWNFXwTQ
	 bQgcVL2T9voIC3o/JQ7bgcl+fTBBtl56ey16d5jHGSxPSYVgyyQO1g6G8HNAQePC/5
	 i5aZdsdMAQ9CUVV5geSBHZcg78ikGHZFlQMQLlk1IgfD7uU8EukT/+JKd7tyfRUaUa
	 lwhhxWwrQOOPuR9Zkn+mGUzbT3WctZMDTDsevx15yfZ61Y88wstVexBhZ3UT3LBjb0
	 /CpWZUaSS1DEl48fcTSoQkjN9MrYvgPrBUzD8WKWBu9B/3b0sC+se/YSPa+yEtcxM5
	 hHpTN7w/6d9+Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ruslan Valiyev <linuxoid@gmail.com>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 1/2] selftests/damon/_damon_sysfs: support kdamond refresh_ms
Date: Mon, 29 Jun 2026 07:49:25 -0700
Message-ID: <20260629144927.134237-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629144927.134237-1-sj@kernel.org>
References: <20260629144927.134237-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruslan Valiyev <linuxoid@gmail.com>

The Kdamond class has no way to set the kdamond-level 'refresh_ms' sysfs
file, which makes DAMON periodically update the read-only sysfs files
(DAMOS stats, tuned monitoring intervals and the kdamond pid) on its own.

Add a 'refresh_ms' parameter to Kdamond.  When it is set (including to
zero, to disable the periodic update), write it before turning the
kdamond on, so tests can exercise the auto-update behavior.  Leaving it
unset keeps the previous behavior of not touching the file, so callers
running against kernels without the feature are unaffected.

Link: https://lore.kernel.org/20260602131217.2210912-2-linuxoid@gmail.com
Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index c197ab99bcc0a..e6a2265d721e8 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -698,12 +698,14 @@ class DamonCtx:
 class Kdamond:
     state = None
     pid = None
+    refresh_ms = None
     contexts = None
     idx = None      # index of this kdamond between siblings
     kdamonds = None # parent
 
-    def __init__(self, contexts=[]):
+    def __init__(self, contexts=[], refresh_ms=None):
         self.contexts = contexts
+        self.refresh_ms = refresh_ms
         for idx, context in enumerate(self.contexts):
             context.idx = idx
             context.kdamond = self
@@ -726,6 +728,11 @@ class Kdamond:
             err = context.stage()
             if err is not None:
                 return err
+        if self.refresh_ms is not None:
+            err = write_file(os.path.join(self.sysfs_dir(), 'refresh_ms'),
+                             '%d' % self.refresh_ms)
+            if err is not None:
+                return err
         err = write_file(os.path.join(self.sysfs_dir(), 'state'), 'on')
         if err is not None:
             return err
-- 
2.47.3
