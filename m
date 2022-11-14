Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867342FAE
	for <damon@lists.linux.dev>; Mon, 14 Nov 2022 18:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E15C433C1;
	Mon, 14 Nov 2022 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668450605;
	bh=xilSGlQYchsVmmKikIJMaS8XjvWaQ2LB9bIwb65/qKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=swj2BFaQreATJBLs249o+BEvmHBNmuMldNlErlB/B8b9dA22U3sLrY9JShtl3euSQ
	 LUc6YwbdvRPS2ozuIqEQEBnl0d69Is6VtnYjjY9at5mu9FXSttoIGplB/W7oT1oETx
	 Bg5vWylJKHenAihciGdnpQLmqsR40s7x4mCjxqZzarjbfJAhtbKOh3HvWpLRiufxuf
	 swEFNl8tFd4BuigWfcY2gMP5XJhOtmtc1aftM+cJkC2hGYAE6ag8mqW8UZW3eWp4cW
	 08HZe+AKn82IERaTJkXuoH6QLoQHIl9gbSUgUOtkzK/ZDCz5xXKMUIZZvT6toGxT7K
	 rIhOCkkEEzaKA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable 1/2] mm/damon/sysfs-schemes: skip tried regions update if the scheme directory has removed
Date: Mon, 14 Nov 2022 18:29:53 +0000
Message-Id: <20221114182954.4745-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221114182954.4745-1-sj@kernel.org>
References: <20221114182954.4745-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A DAMON sysfs interface user can start DAMON with a scheme, remove the
sysfs directory for the scheme, and then ask updates of the scheme's
tried regions.  Because the schemes tried regions update logic doesn't
aware of the situation, it results in an invalid memory access.  Fix the
bug by checking if the scheme sysfs directory exists.

Fixes: 1322c8148dfe ("mm/damon/sysfs: implement DAMOS tried regions update command") # mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index a79aa32d3422..4df3c99983e8 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1231,6 +1231,11 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
 			break;
 		schemes_idx++;
 	}
+
+	/* user could removed the scheme sysfs dir */
+	if (schemes_idx >= sysfs_schemes->nr)
+		return 0;
+
 	sysfs_regions = sysfs_schemes->schemes_arr[schemes_idx]->tried_regions;
 	region = damon_sysfs_scheme_region_alloc(r);
 	list_add_tail(&region->list, &sysfs_regions->regions_list);
-- 
2.25.1

