Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795154870;
	b=XAtHaUIZ5paKsqyv2GaJW0RoPgZp0tkj7KJwOoEfAZ4sHgFwGd9PnUQEtkQsdf/XNmRd
	 KLnoKRaugzLsWi7VmVm0v9ddb33HxvU70GKeYt7fytLQhtiJP+3gz9BivMyyK812RC0UE
	 VukWVsYJXVrOUjSfHieB51Qch9+DX7Zn6mvPj24YTKO07kXYO+DVxxhMIuWc7xHUACBjC
	 vN9+LwVNgX+8qUQhHdowNK3T5N0VArzyaymS3biz7+uJVwanT5dr7jW9D5d0PMuMiJ1pl
	 Rbe249TEYN22d6lgKv0be0N+bkut6DrDz04AV8bZMgr+uIkiaA+OilI4UiV1mIVTbzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795154870;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Qskq9szjVa9XlNedP+qAv1YRg+a7vizmTmlvGZkJCUU=;
	b=CrChKihDlWEzrx7ERbnmWDLypnI7Dzl8FrqMBHpTf3qdqqV9Q3lbYS/Y6N/3rr1vFOik
	 9zJoPAhXQ9RBtuBL2Ar5iv8ZfWXWDoI+JA3e54xvGwxMItBKePgHAnSCjrp2urg+//tvr
	 eZUJzbaHvxqpkquvY35PGBA2IF5Dmk8l0Hsj2FV1AhhewDjhwv/fKxJmFYkxjJsuxVACX
	 hlmFjgF6995m3WyGUw1pRsAtyeVY0c2Q82lYzMU85rpsUT46+2S1WIF4HqBa4piiDSUb5
	 DWLtHghng2t1d969x5FvzytN4qxLBLmCnN56sDzxs+5NnrNrMPlZvvruHEMBMOPf22g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DrP6t8wt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441F9606A504
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DrP6t8wt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036BF1F000C4;
	Fri, 20 Nov 2026 06:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795154870;
	bh=Qskq9szjVa9XlNedP+qAv1YRg+a7vizmTmlvGZkJCUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DrP6t8wtbBsl0csg8WTSkxMKknFEl+bdBnYt6LASgO2kYYCF527kkkM2Eu3MC/km8
	 FMB253p7WriLRmuvYNZ6ybWaZEcyOqMzhLj6/rtuEWspqkMhp3QdVEBs93qDF0fp/o
	 E187u/U+5rlV8I3O6ssoHw1wrwXmVkBjKsbn9aQedjNzbjmiD6ETSOD8OtGlADy7QR
	 9i+RDc0cGS/TOWSPzMRUHoFZRgTYnN7PIUobjGaP7HIbW//dtEkH0j3soMSAf3jXLf
	 4khFiCDsliS7FrvLeepg9+2u7ndxZmdjJ0noW5Ssxfix2X7WP6ij5jLk2wlUDX30LO
	 mW8v6cOddc6uA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/4] mm/damon/reclaim: disable watermarks by default
Date: Thu, 19 Nov 2026 22:07:37 -0800
Message-ID: <20261120060741.92121-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120060741.92121-1-sj@kernel.org>
References: <20261120060741.92121-1-sj@kernel.org>
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

DAMON_RECLAIM's free memory based watermarks features were introduced as
a safe guard for wrongly-tuned coldness threshold (min_age).  The
default watermark values were chosen to let users easily understand how
those can be set and tuned.  The default values are never meant to be
used as are.  DAMON_RECLAIM is later updated to enable PSI-driven
coldness threshold auto-tuning by default.  When the auto-tuning is
enabled, having the watermarks with the default values makes no sense.
Disable the watermarks by default.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index d297b1596704b..a8b18f51e99d5 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -103,12 +103,13 @@ module_param(quota_autotune_feedback, ulong, 0600);
 static bool autotune_monitoring_intervals __read_mostly = true;
 module_param(autotune_monitoring_intervals, bool, 0600);
 
+/* Watermarks are effectively disabled by default. */
 static struct damos_watermarks damon_reclaim_wmarks = {
 	.metric = DAMOS_WMARK_FREE_MEM_RATE,
 	.interval = 5000000,	/* 5 seconds */
-	.high = 500,		/* 50 percent */
-	.mid = 400,		/* 40 percent */
-	.low = 200,		/* 20 percent */
+	.high = 1000,		/* 100 percent */
+	.mid = 1000,		/* 100 percent */
+	.low = 0,		/* 0 percent */
 };
 DEFINE_DAMON_MODULES_WMARKS_PARAMS(damon_reclaim_wmarks);
 
-- 
2.47.3
