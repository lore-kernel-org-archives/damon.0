Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA0AA29
	for <damon@lists.linux.dev>; Thu,  7 Sep 2023 02:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ADAC433C8;
	Thu,  7 Sep 2023 02:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694053784;
	bh=4wgatm5vkHkhu7CH7xqyyNlcb3rmypBu/L3jao8ltp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XawgFLeBMRtYOs3eZvOrynqaYFsNYcVhLx4gCHHw8pi43JQBD3uHXY0KkhiTqaGT7
	 mNsMft8lIeEKWffka38pyw/THuXrqBK9lCxF7GSU53urAFxBy2e34GMG46ha2dtpJk
	 A2qUWz0p0c1Q56x5p1kfVqwyGYYN2kW5IlP34dX80TZprJO/+HIeMH2b3NtgDi29EH
	 CsivVUHp0QpYal2v7rLUMXrU+cryg6NOrdV6gUSkozYykti4rRyRVLSSjW8+u8m5H5
	 /NpzEaSnWhhuGqCXSw2hRbt++8Ez7+7o1gHUHZTiUEG946PnOUZkO8cEQ1zk+23TlQ
	 omATik1sdthtw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] mm/damon/core: remove duplicated comment for watermarks-based deactivation
Date: Thu,  7 Sep 2023 02:29:28 +0000
Message-Id: <20230907022929.91361-11-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907022929.91361-1-sj@kernel.org>
References: <20230907022929.91361-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment for explaining about watermarks-based monitoring part
deactivation is duplicated in two paragraphs.  Remove one.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 266f92b34dd2..ab3089de1478 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -317,9 +317,6 @@ struct damos_access_pattern {
  * monitoring context are inactive, DAMON stops monitoring either, and just
  * repeatedly checks the watermarks.
  *
- * If all schemes that registered to a &struct damon_ctx are inactive, DAMON
- * stops monitoring and just repeatedly checks the watermarks.
- *
  * Before applying the &action to a memory region, &struct damon_operations
  * implementation could check pages of the region and skip &action to respect
  * &filters
-- 
2.25.1

