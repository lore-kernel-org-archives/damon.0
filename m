Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6B33B5311;
	Thu, 15 Jan 2026 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490454; cv=none; b=PAadz+3C/nO/LTDn63wOfHtwesMpSTbDI6b/wRNeYGa14GkV22ros7YF3MOON/aYbn1nzAMEwKM5JjI+JJJfdeKQf3MBDZ3MzCQl+4S4hjLTTme+FCB5KT41zNkLn/RIA8EsNzn3vOt7CCKDahaDwULe+XTKlDwnBnjfE5URQGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490454; c=relaxed/simple;
	bh=liYSv1rqSeh/1ly0K+dN0fc398iVzhoj5D1pp/K03Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGaNEhmcj/MuCitACwLsQURMU1NOSmMI9e80SGxgw4Ek60di27He76YXZkxmugWJqGTF1+lYfMaSrcj1HuDxM/9/TDPdHP8apJ9pZs6MhY8QFGEbvCsXHWUAK3EUDsyn1KMcMSDdR54ubIS14fLphHIoZECie6t7GPLnmbU6fYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qioR1czQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qioR1czQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F168C19424;
	Thu, 15 Jan 2026 15:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768490453;
	bh=liYSv1rqSeh/1ly0K+dN0fc398iVzhoj5D1pp/K03Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qioR1czQGcX9c+h+SaZCzzuecJqpv1iUe+Wy1oY/3VxML1KS5V64I7t1eBLplWkjS
	 u4BJU5jaHEnsSTAZEW8SnOxVc/e6opmGtxW1UHgLGVRc56yRbftnVNia8L/YWBY5nA
	 6HNrsUTAIXr6QamBRrt6lItmuXz5pwMUGPvNW7ZFnKGv+B2QZS/B5ZFJWMjPsPjvhw
	 LZkMecpkIRQSrQkpqztZo3CKInSFGkq0DqihmnRf4CtnNjwWewvlKQJxpNPPPNouGc
	 UyyA8w4JvdPwIeDO2H86MjVcP96JzKSLIKv+f3SzwPndD6pKItG0I0Y3dwwOpjaO1o
	 N9D2L714mndNg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/5] mm/damon/lru_sort: use damon_kdamond_pid()
Date: Thu, 15 Jan 2026 07:20:43 -0800
Message-ID: <20260115152047.68415-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115152047.68415-1-sj@kernel.org>
References: <20260115152047.68415-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_LRU_SORT directly uses damon_ctx->kdamond field with manual
synchronization using damon_ctx->kdamond_lock, to get the pid of the
kdamond.  Use a new dedicated function for the purpose, namely
damon_kdamond_pid(), since that doesn't require manual and error-prone
synchronization.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 8296f984b428..bedb9134d286 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -405,7 +405,9 @@ static int damon_lru_sort_turn(bool on)
 	err = damon_start(&ctx, 1, true);
 	if (err)
 		return err;
-	kdamond_pid = ctx->kdamond->pid;
+	kdamond_pid = damon_kdamond_pid(ctx);
+	if (kdamond_pid < 0)
+		return kdamond_pid;
 	return damon_call(ctx, &call_control);
 }
 
-- 
2.47.3
