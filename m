Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008453C98A4;
	Tue, 12 May 2026 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596627; cv=none; b=UVufDO5/fumpwz4PuVFRYUUNxE+4C7qDaEKxbaMA3VuVlwCMY0jCez2YBCCUiL+UkFBMchVXuEHTWsTFAVPVLCh8J/hD9rZdT9w/DjLjww6bu2PrihpQmyb8K27YPbgUUg5DTjugdcfNpoRyDw5WdKi1h9k/oxGzLs5iVXzmJNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596627; c=relaxed/simple;
	bh=nV0BEXAl/A1NtdiYPlzAvpITHMz8pj1VAAgBa/dBAlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhPcmQctsFV6b2f8bAd5BEUCAzCejVwWawP5X3E+r1C6z5UsIU5WPPTedJ+YnkCLVaFcwbsRbhQUMmlOcwysUwFIT/DsS0xbvSpvb2FQ40aEDhGmIgBxmUPnIjWsadShPFI3ptp3EFoy5jYMnaURHLCKYZR29TsWspKzqPSrHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsojjOUR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsojjOUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9207DC2BCFB;
	Tue, 12 May 2026 14:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596626;
	bh=nV0BEXAl/A1NtdiYPlzAvpITHMz8pj1VAAgBa/dBAlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KsojjOUR5FpzuhoMEsiQ74lUTtF3Sd4uHmbZgbxvj+CN35fepwndOghBiOVFw7xO0
	 Ina4iKV98T2sy2Dl9/ct+GGklfuSC0R28ypUeAVNfyTyvZXbJX9viVYPcDujdLlhlJ
	 fMdeernsOZ2muTPkX9fjxA9IUvBjVb3JUrIDuSA0cy53BnFEXy0WeJFIjVxbqslFze
	 Z5U15cbyGca6bSsK6eJ2xDhpWeWufKtDJcpPofPlrKa1YynmqgbFJvd7fuZ6+a5u77
	 iaFVyUu91FxnYcnsAH7crC5O+qgR4dRcbzf8l37Wkx+Vvga8b1iTzg8a9f3yWdd+8U
	 k0G98Y2QL1+NA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 23/28] mm/damon/paddr: support DAMON_FILTER_TYPE_MEMCG
Date: Tue, 12 May 2026 07:36:38 -0700
Message-ID: <20260512143645.113201-24-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512143645.113201-1-sj@kernel.org>
References: <20260512143645.113201-1-sj@kernel.org>
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
