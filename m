Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D5833D511;
	Sat, 21 Mar 2026 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774115676; cv=none; b=ZtFrNMJsKhN+v7THcGIGTc38AnEdXlSg1UTRmT3jd2KgiN5PqUXovuJWfCAKt5Is4hSgB3CHizs+R9wyifPO2nOKiD0tJ2PD83w8iEl6uGc9QHPf2qKj2GopFl4pBR3SI3tVijWvzMdWsumllJ+7NAW06TsRTvP3LZBv4wGdgLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774115676; c=relaxed/simple;
	bh=kqdEPb3iNN0fFsVK6m3M9gMdlpedC9f1qzwxe6K56h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpOzFGSU/HJNFZlWZqo1LcStNKthZY8fxUEzzNozSnA2DmofchF4EkQt+/rmK0w6rRf4YCsult7vc51aXnA4Ym90S1ldo9BDvBxZ+f3gDVOubHRhDW8rqrnquj7Am4QtsV4jyD1+i7GUaPaYlIr5gZQ6a43/RZ3JPsIQZwgdQak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tgu/N2qJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tgu/N2qJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC19C2BCB2;
	Sat, 21 Mar 2026 17:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774115675;
	bh=kqdEPb3iNN0fFsVK6m3M9gMdlpedC9f1qzwxe6K56h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tgu/N2qJidFELa4r9BzD1WwU6563wFyYLpFeqzAZwcZHxbUQJikNm03IhG6ga4O0P
	 4gkR7H8AeiwT7Q79DF5fBsXfw5MoTmKsIriNGT+uKc7s2Sr47yau3UxeyboKCyUNdA
	 VHVtnCqKX7sB07ZBJrzXivgN8FdeB9gmCP2WUdCom/uNzGv82jAsM3B+kH6UczvgrJ
	 K8FLKphL9mP90Y0th/QZNJhCYCQoiW1KQhQ32+FNA0GXtd2ARWr47W5nlxXUDUhvow
	 cEFGjDgpkRYCMhjQLpwv7cpwXYW4UxUZXNvMrDeBZ0tPyNsHa0UdkaUZxRzrajinW0
	 AWj8UgrMbuYww==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Josh Law <objecting@objecting.org>,
	"# 6 . 18 . x" <stable@vger.kernel.org>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 1/3] mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
Date: Sat, 21 Mar 2026 10:54:24 -0700
Message-ID: <20260321175427.86000-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321175427.86000-1-sj@kernel.org>
References: <20260321175427.86000-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josh Law <objecting@objecting.org>

When damon_sysfs_new_test_ctx() fails in damon_sysfs_commit_input(),
param_ctx is leaked because the early return skips the cleanup at the
out label. Destroy param_ctx before returning.

Fixes: f0c5118ebb0e ("mm/damon/sysfs: catch commit test ctx alloc failure")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Josh Law <objecting@objecting.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 576d1ddd736bf..b573b9d607848 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1524,8 +1524,10 @@ static int damon_sysfs_commit_input(void *data)
 	if (IS_ERR(param_ctx))
 		return PTR_ERR(param_ctx);
 	test_ctx = damon_sysfs_new_test_ctx(kdamond->damon_ctx);
-	if (!test_ctx)
+	if (!test_ctx) {
+		damon_destroy_ctx(param_ctx);
 		return -ENOMEM;
+	}
 	err = damon_commit_ctx(test_ctx, param_ctx);
 	if (err)
 		goto out;
-- 
2.47.3
