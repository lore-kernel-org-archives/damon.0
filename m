Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B60437FF54;
	Wed,  4 Mar 2026 04:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772599290; cv=none; b=Lhxf6Wlwkkr4jaD+xVdylL4eth+nZBaSBYsi6K0kZKLZe3rqatYfYdFqckk7AfKUj1DDNCD0abObK+55V6zOheckHTlxyvcCTYbFJiidxxumSb4TqmfyVwD444qPDu7U+IXmIT2oLDrem2h2/l2AU62awWTyjVwLYlJJnsbXvQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772599290; c=relaxed/simple;
	bh=+HQX6Y6KyyaMrF3l90vkRlVOFR5aGGsrQWEn3/nSaHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8HFgXMA4FIdHGM3F6UQY5gvyseV/72ZVkw8FAMR4VeO+VtrxDUTAKTk8V8w50hlvDI3wa3PHVrhcC3W84Gh9HyU7muN+OV8V7yERC9GIpdgte4BKF867XEKWU/vJ5mMjqh/g9CxLCUmwf/qt7EdYMBzExUHf7LGQA4Xw6Ippss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOANUg29; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOANUg29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FACC19423;
	Wed,  4 Mar 2026 04:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772599289;
	bh=+HQX6Y6KyyaMrF3l90vkRlVOFR5aGGsrQWEn3/nSaHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOANUg29JEMAPQXfb4thilzOeD36TUkrZ81dBj5gH2D+LNQbIVWdhnWG5NHTwV0pZ
	 gG5GLW/GaATT0afiYCs/w1glhlFTps9RK/5ybhSFNVvFX0V5NViHW/ctN2HDu/Z2Aq
	 mtpPZ4/4ZZpbdqEi0YG/gxt3qLkkXLk4g+I6ehv1K+oeAGE55FuFmZnvH7/IxWptKF
	 G0C+VJ6uqiqehkVxHiXaUMwNJnLv5OF+d0cFcHtqjAwx6ZtX3d4NO946bS5hQDgall
	 mQYiEqdUxGwqtcN0JhOJlh4FYTk7WjklMh//kBC8zIx+bv9x73r2wIPIJ3BNRN85mZ
	 ZGAOB8wTvryUQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 08/10] selftests/damon/_damon_sysfs: support goal_tuner setup
Date: Tue,  3 Mar 2026 20:41:17 -0800
Message-ID: <20260304044122.79394-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304044122.79394-1-sj@kernel.org>
References: <20260304044122.79394-1-sj@kernel.org>
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
