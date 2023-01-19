Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CF115B0
	for <damon@lists.linux.dev>; Thu, 19 Jan 2023 01:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FDAC433EF;
	Thu, 19 Jan 2023 01:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674092318;
	bh=fkjQwp0vLjtzRNvd4VhBq2nF7CfFg6frjzTnDoBz50k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CnXTVAitPDgUvsOiX6vW9aROGzCslmoqZfT8CZ2eLQCt4U75qjK1GOtsmFX5Hh1mL
	 GHkICAtA9fIez2uteqBjb+qkYlDqDgZoVFOyaA4k/GTtblnEyhvBhAtb4e4LVws6Qp
	 DA9xynr2yHeQuGfMie535L77J68Rf4loZ8vsr36yvq7yvQL4QJvvOEOs1qtxUHHtBx
	 eUoZBktQdw6BQ+9ajw8kIqoYs6Jgg2rVBMLS5qY0Iq/Jrrd97ra5R6/NBQbhXbH+Sh
	 OBWxwozsw+MPupdH+wpqF7B5X13pWPDxxv1U/jyd8aViHxPxoVK+3G1FYOFKLnTa3g
	 k+lZHNQuKqP+A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm/damon: update comments in damon.h for damon_attrs
Date: Thu, 19 Jan 2023 01:38:29 +0000
Message-Id: <20230119013831.1911-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119013831.1911-1-sj@kernel.org>
References: <20230119013831.1911-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cbeaa77b0449 ("mm/damon/core: use a dedicated struct for
monitoring attributes") moved monitoring intervals from damon_ctx to a
new struct, damon_attrs, but a comment in the header file has not
updated for the change.  Update it.

Fixes: cbeaa77b0449 ("mm/damon/core: use a dedicated struct for monitoring attributes")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index dfb245bb3053..d5d4d19928e0 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -354,10 +354,10 @@ struct damon_ctx;
  * users should register the low level operations for their target address
  * space and usecase via the &damon_ctx.ops.  Then, the monitoring thread
  * (&damon_ctx.kdamond) calls @init and @prepare_access_checks before starting
- * the monitoring, @update after each &damon_ctx.ops_update_interval, and
+ * the monitoring, @update after each &damon_attrs.ops_update_interval, and
  * @check_accesses, @target_valid and @prepare_access_checks after each
- * &damon_ctx.sample_interval.  Finally, @reset_aggregated is called after each
- * &damon_ctx.aggr_interval.
+ * &damon_attrs.sample_interval.  Finally, @reset_aggregated is called after
+ * each &damon_attrs.aggr_interval.
  *
  * Each &struct damon_operations instance having valid @id can be registered
  * via damon_register_ops() and selected by damon_select_ops() later.
-- 
2.25.1

