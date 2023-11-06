Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B4829D07
	for <damon@lists.linux.dev>; Mon,  6 Nov 2023 23:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7EqwQOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5E5C433C7;
	Mon,  6 Nov 2023 23:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699313652;
	bh=W1YiwkaUjwsrSNghKHLS4esY06g2LoID2WDuKt3I9RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7EqwQOv3ujXdIdXqqLv7Yl2LZRZP4XIrLtoom+8gJLK5oV+OiHLT+vhbC/H1l//N
	 3ys60zJfeXmo1OBsPoTrzHX39yAklgEWMZGpaL5dQ84d1Wm494msHCkhjxa3lLv/o+
	 bmlBz1f8LPIrbknFW1iBJdvA5QQacQ1blL3tn2CUS9dsVOdkdhD3h1h9hzWsXsD+lD
	 cQcF6kLh9zlF7uEHKE33vL0PahvmSow2SGpG0LP18EhMlmxAFu7oZpV7nWkVBLUK+y
	 KXwSQej944ZLmBtdEJft4FhJiRYzEA2O1R8i/uGHUKVQC5EUGKH8wVyaId3jKSixkj
	 qTvuPBpthovEA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] mm/damon/sysfs-schemes: handle tried regions sysfs directory allocation failure
Date: Mon,  6 Nov 2023 23:34:07 +0000
Message-Id: <20231106233408.51159-3-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106233408.51159-1-sj@kernel.org>
References: <20231106233408.51159-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS tried regions sysfs directory allocation function
(damon_sysfs_scheme_regions_alloc()) is not handling the memory
allocation failure.  In the case, the code will dereference NULL
pointer.  Handle the failure to avoid such invalid access.

Fixes: 9277d0367ba1 ("mm/damon/sysfs-schemes: implement scheme region directory")
Cc: <stable@vger.kernel.org> # 6.2.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 45bd0fd4a8b1..7413cb35c5a9 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -162,6 +162,9 @@ damon_sysfs_scheme_regions_alloc(void)
 	struct damon_sysfs_scheme_regions *regions = kmalloc(sizeof(*regions),
 			GFP_KERNEL);
 
+	if (!regions)
+		return NULL;
+
 	regions->kobj = (struct kobject){};
 	INIT_LIST_HEAD(&regions->regions_list);
 	regions->nr_regions = 0;
-- 
2.34.1

