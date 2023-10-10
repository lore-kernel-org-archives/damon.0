Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415D6659
	for <damon@lists.linux.dev>; Tue, 10 Oct 2023 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DinnA0mI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F91C433CD;
	Tue, 10 Oct 2023 01:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696901168;
	bh=PRMNaWi4eLwEr1ddca0C6ItteLnRKdFxcFRimSLMbuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DinnA0mIa0xXyxJyvyJPWRn0gfhZL4OuTtZEyU3zDNJ24JTTZMqczCXaW2VxkR2HD
	 9/SCzw1uhvAFQOO25rh75JnffxCNj6eyVIgAoSbetEBVXf7UZoouWyNpUYRhKPVzFL
	 hsXezDNiIK/6jDuO3EJf2XG2trq4vlFHii7KB+umOOp6rlfwtGkO7RikibyFV9WOgB
	 fBwpcMEJb+9ze5Mn8+zY9PMJoZiDp0LrwO/3PNxkdUjxCJ2TVeuVbNIBjl8+upxgTH
	 Mag4Z3w65XlP8fXvzuI0flSiII5ELHCFKiSEEtuzTZqS65EarNJLY/SLDy6g5Xp3Cg
	 LgwoNZvdyVH6Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] Docs/admin-guide/mm/damon/usage: update for tried regions update time interval
Date: Tue, 10 Oct 2023 01:26:00 +0000
Message-Id: <20231010012600.83140-4-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010012600.83140-1-sj@kernel.org>
References: <20231010012600.83140-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation says DAMOS tried regions update feature of DAMON sysfs
interface is doing the update for one aggregation interval after the
request is made.  Since the introduction of the per-scheme apply
interval, that behavior makes no much sense.  Hence the implementation
has changed to update the regions for each scheme for only its apply
interval.  Further update the document to reflect the real behavior.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 8507a6e45d86..da94feb97ed1 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -432,9 +432,9 @@ that reading it returns the total size of the scheme tried regions, and creates
 directories named integer starting from ``0`` under this directory.  Each
 directory contains files exposing detailed information about each of the memory
 region that the corresponding scheme's ``action`` has tried to be applied under
-this directory, during next :ref:`aggregation interval
-<sysfs_monitoring_attrs>`.  The information includes address range,
-``nr_accesses``, and ``age`` of the region.
+this directory, during next :ref:`apply interval <damon_design_damos>` of the
+corresponding scheme.  The information includes address range, ``nr_accesses``,
+and ``age`` of the region.
 
 Writing ``update_schemes_tried_bytes`` to the relevant ``kdamonds/<N>/state``
 file will only update the ``total_bytes`` file, and will not create the
-- 
2.34.1

