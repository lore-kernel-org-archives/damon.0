Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E9622AE65
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 02:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787797028; cv=none; b=FL+Y9DR581zZBUiqec0Cjl6C3BMHFy+kRjbQBcZlnOk9QtSRz6u/oUCDpmZc0RynHDUnZmYV248q4sATdwBpGVQSzQk1W0McJrp3zHVa//mlthw3tPT02pLTIIOqXNGkH5HyDDI8NqtmRq85Bv0Qcamm9J/328gZlXX59dteWPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787797028; c=relaxed/simple;
	bh=Otn8w1yt/gBzaL7xp39f/9GrkWA4bJSG9PRUIE/MBW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSKy1OVyEcVSbzghl7HLb27alNe6bp8xBbv4VlllmzHd3x+98QuTHzfTSsLhMkDAD8n7Qgs0vFuNpJQZ3LicK/hAHsdEtuarT3Dq9np9O3Nl/5Ze82VyrB+BmaF4xsc1tGjUhXxgo7IguMzoXIlpG4ABt/FLOO6etmZwdBmE7QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=kwUrPv/6; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="kwUrPv/6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787796950;
	bh=dY0Ane/g6w6slG4WVya3Y1rgTK4uIbhwmWsfZq4NOqM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kwUrPv/6dRCuB5xGFEV/4IejvozKU13Y5s4J95ScEC2GfBUewQfXO5w2gAy8Em5to
	 qL8wcqdc25w3jSah/HXKQIJuKPpu6uC4pPs+XlLq3UevXGp0HHoKA+8dlHsm2FzGD8
	 LHHTEWSgxfNbvSq0zHerGhQOb0MdHSOO/x5h8nC4=
X-QQ-mid: esmtpgz10t1787796930ta39a6dc6
X-QQ-Originating-IP: Vr/DIm68OfOsFIB+dMR1e+jE5N+2Xsb6EvYj4ckGA8I=
Received: from zzz-PC ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 10:15:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9858402169651406958
EX-QQ-RecipientCnt: 7
From: zhaozhengzhuo@uniontech.com
To: sj@kernel.org,
	shuah@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
Subject: [PATCH] selftests/damon: prevent remaining cross-object state pollution
Date: Thu, 27 Aug 2026 10:14:52 +0800
Message-ID: <38E4AAAAEDFCC283+20260827021515.1316838-1-zhaozhengzhuo@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: MGeqoSbHfHK69bPxTAzoCJdhw2kwrmioHHsWR2DTvlVmG1nTExeaCLmY
	yzvlV+n+exkh3TYHz2ABo5dBBN4WQLdVLhEnu1Z/3KY43UCV242r2NDTQ1qqxIgDTUUeZWQ
	Bpt2v4CgEssYMcGLPMX8hm/m2PgRaZgIp9ERA0dLwN50XptZLf98pxJrL8teIvls/2vlDNc
	3qJGeqksIFJlQjb0Qyixhx8ZgI97KuJGS3uTE3BPryw7lORyxvpchEfzpg46voK1PVUrIvc
	cy/k6OdsYFFF5nOZzdAFpDmQgZV0IRTB4lzc5zisWHtJvSI1e9Rm9HF9GhbFa3SnHBIJcCf
	vcN3cIaBzdvLAWI5V3kWocBHzcy3SQvI4IUMQhNTyTUzrtCW6bVHwuUEXHij0C24GdGgW9F
	I4G9CarW9m4jSK2CrM2Y0XfMJkYBo7+BiyiAJ02a6hRC4rdVWsfmQAZGkZSPUEmGtmOzbCY
	KqkEvhGnfn4kehkwuDY6eT749wO2y4wwkdKfO30sGXNEZG1W0Xa1Wx/ecAhkykcHJ1dKqj4
	1Gb83J8AiGtpHhEeYg1fI+STmR7CsOE32KidDWuOag1Sfj+rJ70UtUQEV70jHXRdV2gO0yI
	wFEU6gMBcU0g+UCFt8ocoOQoN3e4D5/YeK+aCD6btwIICqIf5fG3LEUYOd/ofH0R35epA78
	TX+dezv1L+P0T4aykeUrGEcobQqJJkD+yux7LeUduvjrpJTHly9dUfgLvEpVbQDgfg3W4+f
	ZLAxyj1vkD6c7lMpt5akJc7DN7ngtbnPPTgxjBs+KjxHxwSYdwP+H9Chl9iHUvAlWLHNWeM
	Hzp777pdeRNr7Lz8jo6g6e0ttOIK7eNZpDGrlvMmCONmhkrJDopamsWcFozg2Sw87U7X4T9
	8l8Zn5wVacspNlod9pbswn4kZrVhbR5TZfEWjiXXy0i/k2hI4gOyg+uKvbG2cHSJ8+GIRdT
	3jsPkDMd8FG6r/YTkJDfnjTcUGCiSsy90o+fGzldJvFUDKxIn606/xyD3EkWTx4nHcSo9/v
	1PC1GQ9rXFN/ZCRyXx7H7L/xYr/SUNHKuHz6iDs8jbx/DKSqJO01sN4/zFw4M=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

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
---
 tools/testing/selftests/damon/_damon_sysfs.py | 38 ++++++++++++++-----
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index e6a2265d721e..f604b7d6530b 100644
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
2.50.1

