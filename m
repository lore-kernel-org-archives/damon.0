Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B864ABA4F
	for <damon@lists.linux.dev>; Wed, 30 Nov 2022 20:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F02C4314A;
	Wed, 30 Nov 2022 20:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669838988;
	bh=wsgdvbT/35uxHZu2m3onVtLPaAGvmOTx9y/8CzTLOOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JsatvoLDGeust/Jc03yigWF7AvQ4atAVKdWFKmE0dNZWBmpzz9ZHKZE4BvRsHU9Fi
	 aV7fgIgKo9O+fZIG0rh8nbbzE71dMlsVwQPPORO4oVbGXRx0r7IapuM6n4aC4pHszS
	 9IikxmcflQtlRhbJ55u2cAJ3LARyqvHi3/Z4oQ/D31HNWPpGBZ4Ldjo1ZJ2W/Db0Nz
	 82U+K1uZf+ifNulP0brCg3y9wejFhyh+XGQMM6SobcVMsN/TEgHvpL1k6ANkAIVSQw
	 R0Qngx7chuYTIL2suKnj5btccse85/tHNBxifStrsSfPI4F9FPSsrMZZMwlTR6SGd4
	 2xoJ99lIMtsBA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH v2 11/11] Docs/ABI/damon: document scheme filters files
Date: Wed, 30 Nov 2022 20:09:37 +0000
Message-Id: <20221130200937.118005-12-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130200937.118005-1-sj@kernel.org>
References: <20221130200937.118005-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document newly added DAMON sysfs interface files for DAMOS filtering on
the DAMON ABI document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 13397b853692..2744f21b5a6b 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -258,6 +258,35 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the low
 		watermark of the scheme in permil.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/nr_filters
+Date:		Dec 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for setting filters of the scheme named '0' to
+		'N-1' under the filters/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/type
+Date:		Dec 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the type of
+		the memory of the interest.  'anon' for anonymous pages, or
+		'memcg' for specific memory cgroup can be written and read.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/memcg_path
+Date:		Dec 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	If 'memcg' is written to the 'type' file, writing to and
+		reading from this file sets and gets the path to the memory
+		cgroup of the interest.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/matching
+Date:		Dec 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing 'Y' or 'N' to this file sets whether to filter out
+		pages that do or do not match to the 'type' and 'memcg_path',
+		respectively.  Filter out means the action of the scheme will
+		not be applied to.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_tried
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.25.1

