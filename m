Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC957480
	for <damon@lists.linux.dev>; Tue, 10 Jan 2023 19:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFFFC433F0;
	Tue, 10 Jan 2023 19:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673377447;
	bh=z4OiBFIdAY53y3j04vvpLGBRlRRZlDz1MLs91H9dWgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RLd4J3G76wYwVxSsaSIQPTKHrZbFVa3HMM1Gckqux+XKZcOj5l6ii9Jr0d5ojGaYb
	 OaFXjgnAYAadqc1LQMKbr/wchU1RcH/S5srEO9WUXaQJQPM+kREfCpLLSMiLMLYf3H
	 gDzFMCliEdHfnyVRMgNQz+xK5d0pqnAsKfUIEaT+Oexsy/K2x/qwH49JiW/wPCMoxr
	 9g8XpPSA1eSKwJO0CRhxv0rQ6oyzoFAibgVTGMFfGM+PwtytiJ2AY9IwPuYNlmbuFX
	 2fNEHHLpNzidac6lxcf3Yjhk5+923fksLblXxOfMoVoZtpzL1pk4Nnk8j+L3HhS2GP
	 J9X688D+f9i7Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] Docs/admin-guide/mm/damon/usage: update DAMOS actions/filters supports of each DAMON operations set
Date: Tue, 10 Jan 2023 19:03:56 +0000
Message-Id: <20230110190400.119388-5-sj@kernel.org>
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

Supports of each DAMOS action and filters are up to DAMON operations set
implementation, but it's not mentioned in detail on the documentation.
Update the information on the usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 41 +++++++++++++-------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 3d82ca6a17ff..9237d6a25897 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -279,14 +279,25 @@ The ``action`` file is for setting and getting what action you want to apply to
 memory regions having specific access pattern of the interest.  The keywords
 that can be written to and read from the file and their meaning are as below.
 
- - ``willneed``: Call ``madvise()`` for the region with ``MADV_WILLNEED``
- - ``cold``: Call ``madvise()`` for the region with ``MADV_COLD``
- - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT``
- - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``
- - ``nohugepage``: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``
+Note that support of each action depends on the running DAMON operations set
+`implementation <sysfs_contexts>`.
+
+ - ``willneed``: Call ``madvise()`` for the region with ``MADV_WILLNEED``.
+   Supported by ``vaddr`` and ``fvaddr`` operations set.
+ - ``cold``: Call ``madvise()`` for the region with ``MADV_COLD``.
+   Supported by ``vaddr`` and ``fvaddr`` operations set.
+ - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT``.
+   Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
+ - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``.
+   Supported by ``vaddr`` and ``fvaddr`` operations set.
+ - ``nohugepage``: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``.
+   Supported by ``vaddr`` and ``fvaddr`` operations set.
  - ``lru_prio``: Prioritize the region on its LRU lists.
+   Supported by ``paddr`` operations set.
  - ``lru_deprio``: Deprioritize the region on its LRU lists.
- - ``stat``: Do nothing but count the statistics
+   Supported by ``paddr`` operations set.
+ - ``stat``: Do nothing but count the statistics.
+   Supported by all operations sets.
 
 schemes/<N>/access_pattern/
 ---------------------------
@@ -388,8 +399,8 @@ pages of all memory cgroups except ``/having_care_already``.::
     echo /having_care_already > 1/memcg_path
     echo N > 1/matching
 
-Note that filters could be ignored depend on the running DAMON operations set
-`implementation <sysfs_contexts>`.
+Note that filters are currently supported only when ``paddr``
+`implementation <sysfs_contexts>` is being used.
 
 .. _sysfs_schemes_stats:
 
@@ -618,11 +629,15 @@ The ``<action>`` is a predefined integer for memory management actions, which
 DAMON will apply to the regions having the target access pattern.  The
 supported numbers and their meanings are as below.
 
- - 0: Call ``madvise()`` for the region with ``MADV_WILLNEED``
- - 1: Call ``madvise()`` for the region with ``MADV_COLD``
- - 2: Call ``madvise()`` for the region with ``MADV_PAGEOUT``
- - 3: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``
- - 4: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``
+ - 0: Call ``madvise()`` for the region with ``MADV_WILLNEED``.  Ignored if
+   ``target`` is ``paddr``.
+ - 1: Call ``madvise()`` for the region with ``MADV_COLD``.  Ignored if
+   ``target`` is ``paddr``.
+ - 2: Call ``madvise()`` for the region with ``MADV_PAGEOUT``.
+ - 3: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``.  Ignored if
+   ``target`` is ``paddr``.
+ - 4: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``.  Ignored if
+   ``target`` is ``paddr``.
  - 5: Do nothing but count the statistics
 
 Quota
-- 
2.25.1

