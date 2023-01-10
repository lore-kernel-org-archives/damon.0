Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00929A94C
	for <damon@lists.linux.dev>; Tue, 10 Jan 2023 19:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D7DC43396;
	Tue, 10 Jan 2023 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673377445;
	bh=MkYe8RMWo9Dd/HnFB4VyNk02k3Wj59bPhrWvDe74iBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O12DgK0wfvcNXMnpgdQ3CN5XcfJVRvnLXxTk9Tenc6J86A71PWN8smbh8QHn6allC
	 cieg4aoxQAsihNa53VhtzdmoGyYNK7ii4b++GyYCC8+SEUK2nVroFTJtRhlifuN9B6
	 k3JKMOBKw01yt0WYX/k+NOVE96xHBDfQsvj+6enjh62D0MYD9tB1eUwbw8Iq0OAuld
	 u/mImvwo0LKCKcEhdw4QdXUDR15Y6quvIqFKYFORAhOi1B3bSKg+EKLiG5QmPXIctj
	 hwVD9ousWKgOREOvinbJ2UEgyklCRp9pAvqzYSGgiKGqkN7oKOpIprY5BWPWc2nXls
	 /XCndbXdU9Cqg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] mm/damon/core: update kernel-doc comments for DAMOS filters supports of each DAMON operations set
Date: Tue, 10 Jan 2023 19:03:54 +0000
Message-Id: <20230110190400.119388-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110190400.119388-1-sj@kernel.org>
References: <20230110190400.119388-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supports of each DAMOS filter type are up to DAMON operations set
implementation in use, but not well mentioned on the kernel-doc
comments.  Add the comment.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3fa96d7c9fe4..dfb245bb3053 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -227,6 +227,11 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
+ *
+ * The support of each filter type is up to running &struct damon_operations.
+ * &enum DAMON_OPS_PADDR is supporting all filter types, while
+ * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR are not supporting any
+ * filter types.
  */
 enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
-- 
2.25.1

