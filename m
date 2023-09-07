Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8464A47
	for <damon@lists.linux.dev>; Thu,  7 Sep 2023 02:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0184BC433C7;
	Thu,  7 Sep 2023 02:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694053780;
	bh=EttCSXcWQaBCLpMduSaDVf+bO6xFKw8ChvQvuGULuQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohoS0Q5NTqWvbTzBXP57Dq2ofbn2QBljXe1cpT6j4lRuQzRB3V3WC0/jjWNW9zKsh
	 Pj0L+aNe9DpvOK+7f35EDNXepLHd2afINFwGotsGZrvFObI/8v0cnnEYpBOI2JUYmH
	 /zr4DyQSRbrTK5dB2xtxZlxJVBO3UwjdbgcXEKRHJ7oe+HD6kjIPk8WJR4qzpiLMez
	 orXkcK9BjJfpw0WtGMGlpGtkR3tkbB/jErb9/Dcmbg7Npz4s11Z0ecchpXsRgN5L5M
	 t0gpXfrIaxSegMGSQeogKMEwEIC3I5l9+WKq0T+o70jZ9Bez1OALFBaPB6txHNOCkN
	 ks7bnKiPNy1Vg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] Docs/mm/damon/design: explicitly introduce ``nr_accesses``
Date: Thu,  7 Sep 2023 02:29:22 +0000
Message-Id: <20230907022929.91361-5-sj@kernel.org>
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

The design document is explaining about the access tracking mechanism
and the access rate counter (nr_accesses), but not directly mentions the
name.  Add a sentence for making it clear.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index a20383d01a95..5c465835a44f 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -163,9 +163,10 @@ assumption (pages in a region have the same access frequencies) is kept, only
 one page in the region is required to be checked.  Thus, for each ``sampling
 interval``, DAMON randomly picks one page in each region, waits for one
 ``sampling interval``, checks whether the page is accessed meanwhile, and
-increases the access frequency of the region if so.  Therefore, the monitoring
-overhead is controllable by setting the number of regions.  DAMON allows users
-to set the minimum and the maximum number of regions for the trade-off.
+increases the access frequency counter of the region if so.  The counter is
+called ``nr_regions`` of the region.  Therefore, the monitoring overhead is
+controllable by setting the number of regions.  DAMON allows users to set the
+minimum and the maximum number of regions for the trade-off.
 
 This scheme, however, cannot preserve the quality of the output if the
 assumption is not guaranteed.
-- 
2.25.1

