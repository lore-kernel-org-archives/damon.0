Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9A2347C6;
	Tue, 16 Dec 2025 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765870486; cv=none; b=rVl4YAt5FehDiudFCBVWkPIie4HIYi1Vv/yoLVL6Aw0fpnDFcmlfnE6snX8gSeP1qpuyg+b72/kqDNZxhFzh8gyItf5XSCA+N1VYsotpCAKQLLtlgwL7ZPU8m57H3UeN1SzEv3bTU+0Wpb1VXo0IQlms0h1l8YVKxDjjW5yZR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765870486; c=relaxed/simple;
	bh=cTgue9oJHs4eyHA2WXBqYnceUZkmXFS9QudKYRO1wFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GnhdxVyYGG6Z6ea4oACcyN7e+dn6fc/GdrlWbTWQ6JdqiMyOdDeBTWwuszOCMu0QeTgKsrR1BUbEg+DxPoOu3J+Ax7vY2XVXumufwXa/FQ5D9jFRSe/nEist/zBTT9LeFveF2RiK2V3OoTZEjTLsZgZuQalyOBgdAJJfhXiMLXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci7Psk2J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci7Psk2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F442C4CEF1;
	Tue, 16 Dec 2025 07:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765870485;
	bh=cTgue9oJHs4eyHA2WXBqYnceUZkmXFS9QudKYRO1wFg=;
	h=From:To:Cc:Subject:Date:From;
	b=ci7Psk2JV2qnpdhmzfWPlqe3n9/Dvz3YMfCGZyhc6sYAsEPHvU/gN+e7x8ukEEzMI
	 4opHTsmMY/ycriAGRoWPL/58OBXAkM9SWbm1OB1vgBuRYols3nXjgHvvSJ6+a9YaaK
	 xNtXs8WVMuCQNe1Y482LuxFohFTchgIOlpqVGR80UzSJOB5Y56APcs8CbOL8x/yt0o
	 fejRiDJC0stHwKakTkCmRHBsotsiUZsjRlV05LGn1SrxXNNTBgvcDOyZn3KJjEy63h
	 hHetDnsiCcoV+CTz5alO68+HKlAH6gOO/qWrQo5Gd6yTx+HdBXmRUemLF+KQpfUXp4
	 lASEe+JbBWNzg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH RESEND] mm/damon/stat: deduplicate intervals_goal setup in damon_stat_build_ctx()
Date: Mon, 15 Dec 2025 23:34:38 -0800
Message-ID: <20251216073440.40891-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JaeJoon Jung <rgbi3307@gmail.com>

The damon_stat_build_ctx() function sets the values of intervals_goal
structure members.  These values are applied to damon_ctx in
damon_set_attrs().  However, It is resetting the values that were already
applied previously to the same values.  I suggest removing this code as it
constitutes duplicate execution.

Link: https://patch.msgid.link/20251206011716.7185-1-rgbi3307@gmail.com
Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
Reviewed-by: Enze Li <lienze@kylinos.cn>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index ed8e3629d31a..ef0a1195a584 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -173,14 +173,6 @@ static struct damon_ctx *damon_stat_build_ctx(void)
 	if (damon_set_attrs(ctx, &attrs))
 		goto free_out;
 
-	/*
-	 * auto-tune sampling and aggregation interval aiming 4% DAMON-observed
-	 * accesses ratio, keeping sampling interval in [5ms, 10s] range.
-	 */
-	ctx->attrs.intervals_goal = (struct damon_intervals_goal) {
-		.access_bp = 400, .aggrs = 3,
-		.min_sample_us = 5000, .max_sample_us = 10000000,
-	};
 	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
 		goto free_out;
 

base-commit: 1791b1de223b928dd1903984344b64b8148ca671
-- 
2.47.3
