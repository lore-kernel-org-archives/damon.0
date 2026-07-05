Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785DF3A9D94;
	Sun,  5 Jul 2026 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285079; cv=none; b=UQkvNtAJSI9CR0MEjLshkjWK1ms8dhfPMHvAuXO0gUqeqt1kq9qOL0PlNFdOTTm4e7c4LepZ64nE9taO7yT11ClZ3cXmgK1SBetswPtRQwYI2aAHKTQykDqyg58/s9uzqcuFCzMp0CGRFOluvzqEARsdPA3UIT/eX2cX4rIJ+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285079; c=relaxed/simple;
	bh=+c87Kb4PO3SSeDc5SMswAy4XK0/f8uJHUrh2uf9o+xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3s+eZulXQN3ftwm9UF0ycfWmN29jY0RmAa/sV7tlACoBGEg34160s7lFyCRwQvJdUf58ad79SR9v9qJ0yjYdoe6n6Ves4H1cDhSOAKKHL7i73tshUGJBE5zOaaAax0qZBaibds5CIxb28EJV91WJiTCirr4uLfuMYjkR4P9+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQAu1j7A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQAu1j7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297A91F00A3E;
	Sun,  5 Jul 2026 20:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285078;
	bh=QnL6i0mbNzGqk7F6gIjbd/KMt9GZkHBDgTWFw34qqes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NQAu1j7AwAYYBd6YoXtthiwGqh3oGnAKpiDpkG+9z2+IHVfzEjXyUVELfRbSdMnjv
	 VNdYhYMk9UuaruqLiOJlGQp0VaC529Cu801wyalAP2zIC8jh6eTdVlCJSzVen63ux5
	 Gg9b0wUNXB2qnfHZwYfI7bPZXEE74kY2LW+exNDbiS8UtdUqk4cRj3iCdyM4Ix4Eiz
	 xD43KxUceR9Zghv9jm12uIq0QdB39YMj1DWQQUn96IP5KrhaWMTY/1/uFGoQ4yABBd
	 0ozNQh/G+VehL5cQ5ruJ6GzIDvfLwGcMHYIEOIjjRjiSryX4klbTvfQ1BmX69alHbk
	 r7EGfoRUtgbvw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 12/16] mm/damon/core: implement damon_has_probe_weight()
Date: Sun,  5 Jul 2026 13:57:34 -0700
Message-ID: <20260705205743.98656-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705205743.98656-1-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON monitors only data attributes when probe weights are set.
However, the function for detecting it is intentionally returning false
always.  The intention was to make changes for complete support of the
mode in a safe and incremental way.  Now all the building blocks are
made.  Complete the mode detection function so that the mode can really
start working.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 83db073c74e2b..b44393ccaf6b1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -211,6 +211,12 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
 
 static bool damon_has_probe_weights(struct damon_ctx *c)
 {
+	struct damon_probe *p;
+
+	damon_for_each_probe(p, c) {
+		if (p->weight)
+			return true;
+	}
 	return false;
 }
 
-- 
2.47.3
