Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B8D33B6C4;
	Mon, 27 Apr 2026 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302764; cv=none; b=b11V8hBVrCHTTvrokv1qs6sS2wugtemUMXBYcOTQ7tjCW8Gs7vXsa89Sp3/VugmtGX2HoMyz5wGCihviDbqpVx3Jy+hp83hacfOf7QOPLaHnPw52vpbtpU1YD2Nj5X/+JE3MYn+q6WV1aaBJwHXL3xJby6OvdtF8pDp7YAdFvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302764; c=relaxed/simple;
	bh=o+aCOZ8LYgQ7c4SiAM/QTBFJ12mubN4z21IkEnGUqdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8FnNXcavPY+QAOmE1LvRBoyzejUbQUEp0WjtOUj6f0rE6f8WiEFrQqLW75wjYfDOTEEvSMEP1XOQdBIlQpNN88h9HdgkDMI7arR61vvP6JI/HBFeElwERDPeWz9eJv2dOG49maZ31sm9vcCy0M5Usqgli92d4eXmNNwhcu0tJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHFWsTLk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHFWsTLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486A5C2BCB7;
	Mon, 27 Apr 2026 15:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302764;
	bh=o+aCOZ8LYgQ7c4SiAM/QTBFJ12mubN4z21IkEnGUqdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VHFWsTLkJlDEZTGoFpJGGzf/s9KTchh9p7s1uxrbmNVq0FWxJpFYg/L8M0nKbV+/s
	 +HcZRFvRWd60ojYtA5QpTNHejdqv2BGsfB5CMvMD6iXI75gp0mD9aYKzyo00ELcnp6
	 nphwpWSiM2T+6KMjb+ErlzWxX/AAc2FtXXPwmXV08rl4rIFR1hfid4ypwLzPSaT4DU
	 Txib6HpFfBA1KNBycIDQHpkio3QxdpoC3ouIK5oUY0/xRZYBI8axpMdbn8V0oIgBEB
	 zx66VyyAGggKYhcGdBxXd1rusVdASrngnnV4vOpfBb1Ibfa8LGuH68PdZMsgB3/iY8
	 hNnl9x9vw2+yg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 10/10] selftests/damon/sysfs.py: pause DAMON before dumping status
Date: Mon, 27 Apr 2026 08:12:29 -0700
Message-ID: <20260427151231.113429-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427151231.113429-1-sj@kernel.org>
References: <20260427151231.113429-1-sj@kernel.org>
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
 tools/testing/selftests/damon/sysfs.py | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 5a5d2f2774566..387286dc449d5 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -194,18 +194,55 @@ def assert_ctx_committed(ctx, dump):
     assert_true(dump['pause'] == ctx.pause, 'pause', dump)
 
 def assert_ctxs_committed(kdamonds):
+    ctxs_paused_for_dump = []
+    kdamonds_paused_for_dump = []
+    # pause for safe state dumping
+    for kd in kdamonds.kdamonds:
+        for ctx in kd.contexts:
+            if ctx.pause is False:
+                ctx.pause = True
+                ctxs_paused_for_dump.append(ctx)
+                if not kd in kdamonds_paused_for_dump:
+                    kdamonds_paused_for_dump.append(kd)
+        if kd in kdamonds_paused_for_dump:
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
+    for ctx in ctxs_paused_for_dump:
+        ctx.pause = False
+    for kd in kdamonds_paused_for_dump:
+        err = kd.commit()
+        if err is not None:
+            print('resume fail (%s)' % err)
+            kdamonds.stop()
+            exit(1)
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
@@ -303,6 +340,7 @@ def main():
         print('kdamond start failed: %s' % err)
         exit(1)
     kdamonds.kdamonds[0].contexts[0].targets[1].obsolete = True
+    kdamonds.kdamonds[0].contexts[0].pause = True
     kdamonds.kdamonds[0].commit()
     del kdamonds.kdamonds[0].contexts[0].targets[1]
     assert_ctxs_committed(kdamonds)
-- 
2.47.3
