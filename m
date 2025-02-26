Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D8A26BDA4;
	Wed, 26 Feb 2025 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551821; cv=none; b=qpy1f/hLWx4xqmIAJppOXJzH6PvsbnILYClz9N55TI9MOZcOR8Vn9iw3Xktz5q6HImkj/LDoPEXsOrCoZrCzSxHNxOlSBBkM7OJauYrROgm0RgStn+1b4wP2vbvpmj7v7nhGn1RYcDFk9fkpfT2k7XM8A2DVRx/qBS4t6MbDm7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551821; c=relaxed/simple;
	bh=ZDADvW0oQPUgZeNcgv9P9GJF3heQ3/Xecw6OVh3xMI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jzGb/9rDRTiMrNrHsc/myC0KlW6bUxHfUogj+vQvNY+GdpaWnwyNW18F2QI4n74Orw0Kh0WXobXJrNx887ZPlvXxYcD+5QqO96I4Ie/YvtiJoQL9VFazLi97V8eIjp6Y9XNAJ/hA0LL85f25xQSdyygDQBYjsk+ska+wS6csuIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+NvSuYV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+NvSuYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AE7C4CEE9;
	Wed, 26 Feb 2025 06:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740551820;
	bh=ZDADvW0oQPUgZeNcgv9P9GJF3heQ3/Xecw6OVh3xMI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+NvSuYVCbP0zamxR9Q/T6/f9oqao4fhYmC9FmNd8WnmGQmavl/+yCP8sFp2JJ0x0
	 wsdh8ZTOVYIAhsfdq8IUCe8m4JKlWrpDNkAawiTNWgTv/DeA3X9QD6QzsQAbZXxNVe
	 VlutXHzq9Cai0AjDj1uiQI0L+7cCB+wBaQLFWxoFlfGHWJlS1nneI197sqWE/pFpUa
	 1tM/iMs5d5Dc1ose5/SFQDJGVVoyMralJztkIL26RLL48jyNrfZbew7bCdkgHBaqrl
	 OagseUL313dWU+fHsgFcJ5Lztx1xk34sj/HVXOfwOWcZcbUGzvAv+qz+3NB+F5wnmV
	 i827EwrB5itOA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/13] mm/damon/sysfs: remove damon_sysfs_cmd_request code from damon_sysfs_handle_cmd()
Date: Tue, 25 Feb 2025 22:36:43 -0800
Message-Id: <20250226063651.513178-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226063651.513178-1-sj@kernel.org>
References: <20250226063651.513178-1-sj@kernel.org>
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
damon_callback hooks, so damon_sysfs_cmd_request use code in
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
