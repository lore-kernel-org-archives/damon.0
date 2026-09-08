Received: from mta0.migadu.com (out-7.mta0.migadu.com [91.218.175.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC81357983F
	for <damon@lists.linux.dev>; Tue,  8 Sep 2026 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884855; cv=none; b=kUX+4ukX6W7N9KvrMf8XCwGD39TltVGN/k30VKWu0HWyiEHwO1RJ32mUfqhSc/qguXzKsPHoyhytW3OCoCNzeGFzL1NJpGEmfsPm7NrU/aLRsgWyuXY1udN4VuiKdj3SBuezPBc/rgcRwbr95Lo8EwopUuB6yjpy8tS5jpU46W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884855; c=relaxed/simple;
	bh=P9rcx9cRYKzp1j2igJPf6N36DH81nBcUWy49yeFgq6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KBeSQv+fRUP0KCVM/SjvIda52Yebb4dj1ATHjS1OnZIxTmJ6tsh7TGoC0fW7nFyj/mU7AkUk0KgtvZDL06ijfCP2y4aJybi2m6MEeQpTLGYQzrZ1qlFjKUTojQ4iStVqhDbTSWQbnKuNLPoUas9wa4IFwBNCpFhHyk5guTsHTBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uY6g9PS7; arc=none smtp.client-ip=91.218.175.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uY6g9PS7"
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=P9rcx9cRYKzp1j2igJPf6N36DH81nBcUWy49yeFgq6s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788884850; v=1; x=1789489650;
 b=uY6g9PS7jFL3fQgacYlFZadH5klyrWZHPkaqhsknw1WBCFuEKKBiUpQBjC1/WQZjyF1aWjue
 ZTZErUWstlgmViILyrBOD1mCDCg6bK68aUqOXswZGALVbLKRIsA4XhmvNeTogpXWD4okYlbwHvJ
 0hu8JiZO7eTUA/H4IPlZMkm0=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 24572b4011ab19ae;
	Tue, 08 Sep 2026 16:27:30 +0000
X-Mizu-Trace-ID: 24572b4011ab19ae
X-Migadu-Flow: FLOW_OUT
From: Zenghui Yu <zenghui.yu@linux.dev>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: sj@kernel.org,
	shuah@kernel.org,
	"Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
Subject: [PATCH] selftests/damon: ignore test-generated damon_dump_output
Date: Wed,  9 Sep 2026 00:27:16 +0800
Message-ID: <20260908162716.85648-1-zenghui.yu@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>

sysfs.py and sysfs_no_op_commit_break.py dump the DAMON status collected
via drgn_dump_damon_status.py into a damon_dump_output file in the working
directory.  Ignore it so that running the tests in-tree does not pollute
git status.

Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
---
 tools/testing/selftests/damon/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
index 2f0297657c81..226bd7c4e072 100644
--- a/tools/testing/selftests/damon/.gitignore
+++ b/tools/testing/selftests/damon/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 access_memory
 access_memory_even
+damon_dump_output
-- 
2.53.0

