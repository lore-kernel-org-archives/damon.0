Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC97354ADF;
	Fri, 17 Oct 2025 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736434; cv=none; b=rXc4SxvCLCx+GvWv3SJimkM+bJurQMw9h2VraMHydYyoJG1eviQwmDhOzVmcWw4GW8OiSGsA1OQti5QtJnfE61FdFUvYHi7nLx1goGcFH5XT1kybxidxd4vcIIVaps0NckLeAi8gbLDuc4k18GHmBwBlRS/38+lp0kaAWPFlCqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736434; c=relaxed/simple;
	bh=aLHLz1HJxT2tP86bchmItKLfg1FQG0fbZ+VFjhe7w9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWmA4wU4Ez54DV9Tdsrx1ynB1sEczYkiJFF6wi90OJC58iS3Kf8SyaEhCu4w6mBfU3HAKdeRimzjoctXSrwabRYF4S90vAfHOboCLXk4vaV1bhQ71XNDVGgvme5pJU2LZaiCNtBO9cHmEyGbdO8RHhfXsZNxh1MAdxlSXbrUUXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFC9b+qE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFC9b+qE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29999C4AF09;
	Fri, 17 Oct 2025 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760736434;
	bh=aLHLz1HJxT2tP86bchmItKLfg1FQG0fbZ+VFjhe7w9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tFC9b+qEhqdnWztJkXarAi+NxYFURzOYI1PWHkcRwhVFz7e+OHpN+oCboovEo0yNL
	 mq0k50l7jGzMjUdGkd9ynLOvO7JARmNL+m+kUEa/F+hJ6vPBgfwSHQOAaMekIGTpkW
	 oUkhb07u8Cb4rVqpvKdKKvg9xiuiodLHfBKDNVzHc5pRKJn6At/gFLzKq7ekOFyLwG
	 Z/ahQKFQi2QEwn80N/mtbN1vjSXCPptw7eIWuYK6ZD3eMXTczV65m+KNCUoIbckvTM
	 lwwM50AsLb8azsnzSMbgF0FzemJOAv5/rz05smuuUDVrAyP+n9XFSXaL8Gh4hBkRKr
	 t5JYwcwezfXfA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/10] mm/damon: document damos_quota_goal->nid use case
Date: Fri, 17 Oct 2025 14:26:53 -0700
Message-ID: <20251017212706.183502-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017212706.183502-1-sj@kernel.org>
References: <20251017212706.183502-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_quota_goal kerneldoc comment is not explaining when @metric is
used.  Update the comment for that.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1ce75a20febf..bb92c5f396cf 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -176,6 +176,9 @@ enum damos_quota_goal_metric {
  * If @metric is DAMOS_QUOTA_USER_INPUT, @current_value should be manually
  * entered by the user, probably inside the kdamond callbacks.  Otherwise,
  * DAMON sets @current_value with self-measured value of @metric.
+ *
+ * If @metric is DAMOS_QUOTA_NODE_MEM_{USED,FREE}_BP, @nid represents the node
+ * id of the target node to account the used/free memory.
  */
 struct damos_quota_goal {
 	enum damos_quota_goal_metric metric;
-- 
2.47.3
