Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DFBA4D
	for <damon@lists.linux.dev>; Thu,  7 Sep 2023 02:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90E7C433D9;
	Thu,  7 Sep 2023 02:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694053783;
	bh=ey6ldgAd6VTxnRDoPtCtQlr0A3IAnRC6k78ku2lztFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o5w62vS3iAkNVuzYgY9bfNL4wHOb5z8v2SB71t6EVqtoa8SA11fQws6liGofafFMo
	 p8YQONgSgi2PrcMcx4kRPKTnnkIXVq+T1F6uLipVw79Q83LbAwU6y0a0xAjmmGBI3a
	 Qy/07A+eOLSlFgEP0sKXQqwPmigbHXrm0JGjzBbAuJbX2SriKrQ8PW+HGJDuIDIalY
	 G+kkyD7yTeSglfm6B5Wt3S064RhYrOztpWqbp1us/4OowA0TWkqW/8E63Ooa6Hxefr
	 66k8OkJbNqIzn+YiAzcNVQcfgU1rLO034hJIKGrtYOYB0QvlE4wLe6a4gGRCytSnCj
	 Mhm23vrRe1GgQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] mm/damon/core: fix a comment about damon_set_attrs() call timings
Date: Thu,  7 Sep 2023 02:29:26 +0000
Message-Id: <20230907022929.91361-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907022929.91361-1-sj@kernel.org>
References: <20230907022929.91361-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment on damon_set_attrs() says it should not be called while the
kdamond is running, but now some DAMON modules like sysfs interface and
DAMON_RECLAIM call it from after_aggregation() and/or
after_wmarks_check() callbacks for online tuning.  Update the comment.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 28c7c49882d3..1ce483a3c2b5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -570,7 +570,11 @@ static void damon_update_monitoring_results(struct damon_ctx *ctx,
  * @ctx:		monitoring context
  * @attrs:		monitoring attributes
  *
- * This function should not be called while the kdamond is running.
+ * This function should be called while the kdamond is not running, or an
+ * access check results aggregation is not ongoing (e.g., from
+ * &struct damon_callback->after_aggregation or
+ * &struct damon_callback->after_wmarks_check callbacks).
+ *
  * Every time interval is in micro-seconds.
  *
  * Return: 0 on success, negative error code otherwise.
-- 
2.25.1

