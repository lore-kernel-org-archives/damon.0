Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF0B2874E6;
	Sat, 28 Mar 2026 00:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774659256; cv=none; b=bzX6AmgCDpIbQHvwg3Tx+8d0wIkEExKK9FSYCjRGuTgtwRTOv1U+Oq/nSZgAuh+Qb+k0ZhmI7L1yGVL7LUteC6QHkXBo2eP++Tfqj+93Bjy0JVN3TWHwtFKdquyOeSYaF1385SEZZk/jFXJ0Kb/y7oZpbaDNvp6KG71d3+rO1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774659256; c=relaxed/simple;
	bh=xj+qGE0/+xoZp0bbzzefLJA/Ga+imeoh2utC1fQRZVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPASH+EWY23kY+oa48wB2rjup82nsRY0PVmGZ2zBGripeJcvfFgmPsBj1lkDT6Sw1Ub/O+SbMjSbFuy5JmX4wcyJ9fLx6+XvSR20N+QmAx5FmYvwAj7Xq/aXzcwam/SlvldVwvkt01vGSVpWrB+jGBJ2tg00IRnQfFAI6cGqO7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbxFGJ/1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbxFGJ/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FE2C2BCB1;
	Sat, 28 Mar 2026 00:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774659256;
	bh=xj+qGE0/+xoZp0bbzzefLJA/Ga+imeoh2utC1fQRZVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KbxFGJ/1VvEfifuvXF9eb1wOC09YVBuwaq71eXVjuyBkPpR+mxbz473h7tddXueDU
	 DsMDGMk+EcOvrQa3ni0cXa602tIVOYGiRHUdJEPJ6XQKJxQ+BVbuTDhmBsej/Evzlv
	 u+aijzLWeUhVf+Iujs22FYhn3bxDGelB5WdaDvOY7MdEIxLv3YVPBTzNmyuNQpOwy8
	 Tw/l6titFFHfPgyHP3uCTo+jDEwQ0xH73xyrEozwVx5iCcS6Jz6nfBRtZY1NUKbGvx
	 qAkrqSJLKIn9NO50PmECP6W+VsWhHRf1dfEVgbk93UVvJt41iRYcclgGOX3RA6DXCV
	 prv6UP89Wp3CQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 19 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/2] mm/damon/core: validate damos_quota_goal->nid for node_memcg_{used,free}_bp
Date: Fri, 27 Mar 2026 17:54:10 -0700
Message-ID: <20260328005412.7606-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328005412.7606-1-sj@kernel.org>
References: <20260328005412.7606-1-sj@kernel.org>
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
index 9a848d7647ef..3298ee8d8f64 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2251,6 +2251,13 @@ static unsigned long damos_get_node_memcg_used_bp(
 	unsigned long used_pages, numerator;
 	struct sysinfo i;
 
+	if (invalid_mem_node(goal->nid)) {
+		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
+			return 0;
+		else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
+			return 10000;
+	}
+
 	memcg = mem_cgroup_get_from_id(goal->memcg_id);
 	if (!memcg) {
 		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
-- 
2.47.3
