Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59254387596;
	Mon, 23 Mar 2026 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307745; cv=none; b=LmafEyVkf/sntKpbxoFswZoNZasfKyqhgAyjE83CzN3ssBP7c8o+S/ZmYsdG9JcV8FeW6ZJeTySabtvno044qH/q+eOXabCJaSV4lKKAIOCbrUiEyBqkRkJpPHshNOcKfF5IEQvqsHPGO2rGtKbuiD731hCs6TQa7o5VAOeWPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307745; c=relaxed/simple;
	bh=Z1nIZLeoxb98TWw70o0hO/Y6NrW1kS5M/KiHOgpnygQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgHUoNwQzlyOU9ltSlaEU8UVFnSKngQ0CTWDwT6LkQB75yxy/L310VPYHA5WAzxJ8hsM0j2KlFr70M+dpsnfnWI/9oZW9lynncPcsXZtrMe4slM+vqnF+nuQnzMKupMs8M7xZxAslBWHaMfy+T07a26ODpOTzBYjj+vmHDxHiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5yydVUq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5yydVUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12013C2BCB0;
	Mon, 23 Mar 2026 23:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774307745;
	bh=Z1nIZLeoxb98TWw70o0hO/Y6NrW1kS5M/KiHOgpnygQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5yydVUqpqiwnomNgbxwEbtmAZhljkYMPVfddPIOY8MHs670ZwRkshNhjKACcpyqj
	 UXGdbuW3aC6ygNvSQRh63A6Vm3MKNumaRlwrWu0QGtVA2hBIiLP+51U4tByUyRr9Oc
	 7f29kyj0Ib+buceF5JQSK1Sxs+UqAJ7aUuiLA8HPJSGyO0qkVTSusH1XxouH/GpdiC
	 yz3JlMmLII9kUKLaU9V4q2CTvbrwn53+2P6VCMOqd3pGPWi2o/1I6hlpihFpOpp7wo
	 DWyLl+zXS2LfYTvDmG79gDpl8bY+O2c8DilXB+dNsvHYPfcyJcrXW0BwKMfWoTsima
	 pch5opspDVcuw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 10/10] selftests/damon/sysfs.py: pause DAMON before dumping status
Date: Mon, 23 Mar 2026 16:15:35 -0700
Message-ID: <20260323231538.84452-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323231538.84452-1-sj@kernel.org>
References: <20260323231538.84452-1-sj@kernel.org>
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
index e6d34ba05893f..b8d6e0f8fd906 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -193,18 +193,55 @@ def assert_ctx_committed(ctx, dump):
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
@@ -302,6 +339,7 @@ def main():
         print('kdamond start failed: %s' % err)
         exit(1)
     kdamonds.kdamonds[0].contexts[0].targets[1].obsolete = True
+    kdamonds.kdamonds[0].contexts[0].pause = True
     kdamonds.kdamonds[0].commit()
     del kdamonds.kdamonds[0].contexts[0].targets[1]
     assert_ctxs_committed(kdamonds)
-- 
2.47.3
