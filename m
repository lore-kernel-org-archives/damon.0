Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C562127A133;
	Sun, 29 Mar 2026 04:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774759145; cv=none; b=oNfpBPILFhShaR2lVdpIUBMDZhZkdOdg0Ac2PboYwvf2niddHdIo1J6YOf+7HWa3kGKq4xUdvqI8Ksz9QFBYhDDlztNgHo+ToyRPLwqCQ+cu+m2AJiWY9+7tPLz0QLwOSWbFzekL43sFgTir5sP2OOTCzlNd49x+hq4OaGerudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774759145; c=relaxed/simple;
	bh=ttX/WBJeOO5bV2yGUUqpXlkbrsRo8Ww/CGazpxwYkZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Te+Yt+FwLIBlGP1Tw3hwkQx94E4vL4ZCNV1SRKC2yjuiZA20DuxIfko1Vd4bfL3EVxJeH0KYvyDIs+qdfpaDBqodKw06yisZhZDhabILdjPx5YfnvnqUxwcHvlQi7D88H0/UbUh/ieVvcDpcMsU7GL7G67eZuQ3SSOjHy6JZdxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XChBkQOo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XChBkQOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF28C2BCB3;
	Sun, 29 Mar 2026 04:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774759145;
	bh=ttX/WBJeOO5bV2yGUUqpXlkbrsRo8Ww/CGazpxwYkZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XChBkQOonLLysPpNeMwNXE8rqDIpdxSGiWEmDkwSQvYrS1hRMVTt+XXymvGrq7JcL
	 1gmDVKLtsPesEATjEVqiTBB+zZxj1BLcvV3bPYR+BydOIUIRXH72D5pdRBwd6zm7Ug
	 xduSvbtfgw/DDE+cUBPkwgHr6IwSQgENSBL8C5/Jv+zAqe3dygpBB+FcVdmTda/kGF
	 CUDREzx7OEQqe1J3sD1vcLe2zMNn9wR5S3CDdeOjmRYuyZ/YHz2ij1zDI5Gi8642pv
	 hq/eCRYGLPkwZOhum6a5+z+IhdA/mEJR2OAYghdO2G4k3gbFGoyR1wrzFQLKveAFYx
	 7BywCQfdX1oAA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 19 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] mm/damon/core: validate damos_quota_goal->nid for node_memcg_{used,free}_bp
Date: Sat, 28 Mar 2026 21:39:00 -0700
Message-ID: <20260329043902.46163-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329043902.46163-1-sj@kernel.org>
References: <20260329043902.46163-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users can set damos_quota_goal->nid with arbitrary value for
node_memcg_{used,free}_bp.  But DAMON core is using those for
NODE-DATA() without a validation of the value.  This can result in out
of bounds memory access.  The issue can actually triggered using DAMON
user-space tool (damo), like below.

    $ sudo mkdir /sys/fs/cgroup/foo
    $ sudo ./damo start --damos_action stat --damos_quota_interval 1s \
            --damos_quota_goal node_memcg_used_bp 50% -1 /foo
    $ sudo dmseg
    [...]
    [  524.181426] Unable to handle kernel paging request at virtual address 0000000000002c00

Fix this issue by adding the validation of the given node id.  If an
invalid node id is given, it returns 0% for used memory ratio, and 100%
for free memory ratio.

Fixes: b74a120bcf50 ("mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_USED_BP")
Cc: <stable@vger.kernel.org> # 6.19.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9a848d7647ef..19642c175568 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2251,6 +2251,13 @@ static unsigned long damos_get_node_memcg_used_bp(
 	unsigned long used_pages, numerator;
 	struct sysinfo i;
 
+	if (invalid_mem_node(goal->nid)) {
+		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
+			return 0;
+		else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
+			return 10000;
+	}
+
 	memcg = mem_cgroup_get_from_id(goal->memcg_id);
 	if (!memcg) {
 		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
-- 
2.47.3
