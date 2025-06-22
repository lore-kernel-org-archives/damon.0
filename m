Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECD91DF75A
	for <damon@lists.linux.dev>; Sun, 22 Jun 2025 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750594230; cv=none; b=IEvF/JKLpMgwBkB8LJlZKSSNT2xRv3dCpirqfY9ASEDQ0yOXJsvdLCkeo05WFYeFvxqNKAph2v2gZFyn8+TgdvxZJbjz0hwiHcODIgo8GKgFZhiJuUqjvsU0Kh0drzjwLTSeyC0V/S61jNmiuGBTfw2wLVkeXKrHse8oMFEuvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750594230; c=relaxed/simple;
	bh=JozJuchIzNEIKIBPD9/h0gZAvNR2puffk0A6E6PqRUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIcsFAJQxaQymIwVWffOabfeb+TKKCnQKfJEfnL0mfAEkDTC7BSVMP9vTD3kKSUZT0PvrTOdRsORIN5/53XJBsEWQPbWWaRDtcw4biNEWJcJ52RmgIIZIdOknhNBXCkgzqUViBjgw7sqFl7OPHD7BdiIraYIr6IAE7MOgcDKKKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-3a-6857f2b0b385
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: [PATCH 3/3] samples/damon: fix bugs for damon sample for start failures
Date: Sun, 22 Jun 2025 21:09:25 +0900
Message-ID: <20250622120926.1712-4-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250622120926.1712-1-honggyu.kim@sk.com>
References: <20250622120926.1712-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsXC9ZZnke6GT+EZBif2C1rMWb+GzeLJ/9+s
	FvfW/Ge1OPz1DZMDi8emVZ1sHps+TWL3ODHjN4vHi80zGQNYorhsUlJzMstSi/TtErgyDp6+
	yFjQJ1Gxo7uNqYHxjnAXIyeHhICJRPuLHcww9rkT69hAbDYBNYkrLycxdTFycIgIWElM2xEL
	EmYWWMEoMW9FHIgtLBAgsfPJFbBWFgFViafftzODlPMKmEk8el4AMVFT4vH2n+wgNqeAucT6
	NefByoWASr4e/MEKYvMKCEqcnPmEBWK8vETz1tlANVxAvRPYJNaves8KMUhS4uCKGywTGPln
	IemZhaRnASPTKkahzLyy3MTMHBO9jMq8zAq95PzcTYzAIFxW+yd6B+OnC8GHGAU4GJV4eF8c
	DMsQYk0sK67MPcQowcGsJMJ7yAkoxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6Yklq
	dmpqQWoRTJaJg1OqgVGZrd/yReTsGbEpM7e1Xg022vDFZP+0hadrv4e2Vly/NF3g1PnwcxmS
	XzxnlgQsXbWT6/WXc0eWNuSZpglvfPZg4cHubzZvNSrf2bx4JHDs9tV9cyYXfU46f2yZ0Lod
	y++I853njLcWUt9+U9D+R2dvnJD3mbrSq2cE7O+59srcOb6G8ZAVW4KrEktxRqKhFnNRcSIA
	5cGklD4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsXCNUNLT3fDp/AMg8MfWS3mrF/DZvHk/29W
	i8/PXjNbHJ57ktXi3pr/rBaHv75hsvi9bQWbA7vHplWdbB6bPk1i9zgx4zeLx4vNMxk9vt32
	8Fj84gNTAFsUl01Kak5mWWqRvl0CV8bB0xcZC/okKnZ0tzE1MN4R7mLk5JAQMJE4d2IdG4jN
	JqAmceXlJKYuRg4OEQEriWk7YkHCzAIrGCXmrYgDsYUFAiR2PrnCDGKzCKhKPP2+nRmknFfA
	TOLR8wKIiZoSj7f/ZAexOQXMJdavOQ9WLgRU8vXgD1YQm1dAUOLkzCcsEOPlJZq3zmaewMgz
	C0lqFpLUAkamVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIHhtqz2z8QdjF8uux9iFOBgVOLh
	fXkwLEOINbGsuDL3EKMEB7OSCO8hJ6AQb0piZVVqUX58UWlOavEhRmkOFiVxXq/w1AQhgfTE
	ktTs1NSC1CKYLBMHp1QD45LVFxgetp0PrM3/qTevoWym3+w3rP+3Ku3gF2bkb1+6YF7uIUlW
	yf/ljv+OfP8cvO76geBuq6g9igXqEUe+FXfNEMyLXX2vjMu2wfbB7/P9i+NVeg8n3r19hyGW
	JWn1a71P/+46fvxZxqcn/7XZZ9bkyglTle9ZrBK30jMwm7j5tZ60W29gjxJLcUaioRZzUXEi
	ALQZewIzAgAA
X-CFilter-Loop: Reflected

The damon_sample_{wsse,prcl,mtier}_start() can fail so we must reset the
"enabled" parameter to "false" again for proper rollback.

In such cases, setting Y to "enabled" then N triggers the following
crash because damon sample start failed but the "enabled" stays as Y.

  [ 2441.419649] damon_sample_prcl: start
  [ 2454.146817] damon_sample_prcl: stop
  [ 2454.146862] ------------[ cut here ]------------
  [ 2454.146865] kernel BUG at mm/slub.c:546!
  [ 2454.148183] Oops: invalid opcode: 0000 [#1] SMP NOPTI
  	...
  [ 2454.167555] Call Trace:
  [ 2454.167822]  <TASK>
  [ 2454.168061]  damon_destroy_ctx+0x78/0x140
  [ 2454.168454]  damon_sample_prcl_enable_store+0x8d/0xd0
  [ 2454.168932]  param_attr_store+0xa1/0x120
  [ 2454.169315]  module_attr_store+0x20/0x50
  [ 2454.169695]  sysfs_kf_write+0x72/0x90
  [ 2454.170065]  kernfs_fop_write_iter+0x150/0x1e0
  [ 2454.170491]  vfs_write+0x315/0x440
  [ 2454.170833]  ksys_write+0x69/0xf0
  [ 2454.171162]  __x64_sys_write+0x19/0x30
  [ 2454.171525]  x64_sys_call+0x18b2/0x2700
  [ 2454.171900]  do_syscall_64+0x7f/0x680
  [ 2454.172258]  ? exit_to_user_mode_loop+0xf6/0x180
  [ 2454.172694]  ? clear_bhb_loop+0x30/0x80
  [ 2454.173067]  ? clear_bhb_loop+0x30/0x80
  [ 2454.173439]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Since it's just a sample module, no need to add it to stable tree.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Cc: Yunjeong Mun <yunjeong.mun@sk.com>
---
 samples/damon/mtier.c | 8 ++++++--
 samples/damon/prcl.c  | 8 ++++++--
 samples/damon/wsse.c  | 8 ++++++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index cb273bf4b5c2..29ee5bf60e74 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -170,8 +170,12 @@ static int damon_sample_mtier_enable_store(
 	if (enabled == enable)
 		return 0;
 
-	if (enabled)
-		return damon_sample_mtier_start();
+	if (enabled) {
+		err = damon_sample_mtier_start();
+		if (err)
+			enabled = false;
+		return err;
+	}
 	damon_sample_mtier_stop();
 	return 0;
 }
diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index e8fe596704cc..188b292a91c8 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -122,8 +122,12 @@ static int damon_sample_prcl_enable_store(
 	if (enabled == enable)
 		return 0;
 
-	if (enabled)
-		return damon_sample_prcl_start();
+	if (enabled) {
+		err = damon_sample_prcl_start();
+		if (err)
+			enabled = false;
+		return err;
+	}
 	damon_sample_prcl_stop();
 	return 0;
 }
diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index 5039d534fdb6..53e847546d92 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -102,8 +102,12 @@ static int damon_sample_wsse_enable_store(
 	if (enabled == enable)
 		return 0;
 
-	if (enabled)
-		return damon_sample_wsse_start();
+	if (enabled) {
+		err = damon_sample_wsse_start();
+		if (err)
+			enabled = false;
+		return err;
+	}
 	damon_sample_wsse_stop();
 	return 0;
 }
-- 
2.34.1

