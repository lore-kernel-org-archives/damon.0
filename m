Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF9372662;
	Sat,  4 Jul 2026 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783188706; cv=none; b=enLmIYcgPUYRPYQvGnaH5rfStdPMKMLVZLtlNl/1+lLBa77ANekOj6rKBTQ3lBxcOX8Qce533GobTE2MsqYRF753AFfkqTvGVj4t3TyhSHKoNHWZ/K2Bwzx9iUSQmlffZy37RK5ZbFMF6voypt/JOUCiyHDXARTw6BQ1ZA2Iblo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783188706; c=relaxed/simple;
	bh=2GgULBFQpYDO6EvdC9vnTe3kQ/SAYL9X8uFLgsMgTWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6GuULLVtAWfI9iRQB3ss+77WGsh3IxQGfd06Qedjme3y6blGRrVln/MT5rWWpHjQpm9Rqxd1GlNFRZdFkdhfdWvRk1Cu0H33dRu+9l2mb2b2s06kyWPxuCIUrE9i7DgMv8A+zHettuHsrAW3ydTin8dqYXHqSuL0ONKwLqiHp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idWhGM/N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idWhGM/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4222A1F00A3E;
	Sat,  4 Jul 2026 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783188705;
	bh=D62Tcr+yrJC0pq2paze4YieMWP4BsC6k5oHO7N7uukw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=idWhGM/NfW0pTEDlsAa5Fzw6cTaifXusxiPSV68Fu/A5SGWRzv+Ya57tK/wwmqA77
	 SE22BT2MD81KtUsBZ+XmiuaEUb9UvD3Te7qciTSZIPxwHYef/ijxlLHusmVH0oasTK
	 MnyD1BVyEIyDB9/m/nldUskLSsHbr03qjnQQeOAYsUY1yE2hTx7iXfB2xmT12qW4PL
	 kd5gfTcxOHMNj9nmEfMHIcEkh2jqi3QfXIou2x4bSbf/lJyZvP1Dkb8ivj2NZl6pVp
	 d0evckKD6aTR7/bX6U7NKVko3GVgYfJ6SGkGVhdOIrAZ+QVjennd1m6H+nv8z3sIt1
	 imXDs5Px59OrA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/11] samples/damon/mtier: do not stop first context for damon_start() failure
Date: Sat,  4 Jul 2026 11:11:25 -0700
Message-ID: <20260704181135.132956-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704181135.132956-1-sj@kernel.org>
References: <20260704181135.132956-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_start() was able to fail while keeping the first context running.
mtier hence stops the first context in the case.  damon_start() is
refactored to avoid that.  The error handling is no longer necessary.
Remove it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 samples/damon/mtier.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index e567f4edd80ea..90881e8bd441f 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -193,8 +193,6 @@ static int damon_sample_mtier_start(void)
 	if (!err)
 		return 0;
 
-	if (damon_is_running(ctxs[0]))
-		damon_stop(ctxs, 1);
 	damon_destroy_ctx(ctxs[0]);
 	damon_destroy_ctx(ctxs[1]);
 	return err;
-- 
2.47.3
