Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0522F2673B8;
	Thu, 20 Feb 2025 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080124; cv=none; b=SVnvzvlfs8H6FnMlzrWI8aJYnmAUe1IvDRUw8P+e4HtOPWliP/P96dv+BWYwP48xvbXaxf4qu5sqkls3vmou1TSq/J+650klDWmF+J9fMXqgP6I1a+3wQtu+3VoNu9hDSPuEM4FGsyFZfro/Ir/BvkjxZIdB7vJkewKcBqksT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080124; c=relaxed/simple;
	bh=nd9wYO5DNDexZlIChCJ3g1cCRKtQ8wQLlcDDnAi89uY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fSNMGD+l7k1cxQu0N8xKHqKhzmcYUSp6cNDxL1RriUBaGIY/kTxqwrhdFCyoozhr3+WxwU+QSafnEvLl1WlodtDxxD/j9AM7ofGsy8JS5Gugo46cag2xv4vdEXsuVKBHW9FAgZyVI8qon7JNUNQnvtmSr1G6heVXJ7oNF9z9bz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBhUt5cq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBhUt5cq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F11C4CEE3;
	Thu, 20 Feb 2025 19:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080123;
	bh=nd9wYO5DNDexZlIChCJ3g1cCRKtQ8wQLlcDDnAi89uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBhUt5cqfRfFVLUVIBh0ebaIMjk9oVLJPjdVmaMCy7/d2Ux1Pi9XLxlNV7oFOnyHn
	 y8TafmolN0o/wa2T92KEg65SnMvHZunZRhgH2Et0hPPzULK7XDhx3Vp/2k5gAPjfvb
	 2564iDB0R0QLY77w+ZBj4CwThq3rkH8DE7Q+wh/VAcT9V6eOyTl5/qzrFOlMhxK6RH
	 Ugyg2Z1EDuAH0/1bRzahVmnSz25BoB20ereF9vX//ajC7+eMvfQh7TBkD1mDGRbdiF
	 sntcsrI5Gq/EoBO7TqULxTkiFbGMMfYxuMs8nDos/M5OjGoJ1lbJ6Yu8oGnzkzGghM
	 592ZqUWxV5eCw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 8/9] mm/damon/paddr: respect ops_filters_default_reject
Date: Thu, 20 Feb 2025 11:35:08 -0800
Message-Id: <20250220193509.36379-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220193509.36379-1-sj@kernel.org>
References: <20250220193509.36379-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use damos->ops_filters_default_reject, which is decided based on the
installed filters' behaviors, from physical address space DAMON
operations set.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 432ea4efdc4b..fee66a3cc82b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -257,7 +257,7 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 		if (damos_pa_filter_match(filter, folio))
 			return !filter->allow;
 	}
-	return false;
+	return scheme->ops_filters_default_reject;
 }
 
 static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
-- 
2.39.5
