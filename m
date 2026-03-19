Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630BD3EFD21
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935872; cv=pass; b=aXHK/FHxE3mn8oV19R7qWTAZpeC0+EvBbr0vo9zav/aJ/I3zv2WdPhlaaXpO5y90jA48D4BuYSgkBNAd7ycFfuWRWOyyxHQTqVQzoPHbzfCWUewLAfG40tplMlSoRBffuFI2HVzYeHoM1O8M5wOLvO4LkdFpiEKQWqDW8vYLV+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935872; c=relaxed/simple;
	bh=xRmcDZvQqgD5v1yHwnP54SSUG7hojGDE1sN5Iyg9fy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OhO3X7sC2SLq2twTYS7RNPEW3ZcwWpFM6mKx/Ug0y8RomOXJM1Ue3e4XPAsu2m8TWKdIjpPZE1vdll2HMwfVk93m7Dcj+nX1jhVBu5Omryl3Qk+xZ+dPadjY17oELBdLUlQhbKyT7ggd9BcyZp+W71+QM8kk5LwMVDwLGVmbDPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=JVCDBSfA; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="JVCDBSfA"
ARC-Seal: i=1; a=rsa-sha256; t=1773935866; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=GRatP3d9VlCUG70BsMCn+vXrEYY6ePXsuhRMhOrtaHeJIxDIlpbqqpV0uEeToDuih4Z/C2Eposf22r0wYxK1QAwO7fT5m6FFh8gETb10RzqRlx//aUszSy+VCgu7jUfc17GjK5x3hRTQPNC04Z0gAr+BSUe5pWw8EIdVqHRKDm0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773935866; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=v5AmYxxKHBGd/h651de89e6e2kJ78xirvBMwkGyS3mk=; 
	b=HLXvfFaBe1yN5XE8N/YilHHHLadNleS6Uyg7HhD3F6XuN6C5QdDu7g+wQvI2lTHsu/3V7NY92+6CDJFYDuzNkCuYQcTdXuoPp8syzgUzQSAx1X98o6hcvfXP3/nAjtBbN3BD8Qu11EasO+hIxexkIqfCVxhIX/nNevmi2E4VguI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773935866;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=v5AmYxxKHBGd/h651de89e6e2kJ78xirvBMwkGyS3mk=;
	b=JVCDBSfAiVHrSuC+3mrtKDb3s9WsLv/TB2XPrVOzeSSN3bIjQNnhGKx5KA8DEjE9
	MVazrdud5+ssU3Zsg9+mL8v/DxLSY/f0/X5BOfijQpY77Z0fG1V/ZrPr/F5Mgy/QgiH
	sASkwAYOBZ5TfTuBGSjxvLw+et6CioUMv4f3IV9Y=
Received: by mx.zoho.eu with SMTPS id 1773935864833351.06425221152233;
	Thu, 19 Mar 2026 16:57:44 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 1/4] mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
Date: Thu, 19 Mar 2026 15:57:39 +0000
Message-Id: <20260319155742.186627-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319155742.186627-1-objecting@objecting.org>
References: <20260319155742.186627-1-objecting@objecting.org>
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

Signed-off-by: Josh Law <objecting@objecting.org>
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

