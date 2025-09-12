Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352522264CC;
	Fri, 12 Sep 2025 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644798; cv=none; b=DHBPgItbNrjRQquwMwI+6OiHjLBsOfmd19xdS2Ni9SR+/hNbIPYBDz1kHv2hSxWhYpfAYq/tLToiFfVhtOrXU8MXjJN2eDahcFZV3g7krpJZNlXMUAcEfC3dlNwLTRjJrJyrCzx/YM5xkJJEb6Rc2vKYBqgSswc6NaRHGK28wOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644798; c=relaxed/simple;
	bh=2demp7SZfocNtJOdY3h9yRpOtgZXlewJOxyAe06bXV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SA76tR0PBMOfpYqCDwoNlpeG2rL9WGzEak0COE0kLSYcQVHJh2himvjrQbtV+M3rvwsyXqMR+TLSqAv5PuwZakse7vxJp0apy8wp/fW/b5yy5zNpVc2kvxIBLkCWEEBAjjfVANzhdhbrENUDe7Z6f3p6wrkYh0Ij+kqSgT/H7mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOIbux2e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOIbux2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87F9C4CEF5;
	Fri, 12 Sep 2025 02:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757644798;
	bh=2demp7SZfocNtJOdY3h9yRpOtgZXlewJOxyAe06bXV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gOIbux2e0xlvP/53qMivwnlzSiSL0JxQL4XPTJ4+nyltrcm+59hn/qclLbE38UyAW
	 M8LgW3jzBIZzUHayt/fyxX28Imlt5+C1IwEzf5Nm1RLLCPYUdxlebddkLPkM5vrWz3
	 88pdwTGRsQJpFW2P8Y6WCZ78ygE3mfEtfi6sQmRvboSCcTFNraK8887PPkiDk/lZzh
	 W0UZ/fvLYHfpbDadSfsJUAUCxUCwe5kYdr7qIICUkkpQnfF1Tt79jC0OA6OWvt4Bgm
	 7t2YWtwEkf0Gmpq4hb+TaQUPltp7fSaUz5XFHu5q/DPWtx+qBSPfagidJWW/vTfLPJ
	 MnWtxgppmk1SA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/7] samples/damon/wsse: use damon_initialized()
Date: Thu, 11 Sep 2025 19:39:44 -0700
Message-Id: <20250912023946.62337-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912023946.62337-1-sj@kernel.org>
References: <20250912023946.62337-1-sj@kernel.org>
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
