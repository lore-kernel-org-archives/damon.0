Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4637E4A091F;
	Wed,  2 Sep 2026 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357820; cv=none; b=kco2Qjlbu7MJ0u+eDiV6awZCaJEKZBxwWdB+OAjjicuCqW59Izhu7E7JSmnKKYPXw+/3MYZCZvpRNfZZIMVQqH71iYc15NdaXdxtN+LFCec0I/icbM0AjfuMBHHOwnZvPp2Y1qHNjWqdRedt9xrnzhNLh2DHjWTlakJbRm/psc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357820; c=relaxed/simple;
	bh=e9XXcPGdiu7jKQNaRWID+VQr3UMeObYB3tZ/IXjFhCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLstKgNiHnZxEhIHqBLT0w6k4dYlSh74+LcBsgruWYtyhzCHAtS9uWkQhGc564DW3iACSMkBIQQvZayoXlTp5/+NCac3Rz540zexb6vGeGP1o5rtXcJSRK8potKg4Et8n0R+8njVJO0Ua1VCP+wOoClfm45q3QBYpoGog3vq/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idvUACI2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idvUACI2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0AF1F00A3F;
	Wed,  2 Sep 2026 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357819;
	bh=d7E8/+9tPmws87WGovoxRC/oQMT8cFB9YIJxkAr2MhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=idvUACI26/k1C0XqqOqWLVI4Rmd9LGPJ9tmtyN0+S0BIaSijEBokM8ybeEcPKqkur
	 oSl27LswLlmXfrrdEo3aKSQOYEMks9MGB4DaSFKN76JIynYpO8lHIcbMn0xj9ErOSY
	 xXaJXh6YEohELcOQIRfkca8J5XKHDp6fegGNeTXAaHV1kxDxxQWMMKA7A1jSwyNmIG
	 k69Eg+VgQiPtbYVCcKn3SI0tWaCENb53qOA0UCH/VkUMmZY37Dy6rLnt3dL72B2wFj
	 nYqf/a8IBpk3u9T7GP1AhBBltHkKBNZsz9GwDzHGSvOt8TMYmPZN0EIAq67hua6vCn
	 iIUu3APb6htcw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/6] selftests/damon/_damon_sysfs: implement DamonProbes
Date: Wed,  2 Sep 2026 07:03:09 -0700
Message-ID: <20260902140313.85983-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902140313.85983-1-sj@kernel.org>
References: <20260902140313.85983-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend _damon_sysfs.py to support staging and committing DAMON probes.
It will be used for setting DAMON probes via sysfs changes for testing
purposes.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 125 +++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index f604b7d6530b3..e7095c3365245 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -570,6 +570,117 @@ class IntervalsGoal:
             return err
         return None
 
+class DamonFilter:
+    type_ = None
+    matching = None
+    allow = None
+    filters = None
+    path = None
+    idx = None
+
+    def __init__(self, type_='anon', matching=False, allow=False, path=None):
+        self.type_ = type_
+        self.matching = matching
+        self.allow = allow
+        self.path = path
+
+    def sysfs_dir(self):
+        return os.path.join(self.filters.sysfs_dir(), '%d' % self.idx)
+
+    def stage(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'type'), self.type_)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'matching'),
+                         'Y' if self.matching else 'N')
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'allow'),
+                         'Y' if self.allow else 'N')
+        if err is not None:
+            return err
+        if self.type_ == 'memcg':
+            err = write_file(os.path.join(self.sysfs_dir(), 'path'), self.path)
+            if err is not None:
+                return err
+        return None
+
+class DamonFilters:
+    filters = None
+    probe = None
+
+    def __init__(self, filters=None):
+        if filters is None:
+            filters = []
+        self.filters = filters
+        for idx, filter in enumerate(self.filters):
+            filter.filters = self
+            filter.idx = idx
+
+    def sysfs_dir(self):
+        return os.path.join(self.probe.sysfs_dir(), 'filters')
+
+    def stage(self):
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'nr_filters'),
+                len(self.filters))
+        if err is not None:
+            return err
+        for filter in self.filters:
+            err = filter.stage()
+            if err is not None:
+                return err
+        return None
+
+class DamonProbe:
+    weight = None
+    filters = None
+    probes = None
+    idx = None
+
+    def __init__(self, weight=0, filters=None):
+        self.weight = weight
+        if filters is None:
+            filters = DamonFilters()
+        self.filters = filters
+        self.filters.probe = self
+
+    def sysfs_dir(self):
+        return os.path.join(self.probes.sysfs_dir(), '%d' % self.idx)
+
+    def stage(self):
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'weight'), '%d' % self.weight)
+        if err is not None:
+            return err
+        return self.filters.stage()
+
+class DamonProbes:
+    probes = None
+    attrs = None
+
+    def __init__(self, probes=None):
+        if probes is None:
+            probes = []
+        self.probes = probes
+        for idx, probe in enumerate(self.probes):
+            probe.probes = self
+            probe.idx = idx
+
+    def sysfs_dir(self):
+        return os.path.join(self.attrs.sysfs_dir(), 'probes')
+
+    def stage(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'nr_probes'),
+                         len(self.probes))
+        if err is not None:
+            return err
+        for probe in self.probes:
+            err = probe.stage()
+            if err is not None:
+                return err
+        return None
+
 class DamonAttrs:
     sample_us = None
     aggr_us = None
@@ -577,11 +688,12 @@ class DamonAttrs:
     update_us = None
     min_nr_regions = None
     max_nr_regions = None
+    probes = None
     context = None
 
     def __init__(self, sample_us=5000, aggr_us=100000,
                  intervals_goal=None, update_us=1000000, min_nr_regions=10,
-                 max_nr_regions=1000):
+                 max_nr_regions=1000, probes=None):
         self.sample_us = sample_us
         self.aggr_us = aggr_us
         if intervals_goal is None:
@@ -591,6 +703,10 @@ class DamonAttrs:
         self.update_us = update_us
         self.min_nr_regions = min_nr_regions
         self.max_nr_regions = max_nr_regions
+        if probes is None:
+            probes = DamonProbes()
+        self.probes = probes
+        self.probes.attrs = self
 
     def interval_sysfs_dir(self):
         return os.path.join(self.context.sysfs_dir(), 'monitoring_attrs',
@@ -600,6 +716,9 @@ class DamonAttrs:
         return os.path.join(self.context.sysfs_dir(), 'monitoring_attrs',
                 'nr_regions')
 
+    def sysfs_dir(self):
+        return os.path.join(self.context.sysfs_dir(), 'monitoring_attrs')
+
     def stage(self):
         err = write_file(os.path.join(self.interval_sysfs_dir(), 'sample_us'),
                 self.sample_us)
@@ -629,6 +748,10 @@ class DamonAttrs:
         if err is not None:
             return err
 
+        err = self.probes.stage()
+        if err is not None:
+            return err
+
 class DamonCtx:
     ops = None
     monitoring_attrs = None
-- 
2.47.3
