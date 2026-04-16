Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21A128816;
	Thu, 16 Apr 2026 00:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776298919; cv=none; b=J3p1aVg0kIc0flx2lclURVeKdW9vw0XaWbhfwwI+atHgaelbf021swd7uWBMPRFxgMDAsyWa8dtEVNGtfrD6bflppXGskfSeF97a4fm0KEzmNZDMA8Bn3O/80Nn2USv0J4NCwRdI2WIaxvwsIIEial0r+4CJjzoGp1/jpJbXTOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776298919; c=relaxed/simple;
	bh=oAz4P2Xf/vMXHQmZ0zMlkiiML8XeygCzQMESdno0b8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvC8xBo1Lu91nH5GOG4qU779dYIQ/3F6BuGfyvzfwR+0PyIvQ1zOgD7FG/Qzut1H116y8s+k5Hxd8X4YPmtVNU8Y6vUNTu8C9Oqgjh+ZJzn29yLFW9flD6qkgNQbM2YN87W3hN7nCQVncWNpM8vKidjju/eX3FLMf4R1E2pw5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR7dFtol; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR7dFtol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CECC2BCB9;
	Thu, 16 Apr 2026 00:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776298919;
	bh=oAz4P2Xf/vMXHQmZ0zMlkiiML8XeygCzQMESdno0b8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KR7dFtolv76LoMS4QdAmmx6dkibmmtpjYB7wsALDytuBX/USmNta5JsKJoX1Xd5Gx
	 XIAzFMC1xwjGPHYLAD7pTRooT2nNizetTkkLtBvgaS4uAybHdZ2+xIE/jOk8QQLvBr
	 HsxCSycHu4YAetBYhg8/w78znAJqPKtQKLS7PFbnJeeAotTFcelLtyA1mKoHAvlIfq
	 XPbcYs/Z1Pm5VC4h9SATiew+LIL1RD1YmtrsoNZ3cvpJWyrfd7cWvm9JzstA6Lch5h
	 96Dj1htYEw5Kngtaz4DaAlJCLyhC+3mXJl9px/FPxKodCWwTGD/NuuCKtWBhSs1fPK
	 pN6Vk++rTg4Hw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 1/2] mm/damon/stat: add a parameter for reading kdamond pid
Date: Wed, 15 Apr 2026 17:21:46 -0700
Message-ID: <20260416002149.87090-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260416002149.87090-1-sj@kernel.org>
References: <20260416002149.87090-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Knowing the pid of the kdamonds can help user-space management including
monitoring of DAMON's system resource consumption.  To make it easier,
DAMON_SYSFS, DAMON_RECLAIM and DAMON_LRU_SORT provide the pid
information.  DAMON_STAT is not providing it, though.  Expose the pid of
DAMON_STAT kdamond via a new read-only module parameter, namely
kdamond_pid.  This also makes DAMON modules usage more standardized,
because DAMON_RECLAIM and DAMON_LRU_SORT also provide the information
via their read-only parameters of the same name.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 99ba346f9e325..4901e9a7c3398 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -44,6 +44,15 @@ module_param(aggr_interval_us, ulong, 0400);
 MODULE_PARM_DESC(aggr_interval_us,
 		"Current tuned aggregation interval in microseconds");
 
+/*
+ * PID of the DAMON thread
+ *
+ * If DAMON_STAT is enabled, this becomes the PID of the worker thread.
+ * Else, -1.
+ */
+static int kdamond_pid __read_mostly = -1;
+module_param(kdamond_pid, int, 0400);
+
 static struct damon_ctx *damon_stat_context;
 
 static unsigned long damon_stat_last_refresh_jiffies;
@@ -260,6 +269,14 @@ static int damon_stat_start(void)
 		damon_stat_context = NULL;
 		return err;
 	}
+	kdamond_pid = damon_kdamond_pid(damon_stat_context);
+	if (kdamond_pid < 0) {
+		err = kdamond_pid;
+		kdamond_pid = -1;
+		damon_destroy_ctx(damon_stat_context);
+		damon_stat_context = NULL;
+		return err;
+	}
 
 	damon_stat_last_refresh_jiffies = jiffies;
 	call_control.data = damon_stat_context;
@@ -269,6 +286,7 @@ static int damon_stat_start(void)
 static void damon_stat_stop(void)
 {
 	damon_stop(&damon_stat_context, 1);
+	kdamond_pid = -1;
 	damon_destroy_ctx(damon_stat_context);
 	damon_stat_context = NULL;
 }
-- 
2.47.3
