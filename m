Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133337C935;
	Sun, 15 Mar 2026 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773608425; cv=none; b=uHOE/YGRfnmcLiHBnSgw3CoNYgFBBeIxzmsHcNnY1umsNS65AGkTo3Xd0mk0RIoUSQp+aO6hXf9rJ/GOFxIKGY55OyGLVGHF6a0kGxDSwTByI6HdUzN+WFUkgaXoEOqEYh2aIY1M5M4rvuaG5nFB4VpsDHdQ93O5WW9FmdeUFtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773608425; c=relaxed/simple;
	bh=TJXeffpmshBn5e3s77gk9ewA/YmV5afqYkZ0L4RsmNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBCIBdIS5YtKQBcxVa9EeEjSuVPjcqEMzTktoeLrEAKOTip5ymjILHy7jnmXyXme6nMlRQi201wLO3qjwIeFKaWIj+QBFtnQ5TIlXiZujDAtfHq7fm12V4uz4Fu62NeDeFCeDGkx0qgTompZszKF/6Uw5z8oEcd1hOEM+LD+ljA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYTN4IFR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYTN4IFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0699C4AF09;
	Sun, 15 Mar 2026 21:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773608425;
	bh=TJXeffpmshBn5e3s77gk9ewA/YmV5afqYkZ0L4RsmNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYTN4IFRaRp+sesyBx8wFBO0MD+H2iyBHeaY5dDSP6FDhKvuHXHrcIDjBS4EDdrzV
	 Ft+7xIeOrtAAg0/ch/Qv/rZIr91vvxCynNYUsZp5K1iBP9MJi0PG681M9kKl3Bs/Kd
	 nJnEaSlgkmaxMyQ+lwGsMJ1hqFtOi/KCml7i6xRkyZvt2iTqbk9NhEMXhD83oeYIt8
	 2gZCsC0bXBZs3KHDfvBcTSAhsvM5Ac/TQ+WNMyqiEvXn4RwG26DoE/4sKWqF8OHxUu
	 3xjeOznxucWkfXN2/FzB8we6ipAiJ9YK8DxiHoOuHmZXfyOC8vWQ1vgnSWp+K7I6UX
	 Nm+pnZnWyq1FA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/10] selftests/damon/_damon_sysfs: support pause file staging
Date: Sun, 15 Mar 2026 14:00:06 -0700
Message-ID: <20260315210012.94846-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315210012.94846-1-sj@kernel.org>
References: <20260315210012.94846-1-sj@kernel.org>
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
