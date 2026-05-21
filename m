Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAF03EE1C6;
	Thu, 21 May 2026 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374079; cv=none; b=ezfc+wJ/pwacgnJvauRn65A+pj5dCsM3TEYuo4pte7Qa1T892braHtsshYTU97jp/STfN5XxB5oVGSjMxu8a5HEVxhN7fb9POyQOVgghniLup6K+UvtS/vekASEX9g6fiY3T3J9zQhW7l7DarPDY7tZFzEnCdiEHLmh8ujiJlto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374079; c=relaxed/simple;
	bh=8B9IiCSCXwYFGO3g7QwEtxLcmC3JtXQgAOF4um9StEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNFC/NF/TpFdlAFemlN2gRtM8egy7ELVLk8NRK2CoquZx7/g65Z+FWwDF4UGzwno1nuf8powEhfm1agcFyx0Q+t5JAbaFb7Zh6Ewc7OFsli1dtxUBH4WLns3dS9hHQsr+TNDVroHxi/WUgt1Xj9tBLiUDujwUTFzha8jkT4gqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMUsZIf9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMUsZIf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9E11F00A3B;
	Thu, 21 May 2026 14:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374077;
	bh=5i2WVbg2PjBsmn2NfpjKEh0VGjqNajgL/l9BFto2EhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AMUsZIf9llHaj+LMaBC6OfmqVdMv4o6AxcDfQ9KSHUD6w21A49A9s6lLb3X0UmsnD
	 PM+CdMA9+zuqcZaNQ3MzcLIF+Ot9zyn/xFMifwlfsikGP/+N28I2xvTa4WaranbdpA
	 vYNEEAz4ZsRileTbMkA+D20t/vv1ZWxrXvfV22ZxUEbIvTYJlPQ0QStRRYPlOhqlFP
	 P75wrk+PZyWQQpu7eWcDF70i70vYfRTRNz/co0tQHMBDyBraLS1VUlMUGZzkPs08lK
	 Ee0GmtRDEaWJiOwhrv/EuMO+1Gtk/fB7ZHP4uwOYZZ+eunW1riAQX6A+xVioLJ3XEk
	 SLlvX3nddJAZg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 01/14] mm/damon/core: safely handle no region case in damon_set_regions()
Date: Thu, 21 May 2026 07:34:11 -0700
Message-ID: <20260521143428.83157-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521143428.83157-1-sj@kernel.org>
References: <20260521143428.83157-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_regions() calls damon_first_region() regardless of the number
of DAMON regions in a given DAMON target.  damon_first_region()
internally uses list_first_entry(), which clearly documents the list is
expected to be not empty.  Due to the internal implementation of the
macro, damon_set_regions() is safe for now.  But the internal
implementation of the macro can be changed in future.  Refactor the
function to explicitly and safely handle the empty region list case
without depending on the internal implementation.

No behavioral change is intended.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0267faf216b95..40946a7f6f549 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -356,6 +356,19 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 			damon_destroy_region(r, t);
 	}
 
+	if (!damon_nr_regions(t)) {
+		for (i = 0; i < nr_ranges; i++) {
+			r = damon_new_region(
+					ALIGN_DOWN(ranges[i].start,
+						min_region_sz),
+					ALIGN(ranges[i].end, min_region_sz));
+			if (!r)
+				return -ENOMEM;
+			damon_add_region(r, t);
+		}
+		return 0;
+	}
+
 	r = damon_first_region(t);
 	/* Add new regions or resize existing regions to fit in the ranges */
 	for (i = 0; i < nr_ranges; i++) {
-- 
2.47.3
