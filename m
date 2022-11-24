Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100AF79EC
	for <damon@lists.linux.dev>; Thu, 24 Nov 2022 21:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67664C433D7;
	Thu, 24 Nov 2022 21:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669324881;
	bh=ew0j918CPCZ3BCkCfl4ilV0ZC0sdlaLXkkNEQyNFiwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJmT6SE5SJA1ZiuoIDKQK7YvF+WpstqdQXLA2OAwmGzcllHfgqeMqHBQmw3fIDzBh
	 6/4db/iEOf/VXaVubqIXasXS+XfUwUpC4hIG+yryfKETPVmo/SatiMQHssPRl9LxF2
	 HHd3aXxHc66tRm4Hs6ZmhQOYs/W4WRl81HNoyDx1kjhPKt9XkO4VkR0oxIeARx/ZWT
	 p2w5sT7EmdFs/6tgNZtVwDDM4WtHoRa1vgujGujBRqBqfAZPEbQYUczoRmlOng9tL9
	 sU3WWusdLWjBWHoAb2N8MZqjiUK1cv71Jw3MesaBo1Rvo7NslMPD8xh+SrC+xjOStS
	 u3xZsD3pP/T2g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH 04/11] Docs/admin-guide/damon/reclaim: document 'skip_anon' parameter
Date: Thu, 24 Nov 2022 21:21:07 +0000
Message-Id: <20221124212114.136863-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124212114.136863-1-sj@kernel.org>
References: <20221124212114.136863-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the newly added 'skip_anon' parameter of DAMON_RECLAIM, which
can be used to avoid anonymous pages reclamation.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/reclaim.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 4f1479a11e63..ff335e96e0d8 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -205,6 +205,15 @@ The end physical address of memory region that DAMON_RECLAIM will do work
 against.  That is, DAMON_RECLAIM will find cold memory regions in this region
 and reclaims.  By default, biggest System RAM is used as the region.
 
+skip_anon
+---------
+
+Skip anonymous pages reclamation.
+
+If this parameter is set as ``Y``, DAMON_RECLAIM does not reclaim anonymous
+pages.  By default, ``N``.
+
+
 kdamond_pid
 -----------
 
-- 
2.25.1

