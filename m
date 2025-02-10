Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE572566EE;
	Mon, 10 Feb 2025 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212064; cv=none; b=SJ+FxyFLRi2C4ljjfAxHITMTw/XVZ3p7RkJiowW8uPRaDBny40c6oli2VH5Im81su9JdMWo83aKVX92/KgASWkPFsy0wb2/oz6v+IRTn28NHALLgwTyuOcKupBhgC72X0ilIxGJe9zwaxnFvZWcSNV7+OS+jnfN2lwN1YimsgiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212064; c=relaxed/simple;
	bh=hYylxJ/t4NlvulYeuOeW/1CI3orFeM5MsoOWEdxNfxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z5xiHFozLtWPEci4g69GxXHGlfOs++xSE58n1jYitD/isF9vhyZLR1xND/KW5goEEWrPguQ+wsLvE2+sdFhRysBw6kMo0Tfuormvwdgyctgyu61ItaxhIINaYItHgAjU5BHxg5TO6XkSie77xDbCabx3Ushw98qzCbDcrwfAI5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIgqxIxe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIgqxIxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06060C4CEE6;
	Mon, 10 Feb 2025 18:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739212064;
	bh=hYylxJ/t4NlvulYeuOeW/1CI3orFeM5MsoOWEdxNfxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uIgqxIxe3bqwoy6asnuOYnlpRVTFpkFH1FOGwJCT42U50Uxe4FJYa81ENcSz0orfd
	 qrVK2HdWWpKbdN+XcTgcvaOOyk8KVHX7tsrprCrpxqfi7kiRim5cOwKrQmUBOzBgcl
	 GkgWyHr2PGOHwjcREDaEXNdSAl8jCNp0niySHC5/nrcUtsUcfeV3kNY9ZnX+G54wCD
	 D4YNB4Hr3jT76xCjb0bpCRR4gYviefC4sCotPJj3n0QlUXmE0ESodqt/6PC+XYsEIC
	 84cbYyEqNKd16F4+e0TqwdX5ocfz3S8FZXyggY6T3XEyXII3uFNfiqQHf+vXE8Xkrk
	 +GZK1ByHMIHTA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] mm/damon/core: do not call damos_walk_control->walk() if walk is completed
Date: Mon, 10 Feb 2025 10:27:35 -0800
Message-Id: <20250210182737.134994-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210182737.134994-1-sj@kernel.org>
References: <20250210182737.134994-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_walk() invokes callback functions of schemes until all schemes
finishes at least one round of walks.  If there are multiple DAMOS
schemes having different apply_interval, the callback functions for
longer apply interval scheme will be called for more than a round of the
walk.

The behavior is different from the document (see damos_walk() kernel-doc
comment), and not useful.  Make the behavior be same to the documented
one, by stopping invoking the callback if the walk for the given scheme
is completed.

Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1d9025d14d83..4b865b2558d9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1453,6 +1453,9 @@ static void damos_walk_call_walk(struct damon_ctx *ctx, struct damon_target *t,
 {
 	struct damos_walk_control *control;
 
+	if (s->walk_completed)
+		return;
+
 	mutex_lock(&ctx->walk_control_lock);
 	control = ctx->walk_control;
 	mutex_unlock(&ctx->walk_control_lock);
-- 
2.39.5
