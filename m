Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACAB171DA
	for <damon@lists.linux.dev>; Sat, 29 Jul 2023 20:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF87C433CA;
	Sat, 29 Jul 2023 20:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690663058;
	bh=obtSlnvy07n5RqMkT9ft+YWwsEmXSmZYdkX6jt7/ZH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdAWiTrM5jLNvyEBr96k2bMsZpKhmFnONlHBuxh9ggS6iOcSUvJwgxLYzbHzBg9wS
	 Ru1MQ8gRyCCNabq0iEEj553U3cF/LPfy0Z0RP1lLlqIranr3CxrK7kwMlydMcHIEt2
	 mSWUspQMNOceTsGydjYASOP5JF4GQDXRDt5LbRC1/bnb+Qf5GF270paW1Empm5JTfE
	 pms39T+3hsMPHK1s1xJXi3Qz6XelHOE+8iQjtuS/sHfhyIDLjibfxH9NuWXDhb97Ui
	 CwFQtevzKuW9qy+wLJDw5htGv071KBVoNdVp8kywCJ2s4wKeX4TOrviMNnxZTvwnyQ
	 9TIBw3B3hZQIQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/damon/core: initialize damo_filter->list from damos_new_filter()
Date: Sat, 29 Jul 2023 20:37:32 +0000
Message-Id: <20230729203733.38949-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729203733.38949-1-sj@kernel.org>
References: <20230729203733.38949-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_new_filter() is not initializing the list field of newly allocated
filter object.  However, DAMON sysfs interface and DAMON_RECLAIM are not
initializing it after calling damos_new_filter().  As a result,
accessing uninitialized memory is possible.  Actually, adding multiple
DAMOS filters via DAMON sysfs interface caused NULL pointer
dereferencing.  Initialize the field just after the allocation from
damos_new_filter().

Fixes: 98def236f63c ("mm/damon/core: implement damos filter")
Cc: stable@vger.kernel.org # 6.3.x-
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 91cff7f2997e..eb9580942a5c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -273,6 +273,7 @@ struct damos_filter *damos_new_filter(enum damos_filter_type type,
 		return NULL;
 	filter->type = type;
 	filter->matching = matching;
+	INIT_LIST_HEAD(&filter->list);
 	return filter;
 }
 
-- 
2.25.1

