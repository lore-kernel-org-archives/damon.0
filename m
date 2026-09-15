Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BFC3C342B;
	Tue, 15 Sep 2026 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482849; cv=none; b=Co4SAo4Ngbbp7WckpNIwKPO+J5VBgABT8V+WHTJwgPwzbxy5woBdSOyYgbRs/7EhS6WbqfCTLgkm3WIhj7mzzdm13xuRk0NnT4Nt90uSVeWT2XitT8YntMXPuPqlJb5U0XcDai+28UVZPCOyJ3VTh5W2H5D9Dw4tqn2CMKbzZ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482849; c=relaxed/simple;
	bh=D6BHBRxeaxnmXjOk/qO0eNxWnxIZGdfq5CY6QwIgMmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbbgo5OG/OApaCssL/zWJdD04syNUYwYG2/a5vG8rHYSzjKfggH47It2E6Zs2AwUhz5QA7qM+DETPsaYJkgTiU6wcIVHZM5C/7QF1CKRo560dYKdJGfC2qciymmuphwaqTcRfKLPthVKEgqS3iUVdQLZXLp+tGe37vLcUvbUcCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jczOAY43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jczOAY43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DA91F0089A;
	Tue, 15 Sep 2026 14:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789482848;
	bh=WsrL2oFK9840WoIrM7QJPBsnHu9HVCMK1ZcOyqnJN44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jczOAY43TV82GPM9joO0KlMbFEhEwzVbxDedWo2jpIngc2YnKXqKV1N6fEST14jda
	 1bo+HY689g3cdashcwO2Xe6gl7qP7NtVUQO56OTH0bGsu9sRWT8j4mci50+2dQkC+7
	 w92S5G8oVmp58iIf+2qzkAFUuyjZpdKkBxKuiYAZWkzYWYc6u5+UmdUpUSCpdw/1c5
	 92UiWOIF+ooND9mn71yZ53zCNmfhnEDdjbSVs/+g10r7ixrV4qX/Tu3QG8UQZHU8z0
	 9A6sOziWW696qrxTub1RTsKQVS8c/EPAL/C2KU5Xd7GdYJ6ACrhH5VIqZp9EploMhR
	 /qaRa1MyNfMyA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/8] mm/damon/ops-common: support hugepage_size damon filter matching
Date: Tue, 15 Sep 2026 07:33:52 -0700
Message-ID: <20260915143359.91472-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915143359.91472-1-sj@kernel.org>
References: <20260915143359.91472-1-sj@kernel.org>
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
