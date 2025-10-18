Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B042D8362;
	Sat, 18 Oct 2025 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760820293; cv=none; b=QHMoCFdfnc/pIb8cJUQGXRyJwgco8eRIPhrrKCJ8MEyN3mgaOy0wZwSxKerBsOAldqdgzG3X/nF7Bypn7o491M9wfnOuc+mwm3FHwT9nJ4Tpesu5f+BGG0WjEq9zuJBztQh2Ym8faoo09KQ8oKWDccTiD6xgTepYrrFIcUcs6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760820293; c=relaxed/simple;
	bh=S4lW4Yt0S7MkHRb5GuM0MpYSg8IJozn8ecS6DJPFv08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVb2LglC2WdMsMFOXlkoTA/4FvQI+o1YZMmP8zwlZ1HLW9upxOnWN/JXg2xDR0txR6Tvwub69Sj8s0Qt+aDJulekY/5tQKBdPl7EElYqJIsYT5rqe/mojwRrInb0uU2sUc4/KiTuia8N0dM1+zpGYgR1l4guJ+/t9wPXdJgnaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqXsi/52; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqXsi/52"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D96FC4CEFE;
	Sat, 18 Oct 2025 20:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760820292;
	bh=S4lW4Yt0S7MkHRb5GuM0MpYSg8IJozn8ecS6DJPFv08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DqXsi/52g5a5C4pINsXt4g4P/sejZ00AhNJflJ/NDCRkGGHM6Wo1b4RBxlcaJU3mp
	 3Qzyq8DIZRrbii3iw7BY/KyIObXLJtaRZ3zSV9gltUis/hoWGq2Ixan/X8kidTGNjX
	 Ez4IRFb4PzV5170Fs0vN/yWoglJJgf8x5Lzh2aLgHxcgtTm0OSJ2nlH4cNo8sPyZog
	 p6V3+s3CYVt/dr4+x8XMe2BarNkBFCQuv53m6pSc0yVbkur2G+dLxGhB5l0jH1FHSd
	 SZfIB/dJiMA6QYK7p+hvcUTaoL1VFxceXBC25QoJlFEEqo+nrNpZuKhLFLCI+LW2u9
	 zHPEz7x7FxxoQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/4] selftests/damon/_damon_sysfs: support obsolete_target file
Date: Sat, 18 Oct 2025 13:44:42 -0700
Message-ID: <20251018204448.8906-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251018204448.8906-1-sj@kernel.org>
References: <20251018204448.8906-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A DAMON sysfs file, namely obsolete_target, has newly introduced.  Add a
support of that file to _damon_sysfs.py so that DAMON selftests for the
file can be easily written.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index a0e6290833fb..748778b563cd 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -475,12 +475,14 @@ class Damos:
 
 class DamonTarget:
     pid = None
+    obsolete = None
     # todo: Support target regions if test is made
     idx = None
     context = None
 
-    def __init__(self, pid):
+    def __init__(self, pid, obsolete=False):
         self.pid = pid
+        self.obsolete = obsolete
 
     def sysfs_dir(self):
         return os.path.join(
@@ -491,8 +493,13 @@ class DamonTarget:
                 os.path.join(self.sysfs_dir(), 'regions', 'nr_regions'), '0')
         if err is not None:
             return err
-        return write_file(
+        err = write_file(
                 os.path.join(self.sysfs_dir(), 'pid_target'), self.pid)
+        if err is not None:
+            return err
+        return write_file(
+                os.path.join(self.sysfs_dir(), 'obsolete_target'),
+                'Y' if self.obsolete else 'N')
 
 class IntervalsGoal:
     access_bp = None
-- 
2.47.3
