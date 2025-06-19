Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195BB29994A;
	Thu, 19 Jun 2025 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370440; cv=none; b=uZD27yXz4HNfJflRjbhcOIxfTGX260kgc3dHvRXjrEQDo0DWPZYr02DrO8sldT5k80xEUSLEsliqnf8FpaFJgfnAcDvPHJ5/LwEUSfkDsUasNcPRoC5ZUxZWf4TJuT7qD1aepVRTGeJixEtpRRdPjPzkBCk+xmL2FQ/IuJHIp9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370440; c=relaxed/simple;
	bh=ZNI7/tZOYHb60wq0Az69HW/eVRwT+4RSn0T5f4Wa/tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkCnulACUdf/aO0QmI0GCQwv0jRj3pAYG5mikiPMusR59fDl5WyMPNKzwnOI5RVaUDvKW3ua5lv0yVm35wku60Qc0fiAA03FPJ50twP58jhcdfA/Z3ZNcVLVM1cBoD7UXSsp36GbivPUzCRmoQBzYXJ9XGw/pxN2SxUFdLkaBNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLBic7nS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLBic7nS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE05C4CEEA;
	Thu, 19 Jun 2025 22:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370439;
	bh=ZNI7/tZOYHb60wq0Az69HW/eVRwT+4RSn0T5f4Wa/tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLBic7nS3Vb/FBT/LScHk/fPd9ih11k7VR0Sb6OVs/+cehe7HzGMa6PszQizdy/hr
	 UeHIusRhNeGgwvi59EUcLOEIW4qhFSWIpzximKneWAlticH0Bb3hkVzBll8l41HHw6
	 CltcsJhdD/LPYtME6wXTZTFJlFHVOzeq44JZlqS+UplOiAgUlS8e734DgB2BeW9Dwr
	 FCIoeZ2RPbyKzeDuEG7M/VcpuSsBAsWrACb7CKHxoVNC1CREbkeHNj4FVlKUWXTCZb
	 LTCZkJa4JcnJ4pfAkqsb6umct8Wwfh8CBBxXlwJvy4obi84AwX82IvvZcLjNohTKNb
	 Izg4WYaxNj9qg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 10/11] mm/damon/sysfs-schemes: support DAMOS_QUOTA_NODE_MEMCG_FREE_BP
Date: Thu, 19 Jun 2025 15:00:22 -0700
Message-Id: <20250619220023.24023-11-sj@kernel.org>
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

Let DAMON sysfs to support DAMOS_QUOTA_NODE_MEMCG_FREE_BP.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 89e5e40bdf63..819e16151752 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1034,6 +1034,10 @@ static struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] =
 		.metric = DAMOS_QUOTA_NODE_MEMCG_USED_BP,
 		.name = "node_memcg_used_bp",
 	},
+	{
+		.metric = DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
+		.name = "node_memcg_free_bp",
+	},
 	{
 		.metric = DAMOS_QUOTA_ACTIVE_MEM_BP,
 		.name = "active_mem_bp",
@@ -2343,6 +2347,7 @@ static int damos_sysfs_add_quota_score(
 			goal->nid = sysfs_goal->nid;
 			break;
 		case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
+		case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
 			err = damon_sysfs_memcg_path_to_id(
 					sysfs_goal->path, &goal->memcg_id);
 			if (err) {
-- 
2.39.5
