Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD397355814;
	Sat, 21 Mar 2026 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774116835; cv=none; b=AZ6s73ACvRXiIDUG1vg8U+M//khYeYXmfM5gQm3B8dDVgdbDLQyV8zOOAqXHg/Ljmb0EPqMnidhGTOo00tmc1DUNEsAKim4ABjPdD+5ha4Xd7lKkikzsKdIK2g361jwo3zhITi/tXaBKo9vqq5d4GRCds8wx//OqFX/6+YmzfDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774116835; c=relaxed/simple;
	bh=8CAJmnXM5hTXIdgeoG4mgBlgGTWslXDeLQsPkAPObfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evqx6I4Zkvn7hNHQH5r717S/JZ3lu5buZaygCxveGtSez+0QJceEvVm8X8carRGYwk7iB1TCgDNMAwMw9yj+D+A7F0eZpiMhUnp69gJ7X9PJmo3q3s7b6TnxyJnvmkFzOWHVY19uhTTthEZ3Ib7H4z3Nc/nrB4pudYiUGmygJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5ZylUjd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5ZylUjd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778C1C2BCB0;
	Sat, 21 Mar 2026 18:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774116835;
	bh=8CAJmnXM5hTXIdgeoG4mgBlgGTWslXDeLQsPkAPObfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5ZylUjdQnzbpGn66thpuzFmsjx7QgL20spJw599mPYV8WT0+08p4aHAJD1dceRzS
	 PtatTga0LmJOVq9Yma+gQitzw+wqrPKva24yEhdNfArY042ApfJSvy5lS3s6uiqWD+
	 psUh1QbKT+1MEhcq51OADY6WPrHrBoCSscYfW4IuP3+xIHTzy1uHQee5swAxGxLU8o
	 BX+0GiqvmuC5fyY68ZtcK0H6cgknfvipezkmLWtDoI0Dawf9PIToQQZT2V6l5SG7Q/
	 Qnu6rM9hXthl88sD9pEV8ER7+rTkw0FyYoW2j+hXI44uFKoXVomKcpgdhUAl2VUdy1
	 Rimoocr2YTtEQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/10] selftets/damon/sysfs.py: pause DAMON before dumping status
Date: Sat, 21 Mar 2026 11:13:40 -0700
Message-ID: <20260321181343.93971-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321181343.93971-1-sj@kernel.org>
References: <20260321181343.93971-1-sj@kernel.org>
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
 tools/testing/selftests/damon/sysfs.py | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index e6d34ba05893f..7a4cd915d5bc9 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -193,18 +193,53 @@ def assert_ctx_committed(ctx, dump):
     assert_true(dump['pause'] == ctx.pause, 'pause', dump)
 
 def assert_ctxs_committed(kdamonds):
+    ctxs_paused_for_dump = []
+    # pause for safe state dumping
+    for kd in kdamonds.kdamonds:
+        for ctx in kd.contexts:
+            if ctx.pause is False:
+                ctx.pause = True
+                ctxs_paused_for_dump.append(ctx)
+        if len(ctxs_paused_for_dump) > 0:
+            err = kd.commit()
+            if err is not None:
+                print('pause fail (%s)' % err)
+                kdamonds.stop()
+                exit(1)
+
     status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
     if err is not None:
         print(err)
         kdamonds.stop()
         exit(1)
 
+    # resume contexts paused for safe state dumping
+    for kd in kdamonds.kdamonds:
+        for ctx in ctxs_paused_for_dump:
+            ctx.pause = False
+        if len(ctxs_paused_for_dump) > 0:
+            err = kd.commit()
+            if err is not None:
+                print('resume fail (%s)' % err)
+                kdamonds.stop()
+                exit(1)
+
+    # restore for comparison
+    for ctx in ctxs_paused_for_dump:
+        ctx.pause = True
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
@@ -302,6 +337,7 @@ def main():
         print('kdamond start failed: %s' % err)
         exit(1)
     kdamonds.kdamonds[0].contexts[0].targets[1].obsolete = True
+    kdamonds.kdamonds[0].contexts[0].pause = True
     kdamonds.kdamonds[0].commit()
     del kdamonds.kdamonds[0].contexts[0].targets[1]
     assert_ctxs_committed(kdamonds)
-- 
2.47.3
