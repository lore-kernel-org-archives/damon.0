Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3992D3A75;
	Mon,  8 Dec 2025 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175423; cv=none; b=u7yAeahZvoTTsytNgVv18W26gwLMxrWejSAFvmflsTEnz0L2iAuZleAkbYh3nACKtr2IFJ+eXtemoGg0S89QE6BPShT9Jl49dgbNgc35nahgkBkCnRbYHUpG6p49Ex+rOEPA0NrS73FXhqYzuthm2ejRHkBqRxJVWiWOYBUuiMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175423; c=relaxed/simple;
	bh=QdvS7fwjEHTygGGbOIz6Ht6d55+sgZP4hFmu5IDrnVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TK7eAVRzz1ASgTuVSPShQaplVuMxo8+dVbGuz40G9Ji/AY3RAbPhPwMWcunJi6Ypj16fN9TFsuD8teQ99Iv7uUBwPZEbJYLFRGPwxbCcVKTE9YNVMRJ7q2MS2pWs2ygYPRfJv1suC+yybxUIAW7OqSEe8yrxNcGxVAyYL+l981o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNkul2iS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNkul2iS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB73C4CEF1;
	Mon,  8 Dec 2025 06:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175423;
	bh=QdvS7fwjEHTygGGbOIz6Ht6d55+sgZP4hFmu5IDrnVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNkul2iSXsQ14qVswyuoPgh7WhQlrFK6KDpfr49NKoT7+ekP7VI1kiUzeVKw/h8o5
	 e124ct7G+hZnLujpWYfVlVuivbilZbqhHwqW9M1CxxCFQglSa4MSmyW41DDg2xh5be
	 BJ9RdcHt6Cx3Rkq0Sntjy0EJYIWb9j50EZ30Uz8KVHB4rN7XtcXaPeox7XYH06WWl0
	 YQ/porikMi9xZ29JGuupPckTOXxHaONboOpTuzcMVLMTCIr37ifXnpcxZc39K7I+Fi
	 dfb+hqPYhzn7NLhLr5NU6dS0k7hRCFxepp0vfR7fQaHALUnedGPYL8BZMOEy0EjnNa
	 wureveNDGsrVA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 23/37] mm/damon/sysfs: connect sample filters with core layer
Date: Sun,  7 Dec 2025 22:29:27 -0800
Message-ID: <20251208062943.68824-24-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only basic file operations are implemented for the DAMON sample filters
sysfs directory.  The user inputs are not really passed to the core
layer.  Make the connection.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index d6b0b6513fd1..3aac2aea6b0c 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1952,6 +1952,35 @@ static inline bool damon_sysfs_kdamond_running(
 		damon_is_running(kdamond->damon_ctx);
 }
 
+static int damon_sysfs_set_sample_filters(
+		struct damon_sample_control *control,
+		struct damon_sysfs_sample_filters *sysfs_filters)
+{
+	int i, err;
+
+	for (i = 0; i < sysfs_filters->nr; i++) {
+		struct damon_sysfs_sample_filter *sysfs_filter =
+			sysfs_filters->filters_arr[i];
+		struct damon_sample_filter *filter;
+
+		filter = damon_new_sample_filter(
+				sysfs_filter->type, sysfs_filter->matching,
+				sysfs_filter->allow);
+		if (!filter)
+			return -ENOMEM;
+		switch (filter->type) {
+		case DAMON_FILTER_TYPE_CPUMASK:
+			filter->cpumask = sysfs_filter->cpumask;
+			break;
+		default:
+			break;
+		}
+		damon_add_sample_filter(control, filter);
+	}
+	return 0;
+}
+
+
 static int damon_sysfs_set_sample_control(
 		struct damon_sample_control *control,
 		struct damon_sysfs_sample *sysfs_sample)
@@ -1960,7 +1989,9 @@ static int damon_sysfs_set_sample_control(
 		sysfs_sample->primitives->page_table;
 	control->primitives_enabled.page_fault =
 		sysfs_sample->primitives->page_fault;
-	return 0;
+
+	return damon_sysfs_set_sample_filters(control,
+			sysfs_sample->filters);
 }
 
 static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
-- 
2.47.3
