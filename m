Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B806A29187E;
	Thu, 19 Jun 2025 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370434; cv=none; b=e6XeTKAcQqPdEj5jqT6w5+9H+4x3wUaluOWzZWWKUKqVUjlI4v3VNHOlFi/Dte3Wr/FkwuqH80cEdzQVYTkuQPZgSHNt2E+3ZSCQk46VNsIqCQR2ZAcUOOurofjlSaKmbAP2FH0NU0Wb3KQXJspuUspyXJp1ZWEA9kW6S+T4cSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370434; c=relaxed/simple;
	bh=gncPAmp9X4uOKinuCsBckPc5W+YYA5SmjzqnymRxrxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MkYwgnPqWRw7itqL9jXkleJdkqjTq3AbIT90xnuvSBUkQ6/GvqfrxYwYpCl2A4oMzKUk1x5RSWJU0vZOXMWOxWdxm8oZU3eFhqcx6xNTlXJ40e4yEoxaP+UD6KjgM9JjLMT/okj4xwkukSFgVM69FJvIi/319Hh5NgmUCCeoUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3mhJg1l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3mhJg1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36519C4CEEE;
	Thu, 19 Jun 2025 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370434;
	bh=gncPAmp9X4uOKinuCsBckPc5W+YYA5SmjzqnymRxrxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f3mhJg1lE5Mw/oWXgvzSeZUyYE4TOy1VQx/Qh2VJluCl5Vn7MmUdEwFLc4e/FSZsL
	 pdbuWKIjCnHOXnFHvruTofGhSAKi+z9MXdfD19ZCf/tBF1s3EyUtNvQ876O5jN/zEc
	 GMLl+KPbb4MVGmvv481CEM6K3/f9OsJQYiHpj2MOOLehjRds7RPQuP3sXjA7k4e1sb
	 FMZOBa28PwSb5FM2zWmSNvVDCKNX+hv7AAVWsgj916SuTYqc1vWgUjgAfNoJvYPOIj
	 b/phKgDIFcE3AViSrm0uzefdJTlk5sS3XDxoK8paY5dIC9Rufz307eUgF/5Klw0Ch1
	 5FAJEZFDk5CfA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/11] mm/damon/sysfs-schemes: connect quota goal path file to DAMON core
Date: Thu, 19 Jun 2025 15:00:17 -0700
Message-Id: <20250619220023.24023-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250619220023.24023-1-sj@kernel.org>
References: <20250619220023.24023-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read and commit the user-specified cgroup information for
DAMOS_QUOTA_NODE_MEMCG_USED_BP to DAMON core.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 4a340baa72a4..89e5e40bdf63 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1030,6 +1030,10 @@ static struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] =
 		.metric = DAMOS_QUOTA_NODE_MEM_FREE_BP,
 		.name = "node_mem_free_bp",
 	},
+	{
+		.metric = DAMOS_QUOTA_NODE_MEMCG_USED_BP,
+		.name = "node_memcg_used_bp",
+	},
 	{
 		.metric = DAMOS_QUOTA_ACTIVE_MEM_BP,
 		.name = "active_mem_bp",
@@ -2317,7 +2321,7 @@ static int damos_sysfs_add_quota_score(
 		struct damos_quota *quota)
 {
 	struct damos_quota_goal *goal;
-	int i;
+	int i, err;
 
 	for (i = 0; i < sysfs_goals->nr; i++) {
 		struct damos_sysfs_quota_goal *sysfs_goal =
@@ -2338,6 +2342,15 @@ static int damos_sysfs_add_quota_score(
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
