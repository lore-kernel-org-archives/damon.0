Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1527C851;
	Tue,  4 Mar 2025 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123166; cv=none; b=sjJegE9UGYq3IDK0tnrfQlhAvX3NE8mnQxuFBoOUCx0jfgNzbZV3dFmCf3hBxn5+lSLrVF3eq/LXjGJMnl4hVo6QFR0ONBr4ePnWzhkoiEuHeltFm7rLMIWaiiaVwaFEuyTTg6YDqP8fZoq+rlGxWrf1Xgc6McpKCC19CtzxjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123166; c=relaxed/simple;
	bh=ZliShDrZ0L46pvsTW9GzGZb0sxInjXIUsFCHMS3ng74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IduQ9Yi8NWsSYGd8PoxI2wK4X+bEmjvY1Dh2i8JMk5j3emzERXa/XYwbti/mD998RtY+3n613NfDrTi9cYzeXKWxfTiQYLzdtoIrem5VGLVJIOcK0TKUq8tq/3dZxqfFi5evkFA2OzrmjCpJJvSBK/1F1oGE8zXC/Xl3oFvsG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6UHmq9j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6UHmq9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB93C4CEED;
	Tue,  4 Mar 2025 21:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741123166;
	bh=ZliShDrZ0L46pvsTW9GzGZb0sxInjXIUsFCHMS3ng74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M6UHmq9j1mkN0E/jbDoKlPvDDEXN/HEofEzXOoAFv0R1wVXpPeAhVFQJJaUGEd92Y
	 jQ1s619HlVIVL8SyV04x2TWXiNMexUhRdUYdtPTaOVD2qGOdcZrhCEgjdHE2ByQ7Md
	 DRVjaE9NdYdxM3bqI5sD2SPg0cDGH8C8Wc30mrp5pISWr9OFgd2YVZeXp6yDIwh8Tt
	 BjGI9s/MfnA2tJF8PuQutJmOjRwrHQjugfSr1VVxLI0KAzSxYzMu6WJoGS4FVOXjbT
	 Rywfe/pxqGFCmot7EwubXP2V6pTtKe64V+1xGioybpTKR999XhhpOHiYk7c2ZjbAnZ
	 2aVtS7qsiY9fQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 8/9] mm/damon/paddr: respect ops_filters_default_reject
Date: Tue,  4 Mar 2025 13:19:12 -0800
Message-Id: <20250304211913.53574-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304211913.53574-1-sj@kernel.org>
References: <20250304211913.53574-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use damos->ops_filters_default_reject, which is set based on the
installed filters' behaviors, from physical address space DAMON
operations set.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index dded659bb110..fba8b3c8ba30 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -260,7 +260,7 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 		if (damos_pa_filter_match(filter, folio))
 			return !filter->allow;
 	}
-	return false;
+	return scheme->ops_filters_default_reject;
 }
 
 static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
-- 
2.39.5
