Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336E23F434;
	Sun, 29 Jun 2025 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751228093; cv=none; b=m+aSwdRlFuXy0n6BsyODJkV0aMBrkt9SJQocSqtnG/3kEpZ9ReSgk+R+UVy8tSXq/8SSG/WPO2uEHPpb34oqZ3BfdjS/xhLxfxstsz/B8KsUvQqDelHBO3e4F+uYCIWJqjJpi6jtYwEjFr738+/bm1i5CiIE+PyPGVyychvqJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751228093; c=relaxed/simple;
	bh=+xY45ARCwqOrqcwUKSao5lMG0pp6ebXpZJN+oBjPmsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EvJGjGztP+Psw0AP3PKTNKsRH81A7z0P+e7pM03/5HxNS+sZWmytLzd8DAgK9CjKbCk2Gy/U0D/DJhLR5LFZioOuSmuv71k+2N4M95k4xlCb+VuF4vCphR2CEDb9XZUiI6MCl42fhtJ2lZOf9HcFQmYBFB24ubzrmpxsuzFenPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDScZksg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDScZksg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EFAC4CEEF;
	Sun, 29 Jun 2025 20:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751228092;
	bh=+xY45ARCwqOrqcwUKSao5lMG0pp6ebXpZJN+oBjPmsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDScZksg15rxir5Ww+HYRRdG+O7S6h/fAfriR9yeBLWKpn4QdQMtWmvu6DH+HI+O4
	 OkjGWlFBRGjdTA3wICFeOTXrtpCtheKGnk/STJZ1+tF1yOWtbv2iw9lJWjtdRS+Vxs
	 O6Tsez+l1cu6NnRir8S+87ZZov6mmA+LmQmSrTN2D9gAfHmTmfPwm09PYPTu+PfdTm
	 AUwq4nPWthRiceIezjrEVg72nuXe8W9A6sKvzzCY/6oMz86r2H4FYkbyuAxWQOn3QA
	 X0vxeYlWCxv8LOqYFx6dR9zTQXOQkR7lG35a/1MvzbHdZOSEsntGiikkiU4p+tVCU7
	 K8XLF4kEVrjSQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/6] mm/damon: add write field to damon_access_report
Date: Sun, 29 Jun 2025 13:14:43 -0700
Message-Id: <20250629201443.52569-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250629201443.52569-1-sj@kernel.org>
References: <20250629201443.52569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit is for showing the first part of the idea for implementing
write-only access monitoring.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 29223fea710f..bd5e3287f6f2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -112,6 +112,7 @@ struct damon_target {
  * @size:		The size of the reporting region.
  * @nr_accesses:	Number of detected accesses to the region.
  * @node_id:		NUMA node that made the access.
+ * @write:		Whether the access is write.
  *
  * @pid could be stale, and hence shouldn't be de-referenced.
  */
@@ -121,6 +122,7 @@ struct damon_access_report {
 	unsigned long size;
 	int nr_accesses;
 	int node_id;
+	bool write;
 /* private: */
 	unsigned long report_jiffies;	/* when this report is made */
 };
-- 
2.39.5
