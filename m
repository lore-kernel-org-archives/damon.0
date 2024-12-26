Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B0E1B415D;
	Thu, 26 Dec 2024 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735251301; cv=none; b=O/bEw9SgTnWAUqIq+F8xJVgKFwSs+LJJb2G3Uy1xGp8UE1NDQ9ylv3CA7C2rq8V1tLH5D3vur5tz+GTfBtsvC41P/ne1fCUTeMeb/JwBN+6bk0yJEvGWWeK8eaAr2itWTKHDpE0FoFqSmXiAP7GSGfMH9hHIkYtIQzYoEJq5yRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735251301; c=relaxed/simple;
	bh=DCAC3zBpwSlEJOxW64cidA0UEg6r7ucuAwa/fXFsTMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Loe4SO+OYGa2PFak/7JaGwyH8lO6LAaCQPn5/8H/Ie/aT0XrCwYyyY/kZroN3rMrVvXjKkW0ulzl515hLPOkRCxtFMd1m+N9fwJrBGuZIESpacEQxIjEAVf9UAxZU5GcHzEYErIKYpB2QNFQWHesFsK/G/SmV/LSMokFczXVsi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTFUat3S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTFUat3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6336C4CEDC;
	Thu, 26 Dec 2024 22:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735251301;
	bh=DCAC3zBpwSlEJOxW64cidA0UEg6r7ucuAwa/fXFsTMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UTFUat3SOgqfEEZJflyn3JCmKPWPiVLSkX5iWTSvS8HbRowJLpHcRXE8CkToU7yng
	 q9LcpJvsRvtAEEM6LOqsAMgcm9JDVwZC7U6E14+p0CwctP/OtYhiwFol5MugS7WPbr
	 n8W+iXE9TRBPEbLOFuiunssyQk65luJPPIEgJyo+b8wxqRIvImB+wxvowRWOF0oqb8
	 7tJD//H7GqLp0Ez6JbFfOCn6CUcbjxvnCYwg2r7qdYjNWjYRiEDmCrbS+UL8Zd4YxD
	 LZHD95G78KCKjZFmkix0ubtZgugm2mjboK4jSlbhQw5V1q/nHhbgq4b2tZ4tacL6fG
	 yrAsNmCBn7Zgg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/10] mm/damon/core: add damos_filter->pass field
Date: Thu, 26 Dec 2024 14:14:37 -0800
Message-Id: <20241226221445.78433-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241226221445.78433-1-sj@kernel.org>
References: <20241226221445.78433-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filters work as only exclusive (block) filters.  This makes it
easy to be confused, and restrictive at combining multiple filters for
various types of memory.

To extend DAMOS filters for inclusion behavior, add a filed to
damos_filter.  Following commits will make the field to decide whether
the filter should work as an exclusive (block) filter, or an inclusive
(pass) filter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 4 +++-
 mm/damon/core.c       | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 15f098372672..122c30e4ce19 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -348,7 +348,8 @@ enum damos_filter_type {
 /**
  * struct damos_filter - DAMOS action target memory filter.
  * @type:	Type of the target memory.
- * @matching:	If the @type-matching memory should be filtered out.
+ * @matching:	Whether this is for @type-matching memory.
+ * @pass:	Whether the memory should pass-through the filter.
  * @memcg_id:	Memcg id of the question if @type is DAMOS_FILTER_MEMCG.
  * @addr_range:	Address range if @type is DAMOS_FILTER_TYPE_ADDR.
  * @target_idx:	Index of the &struct damon_target of
@@ -365,6 +366,7 @@ enum damos_filter_type {
 struct damos_filter {
 	enum damos_filter_type type;
 	bool matching;
+	bool pass;
 	union {
 		unsigned short memcg_id;
 		struct damon_addr_range addr_range;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 52e50f183ffe..e54bd19d6f06 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -275,6 +275,7 @@ struct damos_filter *damos_new_filter(enum damos_filter_type type,
 		return NULL;
 	filter->type = type;
 	filter->matching = matching;
+	filter->pass = false;
 	INIT_LIST_HEAD(&filter->list);
 	return filter;
 }
-- 
2.39.5
