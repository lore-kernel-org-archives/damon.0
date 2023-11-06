Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA1A29D07
	for <damon@lists.linux.dev>; Mon,  6 Nov 2023 23:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1wTspPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F12C433CA;
	Mon,  6 Nov 2023 23:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699313653;
	bh=19smz8vjkknnlftKxQDFJP/XhxeknF20W/DyGkIS8Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1wTspPUeGLo6x8Q/O1NGf9r8R7Y77Rea13Em+t/uPG+M8MB1RkYbqzvbkzEFu/2o
	 +EbJZr5EpmuJNr37DT7pK4w7FQz0S3gGCgTdLEjwu0j0llYH7NAk8oU5KIZyMrGTDa
	 xU8ou+PE7Hw8IjLv9dyB+hxXwQngY+1i+Ioz1CMmAr4QR9KqCjMOtErZW426EoDG0n
	 ZWwH3Jx6nAAnd11/pOFJY9vSHUNoDTRFu1AngsTYsvE2korQlJDZmaQT6CsbPoIwr5
	 yzi1Mp+MivvdfbKoUGQsKHXEJT583q7JL2Znk9lwUlXiHrruB3lltIK3NLWFk4pDhE
	 SzPy2Mk286CAw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] mm/damon/sysfs-schemes: handle tried region directory allocation failure
Date: Mon,  6 Nov 2023 23:34:08 +0000
Message-Id: <20231106233408.51159-4-sj@kernel.org>
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

DAMON sysfs interface's before_damos_apply callback
(damon_sysfs_before_damos_apply()), which creates the DAMOS tried
regions for each DAMOS action applied region, is not handling the
allocation failure for the sysfs directory data.  As a result, NULL
pointer derefeence is possible.  Fix it by handling the case.

Fixes: f1d13cacabe1 ("mm/damon/sysfs: implement DAMOS tried regions update command")
Cc: <stable@vger.kernel.org> # 6.2.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 7413cb35c5a9..be667236b8e6 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1826,6 +1826,8 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
 		return 0;
 
 	region = damon_sysfs_scheme_region_alloc(r);
+	if (!region)
+		return 0;
 	list_add_tail(&region->list, &sysfs_regions->regions_list);
 	sysfs_regions->nr_regions++;
 	if (kobject_init_and_add(&region->kobj,
-- 
2.34.1

