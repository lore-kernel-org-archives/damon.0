Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29BD145A05;
	Tue, 24 Feb 2026 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771895465; cv=none; b=Sh/COD2N0KtN8NSoGTJ1G0WY7oOr+CNLagh976tKSXinQyjPjKrVV3VjcozzOHhrpcdM2Nson6RJX2NRoF9x5SXbquxuK/JiwmWy0DsZ3AX0CWihi4w+r66mfULahqeJNyOnSBVPYK96y0PuTsoR+iZifNURAbE56FeW2fWJBRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771895465; c=relaxed/simple;
	bh=pGqupyrZkQnB2v5wYbkX7u71u2AJYUynj+S6P+vLWew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lKJ8/prLaQGCgVqjcFkeJvL0r7+FE0fP/Is7XcL+KVEEeJhI8BiwF687MOu8cw6AuhXNC/k6fR4C1yDyqwKVmwq4CROGNOXUE1tM3meUcNAdNPSdopmyKFAi5stCTZxEq1FV3N4NetEyFgu8T0kfloqZmh3idAUTjMwG1oa7jag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBFe1Nbk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBFe1Nbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B221C116C6;
	Tue, 24 Feb 2026 01:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771895464;
	bh=pGqupyrZkQnB2v5wYbkX7u71u2AJYUynj+S6P+vLWew=;
	h=From:To:Cc:Subject:Date:From;
	b=CBFe1Nbk9AM8YhBVdghjlxim5aur6yj0JF82zynSCGe2OEvY1/yYz3R8XejaDKB9Y
	 S8ugX+IHHyXJKcBNNPkt15M3PWSh67XxOrVXHZO9Ycu1tryAdsPaS80+tAEEL0KXdV
	 Yjie6LVSQcY8us6CbdxUHp442OU4gl7jVTcev7gwykoqRzjDljLELDJhbJg7pPnDNR
	 QGxgPO4wW1zsYTGca1Yn5pM3xCX1Rm1zSYkFrKEQK7HHq3LJpL7tMJtZKr5L3NQUYR
	 knUjeHOstMbS7HtfEHNthIL/fcyw5CgdiOVyHwMNwb88I48KMlAIdnCQoeMJbfelUV
	 2+srb6kvI553g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Raul Pazemecxas De Andrade <raul_pazemecxas@hotmail.com>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/core: clear walk_control on inactive context in damos_walk()
Date: Mon, 23 Feb 2026 17:10:59 -0800
Message-ID: <20260224011102.56033-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Raul Pazemecxas De Andrade <raul_pazemecxas@hotmail.com>

damos_walk() sets ctx->walk_control to the caller-provided control
structure before checking whether the context is running. If the context
is inactive (damon_is_running() returns false), the function returns
-EINVAL without clearing ctx->walk_control. This leaves a dangling
pointer to a stack-allocated structure that will be freed when the
caller returns.

This is structurally identical to the bug fixed in commit f9132fbc2e83
("mm/damon/core: remove call_control in inactive contexts") for
damon_call(), which had the same pattern of linking a control object
and returning an error without unlinking it.

The dangling walk_control pointer can cause:
1. Use-after-free if the context is later started and kdamond
   dereferences ctx->walk_control (e.g., in damos_walk_cancel()
   which writes to control->canceled and calls complete())
2. Permanent -EBUSY from subsequent damos_walk() calls, since the
   stale pointer is non-NULL

Nonetheless, the real user impact is quite restrictive.  The
use-after-free is impossible because there is no damos_walk() callers
who starts the context later.  The permanent -EBUSY can actually confuse
users, as DAMON is not running.  But the symptom is kept only while the
context is turned off.  Turning it on again will make DAMON internally
uses a newly generated damon_ctx object that doesn't have the invalid
damos_walk_control pointer, so everything will work fine again.

Fix this by clearing ctx->walk_control under walk_control_lock before
returning -EINVAL, mirroring the fix pattern from f9132fbc2e83.

Reported-by: Raul Pazemecxas De Andrade <raul_pazemecxas@hotmail.com>
Closes: https://lore.kernel.org/CPUPR80MB8171025468965E583EF2490F956CA@CPUPR80MB8171.lamprd80.prod.outlook.com
Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
Cc: stable@vger.kernel.org # 6.14.x
Signed-off-by: Raul Pazemecxas De Andrade <raul_pazemecxas@hotmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v1
(https://lore.kernel.org/all/CPUPR80MB81718B12798BCF9959535B05956CA@CPUPR80MB8171.lamprd80.prod.outlook.com/)
- Rebase to latest mm-new
- Add notes about real user impacts

 mm/damon/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6be8c4cc14162..eae387d4e0786 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1562,8 +1562,13 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
 	}
 	ctx->walk_control = control;
 	mutex_unlock(&ctx->walk_control_lock);
-	if (!damon_is_running(ctx))
+	if (!damon_is_running(ctx)) {
+		mutex_lock(&ctx->walk_control_lock);
+		if (ctx->walk_control == control)
+			ctx->walk_control = NULL;
+		mutex_unlock(&ctx->walk_control_lock);
 		return -EINVAL;
+	}
 	wait_for_completion(&control->completion);
 	if (control->canceled)
 		return -ECANCELED;

base-commit: 252ff65aa9536c88ef66dedfbdafe63a479a4b3d
-- 
2.47.3
