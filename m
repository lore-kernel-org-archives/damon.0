Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E24F2BE7CD;
	Sat, 17 Jan 2026 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768672386; cv=none; b=IYV2+x5OeQVsEO6WpNPoqRPRJOaW2AZeKfAF49BzEGQ1DgsgcVap3nymzsQptqoY04zj2+gR4HrIUDLE50+yxJi92oz/eA8V/RHQkSYx7Z7quDDEtSVN1WEw4tD3YEKPv4T592N9siBFeVsL2aVTPnBL67xG10NKNh18mtcXxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768672386; c=relaxed/simple;
	bh=OpNBmjSVIXZeLwKSC0iBB/4oylJS3GFwqsmSW7MYMwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/0d89h3TAsX1fS/aSdhsgUzaGKp8CWu3JB9xwf/vXvyEOwGFXs0dbUjb46EwAbqgS7UKBbRPYblO0wTzU8Z5WbMNKkX4zC5vUVqpN6oX8mY+xkj2W0boxQyEevneSGVC87ZFPJhQLpCwCHShn0zTbVJMc+RK6lDHG8uaRbJ2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD+CWFO2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD+CWFO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CA0C19423;
	Sat, 17 Jan 2026 17:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768672386;
	bh=OpNBmjSVIXZeLwKSC0iBB/4oylJS3GFwqsmSW7MYMwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZD+CWFO2bByzHP1/Ma1LCn2h64LHsI2D7NRiTxOT21csK0eerKc4/8LCnGXSMglka
	 rjIN1W5CEsFQr1PmX7TzAa8uHeMsXK/2T6FnIZQ58Vc2wqOkK7K7C4RoK7iC1oVRX2
	 skBjw6qjxQjlMTloFm4wiomgLW225lxj0gDjqudo+RhQjxQLirUaT1zhiA+4zX/3lp
	 iiR1FO9o2EkHskCXr/cCc2v4LxzxqJeJAlIdLN4yOO9otcGAOn6VVtkjMX5e/vSLE3
	 3OvgWAlo5ucZ+lPqpLGMdJGu+QEcw7w0cqhdQ++w3wYsIddpZ5u62oyQSK3N/T7A90
	 n9hJM8a3GkHcA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/8] mm/damon/core: process damon_call_control requests on a local list
Date: Sat, 17 Jan 2026 09:52:51 -0800
Message-ID: <20260117175256.82826-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260117175256.82826-1-sj@kernel.org>
References: <20260117175256.82826-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kdamond_call() handles damon_call() requests on the ->call_controls list
of damon_ctx, which is shared with damon_call() callers.  To protect the
list from concurrent accesses while letting the callback function
independent of the call_controls_lock, the function does complicated
locking operations.  For each damon_call_control object on the list, the
function removes the control object from the list under locking, invoke
the callback of the control object without locking, and then puts the
control object back to the list if needed, under locking.  It is
complicated, and can contend the locks more frequently with other DAMON
API caller threads as the number of concurrent callback requests
increases.  Contention overhead is not a big deal, but the increased
race opportunity can make headaches.

Simplify the locking sequence by moving all damon_call_control objects
from the shared list to a local list at once under the single lock
protection, processing the callback requests without locking, and adding
back repeat mode controls to the shared list again at once again, again
under the single lock protection.  This change makes the number of
locking in kdamond_call() be always two, regardless of the number of the
queued requests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 59 ++++++++++++++++++-------------------------------
 1 file changed, 21 insertions(+), 38 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0bed937b1dce..54a7ea98340a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2649,48 +2649,31 @@ static void kdamond_usleep(unsigned long usecs)
  */
 static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 {
-	struct damon_call_control *control;
-	LIST_HEAD(repeat_controls);
-	int ret = 0;
-
-	while (true) {
-		mutex_lock(&ctx->call_controls_lock);
-		control = list_first_entry_or_null(&ctx->call_controls,
-				struct damon_call_control, list);
-		mutex_unlock(&ctx->call_controls_lock);
-		if (!control)
-			break;
-		if (cancel) {
+	struct damon_call_control *control, *next;
+	LIST_HEAD(controls);
+
+	mutex_lock(&ctx->call_controls_lock);
+	list_splice_tail_init(&ctx->call_controls, &controls);
+	mutex_unlock(&ctx->call_controls_lock);
+
+	list_for_each_entry_safe(control, next, &controls, list) {
+		if (!control->repeat || cancel)
+			list_del(&control->list);
+
+		if (cancel)
 			control->canceled = true;
-		} else {
-			ret = control->fn(control->data);
-			control->return_code = ret;
-		}
-		mutex_lock(&ctx->call_controls_lock);
-		list_del(&control->list);
-		mutex_unlock(&ctx->call_controls_lock);
-		if (!control->repeat) {
+		else
+			control->return_code = control->fn(control->data);
+
+		if (!control->repeat)
 			complete(&control->completion);
-		} else if (control->canceled && control->dealloc_on_cancel) {
+		else if (control->canceled && control->dealloc_on_cancel)
 			kfree(control);
-			continue;
-		} else {
-			list_add(&control->list, &repeat_controls);
-		}
-	}
-	while (true) {
-		control = list_first_entry_or_null(&repeat_controls,
-				struct damon_call_control, list);
-		if (!control)
-			break;
-		/* Unlink from the repeate_controls list. */
-		list_del(&control->list);
-		if (cancel)
-			continue;
-		mutex_lock(&ctx->call_controls_lock);
-		list_add(&control->list, &ctx->call_controls);
-		mutex_unlock(&ctx->call_controls_lock);
 	}
+
+	mutex_lock(&ctx->call_controls_lock);
+	list_splice_tail(&controls, &ctx->call_controls);
+	mutex_unlock(&ctx->call_controls_lock);
 }
 
 /* Returns negative error code if it's not activated but should return */
-- 
2.47.3
