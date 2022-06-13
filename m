Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E91D186F
	for <damon@lists.linux.dev>; Mon, 13 Jun 2022 19:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8645C341C6;
	Mon, 13 Jun 2022 19:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655148191;
	bh=VBsgQVJb305tu+x5Ezk9xdnNcUiCg8aWk5S50W2VGCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nwkY5iB/FBsFoMBVuUTRoDxNVkViDcsprfVa78XaY+e7pn0E6ofcJAjKfa3FiTuYV
	 ZAvtKRakoy2Pw1Ka4WbCimxUtoupKTxE20bGydUF+qaBNqxK/oP1M6tGBim0b2riWz
	 cGhqciMQKJiHntWylNAwhcH/oNXNkvpcJEaUyQdEvtpD+RWTJqwYRFItCqj5M5Tkvp
	 UWOf5ZuGcGnRJtioModUaO7SA5r/B+//cRZaUe9JKD4P2fu9GTWgjb33Em7uXhzCx5
	 PkFPWPiOXYDWYA9uKF8XmQkIwVCXFXHp9VlLNw5VW9Szz+j2t5rCRuHGQuxZ3vIWGo
	 32ujOHqyEAA1A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] Docs/admin-guide/damon/sysfs: document 'LRU_PRIO' scheme action
Date: Mon, 13 Jun 2022 19:22:57 +0000
Message-Id: <20220613192301.8817-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613192301.8817-1-sj@kernel.org>
References: <20220613192301.8817-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit documents the 'lru_prio' scheme action for DAMON sysfs
interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 1bb7b72414b2..af4e15ee81cd 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -264,6 +264,7 @@ that can be written to and read from the file and their meaning are as below.
  - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT``
  - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``
  - ``nohugepage``: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``
+ - ``lru_prio``: Prioritize the region on its LRU lists.
  - ``stat``: Do nothing but count the statistics
 
 schemes/<N>/access_pattern/
-- 
2.25.1

