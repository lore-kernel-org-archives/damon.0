Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65361108
	for <damon@lists.linux.dev>; Mon, 16 Jan 2023 06:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673850237; x=1705386237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a+MM6LFSFN6O0Ul1MbCfo6cLTpT945+XnwjwGbaR2AM=;
  b=CdNswiX6B38JeV2ub5DOgNYiQxy6QDON2M76o7mmWLFts8ZplKzk2xMx
   XwMSDSoMJimpFsxi8FmnDTlQH6m9LP+30iAXyWkXP+h/9BDKbSgp8mfWh
   DyJR71dBPScS0kTZA2gbXXECYqkwvbIFKaGjIyuzVjR2VKFyYNur7FWP5
   KuA00clJHX7szWPGex6GnNi7oAPBYW/KzDom1q+JuKhLsCpXHDZ2EbfpG
   Z3OQHKZyA9Ij472nhMCgkMlpiMG/FsGQvvg3/SbnmFE9pG0kAMNSy6Yp/
   gRenF80V5RcZd2ofdonKwyL+FoFf5zrRRvUimRYhC8jdhmYM2/xr8/CXg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="326454288"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="326454288"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 22:23:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="658916451"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="658916451"
Received: from dev01.bj.intel.com ([10.238.158.76])
  by orsmga002.jf.intel.com with ESMTP; 15 Jan 2023 22:23:55 -0800
From: Huaisheng Ye <huaisheng.ye@intel.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huaisheng Ye <huaisheng.ye@intel.com>
Subject: [PATCH] mm/damon/core: skip apply schemes if empty
Date: Mon, 16 Jan 2023 14:23:47 +0800
Message-Id: <20230116062347.1148553-1-huaisheng.ye@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes there is no scheme in damon's context, for example
just use damo record to monitor workload's data access pattern.

If current damon context doesn't have any scheme in the list,
kdamond has no need to iterate over list of all targets and regions
but do nothing.

So, skip apply schemes when ctx->schemes is empty.

Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>
---
 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ceec75b88ef9..f338691e4591 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1230,7 +1230,8 @@ static int kdamond_fn(void *data)
 			if (ctx->callback.after_aggregation &&
 					ctx->callback.after_aggregation(ctx))
 				break;
-			kdamond_apply_schemes(ctx);
+			if (!list_empty(&ctx->schemes))
+				kdamond_apply_schemes(ctx);
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
 			if (ctx->ops.reset_aggregated)
-- 
2.31.1

