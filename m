Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818449;
	b=Dr9+rGOQaTEGiHzGufm6nOGKnY9h97qPtebMgoad6uk428J1W5fMPTpGVoOc1mC4AAKe
	 UT02GNxEVlm4Ccvu+DcPyHkWpa2yf1oZ/rInt10SxYGLGXtwwojPwk8y1V14cDOE/W3m6
	 hqOFP1HsnF/1331fGRLu2FHT9y0WiRtcMm8hhwwHSX4kNzrI8+JDFYhwsOGWwPrdnBIPi
	 8cFvDF7NEkfADxnFGtlut+H/4Lly7Tj4PrQK8oMi38mCO2MM7yn32jP+bablp7Dlv2tc6
	 7ofuwwBof1FjYZYWz405KKnz957VzaxGnkaARC1uAwxZ0dPSJLPZ4x2O9kR3N58MOeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818449;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o7wpSeL6G0QpGcEme2lV9PTUvLXdPq2HjfhafRLkksA=;
	b=HkSpKbLQM8X8oeFh93VymAGk/c5Fa4ldr/U0Q1oNswxh6i5ruFLa88uS1qnGYA+c5qZY
	 0RUG4oioty0250f/Yf/v37TXXLtrinz0aWMsfSe01GlA0lblJDbBVUy0N+U+V26GOOzao
	 Mu6RIthjYJeR642vsLNAt1r6fueBfiazXHYJXLCOJnlUKK+Gne0o8wvs/cQ9pP0PvBUPJ
	 95cZpRCN3iFf6SaphXrp8ENv64Tgj7+j2t2oVXxhbTv5fZWOJcJ5wXNPrU0ZzATT8OvCF
	 69YlCcTl6ASNG3wS+JGw97T+SErjrOWwSVIdfPF2hK7Q+0cVG8x2jSCAY7CXJLOMyZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3XW1xeQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E56606A31C;
	Fri, 27 Nov 2026 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3XW1xeQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC3C1F000C1;
	Fri, 27 Nov 2026 22:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795818449;
	bh=o7wpSeL6G0QpGcEme2lV9PTUvLXdPq2HjfhafRLkksA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N3XW1xeQJIu91zH9xJxXcHbsY8f6yJtA6RKUhKQB05gVInyO4c5F54h80kdIok9SQ
	 8OOxnFMh1zByumc3kY3O8XkLSf1VgacLKYUQZKFBtZB6JdlLlB7XOwBjXdodlKfTfe
	 4ddESz76Z9BEe2lGtMapwNXJKyWcqmM6m9WQbefre5kdM217u/NjM4yl/Y9nla7Fjx
	 LdRMJECxCLKu5MR0+SzHTNgoIwuGC+sZl/uX5nM22PNHvcYrzzWns5oGYb+QeYIxu5
	 dkmcF7DderJW99K/vNRGvbgZRswr4LgjE4i9w1xWHNjd5xvzvMxBHUexXPCBHYoeDe
	 vSRwr9ciJ98mg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 6/7] selftests/damon: remove unused imports of sys and time modules
Date: Fri, 27 Nov 2026 14:27:17 -0800
Message-ID: <20261127222719.105510-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127222719.105510-1-sj@kernel.org>
References: <20261127222719.105510-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs_no_op_commit_break.py imports 'sys' module but never uses it.
sysfs_update_schemes_tried_regions_hang imports 'time' module but never
uses it.  Remove the unnecessary imports.

The issue is found using flake8.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs_no_op_commit_break.py        | 1 -
 .../selftests/damon/sysfs_update_schemes_tried_regions_hang.py   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
index 81774ddc55ac..5664f75186ba 100755
--- a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
+++ b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
@@ -4,7 +4,6 @@
 import json
 import os
 import subprocess
-import sys
 
 import _damon_sysfs
 
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
index 625761c243b5..326a14f04053 100755
--- a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
@@ -4,7 +4,6 @@
 import os
 import subprocess
 import sys
-import time
 
 sys.path.append(os.path.dirname(os.path.abspath(__file__)))
 import _damon_sysfs
-- 
2.47.3
