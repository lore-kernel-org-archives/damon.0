Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD4946AEFE;
	Mon, 14 Sep 2026 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395608; cv=none; b=Bk4t03je4M9XD8bL4t3c950QynJGX5gdMQC0vPatgYMiHMRZtXr/pzfnBcM/k4+o87XfIw7qaEA7/+3KLVIP00Q9kTPCEofMArXLSBsLO/HLuJMi7/yqjO16ZvQY6MTS02Z0PWWcXuk1QKYRUSr5moVtNkoHZzvrAyz7iVIojrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395608; c=relaxed/simple;
	bh=YkUGaOGxAboONSlOCUlrI0V3DUz26aswBLoll6hE1Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKYGmvJVbyO9wSZPsiSw26HFt6EXOWym7ez4eK9PS5GP3oWKJSLzXFqN0pg5fQsEhMLsr6SpD4I3/1+vss+d/GSSbMU82VzvLyM2WPp1XGqqzeaPfpNbaMS7+2anQJLi/RFiyUuRZ3B4lV2mJJOt0wo6zZHykrz7YE0shJEsz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJpoxhar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJpoxhar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F381F0089A;
	Mon, 14 Sep 2026 14:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395602;
	bh=iMSM+RY05r6OH+v1CtMIxEVXYlWKzTDj5y/6JWGPvKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QJpoxhar5EcAr9Tj32UEKCjB7ygUKbu+YQU2MwEULu89BluCAJAvbiz8D9aLFe3YG
	 m4O61hGCSQ0UYdO8yIgUDixQlB/et1Zirheejfmo2ktwuCi9r78kzt8BPtFgRqgAaK
	 +V13J3DqhduxvjoE1QY0FHOAfyKFB+Pz/Ig249foADiDCtx+eEA3yPQT2WcsNgafrD
	 OoAJudEDwKaYMoCTZQ44t5loXVYBMqre193GtpoUpCzRikHp8b7PTkneOrR/PF55Cr
	 eRw7wbeExZ967wBmO1MYstDrdkz3rC5DwnrmueWTUku27UgrfALTFxxvXDiCtCobf3
	 dzdsJmnzyR7Fw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/6] selftests/damon: add script dir to sys.path for PYTHONSAFEPATH compatibility
Date: Mon, 14 Sep 2026 07:19:48 -0700
Message-ID: <20260914141952.91465-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914141952.91465-1-sj@kernel.org>
References: <20260914141952.91465-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>

Running these tests under Python's safe path mode, either with -P on the
interpreter command line or with PYTHONSAFEPATH set in the environment,
stops the script's own directory being prepended to sys.path. Some
distributions (RHEL, for example) build the tests with -P in the shebang.

This breaks all 7 DAMON Python selftests that import the _damon_sysfs
helper module located in the same directory:

  ModuleNotFoundError: No module named '_damon_sysfs'

Fix this by explicitly adding the script's directory to sys.path before
importing _damon_sysfs, following the same pattern used in commit
c3b3eb565bd7 ("tools: ynl: add script dir to sys.path") which fixed the
identical issue for the YNL tools.

Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260908214238.2680324-1-eva.kurchatova@virtuozzo.com
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 tools/testing/selftests/damon/damon_nr_regions.py              | 3 +++
 tools/testing/selftests/damon/damos_apply_interval.py          | 3 +++
 tools/testing/selftests/damon/damos_quota.py                   | 3 +++
 tools/testing/selftests/damon/damos_quota_goal.py              | 3 +++
 tools/testing/selftests/damon/damos_tried_regions.py           | 3 +++
 .../selftests/damon/sysfs_update_schemes_tried_regions_hang.py | 3 +++
 .../damon/sysfs_update_schemes_tried_regions_wss_estimation.py | 3 +++
 7 files changed, 21 insertions(+)

diff --git a/tools/testing/selftests/damon/damon_nr_regions.py b/tools/testing/selftests/damon/damon_nr_regions.py
index 58f3291fed12a..e55239813c654 100755
--- a/tools/testing/selftests/damon/damon_nr_regions.py
+++ b/tools/testing/selftests/damon/damon_nr_regions.py
@@ -1,9 +1,12 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+import os
 import subprocess
+import sys
 import time
 
+sys.path.append(os.path.dirname(os.path.abspath(__file__)))
 import _damon_sysfs
 
 def test_nr_regions(real_nr_regions, min_nr_regions, max_nr_regions):
diff --git a/tools/testing/selftests/damon/damos_apply_interval.py b/tools/testing/selftests/damon/damos_apply_interval.py
index 0f2f36584e48c..0bf7768b2006a 100755
--- a/tools/testing/selftests/damon/damos_apply_interval.py
+++ b/tools/testing/selftests/damon/damos_apply_interval.py
@@ -1,9 +1,12 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+import os
 import subprocess
+import sys
 import time
 
+sys.path.append(os.path.dirname(os.path.abspath(__file__)))
 import _damon_sysfs
 
 def main():
diff --git a/tools/testing/selftests/damon/damos_quota.py b/tools/testing/selftests/damon/damos_quota.py
index 57c4937aaed28..879115a499bf8 100755
--- a/tools/testing/selftests/damon/damos_quota.py
+++ b/tools/testing/selftests/damon/damos_quota.py
@@ -1,9 +1,12 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+import os
 import subprocess
+import sys
 import time
 
+sys.path.append(os.path.dirname(os.path.abspath(__file__)))
 import _damon_sysfs
 
 def main():
diff --git a/tools/testing/selftests/damon/damos_quota_goal.py b/tools/testing/selftests/damon/damos_quota_goal.py
index 661e4ba4765ae..fed033a0afdf9 100755
--- a/tools/testing/selftests/damon/damos_quota_goal.py
+++ b/tools/testing/selftests/damon/damos_quota_goal.py
@@ -1,9 +1,12 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+import os
 import subprocess
+import sys
 import time
 
+sys.path.append(os.path.dirname(os.path.abspath(__file__)))
 import _damon_sysfs
 
 def main():
diff --git a/tools/testing/selftests/damon/damos_tried_regions.py b/tools/testing/selftests/damon/damos_tried_regions.py
index d6472e6a6e082..6941f87c10b1c 100755
--- a/tools/testing/selftests/damon/damos_tried_regions.py
+++ b/tools/testing/selftests/damon/damos_tried_regions.py
@@ -1,9 +1,12 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+import os
 import subprocess
+import sys
 import time
 
+sys.path.append(os.path.dirname(os.path.abspath(__file__)))
 import _damon_sysfs
 
 def main():
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
index 28c887a0108fd..625761c243b58 100755
--- a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
@@ -1,9 +1,12 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+import os
 import subprocess
+import sys
 import time
 
+sys.path.append(os.path.dirname(os.path.abspath(__file__)))
 import _damon_sysfs
 
 def main():
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
index 16fdc6e7fc566..36e7ae5f826d8 100755
--- a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
@@ -1,9 +1,12 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+import os
 import subprocess
+import sys
 import time
 
+sys.path.append(os.path.dirname(os.path.abspath(__file__)))
 import _damon_sysfs
 
 def pass_wss_estimation(sz_region):
-- 
2.47.3
