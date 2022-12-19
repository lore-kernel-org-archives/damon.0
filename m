Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1123D6D24
	for <damon@lists.linux.dev>; Mon, 19 Dec 2022 17:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588B5C433F0;
	Mon, 19 Dec 2022 17:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671470293;
	bh=Az1DXboUgRl+YAMk48Zah7TQBLUIJ4ua1EMPirQ5/3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7iuXB5ZEm6O0EUjdxu5DQDi6cpCEpzeu3Zsa9iJyPi1H/rZSq/6M5VA7cUOv1WH8
	 NVdoiSN3kxcVWbmlgVaZARrAW6n7M3KikLiJxzQKSc8wJkL+dPjnJs0eHGv1VmJFep
	 4PejNW+g758e7hTjmRmXx/epWzJrVzgg9d3jH1rTSyByV7g1kCvlqvOJ3mtLtC+xwz
	 107NmX9Um9h8GKmqextgzKBM75180RfQ0OKBM7t17wNxns3jG9UT+l8hhtX7ss46GO
	 L8UX0b7e/kkSZJHB/zhPcbEiNjGNKHGkL+ERT9H9Rww1MgZRTiQVat2VYr0EDmOc7g
	 wRi4h5+o1tB7Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH mm-unstable 1/2] mm/damon/sysfs-schemes: Fix leaking a filter for wrong cgroup path
Date: Mon, 19 Dec 2022 17:18:06 +0000
Message-Id: <20221219171807.55708-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219171807.55708-1-sj@kernel.org>
References: <20221219171807.55708-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f36f860207efa ("mm/damon/sysfs-schemes: implement scheme
filters") on mm-unstable introduced 'damon_syfs_set_scheme_filters()',
which does not free newly allocated filter when it fails setting memcg
id for the filter.  As a result, the memory for the filter leaks.  Fix
it by freeing the filter before returning the error.

Coverity CID: 1530032

Fixes: f36f860207ef ("mm/damon/sysfs-schemes: implement scheme filters") on mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 0501862534f2..5d3ac3107927 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1464,8 +1464,10 @@ static int damon_sysfs_set_scheme_filters(struct damos *scheme,
 			err = damon_sysfs_memcg_path_to_id(
 					sysfs_filter->memcg_path,
 					&filter->memcg_id);
-			if (err)
+			if (err) {
+				damos_destroy_filter(filter);
 				return err;
+			}
 		}
 		damos_add_filter(scheme, filter);
 	}
-- 
2.25.1

