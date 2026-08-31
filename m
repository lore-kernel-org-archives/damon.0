Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F98B368291;
	Mon, 31 Aug 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187663; cv=none; b=eXNuZq1VN/LlM5hGTsa1j/+fgXe+uKofMxgtV0clrIGHNt7ncXnf+XBpvHyxz32rs62yNSox9ViDTfqTtMU7WnGoeCpdm3rVJf8tHK3QyJ0Z2YcKuNoaA5vgwpKJl2oCDpaM/Yvmm+7sNUMQFCblatvSxl5fVZt0HtnVrrsDedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187663; c=relaxed/simple;
	bh=tT8+7JHX4Z5CQNZSU6CIJUR4PBtRpLSLW0mkDQ5Q72M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q63fWXPx4819ltFN2NbGcG30NqvAPg0KM6PkRbA9x7eycOBE6YIzQAWc7/pCp1KOJjXRIuM0L6TRP7e76zxUZQizmaBf3rlNNLQqDphuksdXzWr2mhFU4pzoQwbnGib3H+H2NSy0mf5AAc7ZzQU2t7UfgpigiWvPJXQcWHR13ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdsBr8V8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdsBr8V8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020C41F00A3F;
	Mon, 31 Aug 2026 14:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788187662;
	bh=jRlTOiEIY3tiJAO3FSkFxauqKn7UWt45qGOpOASV3nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SdsBr8V8Wz3lqkMNdh5QCy+1X8yc/Nvwitq8jvgztKAbCU58EZKIJwLdIs/Ox5nLq
	 VHcBEsCeDDQTjjiH9neNf14ngxKWXuy4QQQfr5rL7UqCiN6DbOJtmTXIWgbafyUgGo
	 ijRAOEffpePeH+TVg5H0eOMz/IGChahtEprI4adZszGk4OGKx0P3qWFf7wij14SFpv
	 LA35NY33vziyekYX0s8BICIkmTzF3Zi6vjx548fS2TNkXFuZHgicQxfckNwOdeznss
	 iHtS6Xr1ZjOqMFHvzQ/b+p5MqoqgrR67lD8Wy6Mzi+GNHPyarAmjHxfOGU25nt4Hdk
	 0qOHWqPnAe81g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 2/3] mm/damon/sysfs: support hugepage_mem_bp quota goal metric
Date: Mon, 31 Aug 2026 07:47:29 -0700
Message-ID: <20260831144732.80910-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831144732.80910-1-sj@kernel.org>
References: <20260831144732.80910-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

DAMOS has a new autotune policy metric: DAMOS_QUOTA_HUGEPAGE_MEM_BP.
This patch exposes DAMOS_QUOTA_HUGEPAGE_MEM_BP through sysfs.

Add the "hugepage_mem_bp" to the sysfs-schemes interface.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 32f495a96b17a..d9b81d7b5910e 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1269,6 +1269,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
 		.metric = DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
 		.name = "node_eligible_mem_bp",
 	},
+	{
+		.metric = DAMOS_QUOTA_HUGEPAGE_MEM_BP,
+		.name = "hugepage_mem_bp",
+	},
 };
 
 static ssize_t target_metric_show(struct kobject *kobj,
-- 
2.47.3
