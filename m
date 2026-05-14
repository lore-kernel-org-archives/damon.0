Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04373FFACB;
	Thu, 14 May 2026 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767767; cv=none; b=evLostWFfJzmHwvfVhs5kUTE6NJHsb0bKQ2lhLNygeVfZckEKSsHx+CHQBZt6Sag3dfJf+46K5VwX3jwGEF0XsuE9Sd0iT7FyH0Y3AID+LpFg1GqF77TTDQTW8sRmeW3dp42NjX443GW+eoHPiXQeHeSdxAi6s22pAOZ2K6cERQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767767; c=relaxed/simple;
	bh=nV0BEXAl/A1NtdiYPlzAvpITHMz8pj1VAAgBa/dBAlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auXIGHkg7OZsmN4WDJzHiw7i1YVrTDzCHY736/IWFvIcVM+QgGlRCfTu2OrzVqomWwf11wqOkKU9q/LTcAjDE7MXjDnu5MxJlYjGAmXf6mUCaTTE/dta5w6maW0XcdiDCRtYKYTxKCDcSb9ZJHMoZXGC/bHKIT6vxLWVRAlBHDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mus3+/t3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mus3+/t3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A935BC2BCC7;
	Thu, 14 May 2026 14:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767766;
	bh=nV0BEXAl/A1NtdiYPlzAvpITHMz8pj1VAAgBa/dBAlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mus3+/t3MS0p3bVGewchGU1cj0bSS8OuENPsGcTXoxhAlzYi6gB841ctXOqeNgB2w
	 +0M0FJoHO1sEqwD4HCszb608BB/khqQgl7Ksy1uMtKcLpkS/JspgwJJkpN8WGTpWRw
	 zskax89/YnICCVJW18uE4jo6VY/CK+PZ6QtpZTROwXxEz8ifwtydoXF9zPNpgSWMbI
	 WnRlyT2obZGPucV/hyYTKHPtScj69sJL3cDl3g0vqlFl16jeNtqMiLkh6tFr4boKO5
	 P79vVvDKJIbRGMBH7t3lLKbOT5TxD9pCIuNnP/YZiZ2LgX8Xb9CZ8HXun3atdezeRb
	 OuiOZYPyvbpvw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 23/28] mm/damon/paddr: support DAMON_FILTER_TYPE_MEMCG
Date: Thu, 14 May 2026 07:08:56 -0700
Message-ID: <20260514140904.119781-24-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514140904.119781-1-sj@kernel.org>
References: <20260514140904.119781-1-sj@kernel.org>
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
index e60af2cbc1089..f093485fd16a6 100644
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
