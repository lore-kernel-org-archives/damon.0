Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60BE3A256C;
	Mon, 18 May 2026 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147692; cv=none; b=FXgNH8S+0nvZZHQHKKtYXqjbCHODGnLOpodJ1pwteDHhwL0JqUrkatWqaZZ9mHweySeXeTfh3jGSL4q5V8UoZGmIdjyI1p6dSIEIRUVjQx/bNsZgjbdXrtbtrd9ZhM289zchC5l4OVDm8RG4DwsYMSStBARJtWkIpdvkToziIB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147692; c=relaxed/simple;
	bh=nQkVs1zWTxTfa8xwvc1gaYrxiOp7sl8ZruOo6hvwVAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HI7t0AIb2lbAScww1GFkibFHma+EOsDQiiCvBtrwhnKKGQzc4pyGAq4Z6AG5YPUabsqcBq0ii2GMKXYeaBNV0nx0Lh+EBnuKE28lscZHErpx09k9JAK0Oj2wySdp80BpTr/FmMNDg81zQqtTxQOb7eiUUjXjQ1cimtVl8DVb+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkfPHVX7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkfPHVX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49151C2BCB8;
	Mon, 18 May 2026 23:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147692;
	bh=nQkVs1zWTxTfa8xwvc1gaYrxiOp7sl8ZruOo6hvwVAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pkfPHVX7GX8aIMQ/kJ/GD5EiTwpxljO4R8nUKMySnXQ9Vb+lulnQBcBIW/nNx2C4m
	 ClZoKjHJxKswAPf0joekMlk+8v0v/EcSa3o3mQKfLv3Ar52wfMDr8BD+yelnCCNxIE
	 JK2PiqCCw47a0Gilz4unDa3f46dCO/7Od9kBIR3pK9I0AtPfwjlBKou8sro1cq+v4c
	 WMwCJLs4ae4KK6G7lrM68CS8PIi17wGbjrlNK4m42Eep1f/ShmlBqddY3ucSqHquHX
	 tgrLIMXbARD07N0DVWPGPDM7zK2GsKQjvV54K/Kp/onV0anElv6sHl8GwY0UFczpvU
	 c+se8nMtaPYtw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 23/28] mm/damon/paddr: support DAMON_FILTER_TYPE_MEMCG
Date: Mon, 18 May 2026 16:41:11 -0700
Message-ID: <20260518234119.97569-24-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the support of DAMON_FILTER_TYPE_MEMCG on the DAMON operation
set implementation for the physical address space.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 9997c5174ef1b..d0598f5f26882 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -124,6 +124,7 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
 		struct folio *folio)
 {
 	bool matched = false;
+	struct mem_cgroup *memcg;
 
 	switch (filter->type) {
 	case DAMON_FILTER_TYPE_ANON:
@@ -133,6 +134,19 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
 		}
 		matched = folio_test_anon(folio);
 		break;
+	case DAMON_FILTER_TYPE_MEMCG:
+		if (!folio) {
+			matched = false;
+			break;
+		}
+		rcu_read_lock();
+		memcg = folio_memcg_check(folio);
+		if (!memcg)
+			matched = false;
+		else
+			matched = filter->memcg_id == mem_cgroup_id(memcg);
+		rcu_read_unlock();
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
