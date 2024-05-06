Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D3158845;
	Mon,  6 May 2024 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018565; cv=none; b=fKLX/ATH5C/Oy5MWIEPgkUhoWVl1zNnZVuT1Zmco7msotpW83lnPWiFWBK9OLvw2f0fCkmaQaKT1E4BuPuO0wO4t8peOEYzdEaS0GX3f7is/jDb9t+cUtRb5kqXmyAT4nx4R/t08KX20GtJ+0ho+oiQqBMVT9X6OBIu6rajTAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018565; c=relaxed/simple;
	bh=fqRLeDpMpLEhNJVbHZLCTU75BBCRbuwZMSWodHnJdO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pF81mP2+1f+JiDsj8mDCK0F9viXkqVKL+4WPN7cfw75zynXLEonWEK/Hdon+hDqiiV6UhbDvfvBjsV0eHyN8UvuTenLJn0soUcJ+tYlqgJFEpC4lAsXuuU1gNy/jyIfGcZOe4+FORXpJq4PUUuPrxhTzmpDsJ2VJ7h19LgSpFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhkBB7in; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhkBB7in"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D56C116B1;
	Mon,  6 May 2024 18:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715018564;
	bh=fqRLeDpMpLEhNJVbHZLCTU75BBCRbuwZMSWodHnJdO0=;
	h=From:To:Cc:Subject:Date:From;
	b=qhkBB7in8mS9W1tIqHCEPWz5aZqW5cfimQodAJooz4TEaNkJOLCX7+MGkuP34BBCq
	 v9aFDXNjhEBjTusv8n/LIGzL+Ar/JOJInwutge/ypD6XICQWSsgLOl3Z1Db9K4HdCV
	 Bkmij/ktc1VwJL6egTUmTNt3vH6nd5GfYKNvWj73mMnIN+dHgdwStaytOWY6HVsTGH
	 YD/cEcOhmatDTuifUAQZA2QD8IJ3JnIi/g5TbtR6hdEu7KBZ53rYmAytXyUaM1ZO3C
	 Jo4+gsoS3k/m9xpP3sgdJLX3cYV+TLKA13sx16j+/ww9WmF84zDPYhFRAkOMcqK5N6
	 ZDWNbgu58Nmsg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Rusuf <yorha.op@gmail.com>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] mm/damon/core: Fix return value from damos_wmark_metric_value
Date: Mon,  6 May 2024 11:02:38 -0700
Message-Id: <20240506180238.53842-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Rusuf <yorha.op@gmail.com>

damos_wmark_metric_value's return value is 'unsigned long', so
returning -EINVAL as 'unsigned long' may turn out to be
very different from the expected one (using 2's complement) and
treat as usual matric's value. So, fix that, checking if
returned value is not 0.

Fixes: ee801b7dd782 ("mm/damon/schemes: activate schemes based on a watermarks mechanism")
Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---

Changes from v3
(https://lore.kernel.org/20240428191439.194027-1-yorha.op@gmail.com)
- Add Reviewed-by: SeongJae Park <sj@kernel.org>
- Send to Andrew and linux-mm@ for being merged in mm tree

 mm/damon/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 939ecfcd4641..6392f1cc97a3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1481,12 +1481,14 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 	return true;
 }
 
-static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
+static int damos_get_wmark_metric_value(enum damos_wmark_metric metric,
+					unsigned long *metric_value)
 {
 	switch (metric) {
 	case DAMOS_WMARK_FREE_MEM_RATE:
-		return global_zone_page_state(NR_FREE_PAGES) * 1000 /
+		*metric_value = global_zone_page_state(NR_FREE_PAGES) * 1000 /
 		       totalram_pages();
+		return 0;
 	default:
 		break;
 	}
@@ -1501,10 +1503,9 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 {
 	unsigned long metric;
 
-	if (scheme->wmarks.metric == DAMOS_WMARK_NONE)
+	if (damos_get_wmark_metric_value(scheme->wmarks.metric, &metric))
 		return 0;
 
-	metric = damos_wmark_metric_value(scheme->wmarks.metric);
 	/* higher than high watermark or lower than low watermark */
 	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
 		if (scheme->wmarks.activated)
-- 
2.39.2

