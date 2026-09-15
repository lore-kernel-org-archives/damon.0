Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9893CEBBA;
	Tue, 15 Sep 2026 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438180; cv=none; b=JIZc0iEYL0b51Zt4i8zkwaB6xd7MCwxDibchG/I5NsjoVIP96ppCizHGI0pNRMPx1snv11Z5fYDdQEOA1GtYHgYl93k5M6dA9967/gmMKsR71hlpNlC7B420CzSDnE45jxu4UKTxe2CrB5hxfHkRCiQpwnoJdk2bN5yFxBcnUpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438180; c=relaxed/simple;
	bh=D6BHBRxeaxnmXjOk/qO0eNxWnxIZGdfq5CY6QwIgMmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMzYZaf9vgi0jALQ7AlLjusqNCVVoVwx3C4ECSfDbIFHlQwlsVxMlgl4y3d9KjpRReRXlki28twK9JLMDODGJuqPfslMzSTViD1Fc/Sig2ReitLmSkwaU9WmL+f5A9fI/Coil7SKTAH5rqe+bjmRwl48VN1bQ4NVROzRsFCRgDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2Iis2E4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2Iis2E4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1694D1F00898;
	Tue, 15 Sep 2026 02:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438179;
	bh=WsrL2oFK9840WoIrM7QJPBsnHu9HVCMK1ZcOyqnJN44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O2Iis2E4n44X/NA0Xw0mz+iXnyBqdsP7cavlY1qEktz/DTa6Amkian8eyIW7/Ckto
	 dd4UPljolRKOfCDrCD8PC2JDDZisiJoD7n5XCx2MzBlxTHwlFokV+soFX3qHlONLba
	 lg5+LAxy/gsWjXmAF2BCIAuMuSTlWuvUgf9CFgVwJ3UZD7v91lEIbtqjSMIJ2PYaDX
	 dtx3fVllb8bdGaP1GZGx5WkKqQokCf9blWMCrrA0/BD6VuBXLwjyJY+wPHncTMc31e
	 OOf2pCd+xgo/XwR4AqSqw0aRIJJ5d1HXJV0bQOtDCbbVVzkMRX8H+tyiZ4TgGRjbDZ
	 8APcSekMueGPA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 3/8] mm/damon/ops-common: support hugepage_size damon filter matching
Date: Mon, 14 Sep 2026 19:09:22 -0700
Message-ID: <20260915020929.102953-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915020929.102953-1-sj@kernel.org>
References: <20260915020929.102953-1-sj@kernel.org>
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
