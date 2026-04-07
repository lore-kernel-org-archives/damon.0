Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA022DFA4;
	Tue,  7 Apr 2026 01:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775523943; cv=none; b=jtc/Ohs/uwcPqAHsQC/4Brt2AAAnliHiQxuwsJJs8+uzebKD1U7wFRXTrPuGzvh/pYtZ9o2w5U+VMSgwqJzmmoYTquDTv73rqjoi1IBQBHc5Dpr1KlmA5AVF9yjc29YYktsTQukTFr6d9qdonTxamI+9u3WIXdAaeAUpihlbBsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775523943; c=relaxed/simple;
	bh=EIRB4p0R7OQMpXCAySjtmt5LRqO984ojhpZfxIiXyb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjrV+TLVkHcR8U9hzSQItGg/TNa7VrSgdi0bUoOxR2A5K6Qz4WUVNVHnUGdmcynj3cqCTlzEJ3ahB0+lK3z3wS2bB3S9lHPNITzrr68DemXIF8DxufX977PFELtgZpo1XxkPeR7LPACHMymYt1gdlcZieNIdbBVV34tAuKIqz4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODU85TTZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODU85TTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB1EC2BCAF;
	Tue,  7 Apr 2026 01:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775523943;
	bh=EIRB4p0R7OQMpXCAySjtmt5LRqO984ojhpZfxIiXyb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODU85TTZFKTroXbh8r0wzowseIcB6UbnnIAZwvCjg596LBqHtS4B2P2VMF8DO++xp
	 9i4el1WvytI0Bb+pqpNW/22vs+gwu1q8gvvBQh7icRxckaDeR3PTqwCnr6lCK209FS
	 YJqWZwCxiMtSZsrqMGQ08yhHIGwiTcLn41+MTks8Fhi2KkOVJPoLKZQhJUyBZstGDc
	 YKMq3altvB5TtX2OkOSNIdCTwIpUS+6m1PQ9jPXkLG/3sSxajMicrOx2GUXNaLHy9+
	 AJwQaN2AzfFKY5evddqDeXbEtsKAhg4Xk7v/O4IJy49aPax9GHmZFUPDo2BLwAj029
	 k8+fmjjZw5oSA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 08/10] selftests/damon/_damon_sysfs: support failed region quota charge ratio
Date: Mon,  6 Apr 2026 18:05:30 -0700
Message-ID: <20260407010536.83603-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407010536.83603-1-sj@kernel.org>
References: <20260407010536.83603-1-sj@kernel.org>
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
