Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D8D28689B;
	Thu,  9 Oct 2025 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044856; cv=none; b=Dz7NCrrZ/z+YH4HzKGgdgU5Zchf6KvsIAwd+gxytJX7SSbXYOhUztJl+WmBR+gDVPaxZmwTZ1dpU1eOXFvqqA9HJvFyPGR/AhHomQBGPhSrZB/wVXgazW1SF7cG5/oQXmldu1p8BO/jxe5LVu+CI3ZlHuOfgq5pEKwXNji575UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044856; c=relaxed/simple;
	bh=LW/6mDf7N5tp3NVaa/MTw5MzAUr1eIrJZfX1KpNkybA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZOLTmeSDy4dFqWlpaR9uJJHc2SYmtNjKybtUT5wUfZl1UA3Ly8D49NPsRMhpPe99r000ulC2/u1clpVsZrCUkObNuJwd7tzaQSaqVbydeUsRUmfOK4JtwhdWqzUtN+VN27Rt8oc6cTKLvJLJ0nW3i6sXnWVVU9BZUk5h86uM7mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tz90siZg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tz90siZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA1CC116D0;
	Thu,  9 Oct 2025 21:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760044855;
	bh=LW/6mDf7N5tp3NVaa/MTw5MzAUr1eIrJZfX1KpNkybA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tz90siZgJeVmm6nJG5948QdV75YE3e3vx6SMoOo30urTFGr8SXMhYgE1BdGVItvUE
	 ao0smPENqeNMT+3IRdPWVPkxrh63rfPjDqPIqecuGVQgdowuXFvPOtSEqlf6S3WU7w
	 sIlL7ZjanGac5t9WD7wpXlJFwiy0yainSj6eVtsZEznYvZ0RJFXl5izlXaYz4INTZU
	 3EaBRmhJpQs+qKyjY14VqNVGzhYbjfRz++1EtaCBKfWoFtMuHcrzY0eI6n0qP55wKN
	 PAe0T1j6IhOVZVGWfG4rCXmh9/jBzqt+mj0hDMRt6lx113NgKZX5COGYZJUzTCr7MZ
	 q2rNXksuqaeXw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 07/10] mm/damon/sysfs-schemes: support DAMOS_QUOTA_NODE_MEMCG_FREE_BP
Date: Thu,  9 Oct 2025 14:20:39 -0700
Message-Id: <20251009212042.60084-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009212042.60084-1-sj@kernel.org>
References: <20251009212042.60084-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs to support DAMOS_QUOTA_NODE_MEMCG_FREE_BP.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index c679e62fd4b9..c98cf4bd2fbb 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1034,6 +1034,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
 		.metric = DAMOS_QUOTA_NODE_MEMCG_USED_BP,
 		.name = "node_memcg_used_bp",
 	},
+	{
+		.metric = DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
+		.name = "node_memcg_free_bp",
+	},
 };
 
 static ssize_t target_metric_show(struct kobject *kobj,
@@ -2552,6 +2556,7 @@ static int damos_sysfs_add_quota_score(
 			goal->nid = sysfs_goal->nid;
 			break;
 		case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
+		case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
 			err = damon_sysfs_memcg_path_to_id(
 					sysfs_goal->path, &goal->memcg_id);
 			if (err) {
-- 
2.39.5
