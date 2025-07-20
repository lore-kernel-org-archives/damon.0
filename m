Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49783224B14;
	Sun, 20 Jul 2025 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031822; cv=none; b=pm9AKtBJrLzhyF3g3+hz+gVp0BX+8IH4K3EylKIGqyObzAcsvN1kf9aNg++zNVLZVz1dZEU/WCwNTJd7QEW17y7M69ml9YyeYl0/Fm8dOx1FEd6Hm6U51EurJYTDO1UkVeOnvGA/j8Z3C5wio99l9REqDSxd/93Bqjw6Xzs6AGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031822; c=relaxed/simple;
	bh=uDGOXuisSHH2yLdNvqjy5dI087RwDAzdaOJ4u0Bocck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LsENhAkJCjyAmD0CrNO1IEmbxKKjr01T23uUnVnoRaJMPlZThIA75eA35TtRhKLfO4QJ6hjiGr2SHrlmLYMQNBF0/WAbEYdSHJ33J4IqOvgkxBKY+Bdq4bKRnnFZidspOv/hBbWHv9iAqdk0EZogbHjaT43NXne0TctOD8kmMZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/4sPHbg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/4sPHbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0090FC4CEEB;
	Sun, 20 Jul 2025 17:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031822;
	bh=uDGOXuisSHH2yLdNvqjy5dI087RwDAzdaOJ4u0Bocck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/4sPHbgpENYqB/ea7DWhvbIe/KAJMxh5MkehXWbl5ouWM7rk6WidxQVKFH2ZW1lU
	 Ek9Q7datmcET+2AHE4Xfybm1k0gs4mOrA06SAsl5CJ4BDcSVOK5ePr6QehRTDNClq0
	 oz94/8xQjesd4EG6h2vDzhX6t9+qSie0k6CSfOUXcCGvegCLgeWhNZzCwwa8piqspO
	 z+9L6AnVJmCjUJidvLK8jmEVRY9SMDE/MppoZErfhu954t6Mfix6sAdFB9Vq8yH6Jh
	 2t67cqsddq5FTyLBAet4Tuh+rRRegupLcRZ6U7aHgu6UR2FLWcpQNE9WEm7a1T5yTo
	 fheO6q1cbXjfA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/22] selftests/damon/_damon_sysfs: support DAMOS quota goal nid setup
Date: Sun, 20 Jul 2025 10:16:35 -0700
Message-Id: <20250720171652.92309-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720171652.92309-1-sj@kernel.org>
References: <20250720171652.92309-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_damon_sysfs.py contains code for test-purpose DAMON sysfs interface
control.  Add support of DAMOS quota goal nid setup for more tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 12d076260b2b..23de9202b4e3 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -93,14 +93,16 @@ class DamosQuotaGoal:
     metric = None
     target_value = None
     current_value = None
+    nid = None
     effective_bytes = None
     quota = None            # owner quota
     idx = None
 
-    def __init__(self, metric, target_value=10000, current_value=0):
+    def __init__(self, metric, target_value=10000, current_value=0, nid=0):
         self.metric = metric
         self.target_value = target_value
         self.current_value = current_value
+        self.nid = nid
 
     def sysfs_dir(self):
         return os.path.join(self.quota.sysfs_dir(), 'goals', '%d' % self.idx)
@@ -118,6 +120,10 @@ class DamosQuotaGoal:
                          self.current_value)
         if err is not None:
             return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'nid'), self.nid)
+        if err is not None:
+            return err
+
         return None
 
 class DamosQuota:
-- 
2.39.5
