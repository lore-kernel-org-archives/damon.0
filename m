Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D732E220F5C;
	Mon, 15 Sep 2025 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757901494; cv=none; b=Nf4bc6AND9JcMlgX3xTnK0NQH++nKEsDme4O4HS59r19adWWVc9OvjGzQqnHVZGdVVrkrTDHnI6lRIv8YfGQ/ncYxJwXOsp3e5jP4yAS/roXldvJ5O3artKGsN7o+F6NvWCOlzI2xTnUDyR4O09BOMcsqUeNIHGJ1Kw0HdJQUFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757901494; c=relaxed/simple;
	bh=lwwcDoDvfbiO59qIbS3KSPJx7Imyoi3zWNGgCLtUpbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=illH8M2Tvm/LLIzgFu7g0uRFShD7H5zzGmySmMBIhe7rcC19oazZXZJ3ksGmM/ksNHW1CfuPAmSXlJnBfcp2AjXoCa6k2ET9/j+ReQjHSdlLZyqJCCe93D18Q56SKN0AULpSF9e4DcQeaTe1qlpcNCeZtZy5+22NNudK1V/zX5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSIXbF3H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSIXbF3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364D4C4CEF7;
	Mon, 15 Sep 2025 01:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757901494;
	bh=lwwcDoDvfbiO59qIbS3KSPJx7Imyoi3zWNGgCLtUpbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZSIXbF3HQeUNsua7xhtgFRxmM6uwD27cHJsPA39zVIJ/+b3Ow/J4bj0OOcEX4fJ4G
	 Y+XpVVmglbAYHNkFqCHnhQU18w8/VG3Q5/hEmJDoRjpNFBW7URJ1069oRmhd0/Ia2/
	 Z7ZW8nqBQwozDkEZrLk6VcJUsvdzrDCpNlO7raHromB0ltWaAI7bx+bEUojsG91SS4
	 F4ZcgZ3YDVafcHivFxGBBPSvOV2/pmgQsoRvkR3RR+OZCtezxsKQLiFqLDhWyQVM0g
	 jrnAT9GqKej3Z0pySZC0hFxbsYR8YnNAdBHE8m0HBH9rA/NoXUYwDzymi63vEshrw7
	 J4p0cL7kj7BXw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/6] mm/damon/core: set effective quota on first charge window
Date: Sun, 14 Sep 2025 18:58:03 -0700
Message-Id: <20250915015807.101505-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915015807.101505-1-sj@kernel.org>
References: <20250915015807.101505-1-sj@kernel.org>
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
index 996647caca02..84de1cea5440 100644
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
