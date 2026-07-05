Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953AB38642A;
	Sun,  5 Jul 2026 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783266967; cv=none; b=kPUCRbyK4raiWIIfTy5/SvUj3V5hlQI2/vT7SCvDlunKnWEBgtwav3VieNTcV59AAR9rgoVMT0v0XQTZqDSZ07V9neAkvVZPzZfAiKwXlDJfc0ciCiaRIloV9kSo+LUXq2niNGRnLsYhbXRl6Bp+BULVWUrzy8nXP00pARinLGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783266967; c=relaxed/simple;
	bh=V8JO+A7dnrCg/1ncTzDlamr6P3PVW1soQkBnie7tpVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ih3fXJ6wAJpXUUPjTfRvx56vqZQ0CcTGpZ58/UdEhc1A0bz65PhYkDB6I79A44lOGRSJWjT6Va/ml1tdWwbLjUYdRpjP0mU9iH9BXup5lqIgbRTdosL2gq5xZoLHpMq4P+PoKxIcSODnJ14QbBkP50JAsPeVb64/sE4jMfFQkfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyU5VDAg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyU5VDAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481431F00ACA;
	Sun,  5 Jul 2026 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783266966;
	bh=flGogPd+rUyChBMLRSMN0vLB2pILqw+V29hJNORLFwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DyU5VDAgbj6X0xmO8Ww0U9SrLl/+mHk8nardPbOQj6cBbpov7tXmK4BDbbXN3F3Cm
	 N+8BXHVjXey3E9TLVBVotXAc8gChnSlWskt8ykip1tqjIHDKJDvJ5U5TpHFnETw0OG
	 MH9Jyq2gu9jseqXZhe1s5nnsG1rRa2KuJuUhDsNMgiPyuTTMTPl3pGs16gsqVJ8ws0
	 oxonGWPdRivdExL62/qcJfLFP3BpHBcBDUnDfKbTqpKYIBKywxqpeB9akDsVQZvU+8
	 MHSHWObmwbpjJ6WSk5eUyfilJ7PJgvUpKOZVp+Y2FOkcmXucYzRh+IRcBp4rVjfYuy
	 aqtxltz67PP2Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/8] mm/damon/lru_sort: remove duplicated min_region_sz power_of_2() check
Date: Sun,  5 Jul 2026 08:55:56 -0700
Message-ID: <20260705155600.96555-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705155600.96555-1-sj@kernel.org>
References: <20260705155600.96555-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_LRU_SORT validates the user input for min_region_sz.  The same
validation is done inside damon_start() and damon_commit_ctx().  Remove
the unnecessary duplicate.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 32f41491b726b..2dd0cd0d26273 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -284,11 +284,6 @@ static int damon_lru_sort_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
-	if (!is_power_of_2(param_ctx->min_region_sz)) {
-		err = -EINVAL;
-		goto out;
-	}
-
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.47.3
