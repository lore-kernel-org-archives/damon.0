Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2CB36DA0F;
	Fri, 15 May 2026 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805897; cv=none; b=iEAX7h9AUMPauCwwcRJ8XLpkevXQcTkZqxLrmH2jjeFb7m63PIojo/YfyLUT5t3ywfQu56HmXsbBaQMETVuK1IBuWFxzTvsPOYElfIUv4zdPOP1Tp3y8sw59T1Vkpl/2uuW+so5pp52bEnOKjvnBlTK6LsOy6mE1iZrHeeXhghY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805897; c=relaxed/simple;
	bh=lR5soWN3IOVMOAa5jz6VmMJ/WG2kTof///VJp0cNoDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUKFZ5aeuNs+ccSlTsWlax9LbqvvHLKMsmGV31A7jVq9gCKp/uZx9BMg1J+28aU7dXwn2hBfqIWWaRYTWNlrI+Jgmr5d9mVnO+tCah2hjRJKSShBPiYgFsOKV6xhCOjM2NIX5T4j7vjNp5OHoZxdwhgxRzMRb02G1Lm27SqkCws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJpnyRce; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJpnyRce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF0FC2BCF6;
	Fri, 15 May 2026 00:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805897;
	bh=lR5soWN3IOVMOAa5jz6VmMJ/WG2kTof///VJp0cNoDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJpnyRceOgoYjh64htKLDtHX4VVkUjh+8Gu5d+DFH7Fsl5eodlbpjHMuJq8DeIDEl
	 wJ8T7CvOkwLPL++m7fkvjF40gjIFQQTu4ZkeOe7gDKQ2kBowMKXc+0oCL+eNvu+MQt
	 npJfGTCVkfgXIeUq2ML77DpvLxNibMuqhUGgjZ1J3JtfT9fx3eDmqDaXQg3MdUBke5
	 sENoSXqjkBwKIOX5hGatLf/31uqHFl8lrgzRyHCeAcbAt6u2sAzWxNYXWVzSm8OPnc
	 jEoXlCHuWPmrfSxY0Lld3APgm6jBc5rg50QTlW/DvONAsHU12L+vuSK26/U07oDVve
	 H7wTWOkGt6JEw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 23/28] mm/damon/paddr: support DAMON_FILTER_TYPE_MEMCG
Date: Thu, 14 May 2026 17:44:24 -0700
Message-ID: <20260515004433.128933-24-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515004433.128933-1-sj@kernel.org>
References: <20260515004433.128933-1-sj@kernel.org>
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
index 493bcca8ff104..c3adccc2e6c71 100644
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
