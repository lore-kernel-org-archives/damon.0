Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF7E314A83;
	Sat, 21 Feb 2026 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771702595; cv=none; b=jMpNntIrQIB+uh/UB1AAT/hyVkcjRzSFJTF1lrnLDAJppFSkZDXYFGk+JyiWeC835lRMxcraeY/nYWEOrhY56EXPLyzRYUUHzm88EqL4Wzt+SqOpdW9WHEXx/i59X0onNmH9OsTm6vacw0ZGgTptRr3r1kHMkBMrT/GhG3ptFuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771702595; c=relaxed/simple;
	bh=I8vgGzFmn9eOAxp25MVWasYsGVVIm8Br+R7YY0e17Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfTJak7NRV7VxzInpwOXuSTqq753ysWt0fL8rB7BXKNqespLT9B9KtnRAJ3M5jkhCBUwn08FCb1TX65Avh/Vbi6XlmcGVVIuyZ/hpuhq2egrlyoATfH1fhnyqWO9DM3ZjfbMu5uGFiHyn7KAEexhvNLBN/DSxR139LK7REDu+Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+72ZuX/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+72ZuX/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AF2C2BC9E;
	Sat, 21 Feb 2026 19:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771702595;
	bh=I8vgGzFmn9eOAxp25MVWasYsGVVIm8Br+R7YY0e17Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k+72ZuX/URzHsMuAN+fknl+2ID4qfoFDQn3AZe8rUqgJu5ygA/+FDLFEpgXnoBds+
	 J2Uf9ypx2huS+b6oURZLEquamH70DT70inxL8Wszswem0BkIrwPjbwVXhFnnP8h2NJ
	 uqTI/kCmCFOd0xwr5CF4JbHUUCJX1z5YI9cSAE39G9RgDnPWhbBqQRTE60DrGcyC6j
	 bIdQxBe+P09rlDSLGaprGs6UmENL/MhYNxVsl2+VG0StOzDK0nZO9CHruaz/Ybi09b
	 EOLzZignmqx3ExNAaewSGm/3kx4guwjE/qZBdFU6Qvws+hwOcbrQ2D+rII4qq8Y1E2
	 eDtlfGIfpHYkg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 03/10] mm/damon/core: add damon_del_region() debug_sanity check
Date: Sat, 21 Feb 2026 11:36:20 -0800
Message-ID: <20260221193629.19332-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221193629.19332-1-sj@kernel.org>
References: <20260221193629.19332-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_del_region() should be called for targets that have one or more
regions.  Add a sanity check for that under CONFIG_DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index a7f5748c1fe17..7e03c3af03694 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -158,8 +158,25 @@ void damon_add_region(struct damon_region *r, struct damon_target *t)
 	t->nr_regions++;
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_del_region(struct damon_target *t)
+{
+	if (t->nr_regions > 0)
+		return;
+	pr_err("damon_del_region() called while t->nr_regions <= 0 (%u)\n",
+			t->nr_regions);
+	WARN_ONCE();
+}
+#else
+static void damon_verify_del_region(struct damon_target *t)
+{
+}
+#endif
+
 static void damon_del_region(struct damon_region *r, struct damon_target *t)
 {
+	damon_verify_del_region(t);
+
 	list_del(&r->list);
 	t->nr_regions--;
 }
-- 
2.47.3
