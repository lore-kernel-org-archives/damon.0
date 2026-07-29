Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1F481ABA;
	Wed, 29 Jul 2026 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336466; cv=none; b=nj+Kqiwr6j57DZ5xoc3iIvAZi63pgpjENtkBl3nriC/JRcZvm99Fd/ySCmiPlH7oSSLRepnYU5jBwySvhbWMU4OB0mmiMwDsL+B2mL9zSO6WQZKBkyp5XiNgutHTFO9492VerNObRy7K/UDA8hwBMTn7NUkHDqJX3lfSKO871Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336466; c=relaxed/simple;
	bh=3ISTWX8zTj+8rMO8Umxt4ycJx1qijhS2xp238+eYmoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emzRJvOaPo2fKNUriysrouui8cjLC+3EQXYxDC2+qKI1xlPTWLmAl9DEeFpAboUHrCe+f7hsdZw7awDIv0h9vbY4uwAI2hBGNxCUGZhVmIlY/93QQE/rngY9/dR+j6K8T5i+AAjR0ujIjrRkTDonSkmN3mBE06m+IzjSknJQUnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNHltkMv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNHltkMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0511F00A3A;
	Wed, 29 Jul 2026 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336464;
	bh=mwjQw1xLqzHqBYImUshrguSPjjDssnEjrh3ssNL9R1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UNHltkMvmYCby19ALa5wg7iAKSZrOPnDmKLThfiLsot5LVKn3I/V6RJoFxKld+9Q9
	 uzv6bhF1zedlhP1VAhNYFrt6fS1HFXxRXdjYEFRtJMUfc+x4wIZAmDq2UV0b4B8S9D
	 SD+V1ljngrWJ0h9vRtZEwmj423oTf6w6jdy0GY6p5+KIQR2jLDckDWjiFpF8PyD6rk
	 mtDx7q+uMF70kX/6qoy+7qqR0aZsgdrR8HU+Bf/3l9SDpEZgRhLQaRXlCXq749rhmA
	 E1A41s5XuIusM6c3UfQGGLBj0PD3fglGW4UvzhluJ4emmj4VKtVnWz6HNO0N/1DDkq
	 /ioM5AGPNdtaw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/6] selftests/damon/_damon_sysfs: implement DamonProbes
Date: Wed, 29 Jul 2026 07:47:34 -0700
Message-ID: <20260729144738.90895-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729144738.90895-1-sj@kernel.org>
References: <20260729144738.90895-1-sj@kernel.org>
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
 tools/testing/selftests/damon/_damon_sysfs.py | 123 +++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index e6a2265d721e8..d6afb5b2f0a4a 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -558,6 +558,115 @@ class IntervalsGoal:
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
@@ -565,11 +674,12 @@ class DamonAttrs:
     update_us = None
     min_nr_regions = None
     max_nr_regions = None
+    probes = None
     context = None
 
     def __init__(self, sample_us=5000, aggr_us=100000,
                  intervals_goal=IntervalsGoal(), update_us=1000000,
-            min_nr_regions=10, max_nr_regions=1000):
+            min_nr_regions=10, max_nr_regions=1000, probes=None):
         self.sample_us = sample_us
         self.aggr_us = aggr_us
         self.intervals_goal = intervals_goal
@@ -577,6 +687,10 @@ class DamonAttrs:
         self.update_us = update_us
         self.min_nr_regions = min_nr_regions
         self.max_nr_regions = max_nr_regions
+        if probes is None:
+            probes = DamonProbes()
+        self.probes = probes
+        self.probes.attrs = self
 
     def interval_sysfs_dir(self):
         return os.path.join(self.context.sysfs_dir(), 'monitoring_attrs',
@@ -586,6 +700,9 @@ class DamonAttrs:
         return os.path.join(self.context.sysfs_dir(), 'monitoring_attrs',
                 'nr_regions')
 
+    def sysfs_dir(self):
+        return os.path.join(self.context.sysfs_dir(), 'monitoring_attrs')
+
     def stage(self):
         err = write_file(os.path.join(self.interval_sysfs_dir(), 'sample_us'),
                 self.sample_us)
@@ -615,6 +732,10 @@ class DamonAttrs:
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
