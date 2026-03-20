Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6192F1FEA
	for <damon@lists.linux.dev>; Fri, 20 Mar 2026 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024568; cv=pass; b=A/mMqNJOTOL9emyVXfn0EIXi0DnpFjSF5d+CBjQ2TAzyZBzITdYhC/7VL2HhK1y4TyiaJYjZDT6i+t/vcGJefqRUAN9rgRBErwAqPNnwyFiILb1lmxbPlplf0phXzpWo2rzQ+afl9eezATnz8o+M9dW8fm/q8E3a3n/jUYiK+Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024568; c=relaxed/simple;
	bh=UxrDQ+bV476tvqQrvgRHKh9A8SplKNnFA7Ijhyo2+sg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GcNOJB2xQN+8PVGwGud2jJ+GOTXlvfTxLSgEjddk3UirSiQ+WzkayFqW6n9dySahpTEm8jYwSsUzbYZYXj9Akl/d2uWG1YUeuWvghBvY4qRNjitPscQPnLcSQLLjODwcv3As3bWjkNpJKyYFcoetukanW3GKpslks0a/qEd6sps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=O317TOCR; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="O317TOCR"
ARC-Seal: i=1; a=rsa-sha256; t=1774024564; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=HzAb7DtkmPMMaHFoOtSy1ByOBce8Z2VsonMAgK3g7nAu1gS9o7GrQ9Y/z0xdTbtxrXsr18PpDiLO/NFezHOBw2DZQKExMfZjQztVz5W6d+/JkWrwA20CmYBBjAxhTXYfmFdSbYJ5Rt7Dumh8ozSmc497CFyfTmJJx5QfRj4h184=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774024564; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HdwGly0+BqBUHkF/IVpHh4nGFQLNRDEsFnAVEweW3Yw=; 
	b=RQTJMzmaKNcGEZIM0a0wqaVr0Rt73Z1x7zQ4w6S1YIPk649spcPUtC6azCFKp2LbBuUohC/4ua830oFdYWQ0mmyNrpWUElkd9COVdyrLGvKDq4sUUHqKUhMQwiEezbc3D2PWdxhMGXtaZ19sX373vL2jrldHQGd29jVc52dZWOg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774024564;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=HdwGly0+BqBUHkF/IVpHh4nGFQLNRDEsFnAVEweW3Yw=;
	b=O317TOCR0B+3T99gsNHIJKWes3cGthXqIYy6ZdbnlKhlZlbWf1aaYEk3lgRRV8Jy
	seuTTJJG68epxgzugQRpXwl/8EB56ZmjQRI/xWlVCR+pWjmNviU0yzLCY7EHlpY3CdP
	gxwIScXISBAC46AXC0oC0MoYa1NeI0VuWPnC1T7o=
Received: by mx.zoho.eu with SMTPS id 1774024561416667.7402047367142;
	Fri, 20 Mar 2026 17:36:01 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
Date: Fri, 20 Mar 2026 16:35:57 +0000
Message-Id: <20260320163559.178101-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When damon_sysfs_new_test_ctx() fails in damon_sysfs_commit_input(),
param_ctx is leaked because the early return skips the cleanup at the
out label. Destroy param_ctx before returning.

Fixes: f0c5118ebb0e ("mm/damon/sysfs: catch commit test ctx alloc failure")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Josh Law <objecting@objecting.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 576d1ddd736b..b573b9d60784 100644
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
2.34.1

