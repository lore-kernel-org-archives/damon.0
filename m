Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0713C15CB1
	for <damon@lists.linux.dev>; Mon,  5 Dec 2022 23:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9C9C43146;
	Mon,  5 Dec 2022 23:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670281717;
	bh=grt8f69Dz6AwyetZSMeMbFhewde1iaVMzadAT1LoRZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gkd9ZtOBsrsbXnQFw9/sbyQbOH93AK/MO5lZXVdWN9g0ZWQ8gEIX08NSzEl2o7mnd
	 lEZcmZgk03/Bb1cA8Se81GMDzpz1rpO4pSs3dXeVGR3586qFm0ua28x7yTZUsiP1Jw
	 XohFGfEmlDPWRNb7mRez4As0YcnWL2GTA6oEzH0/r13j4H0S6fl286ORTXbb9xxln0
	 BylJ/JsgTIFq56cYSPF0JSx3FT2kNU+ZCefodS0dcW3vGVzIo0UWtL/hj1a6NmFXhH
	 jxei4CFDcvbTrIf+gco38m0sYnHgXATXdCmuX5WZyuV+UuBXuFRzw1X90uFhiu8G6H
	 jlVIbQEwM991A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 03/11] mm/damon/reclaim: add a parameter called skip_anon for avoiding anonymous pages reclamation
Date: Mon,  5 Dec 2022 23:08:22 +0000
Message-Id: <20221205230830.144349-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205230830.144349-1-sj@kernel.org>
References: <20221205230830.144349-1-sj@kernel.org>
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

