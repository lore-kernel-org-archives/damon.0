Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A8266E7
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 17:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BE6C433D6;
	Tue, 13 Sep 2022 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663091106;
	bh=TpMHecuKvtdBhnIMulCBOg8dzHSBCxkP4seXXVnf3o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jdCE6iWv9HhVPN7MDQ52uUfmE9OXzgOLz0P+fJP2LIXptahcOXvoBkHEsLBhTSNwj
	 xrLhrofoeYdhxmr0yF7a9NMGGDXsSOljaMebIelpbFB5SJEFGCEXreNc8EtkI7kSdn
	 r33Ic3xkizh+xPUXJkZ/yCPD+mWOBL4ziEy43+5GPf9xdeZC+m7ehB8eMXmCyQdqPl
	 AWMHQKAJUvl3RTuI9Qf8lDnEWxDh20IBq6s3CQddOaQefJP/7BVsq3f5l0pR4NKxK8
	 bqS/45DdTR5fiyGxW4N3AFYecqAu2+uW3DvrNqhWmbaZOUBIpyE940+uN56FuVnODK
	 ezKyQ6CsrnXmA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/22] mm/damon/modules-common: implement damos time quota params generator
Date: Tue, 13 Sep 2022 17:44:46 +0000
Message-Id: <20220913174449.50645-20-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913174449.50645-1-sj@kernel.org>
References: <20220913174449.50645-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_LRU_SORT have module parameters for DAMOS time quota only but size
quota.  This commit implements a macro for generating the module
parameters so that we can reuse later.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/modules-common.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index 3e99810b4689..5a4921851d32 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -17,12 +17,15 @@
 	module_param_named(max_nr_regions, attrs.max_nr_regions, ulong,	\
 			0600);
 
-#define DEFINE_DAMON_MODULES_DAMOS_QUOTAS(quota)			\
+#define DEFINE_DAMON_MODULES_DAMOS_TIME_QUOTA(quota)			\
 	module_param_named(quota_ms, quota.ms, ulong, 0600);		\
-	module_param_named(quota_sz, quota.sz, ulong, 0600);		\
 	module_param_named(quota_reset_interval_ms,			\
 			quota.reset_interval, ulong, 0600);
 
+#define DEFINE_DAMON_MODULES_DAMOS_QUOTAS(quota)			\
+	DEFINE_DAMON_MODULES_DAMOS_TIME_QUOTA(quota)			\
+	module_param_named(quota_sz, quota.sz, ulong, 0600);
+
 #define DEFINE_DAMON_MODULES_WMARKS_PARAMS(wmarks)			\
 	module_param_named(wmarks_interval, wmarks.interval, ulong,	\
 			0600);						\
-- 
2.25.1

