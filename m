Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8446C386566
	for <damon@lists.linux.dev>; Fri, 20 Mar 2026 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024504; cv=pass; b=jn7bmJoMd6yaw/aDQRol96f6tdCiswF7gQCwB0OZsmr3UMtqs1/tDj5LcvT7xVrQXth5/Th7t8KIRUQ0x0WvjXod6dKt1gRotUs9IXI5dk89FAzHDrwJwSkpREZHa+J+2u1HtLWrLoTMoBTxA/xDTeB7MOc96m3MjOYHV9snS6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024504; c=relaxed/simple;
	bh=UxrDQ+bV476tvqQrvgRHKh9A8SplKNnFA7Ijhyo2+sg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QlERvzUWbgfOcEe8SfR5BrtmNUMdkIHW0D4nTZY6ajXvmW7vmfg4Uoi592GII9OIv7W58fXSirqz1uuUnW7fOnHUuai7vpONLSs5O2sTGpKK9Hni4pUBaTtyugI417H71l52st88qWm5T2Z4TRxAWTf3Pw4PyswfvtXb6qeUgQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=nu4X1zZT; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="nu4X1zZT"
ARC-Seal: i=1; a=rsa-sha256; t=1774024499; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=kL6TU9SxXmYW0Zx/+kJIt50C7x7C6YJ7xEUjn0GG5n4am89gtGvS20RM8baJngnMB3WLNtnXp7nx8CLFgsymyYdVtDLjBpoEj5SP1DELvHi8kgTSe0wBpNB2bZKaIt5DgIigOrkEqfXE0d2ZH5VyqIPTVYOhnnzYJsrAbRkkeBc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774024499; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HdwGly0+BqBUHkF/IVpHh4nGFQLNRDEsFnAVEweW3Yw=; 
	b=TPcN1HWQ4epDGEcV3r9qKeumPHdQc8aQDqXLiWI6VdaTMIki2UhlHejhxzlATnVhntrG5D0B6ZJ7lkYRM9bHjxN/Sjzy09oSB69sF/8Dg8/HjHDH5qHHcwnwserD8Zud22pPE5LM15LKHp+1V3OdDXCB2jz44nTwWcNi0hC3PME=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774024499;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=HdwGly0+BqBUHkF/IVpHh4nGFQLNRDEsFnAVEweW3Yw=;
	b=nu4X1zZTA9hBK5Ld6MOv5wyDoT6VFY1Ca5zfBveSnqaAz3PidQoayHblWpazYaAZ
	VSgmId83ABif1FBfTXgCLLuWdvBbI/6+BSgfCwhel77epINNP8tspt6q+KpO3LurHRH
	EqTVCT47MbvMtjgx2RCWgVRVUGWN+aee6Aj1KOzE=
Received: by mx.zoho.eu with SMTPS id 1774024497826601.5397544812834;
	Fri, 20 Mar 2026 17:34:57 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
Date: Fri, 20 Mar 2026 16:34:54 +0000
Message-Id: <20260320163456.177750-1-objecting@objecting.org>
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

