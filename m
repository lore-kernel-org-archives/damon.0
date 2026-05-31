Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE15A2343BE
	for <damon@lists.linux.dev>; Sun, 31 May 2026 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780219133; cv=none; b=jhrJ97BlniSBLdTl6LG7W+wMJ8fIMhUk2B8RIdzeTAEErI7Ihu124yYM4lc7NIQAvGg0mq29Idr3xuXA+Evppo8zmX3yldMaq8L7Tpy7cuJTTh8Ew57uxoSpy9iHviHRm3O51rOGVz365qUYJSWxWkEJoAr/h2GP0sjkRBzWL28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780219133; c=relaxed/simple;
	bh=rWCEtYsmQkMOrtZBulkM+qtg+F2Rhqil8XcskGpm2hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUaeHU10r3DmnwpQN+un7hYQAqSYBURyeTLG8AOUgBQLPLm3PR3k9UMhmsVCPlJW4w6j6EoSzIoht1x7QFEshLhSUVe/XLoHvdOD1FMh4zazDGssGb065ub3/OKQXKBq5NA349tvewglOy9MLlwPRxqoZryu1cAaQvbb+pwYjuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RPhGxW9T; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RPhGxW9T"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780219130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXhCVDIEVOBRsQMWe03K8aMA64HZDsrpR3l9gSzxs9k=;
	b=RPhGxW9T9LZpEzsRIy+FbVl2Ab8sj1PAKAVfUl75XJw3NqnWH/11R+TDatO8ghaX9sjRjs
	lCrFIK8O1f/mRp/1aLvEFuoixVzzQukf0/xOf3gKY4T+1G1tlccij5OhZiDcyDiEjQwguy
	/Nvc++A3U0Ijee+rgoSXB3AX308MdTg=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: sj@kernel.org,
	shuah@kernel.org
Cc: damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 4/5] selftests/damon/damos_tried_regions: handle empty tried regions in early cycles
Date: Sun, 31 May 2026 17:17:23 +0800
Message-ID: <20260531091724.84381-4-kunwu.chan@linux.dev>
In-Reply-To: <20260531091724.84381-1-kunwu.chan@linux.dev>
References: <20260531085633.48626-1-kunwu.chan@linux.dev>
 <20260531091724.84381-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <kunwu.chan@gmail.com>

The test aborts if the initial aggregation cycles produce zero
tried regions.  This can happen on slow machines, causing false
failures.  Skip empty cycles and retry up to 200 times before
giving up.  Also check that enough samples were collected before
computing the 50th percentile.

Co-developed-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 .../selftests/damon/damos_tried_regions.py       | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/damon/damos_tried_regions.py b/tools/testing/selftests/damon/damos_tried_regions.py
index d6472e6a6e08..cc6895c56820 100755
--- a/tools/testing/selftests/damon/damos_tried_regions.py
+++ b/tools/testing/selftests/damon/damos_tried_regions.py
@@ -28,7 +28,9 @@ def main():
         exit(1)
 
     collected_nr_regions = []
-    while proc.poll() is None:
+    nr_retries = 0
+    while proc.poll() is None and nr_retries < 200:
+        nr_retries += 1
         time.sleep(0.1)
         err = kdamonds.kdamonds[0].update_schemes_tried_regions()
         if err is not None:
@@ -38,20 +40,20 @@ def main():
 
         scheme = kdamonds.kdamonds[0].contexts[0].schemes[0]
         if scheme.tried_regions is None:
-            proc.terminate()
-            print('tried regions is not collected')
-            exit(1)
+            continue
 
         nr_tried_regions = len(scheme.tried_regions)
         if nr_tried_regions <= 0:
-            proc.terminate()
-            print('tried regions is not created')
-            exit(1)
+            continue
         collected_nr_regions.append(nr_tried_regions)
         if len(collected_nr_regions) > 10:
             break
     proc.terminate()
 
+    if len(collected_nr_regions) <= 4:
+        print('too few tried regions samples collected')
+        exit(1)
+
     collected_nr_regions.sort()
     sample = collected_nr_regions[4]
     print('50-th percentile nr_regions: %d' % sample)
-- 
2.43.0

