Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7C9285C9C;
	Thu,  9 Oct 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044854; cv=none; b=AMIyIAWNg1bUPaqjUyUKZVQ/WKQK+hJ12n7B77Kg4bjxP5aetF5XSVzqMvl+DZzINeKVTgcqWsh9sbEwF0txhILk+hFMHu7hVvebALGELBcaKQTdhT0CGwqTPPbmxHKZn0YDEIZarQQBfTcWwfEcB4PpRlfJDaQdTTIl5f5pJ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044854; c=relaxed/simple;
	bh=HTdQH6mS8J+MYD3Rj6pztEN9kH+IjfPCcbROi0+eWaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/p6XueHOU0LMtsA8BoApGwy+JDcFFdPfH0hyZtHnUtNbdC3M4kENgqPr7bJxq83PwFga/FWdrlfzldV6fC6TWGY08tYlyecOVbnmgkfXL5orh3acmLgmOAbkKUMBumrJzEq80B2qTYMIdkxt7w9DQI+6dx4iCCq7DOpmjCaOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwwztoHQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwwztoHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678EAC116B1;
	Thu,  9 Oct 2025 21:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760044853;
	bh=HTdQH6mS8J+MYD3Rj6pztEN9kH+IjfPCcbROi0+eWaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwwztoHQq0gOcUnJhit9e34YwWQL1uZxDEk3qMp3ncNP0zWYl+8aCxSBwwT/s171Y
	 pN3DDPCQayfFcwVCLZc3jsdyFnVGQ1rLXDNPoTjBK/rquZ/pFLQw2UIuyTJnkhGfT+
	 CvuTkinu3pEdQkgy2C+GSfZ1qJNmJnNsuzakgsM9c8wAm6uilNyWneV5KX5L2KnDqc
	 W8w6P8XPeQPCVFRjwQ8IRe1bQR8n1nxzY0IJrd64qV3I3QWafo2bCYYrxA/2l1xjEX
	 bzPdq7GL3XSozfrTBGW3QRrCJX96184b+EKytuCv5b8BmevNQxMlA4Vtnsafcm5f9D
	 iCC9XZQOc5dgQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 05/10] mm/damon/sysfs-schemes: support DAMOS_QUOTA_NODE_MEMCG_USED_BP
Date: Thu,  9 Oct 2025 14:20:37 -0700
Message-Id: <20251009212042.60084-6-sj@kernel.org>
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

Add support of DAMOS_QUOTA_NODE_MEMCG_USED_BP.  For this, extend quota
goal metric inputs for the new metric, and update DAMOS core layer
request construction logic to set the target cgroup, which is specified
by the user, via the 'path' file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 2c440a2b80e6..c679e62fd4b9 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1030,6 +1030,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
 		.metric = DAMOS_QUOTA_NODE_MEM_FREE_BP,
 		.name = "node_mem_free_bp",
 	},
+	{
+		.metric = DAMOS_QUOTA_NODE_MEMCG_USED_BP,
+		.name = "node_memcg_used_bp",
+	},
 };
 
 static ssize_t target_metric_show(struct kobject *kobj,
@@ -2526,7 +2530,7 @@ static int damos_sysfs_add_quota_score(
 		struct damos_quota *quota)
 {
 	struct damos_quota_goal *goal;
-	int i;
+	int i, err;
 
 	for (i = 0; i < sysfs_goals->nr; i++) {
 		struct damos_sysfs_quota_goal *sysfs_goal =
@@ -2547,6 +2551,15 @@ static int damos_sysfs_add_quota_score(
 		case DAMOS_QUOTA_NODE_MEM_FREE_BP:
 			goal->nid = sysfs_goal->nid;
 			break;
+		case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
+			err = damon_sysfs_memcg_path_to_id(
+					sysfs_goal->path, &goal->memcg_id);
+			if (err) {
+				damos_destroy_quota_goal(goal);
+				return err;
+			}
+			goal->nid = sysfs_goal->nid;
+			break;
 		default:
 			break;
 		}
-- 
2.39.5
