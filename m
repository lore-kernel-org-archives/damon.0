Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204C0302163;
	Tue, 28 Apr 2026 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340074; cv=none; b=gQaChxIDJGBuuiDeiLyPZnQPerrW8WcsH8ttPWP/56yG2m+HcmWbGclJEzyWWuRU9s8B1CfmnBWnzvTRC4UcUEbAzcrDNjsGUpOM2WAX3+VIn3tdLF04V3f7dp+tID1zFYxPGZZmYeVR4snJq0ltiIngW1zFyVpAGB4GWIfMbfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340074; c=relaxed/simple;
	bh=EIRB4p0R7OQMpXCAySjtmt5LRqO984ojhpZfxIiXyb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pj8zsAnRsrCYaf0IKkclajMEgh8aNq9E/j8xrWlD/S72i2jm0ojS/QkRl3/0/A6C10kU399eHW5N2ygdecrLcR1hp2rVr1KhKRQ8KpCZRZE5/pL2+4RMKpiiMa77wyawqMaMaMLBdGNNifVkJ11GPcqCsezL6bCNuxwa4kcRVSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZcZnAsu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZcZnAsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE91AC2BCB8;
	Tue, 28 Apr 2026 01:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777340074;
	bh=EIRB4p0R7OQMpXCAySjtmt5LRqO984ojhpZfxIiXyb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZZcZnAsupewrX89PIOmNdOhVn2+tqOay0z0k+NxczHczuwJXZkL1AoRFErP2NRR3h
	 ZVngppoziqRmwTzbPeXG+Zmk93VHdDtxyJ8G0vaH3qhGJDnJQUtEt9EtWYuQjNjWcE
	 R/89iG/BQ8mgkA6w9BoppTli74ZSzaOxvHkijdpIu2sC+ke0TAC76jO5/2lUkMHaKd
	 wHlMBrceCK98vgBAqlonoYeX8uB7gcACQhDvCW7U+ptOijpxvZrqqtKZYtSA94GgPd
	 GbQfpJRI8KMS1lRa/r4ZWKyX4BPpWQpFOst0Sm0HrwF33He1ci2rnEzcqzG/QG2W7k
	 IPXfPt7l45kkw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/11] selftests/damon/_damon_sysfs: support failed region quota charge ratio
Date: Mon, 27 Apr 2026 18:33:58 -0700
Message-ID: <20260428013402.115171-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428013402.115171-1-sj@kernel.org>
References: <20260428013402.115171-1-sj@kernel.org>
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
