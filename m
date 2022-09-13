Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7693F66E8
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 17:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E44C433D7;
	Tue, 13 Sep 2022 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663091106;
	bh=9TcztpKUfo8rJO30rUXY908EwJFNjnWv9MscjxP6KRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjrzuvWzKjr0o1tHWC3oa/x8CqWNP5PZKYZP/XDN92cM7jK70J4mKUV9vausd238e
	 riryqkMtUWxyD/gX5tYUkxQ3P/3zszg9T3RTTLtE0phE7ILox45K92oYXyhMSPTCOk
	 CUNOQPWXe34ewcWLx1MgGlrJyzyOtADspV8a+qY/3IG+E/X81uLk0fLip6jGYk58PE
	 FkgLBer7nq3bHOUfHrrTi3o8B4uGR+XFGVk2qGgBqPc6twV724Olv2YWOMdKH8HKky
	 vCgcKNxYMVV143k4OapjzmPrZd+gqTrVaC9FHYff8un/H22Cc6xjvgRvM0iApFhA0P
	 HixvJiwLik+1A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/22] mm/damon/modules-common: implement a damos quota params generator
Date: Tue, 13 Sep 2022 17:44:45 +0000
Message-Id: <20220913174449.50645-19-sj@kernel.org>
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

DAMON_RECLAIM and DAMON_LRU_SORT have module parameters for DAMOS quotas
that having same names.  This commit implements a macro for generating
such module parameters so that we can reuse later.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/modules-common.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index ed973e0770ae..3e99810b4689 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -17,6 +17,12 @@
 	module_param_named(max_nr_regions, attrs.max_nr_regions, ulong,	\
 			0600);
 
+#define DEFINE_DAMON_MODULES_DAMOS_QUOTAS(quota)			\
+	module_param_named(quota_ms, quota.ms, ulong, 0600);		\
+	module_param_named(quota_sz, quota.sz, ulong, 0600);		\
+	module_param_named(quota_reset_interval_ms,			\
+			quota.reset_interval, ulong, 0600);
+
 #define DEFINE_DAMON_MODULES_WMARKS_PARAMS(wmarks)			\
 	module_param_named(wmarks_interval, wmarks.interval, ulong,	\
 			0600);						\
@@ -33,5 +39,5 @@
 			0400);						\
 	module_param_named(bytes_##succ_name, stat.sz_applied, ulong,	\
 			0400);						\
-	module_param_named(qt_exceed_name, stat.qt_exceeds, ulong,	\
+	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
 			0400);
-- 
2.25.1

