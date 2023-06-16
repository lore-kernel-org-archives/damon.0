Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAD01DDDB
	for <damon@lists.linux.dev>; Fri, 16 Jun 2023 19:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05F0C433AD;
	Fri, 16 Jun 2023 19:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686943070;
	bh=/PqkZzi3PmcfmmQ2ShVZNSPJIc3ayquVqki2elLWBA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYrW9cm+OeRlKwfHbXjV7uGo3r6/53L5aXiZpIgz9CbhooZv0svdwy3KG+3gjDviP
	 g600JjZC6WGUBJ8Ao8i1vOS2ef8fe5HL8Lo09xnPJqvawnLxGJ0BNLOdtS2DU8XbFO
	 rqsM6NTwxkupSgRKVY5wiICRb1Xm/+peHg+PaUjmquV+CCNy1GffAX0B36347W3rEt
	 tkj2wQOlIH3EAfsXY2L5KW01rNcwYCBJ1DrsIa8IR8iB9m6goXGF9JtfflAE03appl
	 8ESApdmB5BaL1YQ73WzP13I0NNPwX5dIBNRYbPkB5AZ2NX3r2rQJFZxQRBzVvRigjw
	 94cP3Y9asSwhg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] Docs/admin-guide/mm/damon/usage: fix typos in references and commas
Date: Fri, 16 Jun 2023 19:17:38 +0000
Message-Id: <20230616191742.87531-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616191742.87531-1-sj@kernel.org>
References: <20230616191742.87531-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos including a unnecessary comma and incomplete ':ref:' keywords.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 9b823fec974d..d2435dcc22f4 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -139,7 +139,7 @@ scheme of the kdamond.  Writing ``clear_schemes_tried_regions`` to ``state``
 file clears the DAMON-based operating scheme action tried regions directory for
 each DAMON-based operation scheme of the kdamond.  For details of the
 DAMON-based operation scheme action tried regions directory, please refer to
-:ref:tried_regions section <sysfs_schemes_tried_regions>`.
+:ref:`tried_regions section <sysfs_schemes_tried_regions>`.
 
 If the state is ``on``, reading ``pid`` shows the pid of the kdamond thread.
 
@@ -282,7 +282,7 @@ memory regions having specific access pattern of the interest.  The keywords
 that can be written to and read from the file and their meaning are as below.
 
 Note that support of each action depends on the running DAMON operations set
-`implementation <sysfs_contexts>`.
+:ref:`implementation <sysfs_contexts>`.
 
  - ``willneed``: Call ``madvise()`` for the region with ``MADV_WILLNEED``.
    Supported by ``vaddr`` and ``fvaddr`` operations set.
@@ -432,8 +432,7 @@ starting from ``0`` under this directory.  Each directory contains files
 exposing detailed information about each of the memory region that the
 corresponding scheme's ``action`` has tried to be applied under this directory,
 during next :ref:`aggregation interval <sysfs_monitoring_attrs>`.  The
-information includes address range, ``nr_accesses``, , and ``age`` of the
-region.
+information includes address range, ``nr_accesses``, and ``age`` of the region.
 
 The directories will be removed when another special keyword,
 ``clear_schemes_tried_regions``, is written to the relevant
-- 
2.25.1

