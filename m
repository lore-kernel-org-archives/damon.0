Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C817A305;
	Thu, 27 Feb 2025 01:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621488; cv=none; b=Y+4xNoTrNEDRS+Ky3x1KKY1Ae7iHbbtPYhEVzg0vD0QU/HVdxDzLaBmoXW2G+L82lTBYWqxbhHk3I3LZG1WztUd6xjppiFvn0jKevQUWfzZx3hdryYDveXjRWr/W5utvRm0Ontw/b9FfouG5t2kQNRxbzVfR55yB3FJb8cZFt84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621488; c=relaxed/simple;
	bh=S9XFinRzq8Qckj8OZ3J96suStAifVelwVdFkfT6lwsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pl8De+r34pl66l0sKkenOuLAIlVDkLzFUQ7NK6sxC1gAv/dvhLC6gu10TsfBZQU7nYMlNlUR3ucmgGXnebeAAz5Kre/jb6rtihRYF0S7SJR9bfUjui4Vt1Fp8ft1R52Ah/mw/ap3XjuM0r85fZh0d1RLmMMVQjQgMFyo+Har0aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFg4aUZp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFg4aUZp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B480AC4CEE9;
	Thu, 27 Feb 2025 01:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740621487;
	bh=S9XFinRzq8Qckj8OZ3J96suStAifVelwVdFkfT6lwsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFg4aUZpcvDAJt0FMFBylM4KTG431Bd2TRJeJRv7JGBWoHnrsuUQdQLRTT84gi0aN
	 jSZn4AmmhGfesBe8je+1OKX9QewD8rGm8sTkaO/ueid/QTNyvwT/+bt/E4+QTn49tA
	 F/24IP1GLwnSIyFU6EZq9BzGAlFDJbaacDr4NPETqZ/0IKg9mthPql3jFwtf3NJiJh
	 6cIwyyXOylr8SoA/vObsNNTb/TsoqtEETIzcj6b/6SQmhJnzD3xykHaiIbr7HlfThh
	 SOyhSqCFz3q+HZKSfR1FkujwGAGN5Pf5yOTLzdgRXwDkOP7mmrJh0MBaBrIl3aOTiK
	 PcaKpNlf9SmUQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 6/9] mm/damon: add default allow/reject behavior fields to struct damos
Date: Wed, 26 Feb 2025 17:57:51 -0800
Message-Id: <20250227015754.38789-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227015754.38789-1-sj@kernel.org>
References: <20250227015754.38789-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current default allow/reject behavior of filters handling stage has made
before introduction of the allow behavior.  For allow-filters usage, it
is confusing and inefficient.

It is more intuitive to decide the default filtering stage allow/reject
behavior as opposite to the last filter's behavior.  The decision should
be made separately for core and operations layers' filtering stages,
since last core layer-handled filter is not really a last filter if
there are operations layer handling filters.

Keeping separate decisions for the two categories can make the logic
simpler.  Add fields for storing the two decisions.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index add82fdc1117..1d8479f57f85 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -497,6 +497,9 @@ struct damos {
 	unsigned long next_apply_sis;
 	/* informs if ongoing DAMOS walk for this scheme is finished */
 	bool walk_completed;
+	/* whether to reject core/ops filters umatched regions */
+	bool core_filters_default_reject;
+	bool ops_filters_default_reject;
 /* public: */
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
-- 
2.39.5
