Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1429118BBAE
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 03:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284278; cv=none; b=O+6ILMO7nnhFGFwUTkp8PlR4Qq8pyDp3S0qsvpPinA1YXjqzgCOu/bS+GxrIVLxTEzgqMsphnxaAuGBNMFj7GKn+2x+T211xP8gKLIsP5/Gy0YoCVY2MxjaNifXvWbYe7KjMt/gChUPIUm9iTCOt+9yyEz/tFqDyarT8OKbnjfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284278; c=relaxed/simple;
	bh=/KH3aChOBfgFlGGyfxL03i9RqigtaHLERZayfOZo/vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwbQq++KY6rWhhNwomYnXStbMSgIuTbv2VyauElyNUOdrpOPF16KLQGgpWQDx0RmYk+Q+R0BaRUXM/ZJd2MWd7c6nYc4FqHBL6cp/ViZGMiRVgpvch/sg6U3U/JURRAyic5ReLz5uIAR+3CX+AgkJ44PlcZjIeLYz7wUdSQ2YGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HgE+EHcj; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HgE+EHcj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780284274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BpJqpbF9ApLNylCyq0RsExKHsHO66f1ta9bSPuMNQvg=;
	b=HgE+EHcjd9c4DxL4XphF3dM/ndwLGCizdi8lItx1SrPwXrYb0ojr3vggiEfDPROoDdjIo4
	h9ZewjJ0EUXsA7PB3zHQzti+N9cdyjcDxfE3dCbdsZBJdxempVZFSvLWXRV7xMKgerXYuz
	b+WxxGyyG/VOzV3D6+urxj1qmMuLJq4=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: sj@kernel.org,
	shuah@kernel.org
Cc: damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Wang Lian <lianux.mm@gmail.com>
Subject: [PATCH v2 3/3] selftests/damon: fix dead code, skipped checks, and broken lookups
Date: Mon,  1 Jun 2026 11:23:14 +0800
Message-ID: <20260601032314.424013-4-kunwu.chan@linux.dev>
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

'hugeapge_size' in drgn_dump_damon_status.py was a dead elif branch.
$fail_reason in sysfs.sh was undefined, silently emptying the error
message.  'exit' instead of 'exist' in sysfs.sh skipped a file
existence check.  'nohugeapge' in sysfs.py broke an action dict
lookup.

Fix other wrong strings in the same files.

Co-developed-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py               | 2 +-
 tools/testing/selftests/damon/damos_apply_interval.py       | 2 +-
 tools/testing/selftests/damon/damos_quota_goal.py           | 2 +-
 tools/testing/selftests/damon/drgn_dump_damon_status.py     | 2 +-
 tools/testing/selftests/damon/sysfs.py                      | 4 ++--
 tools/testing/selftests/damon/sysfs.sh                      | 6 +++---
 .../sysfs_update_schemes_tried_regions_wss_estimation.py    | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 2f6f2699db25..f6127081dfb2 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -837,7 +837,7 @@ class Kdamond:
                 for goal in scheme.quota.goals:
                     err = goal.stage()
                     if err is not None:
-                        print('commit_schemes_quota_goals failed stagign: %s'%
+                        print('commit_schemes_quota_goals failed staging: %s'%
                               err)
                         exit(1)
         return write_file(os.path.join(self.sysfs_dir(), 'state'),
diff --git a/tools/testing/selftests/damon/damos_apply_interval.py b/tools/testing/selftests/damon/damos_apply_interval.py
index f04d43702481..0f2f36584e48 100755
--- a/tools/testing/selftests/damon/damos_apply_interval.py
+++ b/tools/testing/selftests/damon/damos_apply_interval.py
@@ -56,7 +56,7 @@ def main():
     # Because the second scheme was having the apply interval that is ten times
     # lower than that of the first scheme, the second scheme should be tried
     # about ten times more frequently than the first scheme.  For possible
-    # timing errors, check if it was at least nine times more freuqnetly tried.
+    # timing errors, check if it was at least nine times more frequently tried.
     ratio = nr_tried_stats[1] / nr_tried_stats[0]
     if ratio < 9:
         print('%d / %d = %f (< 9)' %
diff --git a/tools/testing/selftests/damon/damos_quota_goal.py b/tools/testing/selftests/damon/damos_quota_goal.py
index f76e0412b564..661e4ba4765a 100755
--- a/tools/testing/selftests/damon/damos_quota_goal.py
+++ b/tools/testing/selftests/damon/damos_quota_goal.py
@@ -66,7 +66,7 @@ def main():
             # effective quota was already minimum that cannot be more reduced
             if expect_increase is False and last_effective_bytes == 1:
                 continue
-            print('efective bytes not changed: %d' % goal.effective_bytes)
+            print('effective bytes not changed: %d' % goal.effective_bytes)
             exit(1)
 
         increased = last_effective_bytes < goal.effective_bytes
diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index 972948e6215f..26b207e44268 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -163,7 +163,7 @@ def damos_filter_to_dict(damos_filter):
                                int(damos_filter.addr_range.end)]
     elif type_ == 'target':
         dict_['target_idx'] = int(damos_filter.target_idx)
-    elif type_ == 'hugeapge_size':
+    elif type_ == 'hugepage_size':
         dict_['sz_range'] = [int(damos_filter.sz_range.min),
                              int(damos_filter.sz_range.max)]
     return dict_
diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index aa03a1187489..99412f0d31f3 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -119,7 +119,7 @@ def assert_access_pattern_committed(pattern, dump):
                 'max_nr_accesses', dump)
     assert_true(dump['min_age_region'] == pattern.age[0], 'min_age_region',
                 dump)
-    assert_true(dump['max_age_region'] == pattern.age[1], 'miaxage_region',
+    assert_true(dump['max_age_region'] == pattern.age[1], 'max_age_region',
                 dump)
 
 def assert_scheme_committed(scheme, dump):
@@ -129,7 +129,7 @@ def assert_scheme_committed(scheme, dump):
             'cold': 1,
             'pageout': 2,
             'hugepage': 3,
-            'nohugeapge': 4,
+            'nohugepage': 4,
             'collapse': 5,
             'lru_prio': 6,
             'lru_deprio': 7,
diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 78f4badb5beb..2eaaa5ae3c5e 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -3,7 +3,7 @@
 
 source _common.sh
 
-# Kselftest frmework requirement - SKIP code is 4.
+# Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
 ensure_write_succ()
@@ -28,7 +28,7 @@ ensure_write_fail()
 
 	if (echo "$content" > "$file") 2> /dev/null
 	then
-		echo "writing $content to $file succeed ($fail_reason)"
+		echo "writing $content to $file succeeded ($reason)"
 		echo "expected failure because $reason"
 		exit 1
 	fi
@@ -363,7 +363,7 @@ test_context()
 {
 	context_dir=$1
 	ensure_dir "$context_dir" "exist"
-	ensure_file "$context_dir/avail_operations" "exit" 400
+	ensure_file "$context_dir/avail_operations" "exist" 400
 	ensure_file "$context_dir/operations" "exist" 600
 	ensure_file "$context_dir/addr_unit" "exist" 600
 	ensure_file "$context_dir/pause" "exist" 600
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
index 35c724a63f6c..16fdc6e7fc56 100755
--- a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
@@ -7,7 +7,7 @@ import time
 import _damon_sysfs
 
 def pass_wss_estimation(sz_region):
-    # access two regions of given size, 2 seocnds per each region
+    # access two regions of given size, 2 seconds per each region
     proc = subprocess.Popen(
             ['./access_memory', '2', '%d' % sz_region, '2000', 'repeat'])
     kdamonds = _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
-- 
2.43.0

