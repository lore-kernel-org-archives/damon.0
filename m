Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7BF15ECEE;
	Tue, 18 Jun 2024 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734699; cv=none; b=uzqgdQw5WnATth9R1gLLuU8nz2yZSYnBb8SR7FeajNB10fT88XqZ9YPVKK6BplCfGv4LCc9fvDsuexsSRGgxlS59O1glylgtTfgH7YcEVp8NJenqGQt6nJ/vzatoZRPcRZQpWumut998JE9DJBSIOZTdj32/G+G+d5E65vj+8CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734699; c=relaxed/simple;
	bh=vyu4uJ3nrBS9zXRgwSeDU7byk5QTt4EqJtkm+FLnKWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cp3o7IfxtHws5LMuy1MroaVYYQWgWf7bD+hFt8YfjF3VSFvuKyipO+4yVlbE3P9+ikQ7dXmRHBMnoxSyyxT8uAGMC/trAu2Tz4SBKmuPEiU3MSd+DLSXSlDjiTj8Su0JGYJzI9B8L1DaXCQnYLZEYunOC7VrPCgZ1alkhyRJQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhpVrpYn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhpVrpYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8129C3277B;
	Tue, 18 Jun 2024 18:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734699;
	bh=vyu4uJ3nrBS9zXRgwSeDU7byk5QTt4EqJtkm+FLnKWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GhpVrpYn44Wb3cl7ZfbnbyU1jS+5Zjc/B6MgPWl7lT9sv8IsCZd5lgVxQh9JhVPUM
	 ZimB/lpOIiJ1meXbMj8oWQcrGfHLkFYxdRr12LhUnjQadgFAwdX2mZb68RhZSx5JGF
	 6qgA2za6SHEY5hjYVT2mbYaccCOKIIMRycGSPbfr7Qiw/0zO/RoukbVLXIndDCNve9
	 9ItQOg4Jk/OKE25fqQMBHMwUcLO/u7gBX9XxdVCe/Lw2HxsiHDQ+tAwlGimU4O2xpp
	 9wsEmirmXF7I2SOILuIxxo5jJOvRz759lWRp9yuOcSebyBz6qchrzF4SPgFUj4WtR1
	 MEjxIArfqSJqg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] mm/damon/sysfs-schemes: use damos_commit_quota_goals()
Date: Tue, 18 Jun 2024 11:18:01 -0700
Message-Id: <20240618181809.82078-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618181809.82078-1-sj@kernel.org>
References: <20240618181809.82078-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_SYSFS manually manipulates the DAMOS quota structs for online
quotal goals parameter update.  Since the struct contains not only input
parameters but also internal status and operation results, it is not
that simple.  Now DAMON core layer provides a function for the usage,
namely damon_commit_quota_goals().  Replace the manual manipulation
logic with the function.  The core layer function could have its own
bugs, but this change removes a source of bugs.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 66fccfa776d7..1bccf2619e11 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1983,10 +1983,13 @@ int damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx)
 {
 	struct damos *scheme;
+	struct damos_quota quota = {};
 	int i = 0;
 
+	INIT_LIST_HEAD(&quota.goals);
 	damon_for_each_scheme(scheme, ctx) {
 		struct damon_sysfs_scheme *sysfs_scheme;
+		struct damos_quota_goal *g, *g_next;
 		int err;
 
 		/* user could have removed the scheme sysfs dir */
@@ -1995,9 +1998,16 @@ int damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
 
 		sysfs_scheme = sysfs_schemes->schemes_arr[i];
 		err = damos_sysfs_set_quota_score(sysfs_scheme->quotas->goals,
-				&scheme->quota);
+				&quota);
+		if (err) {
+			damos_for_each_quota_goal_safe(g, g_next, &quota)
+				damos_destroy_quota_goal(g);
+			return err;
+		}
+		err = damos_commit_quota_goals(&scheme->quota, &quota);
+		damos_for_each_quota_goal_safe(g, g_next, &quota)
+			damos_destroy_quota_goal(g);
 		if (err)
-			/* kdamond will clean up schemes and terminated */
 			return err;
 		i++;
 	}
-- 
2.39.2

