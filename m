Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E3E7F
	for <damon@lists.linux.dev>; Mon,  7 Nov 2022 16:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3E2C4347C;
	Mon,  7 Nov 2022 16:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667839806;
	bh=9HGMZvb82sypIRoPvUis/kF/0CFkMhQKBGHkFijQToc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPectMM1/5QJ1zmK7cZ7bFJgbJp7443q6YznAqCicO+0SL7aIL9Ou2v5xPpXfmSAr
	 0t3jEcSv68Hquf8wJKa8BFtg1tdZKx+GZV+3JQksHxTobX2UIy36CKcbe8WB6mSjHX
	 LVA0JKqVZ7dGy7I5p6DnZ+XgB1Y9bUONIy2kwYw0Z5WNEng7FgZzKdSsSjdNP7AeyE
	 HAwkI+upl+9Z3udy7DsKPi72rtgbiRJ4XxS1eDPBrlIch1b3WYrELHSZ/i7k5X3yLV
	 vvV0sSmOfuqImb6yC++5lvOQ338tCW1j8ooYAfkAQRvzrhqoxYrCDMdoXC1XvfP21k
	 QbWp0n7zkh3Kg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 2/2] selftests/damon: test non-context inputs to rm_contexts file
Date: Mon,  7 Nov 2022 16:50:01 +0000
Message-Id: <20221107165001.5717-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107165001.5717-1-sj@kernel.org>
References: <20221107165001.5717-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a bug[1] that triggered by writing non-context DAMON debugfs
file names to the 'rm_contexts' DAMON debugfs file.  Add a selftest for
the bug to avoid it happen again.

[1] https://lore.kernel.org/damon/000000000000ede3ac05ec4abf8e@google.com/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |  1 +
 .../damon/debugfs_rm_non_contexts.sh          | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100755 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index af490acc5348..838a8e49f77b 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -7,6 +7,7 @@ TEST_FILES = _chk_dependency.sh _debugfs_common.sh
 TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
 TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
 TEST_PROGS += debugfs_duplicate_context_creation.sh
+TEST_PROGS += debugfs_rm_non_contexts.sh
 TEST_PROGS += sysfs.sh
 TEST_PROGS += reclaim.sh lru_sort.sh
 
diff --git a/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh b/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
new file mode 100755
index 000000000000..48b7af6b022c
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source _debugfs_common.sh
+
+# Test putting non-ctx files/dirs to rm_contexts file
+# ===================================================
+
+dmesg -C
+
+for file in "$DBGFS/"*
+do
+	echo "$(basename "$f")" > "$DBGFS/rm_contexts"
+	if dmesg | grep -q BUG
+	then
+		dmesg
+		exit 1
+	fi
+done
-- 
2.25.1

