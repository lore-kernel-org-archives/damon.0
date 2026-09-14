Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FA548124D;
	Mon, 14 Sep 2026 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397099; cv=none; b=eS+Jakr4D/X7nNeEH0QnKpt9Bm46Wv6QEdP2BWxSpvNN/8n/5LGXbllqAw6e/eWXbucGpILj1m7HgklAqo0zU273xN5+3ArbW97Z4lIUXJUTw3Dg8KkMXQqzk5yvL8cw4OkK1/pmvh6NyWKc0D5qrqZea617WjR3EJeoQ7fNSwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397099; c=relaxed/simple;
	bh=D6BHBRxeaxnmXjOk/qO0eNxWnxIZGdfq5CY6QwIgMmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xut1Gkat2PdhZ1CwYkkBQkREML5nnPckikCGx6Sr9NBCDTryicwiR87un+gFqgi7lceLzT8pH/bu+MEFvnq2C0VTF7ufiuNvQlwoR2zg6XmeDtzhMMvLQKsW1UF1qi6iQmXY9eR4pNXvE1nfVoFJORcT4Q4l8c/O4Ctbr4W3Gdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsJJx57D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsJJx57D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B55E1F0089B;
	Mon, 14 Sep 2026 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397097;
	bh=WsrL2oFK9840WoIrM7QJPBsnHu9HVCMK1ZcOyqnJN44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dsJJx57DbIA0yLwgZEFPsiVAQ9E/HPhEGkVn80+zXts6AqF9XSt9ICtAptmYkOQf3
	 o5yH7Sz+GUGGscu3j1x5Qtip0m3O4ZQNboofdw5bv0z2o53478bhvebVvaex/Wx2dt
	 kmTqN/UiyfwTm0kKGTJwa9ZQTShaUU6TGvuaYKs1RZbLM5yoU8ViUPY8gji6h9/eLs
	 y0AqkHIl7Pi9UV/7XkjCiZQKxz8ZnxnWXMF8tF3kY+426M/lov//9xhI+F34JJ3T0d
	 vFtnwR5f6ncU8wzSGtagMWEdtft4s17bSrCQKLt83QsyeRVRTtcjHo3nnelGUD2TYU
	 vemiadlmIVvPA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 3/8] mm/damon/ops-common: support hugepage_size damon filter matching
Date: Mon, 14 Sep 2026 07:44:40 -0700
Message-ID: <20260914144448.93732-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914144448.93732-1-sj@kernel.org>
References: <20260914144448.93732-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update ops-common data attribute filter matching logic to support
hugepage_size filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index c36cc39cd2c70..77366f42b3e5b 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -536,6 +536,7 @@ bool damon_ops_filter_match(struct damon_filter *filter, struct folio *folio)
 {
 	bool matched = false;
 	struct mem_cgroup *memcg;
+	size_t folio_sz;
 
 	switch (filter->type) {
 	case DAMON_FILTER_TYPE_ANON:
@@ -558,6 +559,15 @@ bool damon_ops_filter_match(struct damon_filter *filter, struct folio *folio)
 			matched = filter->memcg_id == mem_cgroup_id(memcg);
 		rcu_read_unlock();
 		break;
+	case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
+		if (!folio) {
+			matched = false;
+			break;
+		}
+		folio_sz = folio_size(folio);
+		matched = filter->range_min <= folio_sz &&
+			folio_sz <= filter->range_max;
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
