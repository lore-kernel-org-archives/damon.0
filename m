Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76403256C80;
	Sat, 28 Jun 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751129510; cv=none; b=tybHMa5eNL/civJB0/ivU/2hLkO/n+G6kZmFL4ZF9GpqZHCNiLEIef2YaX5Fko8zhbU3z6oFpRfg1B7F3ZKVVVJehhzzyOAfpMWaCv1y/2T/EnqS4iDwOxIC0YBSSBSScK5XSwj48x2efwewl9TmPWh1py/KEtnWrBWjTEX99/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751129510; c=relaxed/simple;
	bh=bpHe961oflZU3B/An+TbdXaXn/ljNslL3rvDuZ9B014=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bj2rWmoeGRgR3/a/9EWQKoe14NZweLML7JnmyWkQiDK65WDk7GH+ediX583XjhxfIuaSDDFsr5xyz3nc0xLZQrVYVJVoJjzmZcyczqnl3hbTmjozDXTnfi67kXY4edoP/RRw35rKNEgWVysZHSETiHVFbZ6Y0g70XOi9MiJv+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ty2jW2a/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ty2jW2a/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1151C4CEED;
	Sat, 28 Jun 2025 16:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751129510;
	bh=bpHe961oflZU3B/An+TbdXaXn/ljNslL3rvDuZ9B014=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ty2jW2a/8T3spwMO2kGwPkcyMIhSWLjSgU2IkzZBq5yrUkNd9LeW4E3b74LgfsWyA
	 Y/vTe1QDPipfZtRvnfmTSch61Dl7Uc8zdLbU5vgKn6fh4lys1XhHO6Lj6ol53Qt2uA
	 Ns3hR86OTHIK9FlJDdVXbQ+HSYSLFEezgknPjrjUdcYFDeYnz7a0LB+EcjHschtxYv
	 a+N+4aPc2v8BfT+aUST9figVzZGv/yOOCclnjuKKYaGMRKHEMbPuxTUnbNEPjaiWnD
	 u8QN4rcLbwfzz/VRWpEdFUWdALkpo4auZUwV99YhEcvb+zroFvHqCU8Cmtkz5IjFqN
	 7S3dcxbrJyqwQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/11] mm/damon/sysfs-schemes: support DAMOS_QUOTA_[IN]ACTIVE_MEM_BP
Date: Sat, 28 Jun 2025 09:51:35 -0700
Message-Id: <20250628165144.55528-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628165144.55528-1-sj@kernel.org>
References: <20250628165144.55528-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support of DAMOS_QUOTA_[IN]ACTIVE_MEM_BP on DAMON sysfs interface.
Users can use [in]active_mem_bp keyword input to the target_metric sysfs
file to use the new DAMOS quota auto-tune target metrics.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index e026eed16c2e..e8dcad65292b 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1029,6 +1029,14 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
 		.metric = DAMOS_QUOTA_NODE_MEM_FREE_BP,
 		.name = "node_mem_free_bp",
 	},
+	{
+		.metric = DAMOS_QUOTA_ACTIVE_MEM_BP,
+		.name = "active_mem_bp",
+	},
+	{
+		.metric = DAMOS_QUOTA_INACTIVE_MEM_BP,
+		.name = "inactive_mem_bp",
+	},
 };
 
 static ssize_t target_metric_show(struct kobject *kobj,
-- 
2.39.5
