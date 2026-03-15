Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA7037CD51;
	Sun, 15 Mar 2026 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773608425; cv=none; b=SddqhcC1o7p4OzGJfmWGjkf81KHJji+rBVLBqXBz6Vvd9q5hnnlKeDfZjhTuS1zL6sJcTgzvbkmo6Kv3ETxcHzB1y2VSn9PStLYDsSW//mbelqXbrWARTPvZfE9Ua9Sal/4ZJXYhN08idm/JMeGo8Bl0jbuwXMhOP4wBBBqTDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773608425; c=relaxed/simple;
	bh=FkncVS2Azn3cp8UsK6No3qAma6g06Iasldq/cgtIdxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SveRXRg2xVD8iX2Xm/iOrL9P+ybgHGk7BGSo6hz+5w/rGNgd3ZFjKCcM1wixpxneNX+HEnbS9/7EGS9hITMIoREVCsJ4N6v5idkRzwGJzg77EvFjsWsunj9lysB3c/dfmVQf+cb0lytfYyfm2Ijx5+qUGehn/nkr9ITOjVLivKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0QI5i7o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0QI5i7o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB63C19421;
	Sun, 15 Mar 2026 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773608425;
	bh=FkncVS2Azn3cp8UsK6No3qAma6g06Iasldq/cgtIdxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u0QI5i7okhqAuIuYc+m4ZHOfluiK16mEvCAMEVk6y7bf9Et5R2oufxpLOHO3aH2C4
	 7CQlyof6w4qpYd6u1hStj6eOvzYvr0cFTsCPW8D5kILIhpYIwEibhBe2hSgy+L3S5J
	 1rlnJ6FhBdfkOfXs9oCyElr8Bb6PMBWXY3LkKnNUd3MFJcYMyIowX116pfPT0NxtMT
	 arbLxE99eeSc6KS1aRrPmeUhZBcGATb/peeCxZA8nRFqCLBM+8qwta9JD9ooPhgzeH
	 JYg6jrr2wA7XD7biLr21QIft+Ew62TmVBmlDUlTa2K/0GhaOir9uDmue40n5Kz6h3J
	 E2pSmsHnzVYtw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 10/10] selftets/damon/sysfs.py: pause DAMON before dumping status
Date: Sun, 15 Mar 2026 14:00:09 -0700
Message-ID: <20260315210012.94846-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315210012.94846-1-sj@kernel.org>
References: <20260315210012.94846-1-sj@kernel.org>
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
 tools/testing/selftests/damon/sysfs.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index e6d34ba05893f..a1a29f1a7c27b 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -193,18 +193,44 @@ def assert_ctx_committed(ctx, dump):
     assert_true(dump['pause'] == ctx.pause, 'pause', dump)
 
 def assert_ctxs_committed(kdamonds):
+    paused_for_dump = False
+    if kdamonds.kdamonds[0].contexts[0].pause is False:
+        kdamonds.kdamonds[0].contexts[0].pause = True
+        err = kdamonds.kdamonds[0].commit()
+        if err is not None:
+            print('pause fail (%s)' % err)
+            kdamonds.stop()
+            exit(1)
+        paused_for_dump = True
+
     status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
     if err is not None:
         print(err)
         kdamonds.stop()
         exit(1)
 
+    if paused_for_dump:
+        # resume
+        kdamonds.kdamonds[0].contexts[0].pause = False
+        err = kdamonds.kdamonds[0].commit()
+        if err is not None:
+            print('resume fail (%s)' % err)
+            kdamonds.stop()
+            exit(1)
+
+        # restore for comparison
+        kdamonds.kdamonds[0].contexts[0].pause = True
+
     ctxs = kdamonds.kdamonds[0].contexts
     dump = status['contexts']
     assert_true(len(ctxs) == len(dump), 'ctxs length', dump)
     for idx, ctx in enumerate(ctxs):
         assert_ctx_committed(ctx, dump[idx])
 
+    if paused_for_dump:
+        # restore for the caller
+        kdamonds.kdamonds[0].contexts[0].pause = False
+
 def main():
     kdamonds = _damon_sysfs.Kdamonds(
             [_damon_sysfs.Kdamond(
@@ -302,6 +328,7 @@ def main():
         print('kdamond start failed: %s' % err)
         exit(1)
     kdamonds.kdamonds[0].contexts[0].targets[1].obsolete = True
+    kdamonds.kdamonds[0].contexts[0].pause = True
     kdamonds.kdamonds[0].commit()
     del kdamonds.kdamonds[0].contexts[0].targets[1]
     assert_ctxs_committed(kdamonds)
-- 
2.47.3
