Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6598E26B0A2;
	Thu,  6 Mar 2025 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283958; cv=none; b=r788AEXfCLuRIKxJWffFfZ7nMlfKjO0d1SpEmK35TayE1EethG310/aXo9wJqTOOqDsmA1G3dE3GVxRhqdNOHgr56ZQ48HOprvvt7jy49uyFmvv6l9x9whGH5R8En83HRC/OCeOnKlIrJBmlLBywvUlGSXIfCf0LldNnGj7v2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283958; c=relaxed/simple;
	bh=g+YGDmMK4WZf3RuQVlcd3/9Gf6V3dNg6yLBZ2nBENG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vj7tEO2x78n1KMGBj0LbOVq4seNvuxZhihwi3LV83yWLBSAOJD9YTlQqLKA+JYFvj93LZW+scyFbik+titAtP7N9zdzUsMUz7QX3F8MinUK30a8GKn9UDIuPQ22i6pAW1yuevdDe82xvl9jJSzY/oKRknM7mLF4oRbyIKSL3R74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U92VK0EN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U92VK0EN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B34BC4CEEA;
	Thu,  6 Mar 2025 17:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283958;
	bh=g+YGDmMK4WZf3RuQVlcd3/9Gf6V3dNg6yLBZ2nBENG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U92VK0ENbWqUUQoPbn23XTVjzA2f3hQRg686NR8ALpfRhCiiFF2CE4pPZe18I36rV
	 OKJL6pEqlDm81rvi2XhwTgYQjQS7uJFF5l/uXzrBV8deKBVUNjzmjXQ45h4O3zjSdR
	 laRIc/fAq3x3hZiv0f/V9hT3jSVbCQTYPeOnph9DnsuW1jiJI2K9cEasacTM2TQBd4
	 pem2cXI9CUhEp38yhj+98a4t25rQ1WqWEf8PMlbRozNhz8dCH35JqdUDkUWJszIq7A
	 FxucxW7LQ76j0isDQpQZ1BgxDxHAERvhBFUWsAxe4M02PEX4a3mkuGu+/jmfR7kPAX
	 kLrrLXQJlZkpA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/13] mm/damon/sysfs: remove damon_sysfs_cmd_request code from damon_sysfs_handle_cmd()
Date: Thu,  6 Mar 2025 09:59:00 -0800
Message-Id: <20250306175908.66300-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306175908.66300-1-sj@kernel.org>
References: <20250306175908.66300-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_handle_cmd() handles user requests that it can directly
handle on its own.  For requests that need to be handled from
damon_callback hooks, it uses DAMON sysfs interface's own synchronous
damon_callback hooks management mechanism, namely
damon_sysfs_cmd_request.  Now all user requests are handled without
damon_callback hooks, so damon_sysfs_cmd_request client code in
damon_sysfs_andle_cmd() does nothing in real.  Remove the unnecessary
code.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index c55a2cee4b74..166161f12c26 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1715,8 +1715,6 @@ static int damon_sysfs_update_schemes_tried_regions(
 static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 		struct damon_sysfs_kdamond *kdamond)
 {
-	bool need_wait = true;
-
 	switch (cmd) {
 	case DAMON_SYSFS_CMD_ON:
 		return damon_sysfs_turn_damon_on(kdamond);
@@ -1747,38 +1745,8 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 		return damon_sysfs_damon_call(
 				damon_sysfs_upd_tuned_intervals, kdamond);
 	default:
-		break;
-	}
-
-	/* Pass the command to DAMON callback for safe DAMON context access */
-	if (damon_sysfs_cmd_request.kdamond)
-		return -EBUSY;
-	if (!damon_sysfs_kdamond_running(kdamond))
 		return -EINVAL;
-	damon_sysfs_cmd_request.cmd = cmd;
-	damon_sysfs_cmd_request.kdamond = kdamond;
-
-	/*
-	 * wait until damon_sysfs_cmd_request_callback() handles the request
-	 * from kdamond context
-	 */
-	mutex_unlock(&damon_sysfs_lock);
-	while (need_wait) {
-		schedule_timeout_idle(msecs_to_jiffies(100));
-		if (!mutex_trylock(&damon_sysfs_lock))
-			continue;
-		if (!damon_sysfs_cmd_request.kdamond) {
-			/* damon_sysfs_cmd_request_callback() handled */
-			need_wait = false;
-		} else if (!damon_sysfs_kdamond_running(kdamond)) {
-			/* kdamond has already finished */
-			need_wait = false;
-			damon_sysfs_cmd_request.kdamond = NULL;
-		}
-		mutex_unlock(&damon_sysfs_lock);
 	}
-	mutex_lock(&damon_sysfs_lock);
-	return 0;
 }
 
 static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
-- 
2.39.5
