Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2754924EAA
	for <damon@lists.linux.dev>; Thu, 25 May 2023 21:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DB8C4339B;
	Thu, 25 May 2023 21:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685051001;
	bh=hVFyQUZN1gcvG6t3Dpq635c426eBMKWXinhJ3HGYh9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGI9nQarh6/dDMgWqzLaHz2tcFxHEP3FNk3dJo770kxOgy8E0LJyKAqlE+8jo5Iz7
	 i1gdU/pd6W2jdEXcJru8gg5rlqj9E45F1fCDuQrxTcO5pnOKEUwGjm+1FkxK4Xje9E
	 rIstQEBLmrKi1/p3JTjltsB0DJRnx+6PTnB7SSxulUpBkLLqNXOof1II5O73QtnHMf
	 Auoe2QSPd8MXvUeutyKUrr57FVkUT9ujcnYjjm0IQ2rChSTKMJk449mIHEOBcc3nII
	 kjX50inG7/9hu/5DIb2MKMSXYvHO+KTXbg3InDmIR6bxFsoDsRhMxBZwGRIivtd4Sc
	 r79YnXhY6S1wg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] Docs/mm/damon/faq: remove old questions
Date: Thu, 25 May 2023 21:43:05 +0000
Message-Id: <20230525214314.5204-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525214314.5204-1-sj@kernel.org>
References: <20230525214314.5204-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first two questions of DAMON faqs have raised when DAMON patches
were first submitted.  More than one year has passed since DAMON patches
get merged in the mainline, and that kind of questions are not asked
nowadays.  Remove the questions.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/faq.rst | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/Documentation/mm/damon/faq.rst b/Documentation/mm/damon/faq.rst
index dde7e2414ee6..3279dc7a8211 100644
--- a/Documentation/mm/damon/faq.rst
+++ b/Documentation/mm/damon/faq.rst
@@ -4,29 +4,6 @@
 Frequently Asked Questions
 ==========================
 
-Why a new subsystem, instead of extending perf or other user space tools?
-=========================================================================
-
-First, because it needs to be lightweight as much as possible so that it can be
-used online, any unnecessary overhead such as kernel - user space context
-switching cost should be avoided.  Second, DAMON aims to be used by other
-programs including the kernel.  Therefore, having a dependency on specific
-tools like perf is not desirable.  These are the two biggest reasons why DAMON
-is implemented in the kernel space.
-
-
-Can 'idle pages tracking' or 'perf mem' substitute DAMON?
-=========================================================
-
-Idle page tracking is a low level primitive for access check of the physical
-address space.  'perf mem' is similar, though it can use sampling to minimize
-the overhead.  On the other hand, DAMON is a higher-level framework for the
-monitoring of various address spaces.  It is focused on memory management
-optimization and provides sophisticated accuracy/overhead handling mechanisms.
-Therefore, 'idle pages tracking' and 'perf mem' could provide a subset of
-DAMON's output, but cannot substitute DAMON.
-
-
 Does DAMON support virtual memory only?
 =======================================
 
-- 
2.25.1

