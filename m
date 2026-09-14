Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703BF47ACC9;
	Mon, 14 Sep 2026 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395609; cv=none; b=fy4jkaE73bhdaIAcPHM4IV6qBz4V0Ej04/DlIcAh8h86y+uWf9uN1Qa58hxYakh6Rcgs0Ljq1aj/svUGFp17X/VOE6hojA5wxBJ2h++n7KeRSnhjRMPA65h5TKG8t3jouRYT2KKeJ4C+ZlDvIbVc5msQ5afc0y8oDTXUU1WTWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395609; c=relaxed/simple;
	bh=lpaO9TLngl+800FN0Oclc9LEAPQL3PfEYQXVFjlxJKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sptaNKqqAljDvmih4RFEQc9kZXOzA4A62c3cBuRzRbbAoFeNTH/WFUJFMHJ2rycj8w+Pr+gHHnB38/iphClIqSrgGqv/Xp5KuvLLus/P1skokTMokwJxtWe4X9KNxULf2B7eLlHAaUXu5LH+7+3vK7lv8s5KJAUhSZF4xcj7aVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO20yQc6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO20yQc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2811F00898;
	Mon, 14 Sep 2026 14:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395601;
	bh=1oWEcWOiJS4U7UoQkNpC5ifxai4TnwShrWzXzWihbqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NO20yQc61hDX4N6lEy0ZsVRFihbtdYpFcBa0+s2k1rLQM8gvTKtjszXCbeuDDTz15
	 76VDqJeJFu2flLbl5M6wRt2uYT6yE8r1Gw+GzCyEiUJ35E8kO2r7FD7Eby8HCqK+mg
	 ZJk9EKrPkgBUPLi6JvDaST2ejDcelGSk2FqJH1oKMIatw0pH8CQnD925cmRy6xSrbW
	 Hx8/7t+ZogRMXXmgXMDApbAD2otaf3Ot0U5pVNhdDx7tQOvQTh+PftyYC1ZklqoLzi
	 xq8AO1fYBApaNkjQlyQz8JHhj7ppcX6PpOYaip//+GOsz0R7YNRUbFJzHY83BJnO0x
	 fguS+r5Extt5Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>,
	SJ Park <sj@kernel.org>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/6] selftests/damon: stop kdamond on error exits of no-op commit test
Date: Mon, 14 Sep 2026 07:19:46 -0700
Message-ID: <20260914141952.91465-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914141952.91465-1-sj@kernel.org>
References: <20260914141952.91465-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>

The sysfs_no_op_commit_break test starts a kdamond via sysfs, but its error
paths (e.g., drgn not installed) exit without stopping it.  The leaked
kdamond then makes subsequent tests, e.g. lru_sort.sh and reclaim.sh, skip
with "Another kdamond is running".

Wrap the post-start logic in try-finally so that kdamonds.stop() is
executed on every exit path.

Fixes: 10725cd2b09a ("selftests/damon: test no-op commit broke DAMON status")
Assisted-by: GLM-5.3 OpenCode
Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260907123455.67246-1-zenghui.yu@linux.dev
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 .../damon/sysfs_no_op_commit_break.py         | 35 ++++++++++---------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
index 2c65cffe6b545..81774ddc55ac4 100755
--- a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
+++ b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
@@ -47,26 +47,27 @@ def main():
         print('kdamond start failed: %s' % err)
         exit(1)
 
-    before_commit_status, err = \
-        dump_damon_status_dict(kdamonds.kdamonds[0].pid)
-    if err is not None:
-        print('before-commit status dump failed: %s' % err)
-        exit(1)
+    try:
+        before_commit_status, err = \
+            dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+        if err is not None:
+            print('before-commit status dump failed: %s' % err)
+            exit(1)
 
-    kdamonds.kdamonds[0].commit()
+        kdamonds.kdamonds[0].commit()
 
-    after_commit_status, err = \
-        dump_damon_status_dict(kdamonds.kdamonds[0].pid)
-    if err is not None:
-        print('after-commit status dump failed: %s' % err)
-        exit(1)
-
-    if before_commit_status != after_commit_status:
-        print(f'before: {json.dumps(before_commit_status, indent=2)}')
-        print(f'after: {json.dumps(after_commit_status, indent=2)}')
-        exit(1)
+        after_commit_status, err = \
+            dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+        if err is not None:
+            print('after-commit status dump failed: %s' % err)
+            exit(1)
 
-    kdamonds.stop()
+        if before_commit_status != after_commit_status:
+            print(f'before: {json.dumps(before_commit_status, indent=2)}')
+            print(f'after: {json.dumps(after_commit_status, indent=2)}')
+            exit(1)
+    finally:
+        kdamonds.stop()
 
 if __name__ == '__main__':
     main()
-- 
2.47.3
