Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1CB4DB568;
	Mon, 31 Aug 2026 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186387; cv=none; b=SKvLckELNAm98u9mvZQvG1GaD23LMX8pzR1wvJyWdHN2Ez8sY0qafDCCMSvUiao80HuG99YSArAd8hga92rtvOhrS9CoplTW4BWSMEfVnOTcnLMvp68eZU435AiIJXYvPoOFgG02R2laR6MnwksbcpzMGk4s6e77paUaaNQ5bwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186387; c=relaxed/simple;
	bh=mBQVBalgo78Gl8oNzOzOSPZT5jyXvkYNsvMckVyOYRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJQgz+RSOvdiwLIHjyaGer5T2rBlJx3MtFDbiagYTs6ltaFJ7Ez0VSgHEdi1Z1l6XKjJXFx4qADKTJek0Enqf+ZOJkbo1kgrLbmV1HygnBmxHORGkYKgqqt7u5MNOrFLpUKohATpL2raGrjM1tNkcgWb1ednEezcO3puePXZjh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Em2drk/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Em2drk/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A971F00A3D;
	Mon, 31 Aug 2026 14:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788186385;
	bh=Epq3PwHO3KDR58/nXH75JqepBtDLOvPb3QexcmNVybw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Em2drk/829piatKSrCV3QA5FNzUpmoDNkTJymkFxgZCGghcuOO8KN+vmmpxqLBMRB
	 KHQijKDcHukKBQsj4bnDryymd+yQNAjM4XHoL1Qkn7BJFbclE9sljIWB+xz4VYhWf+
	 dFthQ2P7kG+wW+m0cde2PlPDCwbiU6UlRwcPyNBXFo7jrJp7Jk3QzpE5ldqM1NyT+b
	 HhNTI3nT9KJXzIdAfAEjZApxZDqtEXSBcFtH7VLnVRrdXz2aHy7QaMWARDcc82Dssb
	 Q2Uo7yKo54EqjjGyxkAliod+fxNcUI88HA0LxZO8eZ0RUqyH5BPoXG8t1gFsovLP56
	 c+92RHPWXh3SQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/7] selftests/damon: prevent remaining cross-object state pollution
Date: Mon, 31 Aug 2026 07:26:08 -0700
Message-ID: <20260831142611.77572-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831142611.77572-1-sj@kernel.org>
References: <20260831142611.77572-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>

_damon_sysfs.py defines constructors with mutable default arguments,
including DamosAccessPattern(), DamosQuota(), DamosWatermarks(),
DamosDests(), IntervalsGoal(), and empty lists.

Default arguments are evaluated once at function definition time.
Damos() instances created without explicit arguments therefore share
the same DamosQuota(), and the other default-constructed sub-objects
and lists are shared in the same way.  The sub-objects keep
back-pointers to their owner scheme, so constructing the second Damos()
rebinds the shared quota's scheme pointer to the second object.  An
item appended to one object's default contexts or filters list is also
visible from other default-constructed objects.

The shared state can corrupt test configurations.  DamosQuota.sysfs_dir()
derives the sysfs directory from its scheme pointer, so operating on
the first scheme's default quota may write to the second scheme's
directory.  The wrong values often match the defaults, so tests still
pass, but the behavior depends on object creation order.

Commit 8319dadcbd81 ("selftests/damon: prevent cross-context state
pollution in DamonCtx") fixed the same pattern in DamonCtx only.  Fix
the remaining constructors by defaulting to None and creating fresh
objects or lists inside each constructor.  Explicit arguments keep
their previous behavior.

Signed-off-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/38E4AAAAEDFCC283+20260827021515.1316838-1-zhaozhengzhuo@uniontech.com
- Collec R-b: from SJ.
- Rebase to latest mm-new.

 tools/testing/selftests/damon/_damon_sysfs.py | 38 ++++++++++++++-----
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index e6a2265d721e8..f604b7d6530b3 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -321,8 +321,10 @@ class DamosFilters:
     filters = None
     scheme = None   # owner scheme
 
-    def __init__(self, name, filters=[]):
+    def __init__(self, name, filters=None):
         self.name = name
+        if filters is None:
+            filters = []
         self.filters = filters
         for idx, filter_ in enumerate(self.filters):
             filter_.idx = idx
@@ -368,7 +370,9 @@ class DamosDests:
     dests = None
     scheme = None   # owner scheme
 
-    def __init__(self, dests=[]):
+    def __init__(self, dests=None):
+        if dests is None:
+            dests = []
         self.dests = dests
         for idx, dest in enumerate(self.dests):
             dest.idx = idx
@@ -426,15 +430,21 @@ class Damos:
     stats = None
     tried_regions = None
 
-    def __init__(self, action='stat', access_pattern=DamosAccessPattern(),
-                 quota=DamosQuota(), watermarks=DamosWatermarks(),
-                 core_filters=[], ops_filters=[], filters=[], target_nid=0,
-                 dests=DamosDests(), apply_interval_us=0):
+    def __init__(self, action='stat', access_pattern=None, quota=None,
+                 watermarks=None, core_filters=None, ops_filters=None,
+                 filters=None, target_nid=0, dests=None,
+                 apply_interval_us=0):
         self.action = action
+        if access_pattern is None:
+            access_pattern = DamosAccessPattern()
         self.access_pattern = access_pattern
         self.access_pattern.scheme = self
+        if quota is None:
+            quota = DamosQuota()
         self.quota = quota
         self.quota.scheme = self
+        if watermarks is None:
+            watermarks = DamosWatermarks()
         self.watermarks = watermarks
         self.watermarks.scheme = self
 
@@ -448,6 +458,8 @@ class Damos:
         self.filters.scheme = self
 
         self.target_nid = target_nid
+        if dests is None:
+            dests = DamosDests()
         self.dests = dests
         self.dests.scheme = self
 
@@ -568,10 +580,12 @@ class DamonAttrs:
     context = None
 
     def __init__(self, sample_us=5000, aggr_us=100000,
-                 intervals_goal=IntervalsGoal(), update_us=1000000,
-            min_nr_regions=10, max_nr_regions=1000):
+                 intervals_goal=None, update_us=1000000, min_nr_regions=10,
+                 max_nr_regions=1000):
         self.sample_us = sample_us
         self.aggr_us = aggr_us
+        if intervals_goal is None:
+            intervals_goal = IntervalsGoal()
         self.intervals_goal = intervals_goal
         self.intervals_goal.attrs = self
         self.update_us = update_us
@@ -703,7 +717,9 @@ class Kdamond:
     idx = None      # index of this kdamond between siblings
     kdamonds = None # parent
 
-    def __init__(self, contexts=[], refresh_ms=None):
+    def __init__(self, contexts=None, refresh_ms=None):
+        if contexts is None:
+            contexts = []
         self.contexts = contexts
         self.refresh_ms = refresh_ms
         for idx, context in enumerate(self.contexts):
@@ -853,7 +869,9 @@ class Kdamond:
 class Kdamonds:
     kdamonds = []
 
-    def __init__(self, kdamonds=[]):
+    def __init__(self, kdamonds=None):
+        if kdamonds is None:
+            kdamonds = []
         self.kdamonds = kdamonds
         for idx, kdamond in enumerate(self.kdamonds):
             kdamond.idx = idx
-- 
2.47.3
