Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE743BAD9F;
	Mon, 29 Jun 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744497; cv=none; b=LVZ2HQGN8E3EKRiZCWKPTMDPijqFallvC7mgBQBPHBRQwuFAJrz1FqRsP++QTL7e5Zn+MxFOXGXDuSSEH70As3Q0q0Ew+IUlgsnPbeAaJe8TIAqzLaKAaz1xX/qHBt8aerlZAtmNU8dM9Wyw91ItuhU9dQ0SgtgTbj9gp3OKT3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744497; c=relaxed/simple;
	bh=odcpK5v/8k4iXry5TNSepcXmWx7jyuK13wqjO9uTfPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fd0k3pAZMoA4ZORsnPBHcNY/4S4lZgd24X4q6tFqkp2Bk96+l5n0HMKUgCdgB8cyiqGiGdRG9FqnLbIPu97Hk/oVTS4LKm5LKCPx04wytKdVJb21mBGeTGzalYwg3+1HhArHFdH/GXAGPthjqsnALh+UXEJ7PeYEMc1lSS038G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXkWB0xC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXkWB0xC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561161F00A3E;
	Mon, 29 Jun 2026 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744496;
	bh=Rgh/etwyJrwwwa/GAcWsO5WdxICD4nfXcQRavERHHxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jXkWB0xC3cSzu+Z6WW/1irg/KU2cjpWLLGnPr07TWbBo25fkh8xNK6DyomKSngTQ9
	 vcLWLmQfs9DG40Xn9wGIaBHd+H+07ZDKRGjMm0gxbjq1QNBvorP1DbXDUeCTAb7ss0
	 zF7PXfeqinjJPqW68u2q5Gf9MdobGyPteJUYtBilRfd9U0f/nUEPOcUdDG1Adbjrxa
	 sXnfe+qVqDSFCELJXJ8uWuI/oIuYdgJZbnf/pNoHN4/AH6ZyGltY+3w9yBMn9lMje/
	 m7tE3rIqvHQPQmhpnbjOUZTnkOQ/6jHBrlYUFjNYHvXciBslJanTUmF5dhoatJhuiX
	 7J6ATfdtXNevA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Cheng Nie <niecheng1@uniontech.com>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 2/2] selftests/damon/sysfs.py: validate memcg_path staging readback
Date: Mon, 29 Jun 2026 07:48:11 -0700
Message-ID: <20260629144812.134159-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629144812.134159-1-sj@kernel.org>
References: <20260629144812.134159-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Nie <niecheng1@uniontech.com>

Add a dedicated test at the end of main() that stages memcg_path via
sysfs and verifies its readback.  Configure the memcg filter before
start(), do not call commit(), and ignore start() failures so the test
does not depend on CONFIG_MEMCG or cgroup layout.  Call stop() for
cleanup without checking its return value.

Link: https://lore.kernel.org/D2B37130D38E09AC+20260601090634.241864-1-niecheng1@uniontech.com
Signed-off-by: Cheng Nie <niecheng1@uniontech.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 99412f0d31f37..3ffa054b63867 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -250,6 +250,35 @@ def assert_ctxs_committed(kdamonds):
             if ctx in ctxs_paused_for_dump:
                 ctx.pause = False
 
+def test_memcg_filter_memcg_path_staging():
+    global kdamonds
+    memcg_filter = _damon_sysfs.DamosFilter(
+            type_='memcg', matching=True, allow=True, memcg_path='/')
+    kdamonds = _damon_sysfs.Kdamonds(
+            [_damon_sysfs.Kdamond(
+                contexts=[_damon_sysfs.DamonCtx(
+                    targets=[_damon_sysfs.DamonTarget(pid=-1)],
+                    schemes=[_damon_sysfs.Damos(
+                        ops_filters=[memcg_filter])],
+                    )])])
+    kdamonds.start()
+
+    shown, rd_err = _damon_sysfs.read_file(
+            os.path.join(memcg_filter.sysfs_dir(), 'memcg_path'))
+    if rd_err is not None:
+        print('memcg_path staging: sysfs read (%s)' % rd_err)
+        kdamonds.stop()
+        exit(1)
+    if shown.rstrip('\n') != memcg_filter.memcg_path:
+        print('memcg_path staging: memcg_path readback '
+              '(shown=%s, expected=%s)' %
+              (shown.rstrip('\n'), memcg_filter.memcg_path))
+        kdamonds.stop()
+        exit(1)
+
+    kdamonds.stop()
+    kdamonds = None
+
 def main():
     global kdamonds
     kdamonds = _damon_sysfs.Kdamonds(
@@ -356,5 +385,7 @@ def main():
     assert_ctxs_committed(kdamonds)
     kdamonds.stop()
 
+    test_memcg_filter_memcg_path_staging()
+
 if __name__ == '__main__':
     main()
-- 
2.47.3
