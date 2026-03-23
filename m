Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98846384228;
	Mon, 23 Mar 2026 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307744; cv=none; b=bP6M24jBC59DPOLiQYdaQyrHcCs2d5DfjwWcUZQ/C9V9+ffw0W4macbA1X33Z4b3dv1ARwsM/ST377XV/nBqLmOCzeiDJgg6TKuOBLxsVl2YgS2+ZQ+/3y4kOQ5Dh/krPV67VNNzccnwAJND6wRcGI4qWrqT6eGpopSUAIHulIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307744; c=relaxed/simple;
	bh=TJXeffpmshBn5e3s77gk9ewA/YmV5afqYkZ0L4RsmNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRAf9FthoR3dZmX+HfBeV4IJaGr2WAbTEGHjWv1oHdPuuPF92B5G92PlFjf2CKdD4ZWVNSHyn+kUIbLuoDX6VnchvHm/EC6bLGOotop/SdpBeeVnspGM9gr/ytGY4MRYazmEDeioG7pSx0DGy0KSGsf7jE0pzSgM1kcIoWYlPWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNqinUsu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNqinUsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604B4C2BCB5;
	Mon, 23 Mar 2026 23:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774307744;
	bh=TJXeffpmshBn5e3s77gk9ewA/YmV5afqYkZ0L4RsmNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNqinUsuiogjYHI1OaDQYljy/pynstj5DRWXkS8+qVtB9giaSeRU+M//H5Er5vicG
	 +B+hvUro+CkWmFCRcuJVzzZ+qt9qNrFiOmeHTop4Lvyq98qTOxNIx0ZWlO77e599EH
	 1dhUGMO/zMT8e+kZ5gGnByxZehl/W7zNOfgr6GcgQHSbJZmDTcheu9ncJgyCyURNST
	 yDf1zQJHFdIg9QWami6JphQlBr+gpWDsgxWS0L9oaRU1TmPPf6qfqKWyiiT2PC7ocM
	 RqwWgk6YC1fFh6MKUMa6dYJsRjxrgf5EmS6AfYMKH2Yeay3Jsi1UYqH+XK8BVBNDgl
	 T4AjfArJH4zDQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 07/10] selftests/damon/_damon_sysfs: support pause file staging
Date: Mon, 23 Mar 2026 16:15:32 -0700
Message-ID: <20260323231538.84452-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323231538.84452-1-sj@kernel.org>
References: <20260323231538.84452-1-sj@kernel.org>
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
