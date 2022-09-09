Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBF7612F
	for <damon@lists.linux.dev>; Fri,  9 Sep 2022 20:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7546BC43144;
	Fri,  9 Sep 2022 20:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662755347;
	bh=+JPntM3lX5pH/5fi2+GQ8i2rNQKTll5DPTLZEASzM9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWHwek/Szye5DMLzBFmaPxtUn4ezlwepsaKQUmZykk41j2zyTUWB/FJwtO72P6mbZ
	 CFs/U2+NGnBAR+Eet5xyVkWza3COoCYw6TgIT4ZpjNYkW0tbAbQShh1Hoy59TkM2++
	 /LDNn5T/aqtQwujshahWDYnQAvf76wneXL3UNoKSDqfutw5k74Sge3jy9ii3auJl/4
	 VYHk/MrYQm0cqRzS9vrog33f3RWb5p+wlC48z3BhkJHH0c5W+Y3T5ksuyjrjsuF6Uu
	 4ngGdeMzEI1QBrRYKKjxLbS/8dWrU3k0AqJf+N/L/uBZFc8oYqkQkZhGLfKQADaQKP
	 m+Y65rnv1CMqA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 4/7] Docs/admin-guide/mm/damon: rename the title of the document
Date: Fri,  9 Sep 2022 20:28:58 +0000
Message-Id: <20220909202901.57977-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909202901.57977-1-sj@kernel.org>
References: <20220909202901.57977-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The title of the DAMON document for admin-guide, 'Monitoring Data
Accesses', could confuse readers in some ways.  First of all, DAMON is
not the only single way for data access monitoring.  And the document is
for not only the data access monitoring but also data access pattern
based memory management optimizations (DAMOS).  This commit updates the
title to 'DAMON: Data Access MONitor', which more explicitly explains
what the document describes.

Fixes: c4ba6014aec3 ("Documentation: add documents for DAMON")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/index.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/index.rst b/Documentation/admin-guide/mm/damon/index.rst
index 05500042f777..33d37bb2fb4e 100644
--- a/Documentation/admin-guide/mm/damon/index.rst
+++ b/Documentation/admin-guide/mm/damon/index.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-========================
-Monitoring Data Accesses
-========================
+==========================
+DAMON: Data Access MONitor
+==========================
 
 :doc:`DAMON </mm/damon/index>` allows light-weight data access monitoring.
 Using DAMON, users can analyze the memory access patterns of their systems and
-- 
2.25.1

