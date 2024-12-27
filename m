Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C841F941B;
	Fri, 27 Dec 2024 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735333711; cv=none; b=pg57NuLSw3fS37dDU8N0zC9eT0gOMSjNRDEo+eQRbZrbvzrPHQATaUA0xxnaPjbH42dmb3SIlK2m6F9jjqgQqeDNaLaZh7D2JkQF7PjlFIRLM3g2W3MJMLCq8p1GnBYPekbYZDMB8wKS8kbtPvvxV33NbEWOTKJrhofsf2M31Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735333711; c=relaxed/simple;
	bh=SeMHzC1M39t8q6CCCk8soRnhB4lB7Sy3qIRyk7EYfrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uKpgPFphxaBTgN/D5DAiaINX+3Gs1qSVnCKEgGThV90C+/ftxedaL0s8LRtvkYsgPVhUJ5qnoFhkeTYv+pnZ9xO3C6lgYe5O/n18tOkSnZ4owByglQMRHHQakidd1644enj2bZGBrLqjOYthon4b+EQbh7DKICpIUz/okBdh86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9gQaHeb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9gQaHeb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C83CC4CED6;
	Fri, 27 Dec 2024 21:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735333711;
	bh=SeMHzC1M39t8q6CCCk8soRnhB4lB7Sy3qIRyk7EYfrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T9gQaHebXbvQqfNyFuj5hWQDHLpGC3wzkpL37XweUv3w1CsosT2Q4AHPDfRQOLacG
	 ChYhjPlY7LsFa00Zd/U+inTizRccRAYmIINCnYnS/yTaMflWorTQkXLLyHWU1XePef
	 e7DexRXVaUxs8RxQawG0QuGuTRaUJg4ZN76rPpzyPEuCEh9Prz+/um2oFGFPdizJfK
	 4nnbrCmDMAuWQR0b4vlz/KlZBAdIU475j9WWH/rZGzqXRuC/VYYqzRvDB6FeKKxkva
	 Ke1g5Jxvm+OQqs3MkQrPOK1PJMe5nVR8nG7rP9awY6rVVdYcMjz6qg1mBICTmOKqhq
	 DdOX1E6fsswTQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 04/10] mm/damon/paddr: support damos_filter->pass
Date: Fri, 27 Dec 2024 13:08:13 -0800
Message-Id: <20241227210819.63776-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241227210819.63776-1-sj@kernel.org>
References: <20241227210819.63776-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'paddr', a DAMON operations set implementation for the physical address
space supports a few types of DAMOS filters (anon, memcg and young), but
ignoring the ->pass field.  Update the logic to support the behavior.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b0c283808ba6..71cb02128b46 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -198,7 +198,7 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
-static bool __damos_pa_filter_out(struct damos_filter *filter,
+static bool damos_pa_filter_match(struct damos_filter *filter,
 		struct folio *folio)
 {
 	bool matched = false;
@@ -237,8 +237,8 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 	struct damos_filter *filter;
 
 	damos_for_each_filter(filter, scheme) {
-		if (__damos_pa_filter_out(filter, folio))
-			return true;
+		if (damos_pa_filter_match(filter, folio))
+			return !filter->pass;
 	}
 	return false;
 }
-- 
2.39.5
