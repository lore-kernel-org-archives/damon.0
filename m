Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364ED39A807;
	Thu, 19 Mar 2026 05:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773897729; cv=none; b=Wdp5KDXzTRZif1HqEDGrLjOru55qSFyq18C+bITL7G1ECr8jW6KbBLZ+yusJRQrYMOfaI6rOsAAsajS+ELvpA3UIlbAXsWHhv8BXI9IVeGxpZNIlPK2tipeJjh9rBe5ejot9T6WFxOA1Es7OfzZw4ae+JSxFRHApL/8ORfWIo98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773897729; c=relaxed/simple;
	bh=TJXeffpmshBn5e3s77gk9ewA/YmV5afqYkZ0L4RsmNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4zEOxAcgeA+g4uIw98j+xnIBNZdrwroUys+jD12YO/4/q9NRpqbWLSAHgVJXtUTxbD7GIHNq7/mnS6b+8rhQL4sRYDDrW7Rp4ehyBZPWzZIIDlXiNy6+OVeEh6NorwCtHwbVLIVJKucmbPnAI9DHeP699Gv9W/FVSBzTZLALhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP+831u3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP+831u3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF939C2BCAF;
	Thu, 19 Mar 2026 05:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773897729;
	bh=TJXeffpmshBn5e3s77gk9ewA/YmV5afqYkZ0L4RsmNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HP+831u3C18QuYGn+8t3T5P3MI5t8JSc7dy5v6wh8t5I2JM7wDsvYJtcnd2CG4WXb
	 Si2jJfp7u2Y0Ucbusoj+kXFBgx5w9aRc/CP/EMtLepFRkYcs9AsXfu5r4OX6ZxFul6
	 IL23kIeOz4DJRkZSsOFTisjdFe4/Ny9iC35R4nPcr+2yQ2CQsR4IgVZ7Mz5pg/taUs
	 jBz5XHpoCVL4py3uf4nX+TCbB5O6G3GK7TcWKZBfBsDXhMWeS+O38lNSfvADomo/DN
	 fizmoAkzJfawSrgRSVLM9PWp0Zfx3FDRVfDfsyUXH0PadUzjhDVz6RQZ/JpbOpxhCU
	 AdPVJbxg5atgw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 07/10] selftests/damon/_damon_sysfs: support pause file staging
Date: Wed, 18 Mar 2026 22:21:50 -0700
Message-ID: <20260319052157.99433-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319052157.99433-1-sj@kernel.org>
References: <20260319052157.99433-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON test-purpose sysfs interface control Python module, _damon_sysfs,
is not supporting the newly added pause file.  Add the support of the
file, for future test and use of the feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 2b4df655d9fd0..120b96ecbd741 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -604,10 +604,11 @@ class DamonCtx:
     targets = None
     schemes = None
     kdamond = None
+    pause = None
     idx = None
 
     def __init__(self, ops='paddr', monitoring_attrs=DamonAttrs(), targets=[],
-            schemes=[]):
+            schemes=[], pause=False):
         self.ops = ops
         self.monitoring_attrs = monitoring_attrs
         self.monitoring_attrs.context = self
@@ -622,6 +623,8 @@ class DamonCtx:
             scheme.idx = idx
             scheme.context = self
 
+        self.pause=pause
+
     def sysfs_dir(self):
         return os.path.join(self.kdamond.sysfs_dir(), 'contexts',
                 '%d' % self.idx)
@@ -662,6 +665,11 @@ class DamonCtx:
             err = scheme.stage()
             if err is not None:
                 return err
+
+        err = write_file(os.path.join(self.sysfs_dir(), 'pause'), self.pause)
+        if err is not None:
+            return err
+
         return None
 
 class Kdamond:
-- 
2.47.3
