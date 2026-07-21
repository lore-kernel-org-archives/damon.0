Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47F30F94D
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 06:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784613970; cv=none; b=MtRDLkHTlNnW/hhcEetE36+SyATeQSnOH/lPGF+smjW7qfUk9HTv1fg0sWfx5fZQLOzvVS8fJF899LPXW57QtNvmbnGKUHFGDIL66JGUocWE7F8vMCzBk1q7OlALOaTrGWOy00z8uDby14+xd+1jhkqjcO6jlk9WdYFu+Guwuq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784613970; c=relaxed/simple;
	bh=r7vtEtX4h2nmkEQvMc36T0KMSlz69SGUN8nK6ksmOqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXwT63TxeBF6ykxtbxlXU699AHGyOxBtrWGBujzse/2LtrFd8gTfOSAlJG8uZofnfXseIFozJCBkHR2uwfD7vT5fokEMbQriywfa3/Ta3IbOc8a7zV3/rThQHjroW2X384WDtrbAwaJL/d52cuRIk4fKZuB6H8Jn3BsC3mhwto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3ed3817a84ca11f1aa26b74ffac11d73-20260721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:aa6d5e60-2d57-4bdd-bca3-2e51833d5e31,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:6d452cceb2101199b58a732b8bb20160,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3ed3817a84ca11f1aa26b74ffac11d73-20260721
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1980014824; Tue, 21 Jul 2026 14:05:59 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	shuah@kernel.org,
	yanlonglong@kylinos.cn
Subject: [PATCH v2] selftests/damon: Add missing NULL checks after malloc()
Date: Tue, 21 Jul 2026 14:05:42 +0800
Message-ID: <20260721060542.326-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <20260721043139.151887-1-sj@kernel.org>
References: <20260721043139.151887-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In low-memory scenarios, malloc() can fail. Without checking,
the test will dereference NULL and crash, causing the test harness
to report a failure that is unrelated to DAMON functionality.
This is a false negative: the test should skip or report a resource error,
not crash and mask the actual test result.

Add NULL checks after each malloc() call, printing an error message
to stderr and returning -1 on failure.

Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
---
 tools/testing/selftests/damon/access_memory.c      | 11 ++++++++++-
 tools/testing/selftests/damon/access_memory_even.c | 11 ++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/access_memory.c b/tools/testing/selftests/damon/access_memory.c
index 567793b11107..e1a8e050dcd4 100644
--- a/tools/testing/selftests/damon/access_memory.c
+++ b/tools/testing/selftests/damon/access_memory.c
@@ -38,8 +38,17 @@ int main(int argc, char *argv[])
 		mode = ACCESS_MODE_REPEAT;
 
 	regions = malloc(sizeof(*regions) * nr_regions);
-	for (i = 0; i < nr_regions; i++)
+	if (!regions) {
+		fprintf(stderr, "Failed to allocate regions array\n");
+		return -1;
+	}
+	for (i = 0; i < nr_regions; i++) {
 		regions[i] = malloc(sz_region);
+		if (!regions[i]) {
+			fprintf(stderr, "Failed to allocate region %d\n", i);
+			return -1;
+		}
+	}
 
 	do {
 		for (i = 0; i < nr_regions; i++) {
diff --git a/tools/testing/selftests/damon/access_memory_even.c b/tools/testing/selftests/damon/access_memory_even.c
index 93f3a71bcfd4..a443835c119c 100644
--- a/tools/testing/selftests/damon/access_memory_even.c
+++ b/tools/testing/selftests/damon/access_memory_even.c
@@ -26,8 +26,17 @@ int main(int argc, char *argv[])
 	sz_region = atoi(argv[2]);
 
 	regions = malloc(sizeof(*regions) * nr_regions);
-	for (i = 0; i < nr_regions; i++)
+	if (!regions) {
+		fprintf(stderr, "Failed to allocate regions array\n");
+		return -1;
+	}
+	for (i = 0; i < nr_regions; i++) {
 		regions[i] = malloc(sz_region);
+		if (!regions[i]) {
+			fprintf(stderr, "Failed to allocate region %d\n", i);
+			return -1;
+		}
+	}
 
 	while (1) {
 		for (i = 0; i < nr_regions; i++) {
-- 
2.43.0

