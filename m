Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615FC311C1B;
	Sun,  5 Apr 2026 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775401960; cv=none; b=e7Tl0mpcRARxPEykK2eEGjEdcOvxOdtS0ORRu+e3K4WNosrPfutGciUkGwPVDsuxbXW27Bk7Z2Yl3Seiru3/+5Og91MfiDLurbTqK2EC6towsfj3UhCH7ir+HbjeGRiC0zzEucVYT2i+mNhCg6qKGwZta4COlPmqFuJg+e2PP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775401960; c=relaxed/simple;
	bh=EIRB4p0R7OQMpXCAySjtmt5LRqO984ojhpZfxIiXyb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMaLFIXskX/GJwOm8i+Mq7uKdKiYSbeE4MLaZNRv3J1zEdV8ETfrVqsvdRniG2l1FCWxjt3wWEuv6kf+fxT10pz8lws/SYZiksAmjPuwP2FuBIjRcrlFMxjmUP25mPh0a5H38tStMOVPrbL89sc8+DWn4qN0KnJ6nzjLHzy7nYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBd1tRlR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBd1tRlR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6419C2BCB0;
	Sun,  5 Apr 2026 15:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775401960;
	bh=EIRB4p0R7OQMpXCAySjtmt5LRqO984ojhpZfxIiXyb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBd1tRlRVlUqZHJkb40DOR3rwB5ijHVT51HL8st3yLtEpNxnDr+V5LAgnRMS1h9tc
	 bht0kR/NS2eydwDBc5GlVomCWgRW794wKrHKjCJu0XsfbpaL3D73rhO70ToMAL3vuE
	 avJZQ6i1ArYdQ/FPNjN1ZgO5LVoSGSaDyLJb8P0OSecsfu8p6JPlbg8OFi5Ok+SdXR
	 n+HpS2It8SRcWONBGR0ta44BtwsPw6LVWt+Np+OWz0d1uLG2PpIOfpamR88LKOU7wm
	 wziYjYnsnItV8m9AGxYcLVk33LIIOfM8wK2P/4wXK0f0gqm+OA7SceMsuBaWIv9OT2
	 NHzZqGLhifP8A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 7/9] selftets/damon/_damon_sysfs: support failed region quota charge ratio
Date: Sun,  5 Apr 2026 08:12:25 -0700
Message-ID: <20260405151232.102690-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260405151232.102690-1-sj@kernel.org>
References: <20260405151232.102690-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend _damon_sysfs.py for DAMOS action failed regions quota charge
ratio setup, so that we can add kselftest for the new feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 120b96ecbd741..8b12cc0484405 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -132,14 +132,17 @@ class DamosQuota:
     goals = None                # quota goals
     goal_tuner = None           # quota goal tuner
     reset_interval_ms = None    # quota reset interval
+    fail_charge_num = None
+    fail_charge_denom = None
     weight_sz_permil = None
     weight_nr_accesses_permil = None
     weight_age_permil = None
     scheme = None               # owner scheme
 
     def __init__(self, sz=0, ms=0, goals=None, goal_tuner='consist',
-                 reset_interval_ms=0, weight_sz_permil=0,
-                 weight_nr_accesses_permil=0, weight_age_permil=0):
+                 reset_interval_ms=0, fail_charge_num=0, fail_charge_denom=0,
+                 weight_sz_permil=0, weight_nr_accesses_permil=0,
+                 weight_age_permil=0):
         self.sz = sz
         self.ms = ms
         self.reset_interval_ms = reset_interval_ms
@@ -151,6 +154,8 @@ class DamosQuota:
         for idx, goal in enumerate(self.goals):
             goal.idx = idx
             goal.quota = self
+        self.fail_charge_num = fail_charge_num
+        self.fail_charge_denom = fail_charge_denom
 
     def sysfs_dir(self):
         return os.path.join(self.scheme.sysfs_dir(), 'quotas')
@@ -197,6 +202,18 @@ class DamosQuota:
                 os.path.join(self.sysfs_dir(), 'goal_tuner'), self.goal_tuner)
         if err is not None:
             return err
+
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'fail_charge_num'),
+                self.fail_charge_num)
+        if err is not None:
+            return err
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'fail_charge_denom'),
+                self.fail_charge_denom)
+        if err is not None:
+            return err
+
         return None
 
 class DamosWatermarks:
-- 
2.47.3
