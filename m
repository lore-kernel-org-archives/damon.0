Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFD8262FC0;
	Tue, 16 Sep 2025 03:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993029; cv=none; b=Or1liTlqZ5JGPQCdupNaFmUlMB0f2IDxSd8NhilBDQUoiK0n/LaSwXai5iRMSUvMrHpAXUM5NhiGbu/kKp+MNqNt2z7zIeyv0Bizkre8OLILlv3OoeFFiEBUGFDbwfw2b0VaufBUZmx29XgMBmw+jWKejwluV2i+FqDLOMD5jpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993029; c=relaxed/simple;
	bh=0axYTgZO105/0nA2HAaiUTIqb7xW8bf0ptfQmVpueWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MvsBoO0UVLnrmQzgHpchp94bjp1xFNK5yO5ZntIhOMBdisJWVXklIDoPcSHvC9jFTT3awKRMw0NyP6agFPn6DnAIoqHLIjeFtArQy866+TUUZXhxhzfLa99ejkYOFNG4l5mXqG7j4CenvRmO1Pj1fV/7voGlxRWXcnj/g/FB4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tufOdFMV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tufOdFMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046EAC4CEF7;
	Tue, 16 Sep 2025 03:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757993029;
	bh=0axYTgZO105/0nA2HAaiUTIqb7xW8bf0ptfQmVpueWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tufOdFMVXOfv/6C1Hi9vrpLziZo0X9Agk0fVxOuD0FyDivUUqCz6hDp475/nfMPbB
	 LYbP9VIJT/+hJuBYTIZ8mkoWUfMc682pA49ARAjoeCGP4AWykOhCVl2Nqnehb1tenD
	 HYH0gPRLncmzTB9PN5VMnnuajcZchx7Lo5DJQ56fpG+y8SyAah/fPgnR8BZVkwG6K7
	 +ybw5nnKvqM29rmvXjUZGCBdAYNjXGHLxAQo1TiFixrfw/k6AoMMAZLPKXCVv0O7Yf
	 KYMIOGfdUxZsWaiCW9IVLwLksQkrPlxZdpzR6jtqJE43ihfv6JQjEg3vz6SpiZSpTV
	 ubFGooweYY1Pg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/5] mm/damon/core: set effective quota on first charge window
Date: Mon, 15 Sep 2025 20:23:36 -0700
Message-Id: <20250916032339.115817-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916032339.115817-1-sj@kernel.org>
References: <20250916032339.115817-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The effective quota of a scheme is initialized zero, which means there
is no quota.  It is set based on user-specified time/quota/quota goals.
But the later value set is done only from the second charge window.  As
a result, a scheme having a user-specified quota can work as not having
the quota (unexpectedly fast) for the first charge window.  In practical
and common use cases the quota interval is not too long, and the
scheme's target access pattern is restrictive.  Hence the issue should
be modest.  That said, it is apparently an unintended misbehavior.  Fix
the problem by setting esz on the first charge window.

Fixes: 1cd243030059 ("mm/damon/schemes: implement time quota") # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ff2c6bb30621..775121ae7a9b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2142,8 +2142,10 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 		return;
 
 	/* First charge window */
-	if (!quota->total_charged_sz && !quota->charged_from)
+	if (!quota->total_charged_sz && !quota->charged_from) {
 		quota->charged_from = jiffies;
+		damos_set_effective_quota(quota);
+	}
 
 	/* New charge window starts */
 	if (time_after_eq(jiffies, quota->charged_from +
-- 
2.39.5
