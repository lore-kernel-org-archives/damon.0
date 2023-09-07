Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2FA29
	for <damon@lists.linux.dev>; Thu,  7 Sep 2023 02:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71ABC433C9;
	Thu,  7 Sep 2023 02:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694053778;
	bh=+IqrUHwg2Fad6cIIwKzoX0FcbTzdrwz+hio0MOPrv5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AsOlxP5a2voHFqvcPXAprrlsyv3GaIQgNIogoaQ4+Hmsfl/P8G7laywwqsD3jEOt2
	 gdwGsJwzcfQbKU+LiCOw4he3yX1Uwy/hSjOMt4r6BkQqwZpdjo74Mfk3njTwNdGPgY
	 hrLRQBbiAo9XZvp6VU1rvKAp5+hTF2Vk+PWz9zhnJFgON14NW2o0aG/Hnz38HRXEks
	 9FEyjNy+rO8BUMugU0TM93xwBKB2MmRBlMgYlgJ+q7Rp43OOVwTP/Az2crLmw0Sb/m
	 SZ3oLq0US685pFT1kaBvWoLHhVrRtzbyuyhjMHplJLIUS4c5sWdpbN3WaYeNCMJd3y
	 ydV0f5sQAeJsA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] Docs/admin-guide/mm/damon/usage: fixup missed :ref: keyword
Date: Thu,  7 Sep 2023 02:29:19 +0000
Message-Id: <20230907022929.91361-2-sj@kernel.org>
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

A cross-link reference in DAMON usage document is missing ':ref:' Sphynx
keyword.  Fix it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 8da1b7281827..834eefe39650 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -392,7 +392,7 @@ pages of all memory cgroups except ``/having_care_already``.::
     echo N > 1/matching
 
 Note that ``anon`` and ``memcg`` filters are currently supported only when
-``paddr`` `implementation <sysfs_contexts>` is being used.
+``paddr`` :ref:`implementation <sysfs_contexts>` is being used.
 
 Also, memory regions that are filtered out by ``addr`` or ``target`` filters
 are not counted as the scheme has tried to those, while regions that filtered
-- 
2.25.1

