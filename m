Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151233938D;
	Thu, 10 Sep 2026 04:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013366; cv=none; b=Bc0Vs1a7eqwrupVY/e3HJ3rXaJgRUIdESgp2s+H5wvZ9bxDbOmrkQcl8m4AZbZjTGH4FRMWP37W/4rlBm8EElVNOaWQfNhqJ2Zae2NSjYAykHc2I/QHO+2krs4n71QkNnwkwLrbhp/yzID5Vs6BVHuwBhJYlUj3Tb/CY9f33qc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013366; c=relaxed/simple;
	bh=tdMg/rAzMwGV8K21yBEvNt3ifahWAbuJJNcO+LoUH3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2ZbpSG6db3jijrFEI3VW3qKWzMdvx5w3FKCbzQIefiLZqRRROOAxy+zQCzqEgC3b47gYjb1hCdVJnimr1+K6RTg5RiYAxtSCHNrVnHzyQD/mfujnzOGUWhLsHMQKS1CDYxPsKXKam+wT/r9ADv7Fm6OEneQbJohoQ4KggT9LQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2Qnh8QD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2Qnh8QD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349831F0089A;
	Thu, 10 Sep 2026 04:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013365;
	bh=tn9W742GaDY7vW9qUrTT7oroxJHcL95g99YMTLAp8qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S2Qnh8QDjnl8nTroDHuL5cB+wM0QUKbNRJMwH9kuOKyITV0vdDi3Nscf6h2O56siv
	 UZkgEIb4ViAVvJXdiFVAt5YsO6jf9tt56JB7po9Wr2ATLf5e7fUa9vvucgMbFrLs3k
	 TnX76BlO1NWbNX5sET+k5ryRZakWLaMCFoBS3/3Jr9KJ5YvQKzp289sQ+5dUnH40JE
	 YraWIKZB69U/oUsIkWs4LRwfKdVcaLifUX52rf6NvHOjRRJ8pwGnzMQXDiQTzkS+dQ
	 Or2UDvuGVgxedXnRVwsappbAFcKl/jhcXeG8zbzd0cEW3UQY5qQzqAMPo1lt/1lJnb
	 MjyskET5jnyGA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 3/5] mm/damon/vaddr: support DAMON_FILTER_TYPE_PGIDLE_SET
Date: Wed,  9 Sep 2026 21:09:05 -0700
Message-ID: <20260910040911.148273-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910040911.148273-1-sj@kernel.org>
References: <20260910040911.148273-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement DAMON_FILTER_TYPE_PGIDLE_SET support on the virtual address
space DAMON operation set (vaddr).

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 4aecf34e39be2..d5dde97b3cd0d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -550,6 +550,13 @@ static bool damon_va_filter_match(struct damon_filter *filter,
 			matched = damon_va_young_addr(folio, pte, pmd, mm,
 					addr);
 		break;
+	case DAMON_FILTER_TYPE_PGIDLE_SET:
+		if (!folio)
+			matched = false;
+		else
+			matched = !damon_va_young_addr(folio, pte, pmd, mm,
+					addr);
+		break;
 	default:
 		return damon_ops_filter_match(filter, folio);
 	}
-- 
2.47.3
