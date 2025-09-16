Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939626FA4E;
	Tue, 16 Sep 2025 03:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993722; cv=none; b=sSn1esUlHu71LHixBiW40T6ZTcPOMqzttJbRY3FaBOWj21Un1IQ/iKRX7/d/7vmWp7JdXyyOpirnpYgI2IH2xqcwj2qhdS/B/IubAlDCvRf+15smSYABwb8oMwiDYEl39fco1Y4TQm9yP130j115FpcLXdTrnACaIM6Z6VLnATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993722; c=relaxed/simple;
	bh=2demp7SZfocNtJOdY3h9yRpOtgZXlewJOxyAe06bXV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hrjERYLx8TfsKnj3Ac+pXHMvUnYKr2Zr8UtnQkabHMTB43vRQrT74BIDefXb/jmCSdB905+l9Aze6Sel0F/MN084k44ll8uic0PK/pBbckOOso5knSPqQsi6u8Yaiv0xzN1wKlZL68VC5fEtlOXZl0LKuRZWabi0B6EmNajLCqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGZfcUg7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGZfcUg7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0846CC4CEF7;
	Tue, 16 Sep 2025 03:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757993722;
	bh=2demp7SZfocNtJOdY3h9yRpOtgZXlewJOxyAe06bXV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGZfcUg7EYIo0PMGPLm0zQMT++5sADBSnFLPvKL/Xi2D9s8FjnUMCJZ93k3AwBbUN
	 CTiePydCLnUhLempDvgCh7ZKz+gs55peHtUSLOLR39RM0HEcDxJbCsWlHnANqGXmvm
	 TP56I41Myk/vI7UsifpnKAi4Yl8T0i3gGwtkGoV5JW5PabKlafetYlWe05pNa9GNPo
	 2W2+P0Jl3cHihLfzuLCNbCraB6DgnDTlNcfda12wR7ve8vW4xDksqYWLKK3NLD379/
	 1zRtVoBZJVkI0KPvNSjb3nJTDoyCzv/xJZmroq1uzljEq6h/VmmcubJ57FnghDbvOe
	 sEpknD+Vbb8hA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/7] samples/damon/wsse: use damon_initialized()
Date: Mon, 15 Sep 2025 20:35:09 -0700
Message-Id: <20250916033511.116366-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916033511.116366-1-sj@kernel.org>
References: <20250916033511.116366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sample_wsse is assuming DAMON is ready to use in module_init time,
and uses its own hack to see if it is the time.  Use
damon_initialized(), which is a way for seeing if DAMON is ready to be
used that is more reliable and better to maintain instead of the hack.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/wsse.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index 21eaf15f987d..799ad4443943 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -102,8 +102,6 @@ static void damon_sample_wsse_stop(void)
 	}
 }
 
-static bool init_called;
-
 static int damon_sample_wsse_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
@@ -117,10 +115,10 @@ static int damon_sample_wsse_enable_store(
 	if (enabled == is_enabled)
 		return 0;
 
-	if (enabled) {
-		if (!init_called)
-			return 0;
+	if (!damon_initialized())
+		return 0;
 
+	if (enabled) {
 		err = damon_sample_wsse_start();
 		if (err)
 			enabled = false;
@@ -134,7 +132,12 @@ static int __init damon_sample_wsse_init(void)
 {
 	int err = 0;
 
-	init_called = true;
+	if (!damon_initialized()) {
+		err = -ENOMEM;
+		if (enabled)
+			enabled = false;
+	}
+
 	if (enabled) {
 		err = damon_sample_wsse_start();
 		if (err)
-- 
2.39.5
