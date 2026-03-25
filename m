Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A03B35FF66
	for <damon@lists.linux.dev>; Wed, 25 Mar 2026 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423851; cv=pass; b=GtgDqOijN4rzpT1ipQ/VHkiywLm7IIm/fAZBkleaKHeHqO7aPdLTkpQnMV9Y3JlgAVvb4Huirnm/QIabok8ZJlvcejvVSQIHjuAxXO1tr3CeaVN8NIa8LDQ2Bor8DdB1FvVJjBmiOERvVu7rCKyQf+U2OZnBVjW2IATSLmTVjTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423851; c=relaxed/simple;
	bh=+4d/k+m5w22u/YvF8HJ7/reHAIlY0ui2S1zdu+6S13Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qRxnUg5cum1EuylxeX8NW4eGOU6CrgaM91C6Rvhq7pU5Ni9NJpfVl+6ls9dJqdqnXJi8HwWhCLWHXNyrgO8rsCDMSVWD/w3PhAMf4Q7MOTRhafVTNjUh0Qr8wpSVHkiaAEeFxNnqeqEtT8Qf0DcJestBtSWqKLw6ucB3eVBsOFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=VBlvPRQO; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="VBlvPRQO"
ARC-Seal: i=1; a=rsa-sha256; t=1774423839; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=RgkZUvzrFXb7IUuxWpYRPPG4sVRS1HxPT41WVuBSgXH8BBsrDEZsPZIYNIWsZXXdmd/IUp/mqpwT8JNX9xim5rnrc4TfikF8qMaVm+60NUg/7JiQdKO6gxUtKnP190dTNmMOTNo7ezzrbsdX5hVC0QXXNIRh+wWN3Jg992GQUxc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774423839; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LRor7oZnl2gk48SOhwpp5bgA4g98rV8TzWVj64hfSy4=; 
	b=b5qmkAZgf+j2gwuvQCZEFmWTJ0XKTiMGv1hqHVwuwudKLvcqRks+GVuj9eCGQFEwBFBGGKolnWJ3KEgT20JXdghxccGdKNNd9kc2Se+kgwSAfmFa5iVYAGcW9Sr9rOtM6n4ZdqsN21B5OjL6bkaR6Q3UiYvzfJCRJ1C6LlFBJh0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774423839;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=LRor7oZnl2gk48SOhwpp5bgA4g98rV8TzWVj64hfSy4=;
	b=VBlvPRQOpyfhT5XN0xWlL9ZblM7oGQNSVZXaTMYjjhCjiqRZ7yqp8mvyVyBt1qKN
	Hhsv7DIsq1t4Uv02iQXdmkZJWfiB1zHszFy2DPgF2L0kh/sXvReVus7wboW0ak+ySYR
	uGWNJzwjcwjw/BG1GdAmiQ8QLwWLew+81csNbMRQ=
Received: by mx.zoho.eu with SMTPS id 1774423836046413.8985698344709;
	Wed, 25 Mar 2026 08:30:36 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH] mm/damon/core: validate goal nid before accessing node data
Date: Wed, 25 Mar 2026 07:30:34 +0000
Message-Id: <20260325073034.140353-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

damos_get_node_mem_bp() and damos_get_node_memcg_used_bp() pass
goal->nid directly to si_meminfo_node() and NODE_DATA() without
checking that it refers to a valid, online NUMA node.  Since
goal->nid is set from userspace via sysfs with no validation, a
negative or out-of-range value causes an out-of-bounds access in
NODE_DATA(), and a valid but offline node gives undefined results.

Add bounds and node_online() checks before using the nid.

Fixes: 0e1c773b501f ("mm/damon/core: introduce damos quota goal metrics for memory node utilization")
Signed-off-by: Josh Law <objecting@objecting.org>
---
 mm/damon/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 59b709f04975..6ee421141996 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2227,6 +2227,10 @@ static __kernel_ulong_t damos_get_node_mem_bp(
 	struct sysinfo i;
 	__kernel_ulong_t numerator;
 
+	if (goal->nid < 0 || goal->nid >= MAX_NUMNODES ||
+	    !node_online(goal->nid))
+		return 0;
+
 	si_meminfo_node(&i, goal->nid);
 	if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
 		numerator = i.totalram - i.freeram;
@@ -2243,6 +2247,10 @@ static unsigned long damos_get_node_memcg_used_bp(
 	unsigned long used_pages, numerator;
 	struct sysinfo i;
 
+	if (goal->nid < 0 || goal->nid >= MAX_NUMNODES ||
+	    !node_online(goal->nid))
+		return 0;
+
 	memcg = mem_cgroup_get_from_id(goal->memcg_id);
 	if (!memcg) {
 		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
-- 
2.34.1

