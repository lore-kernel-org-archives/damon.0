Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDA479E9
	for <damon@lists.linux.dev>; Thu, 24 Nov 2022 21:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0906C43145;
	Thu, 24 Nov 2022 21:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669324881;
	bh=grt8f69Dz6AwyetZSMeMbFhewde1iaVMzadAT1LoRZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Scsna3COmwE6eGQjmyTlyjMBdHtCfsQzO5q1w/q8qp13kHeVLM7pYbq/hp9VTIvZ8
	 oeAq5Z4EryN0E8hwqg7wWWL1yCKYXc6Sx7c5qQOgw8qPvFUd0fYn2CR/0gb0nqE996
	 uv6/Ohyk8hja+94/N/7kXEdJVPkHFh8L4SNkSOG3vMKzBz+hGjxp33tPXRzvIiS37R
	 hsAQFUCu1bE5lUpUt2KOZDM7wOX9x5xe5YvKgnVXWyiErEdkblKhL3siXJ1330TFuy
	 JFhOYoDstdrsx5xYZTQhVJcTuPUxrNfXrJ8qjRnXPyEaXem/Rt6kFQiL66Bp/7ybkJ
	 BJndOwSLhj+0g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH 03/11] mm/damon/reclaim: add a parameter called skip_anon for avoiding anonymous pages reclamation
Date: Thu, 24 Nov 2022 21:21:06 +0000
Message-Id: <20221124212114.136863-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124212114.136863-1-sj@kernel.org>
References: <20221124212114.136863-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases, for example if users have confidence at anonymous pages
management or the swap device is too slow, users would want to avoid
DAMON_RECLAIM swapping the anonymous pages out.  For such case, add yet
another DAMON_RECLAIM parameter, namely 'skip_anon'.  When it is set as
'Y', DAMON_RECLAIM will avoid reclaiming anonymous pages using a DAMOS
filter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index e82631f39481..648d2a85523a 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -98,6 +98,15 @@ module_param(monitor_region_start, ulong, 0600);
 static unsigned long monitor_region_end __read_mostly;
 module_param(monitor_region_end, ulong, 0600);
 
+/*
+ * Skip anonymous pages reclamation.
+ *
+ * If this parameter is set as ``Y``, DAMON_RECLAIM does not reclaim anonymous
+ * pages.  By default, ``N``.
+ */
+static bool skip_anon __read_mostly;
+module_param(skip_anon, bool, 0600);
+
 /*
  * PID of the DAMON thread
  *
@@ -142,6 +151,7 @@ static struct damos *damon_reclaim_new_scheme(void)
 static int damon_reclaim_apply_parameters(void)
 {
 	struct damos *scheme;
+	struct damos_filter *filter;
 	int err = 0;
 
 	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
@@ -152,6 +162,15 @@ static int damon_reclaim_apply_parameters(void)
 	scheme = damon_reclaim_new_scheme();
 	if (!scheme)
 		return -ENOMEM;
+	if (skip_anon) {
+		filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
+		if (!filter) {
+			/* Will be freed by next 'damon_set_schemes()' below */
+			damon_destroy_scheme(scheme);
+			return -ENOMEM;
+		}
+		damos_add_filter(scheme, filter);
+	}
 	damon_set_schemes(ctx, &scheme, 1);
 
 	return damon_set_region_biggest_system_ram_default(target,
-- 
2.25.1

