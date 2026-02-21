Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2033191BD;
	Sat, 21 Feb 2026 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771702596; cv=none; b=LT7+flGH1ZL7k4MInND79QATrz/8FZHJPDhur7v6KuK5phFEd7O+o+36OCpXgzhmN7M7hOZQIMD2bg/6Tdzik354C3dOKpH4xCNq7cs6IujL3O9QIFeIN27xJXPjASvaUq4nuxknfgbEYHhLc3NSo6oc2I0mQaNUMatVf4DZm3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771702596; c=relaxed/simple;
	bh=RXFcEvIn0MWpVnnu1oJ3V6Kn3He/nSAmwf55lWBXXZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuGisXzq4Iija4hLBsz4FktleoSBBEG7l5Y6IKf7kPN/QV9j70/ajzdVrj7VlO89cDm6nBQva+AJg9kOT1H0TAbm22H6Moue4Z/28EHlrYpXHBVZRAWELBkdoK0djD9oIQJ9lUAmxc84MzOPOSJXwzY92mycLY/F1tp8kdPUPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLgrWyhw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLgrWyhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E11EC19424;
	Sat, 21 Feb 2026 19:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771702596;
	bh=RXFcEvIn0MWpVnnu1oJ3V6Kn3He/nSAmwf55lWBXXZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZLgrWyhwax0cT7nz0xs/EG9v4tu/MXv7OA36zpiRe2CNexw3DJQnjeNnnVtyo4Vxm
	 4Rkn7BFF5uU6H1th8z0cFPpFFImYeswzF2ASAGdvmkiJEG7rbMYYdogAiu1IWefaXX
	 UvHXjfodd4SRfEWISn9njL7ykKKALl86yVFpDR/kXFZj+ylG7hSQLAo2NVyrxJ7Ib2
	 sxPu0GkvnKLwbdzMY01yG6zEnhaMBa2HOWq4L75Nrj7kLEfZ/UuLxbnCaPIykfSiCo
	 L2i0Q7TedqgX98EGs6WaO1aGc+xO1zGtnUkM3ovSuNg7OG7SzZmoHpjuARgz95HecE
	 89GY/aErOPc/g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/10] mm/damon/core: add damon_merge_two_regions() debug_sanity check
Date: Sat, 21 Feb 2026 11:36:22 -0800
Message-ID: <20260221193629.19332-6-sj@kernel.org>
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

A data corruption could cause damon_merge_two_regions() creating zero
length DAMON regions.  Add a sanity check for that under
CONFIG_DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ede76e0789be3..291a847a8c9bb 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2507,6 +2507,25 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	mutex_unlock(&c->walk_control_lock);
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_merge_two_regions(
+		struct damon_region *l, struct damon_region *r)
+{
+	if (l->ar.start < l->ar.end)
+		return;
+
+	pr_err("damn_merge_two_regions() created incorrect left region\n");
+	pr_err("l: %lu-%lu, r: %lu-%lu\n",
+			l->ar.start, l->ar.end, r->ar.start, r->ar.end);
+	WARN_ONCE();
+}
+#else
+static void damon_verify_merge_two_regions(
+		struct damon_region *l, struct damon_region *r)
+{
+}
+#endif
+
 /*
  * Merge two adjacent regions into one region
  */
@@ -2520,6 +2539,9 @@ static void damon_merge_two_regions(struct damon_target *t,
 	l->nr_accesses_bp = l->nr_accesses * 10000;
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
+
+	damon_verify_merge_two_regions(l, r);
+
 	damon_destroy_region(r, t);
 }
 
-- 
2.47.3
