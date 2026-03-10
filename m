Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851AE2FD68B;
	Tue, 10 Mar 2026 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104741; cv=none; b=GuUcuKXlfmBPh0jkaOzZNvFWpofmw1VdmVOoSYdbo/gMTSOSQ6VVDLmPajdhg9VNdwdYSa1OjZuErl3el9zVWsKY/chFeFng2TY9712buRXtWiHfTjN37hCgN1AczuvZxNFz/H+YTs0+Bh34Y3M3Po2za/ReAoXIWqIMOItA71c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104741; c=relaxed/simple;
	bh=+HQX6Y6KyyaMrF3l90vkRlVOFR5aGGsrQWEn3/nSaHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPIyCywXt/Z0QQsCm9sgT2bU+hppF3VkGzaKIroMwSn9p1Ze25UPtsTGPv1xhY5dyg5JhwE8U9SzpNwqIXHs6hCVJTuzGRfAFJUlOinLOZ8nIwxCcXcdngkLuJpwhlGgZ1oHUZoNGazxsPxNE8MzX4A+KaVOIJJjDzhAbKpJf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIfVawCJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIfVawCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1CBC2BC9E;
	Tue, 10 Mar 2026 01:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773104741;
	bh=+HQX6Y6KyyaMrF3l90vkRlVOFR5aGGsrQWEn3/nSaHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIfVawCJQa9bYg3f7JUHsBC/cPW2bdAnnuZpTLNWgt9P9RklDCFBYGMDfUdzC6G3V
	 5Q6H8vmJ5r/SXhNnueZA+Ey/nacn36kqUhS+83S5h3P0gCKdxYb5zNgPnb8G9s0Ro+
	 hkwLzCze0vumYA5pjIi2s/Jp1bCMlT5Fw2Upw6OuJZ8qVpIftBr96LBsgKqGqQr7GP
	 IvdSJKLYsM8VsSYj1FS9tsTVXKxisFssiekxS3kf4eJTse9g77xFLA50oQn1oeDbfZ
	 +eBa8bJMqIfcoJu5dsafmpwPdSiUn4mfAdE8X/gWSS5tX0s37m241rujWZyOr51eEE
	 Fa/SNDczfXaVQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/11] selftests/damon/_damon_sysfs: support goal_tuner setup
Date: Mon,  9 Mar 2026 18:05:25 -0700
Message-ID: <20260310010529.91162-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310010529.91162-1-sj@kernel.org>
References: <20260310010529.91162-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support of goal_tuner setup to the test-purpose DAMON sysfs
interface control helper, _damon_sysfs.py.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 748778b563cd2..2b4df655d9fd0 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -130,15 +130,16 @@ class DamosQuota:
     sz = None                   # size quota, in bytes
     ms = None                   # time quota
     goals = None                # quota goals
+    goal_tuner = None           # quota goal tuner
     reset_interval_ms = None    # quota reset interval
     weight_sz_permil = None
     weight_nr_accesses_permil = None
     weight_age_permil = None
     scheme = None               # owner scheme
 
-    def __init__(self, sz=0, ms=0, goals=None, reset_interval_ms=0,
-                 weight_sz_permil=0, weight_nr_accesses_permil=0,
-                 weight_age_permil=0):
+    def __init__(self, sz=0, ms=0, goals=None, goal_tuner='consist',
+                 reset_interval_ms=0, weight_sz_permil=0,
+                 weight_nr_accesses_permil=0, weight_age_permil=0):
         self.sz = sz
         self.ms = ms
         self.reset_interval_ms = reset_interval_ms
@@ -146,6 +147,7 @@ class DamosQuota:
         self.weight_nr_accesses_permil = weight_nr_accesses_permil
         self.weight_age_permil = weight_age_permil
         self.goals = goals if goals is not None else []
+        self.goal_tuner = goal_tuner
         for idx, goal in enumerate(self.goals):
             goal.idx = idx
             goal.quota = self
@@ -191,6 +193,10 @@ class DamosQuota:
             err = goal.stage()
             if err is not None:
                 return err
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'goal_tuner'), self.goal_tuner)
+        if err is not None:
+            return err
         return None
 
 class DamosWatermarks:
-- 
2.47.3
