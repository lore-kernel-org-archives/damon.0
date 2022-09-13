Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F6666E9
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 17:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7202BC43150;
	Tue, 13 Sep 2022 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663091102;
	bh=w3PmzI3eXAtMjTvuW+AZdIXWuI7edjAfsNckFtn3Io4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+gTc8Q3zvNURan9GfDYXpMFt0z7EM7ZU4Rk7rB6CF4TVUZ9u0lOC9R/mnSsqr1rU
	 R09efwl3daVaFAsKHd+OnmT6ETvV0PMjyb4ottR6blkea3JwhH7siUgh+ef1mPMkU4
	 EKaFrbCBRaCJZXOHM29xOnmuI+YeeF34swnPisfOy1yL6mT6wVb1wKUEh4oXq34IwI
	 eLdb6WfOc5+5tc+sbCgWEYV4dgsETv9WG00qb3xBPewMoB8T/VL0hZF3QnKA2oMvFA
	 6vRLl+ewWOzfgDKb1A4WAfcd+sFizn3ILxbC4f+DqYoawhNS02fcOoxPe0EIvzMD4/
	 jGRysRwAE1RFg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/22] mm/damon/modules-common: implement a watermarks module parameters generator macro
Date: Tue, 13 Sep 2022 17:44:39 +0000
Message-Id: <20220913174449.50645-13-sj@kernel.org>
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

DAMON_RECLAIM and DAMON_LRU_SORT have module parameters for watermarks
that having same names.  This commit implements a macro for generating
such module parameters so that we can reuse later.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/modules-common.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index 0abd0636bc64..1370590a37d1 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -16,3 +16,10 @@
 			0600);						\
 	module_param_named(max_nr_regions, attrs.max_nr_regions, ulong,	\
 			0600);
+
+#define DEFINE_DAMON_MODULES_WMARKS_PARAMS(wmarks)			\
+	module_param_named(wmarks_interval, wmarks->interval, ulong,	\
+			0600);						\
+	module_param_named(wmarks_high, wmarks.high, ulong, 0600);	\
+	module_param_named(wmarks_mid, wmarks.mid, ulong, 0600);	\
+	module_param_named(wmarks_low, wmarks.lowulong, 0600);
-- 
2.25.1

