Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719543D34B9;
	Fri,  6 Mar 2026 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810963; cv=none; b=dV6XzVco90hxR+NSHJCI7aag/Rz9ynzjuSI/lxsV2oBZu/kH0DpL5ExNTUkn2GY3UElQKyvghfNl34j3hLYXoqRNha76fspSAr9qGOaL/XhvCVv9+82WUmM7mvPRaVcsyV5P1A0rNYWaUPQnVm1zatoK3QaEPIGY1GUNvTBbh3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810963; c=relaxed/simple;
	bh=zFDrPDtcwfulSyFJOaJh2lietZw1gfebL6litU0OglA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9cMaznrkk1yoVpGfYn9FRfuHYhnlEk+ZYPEnzkh+ICxqw8Df25k0wpvJn9bPgGAakpS2BChAqHJ1aCmqeE5gZt7F1Ond4ci1D/3dBjOOUatHGsib3armMsaxK91YtD/wHWCAlB9DaeTOApw+9QABUm9op6uqV11qGbi8qRgjks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeVHgsPR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeVHgsPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B7BC2BCB8;
	Fri,  6 Mar 2026 15:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772810962;
	bh=zFDrPDtcwfulSyFJOaJh2lietZw1gfebL6litU0OglA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZeVHgsPRrSNZYiyck/thY8pd39Z2lv1DqP49urnH198fOG/D+Xwtzp0LgzidbnQFF
	 +duTf5sg/49BkaZw9XXTxLBdkbqs56OBwRUohllckGSdBmMsFmjovUjmplvA7zzuS+
	 Q6QBvdOgPyNl6a+bjkghYiN5Mf1xTjGJq6hv7m8e4K3+AKZ5w9DwufSyO+MESEkHGR
	 yXDDjXuhCETJnCakfcEUIGdZqfHhogaAhSpKeDfRCWWRa+VJNkEgFDvTYK9hAJ5S0G
	 nxxCzoy++/eO6+Vz+iU7r/jnCeChX4s7vpQNbHReZvYE82d34Nokkknce6zA3IBXEV
	 MG3YT5q/So35g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/10] mm/damon/core: add damon_nr_regions() debug_sanity check
Date: Fri,  6 Mar 2026 07:29:07 -0800
Message-ID: <20260306152914.86303-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306152914.86303-1-sj@kernel.org>
References: <20260306152914.86303-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_target->nr_regions is introduced to get the number quickly without
having to iterate regions always.  Add a sanity check for that under
CONFIG_DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 92eac5eb96026..2b5aed89d449d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -545,8 +545,27 @@ void damon_destroy_target(struct damon_target *t, struct damon_ctx *ctx)
 	damon_free_target(t);
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_nr_regions(struct damon_target *t)
+{
+	struct damon_region *r;
+	unsigned int count = 0;
+
+	damon_for_each_region(r, t)
+		count++;
+	WARN_ONCE(count != t->nr_regions, "t->nr_regions (%u) != count (%u)\n",
+			t->nr_regions, count);
+}
+#else
+static void damon_verify_nr_regions(struct damon_target *t)
+{
+}
+#endif
+
 unsigned int damon_nr_regions(struct damon_target *t)
 {
+	damon_verify_nr_regions(t);
+
 	return t->nr_regions;
 }
 
-- 
2.47.3
