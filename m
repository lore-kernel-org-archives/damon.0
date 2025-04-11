Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D37279339
	for <damon@lists.linux.dev>; Fri, 11 Apr 2025 02:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744339465; cv=none; b=gwi5iP7LcHFFOjlnyYdObmuxvp6M+X0W/MLVtOKRrgxvWId6+VRV+f4+ETtD+sNQGSSueNCz6QIPAPFHDQDAj1iDCCyKQRhwE8Ek+lhsQPq8U8bl4F56Eg8GvhPBqmsnEIPuh1xkcvV5DWzNggR3Fdh84s81DH2rJVjQQ+c/9Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744339465; c=relaxed/simple;
	bh=oeIaLDaTl1GxI52Jf+x4wczd9S1NjYh9ZsG9liseCaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WkhbeGRl5Bofo6nxqgO2e649chPMkF17I4Y6lIq9jcuOn16fx9HFZ4jJ2tDlGmZiK4dS9s/DlguKTZR6lRmt00s6CV+1rxRzJW8wpFhnPIBTO7REMkRpS/bys8k4+8xpyADXh9gc7vB/lK9FockV+/jea4BJwk8wgotQIWVwNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cpr+11hL; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cpr+11hL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744339458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SPIWqsTjCW4p+yM3tP7JZLgi04R4eD2wyVkEzOwtWrA=;
	b=Cpr+11hLqt/ykMVq5FCsaSsF18GozjBmXH3ICxUtgNsF4GyuLKY3WWAIw573JU7PxxJXWX
	HF11BRUYBGWYkjk5wi3jYYeiX/boZN2y4h+elL0DyIKYaTVuGIVol22n45E22Krk7fQRp8
	ngulYARc0RKMkCQcK1XgDMBWArnr9fg=
From: Enze Li <enze.li@linux.dev>
To: sj@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@linux.dev,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] selftests/damon: Remove the remaining test scripts for DAMON debugfs interface
Date: Fri, 11 Apr 2025 10:43:32 +0800
Message-ID: <20250411024332.1373861-1-enze.li@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Enze Li <lienze@kylinos.cn>

DAMON has dropped debugfs support; therefore, remove these unused
scripts.

Fixes: 5ec4333b1967 ("mm/damon: remove DAMON debugfs interface")
Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 tools/testing/selftests/damon/Makefile        |  2 +-
 .../selftests/damon/_chk_dependency.sh        | 52 ---------------
 .../selftests/damon/_debugfs_common.sh        | 64 -------------------
 3 files changed, 1 insertion(+), 117 deletions(-)
 delete mode 100644 tools/testing/selftests/damon/_chk_dependency.sh
 delete mode 100644 tools/testing/selftests/damon/_debugfs_common.sh

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index ecbf07afc6dd..ff21524be458 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -3,7 +3,7 @@
 
 TEST_GEN_FILES += access_memory access_memory_even
 
-TEST_FILES = _chk_dependency.sh _damon_sysfs.py
+TEST_FILES = _damon_sysfs.py
 
 # functionality tests
 TEST_PROGS += sysfs.sh
diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
deleted file mode 100644
index dda3a87dc00a..000000000000
--- a/tools/testing/selftests/damon/_chk_dependency.sh
+++ /dev/null
@@ -1,52 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-DBGFS=$(grep debugfs /proc/mounts --max-count 1 | awk '{print $2}')
-if [ "$DBGFS" = "" ]
-then
-	echo "debugfs not mounted"
-	exit $ksft_skip
-fi
-
-DBGFS+="/damon"
-
-if [ $EUID -ne 0 ];
-then
-	echo "Run as root"
-	exit $ksft_skip
-fi
-
-if [ ! -d "$DBGFS" ]
-then
-	echo "$DBGFS not found"
-	exit $ksft_skip
-fi
-
-if [ -f "$DBGFS/monitor_on_DEPRECATED" ]
-then
-	monitor_on_file="monitor_on_DEPRECATED"
-else
-	monitor_on_file="monitor_on"
-fi
-
-for f in attrs target_ids "$monitor_on_file"
-do
-	if [ ! -f "$DBGFS/$f" ]
-	then
-		echo "$f not found"
-		exit 1
-	fi
-done
-
-permission_error="Operation not permitted"
-for f in attrs target_ids "$monitor_on_file"
-do
-	status=$( cat "$DBGFS/$f" 2>&1 )
-	if [ "${status#*$permission_error}" != "$status" ]; then
-		echo "Permission for reading $DBGFS/$f denied; maybe secureboot enabled?"
-		exit $ksft_skip
-	fi
-done
diff --git a/tools/testing/selftests/damon/_debugfs_common.sh b/tools/testing/selftests/damon/_debugfs_common.sh
deleted file mode 100644
index 54d45791b0d9..000000000000
--- a/tools/testing/selftests/damon/_debugfs_common.sh
+++ /dev/null
@@ -1,64 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-test_write_result() {
-	file=$1
-	content=$2
-	orig_content=$3
-	expect_reason=$4
-	expected=$5
-
-	if [ "$expected" = "0" ]
-	then
-		echo "$content" > "$file"
-	else
-		echo "$content" > "$file" 2> /dev/null
-	fi
-	if [ $? -ne "$expected" ]
-	then
-		echo "writing $content to $file doesn't return $expected"
-		echo "expected because: $expect_reason"
-		echo "$orig_content" > "$file"
-		exit 1
-	fi
-}
-
-test_write_succ() {
-	test_write_result "$1" "$2" "$3" "$4" 0
-}
-
-test_write_fail() {
-	test_write_result "$1" "$2" "$3" "$4" 1
-}
-
-test_content() {
-	file=$1
-	orig_content=$2
-	expected=$3
-	expect_reason=$4
-
-	content=$(cat "$file")
-	if [ "$content" != "$expected" ]
-	then
-		echo "reading $file expected $expected but $content"
-		echo "expected because: $expect_reason"
-		echo "$orig_content" > "$file"
-		exit 1
-	fi
-}
-
-source ./_chk_dependency.sh
-
-damon_onoff="$DBGFS/monitor_on"
-if [ -f "$DBGFS/monitor_on_DEPRECATED" ]
-then
-	damon_onoff="$DBGFS/monitor_on_DEPRECATED"
-else
-	damon_onoff="$DBGFS/monitor_on"
-fi
-
-if [ $(cat "$damon_onoff") = "on" ]
-then
-	echo "monitoring is on"
-	exit $ksft_skip
-fi

base-commit: 3b07108ada81a8ebcebf1fe61367b4e436c895bd
-- 
2.43.0

