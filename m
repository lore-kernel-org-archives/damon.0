Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84AF39C00F;
	Thu, 19 Mar 2026 05:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773897730; cv=none; b=AKtGZkbeaZjPqEM8xXKs6xVOL5G+/Gy300yR9Flolu+/kVGz1Ktbz1XkEA53fB41AohAgN0RpLsJkqLJZquEn1+mYsaKJ9qmzQ+W6ztS30VGyVLFT4Jdvq1aesPtXL5EFaIYKUf6JdEFRXHwuA7hOG245A8/w+Dkls6QMd35hu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773897730; c=relaxed/simple;
	bh=gKzlHjNwVy7/eu8xZ7uHLGZKBMO4b6mmZ9XNI0j6RLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwsQ6qdwMeGJe59WLnBHCX0mF1Ba3UxdrroKiPlv901wZd10PQG64HOwOU2aRSdEzXnf7ZNyzOUcZ/8Nxti9YcnPqVSKxniAqvXTxKxeyTt6P3EaviYTGJXy9Xh66P8QTKYmU8/DMvZR/ZuoWi5gQCD0zVXw89rCPduq2NgySGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLE1gPG+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLE1gPG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2B2C2BCB1;
	Thu, 19 Mar 2026 05:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773897729;
	bh=gKzlHjNwVy7/eu8xZ7uHLGZKBMO4b6mmZ9XNI0j6RLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLE1gPG+Hya7//RWaiPAEKxtepx386lQ0Cm8RdvkucYG+iOXOFeZPuszuRWKmhmqY
	 Hlxm5qQmMgd/Efqo63G8l2SuLp2Bxr4GnzCPV7S+DNGqdG8Q89JJ+QMbBAMNdzoeIK
	 OzXL+h+ya25rpojtJ7Hg/DmBKzOkdSFMuw7s2gKefp9JqRLIUXm7mTtbh2QiioYEka
	 4gWS9afrhZHM7PFTk3oiT+rnkAAeDLRe6Ix7R7uS3YviH0REcZaLVT1Z/Ug7VkjHEa
	 01/5O4fI4zM/Io7soEAT3UH61w2LoEMW0vljBhU7MvbGN30cHB29E8t3vNMLgsG97M
	 tr4+UyLCjhRDg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 10/10] selftets/damon/sysfs.py: pause DAMON before dumping status
Date: Wed, 18 Mar 2026 22:21:53 -0700
Message-ID: <20260319052157.99433-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319052157.99433-1-sj@kernel.org>
References: <20260319052157.99433-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sysfs.py test commits DAMON parameters, dump the internal DAMON
state, and show if the parameters are committed as expected using the
dumped state.  While the dumping is ongoing, DAMON is alive.  It can
make internal changes including addition and removal of regions.  It can
therefore make a race that can result in false test results.  Pause
DAMON execution during the state dumping to avoid such races.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index e6d34ba05893f..704729c7a318e 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -193,18 +193,48 @@ def assert_ctx_committed(ctx, dump):
     assert_true(dump['pause'] == ctx.pause, 'pause', dump)
 
 def assert_ctxs_committed(kdamonds):
+    ctxs_paused_for_dump = []
+    for kd in kdamonds.kdamonds:
+        for ctx in kd.contexts:
+            if ctx.pause is False:
+                ctx.pause = True
+                err = kd.commit()
+                if err is not None:
+                    print('pause fail (%s)' % err)
+                    kdamonds.stop()
+                    exit(1)
+                ctxs_paused_for_dump.append(ctx)
+
     status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
     if err is not None:
         print(err)
         kdamonds.stop()
         exit(1)
 
+    for kd in kdamonds.kdamonds:
+        for ctx in kd.contexts:
+            if ctx in ctxs_paused_for_dump:
+                ctx.pause = False
+                err = kd.commit()
+                if err is not None:
+                    print('resume fail (%s)' % err)
+                    kdamonds.stop()
+                    exit(1)
+                # restore for comparison
+                ctx.pause = True
+
     ctxs = kdamonds.kdamonds[0].contexts
     dump = status['contexts']
     assert_true(len(ctxs) == len(dump), 'ctxs length', dump)
     for idx, ctx in enumerate(ctxs):
         assert_ctx_committed(ctx, dump[idx])
 
+    # restore for the caller
+    for kd in kdamonds.kdamonds:
+        for ctx in kd.contexts:
+            if ctx in ctxs_paused_for_dump:
+                ctx.pause = False
+
 def main():
     kdamonds = _damon_sysfs.Kdamonds(
             [_damon_sysfs.Kdamond(
@@ -302,6 +332,7 @@ def main():
         print('kdamond start failed: %s' % err)
         exit(1)
     kdamonds.kdamonds[0].contexts[0].targets[1].obsolete = True
+    kdamonds.kdamonds[0].contexts[0].pause = True
     kdamonds.kdamonds[0].commit()
     del kdamonds.kdamonds[0].contexts[0].targets[1]
     assert_ctxs_committed(kdamonds)
-- 
2.47.3
