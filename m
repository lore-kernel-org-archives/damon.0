Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B632910
	for <damon@lists.linux.dev>; Mon,  6 Jun 2022 18:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893D2C3411E;
	Mon,  6 Jun 2022 18:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654539797;
	bh=r7qsMO+KaTvKmkx5mx/GJ+zu6Ys/r3ohlnLftZkA8x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8JnNnOJIAvqeARo2dlT4UcQMZ8rJ//iqmHsfN9M4cIEZNdeAnbFB8CmnMAfD9pFX
	 UiNfXHQmu7cthP9LIT7NVUgYTjwxh/t1hCj4FGG40mXLXdsEZKL/tG0IDH3DTABqP9
	 CShyDuo9w395PBZ9kKneAsphx18R3r5xsL7Hz3jYc/+c3HPRj/ZDn4Qwz2F1SGZdmJ
	 gXzn9ShGWt/0FcDEfnrA+8yjck9sc+THOzP/B3pPNFpv6TjA2w2poz0JKvp/zbN4ma
	 hiDHiL0i65m5+wH4OQR1HgiqbAYaMe2pVD5/GLouer+Z4FjGo3NJNAhsc5AEAY1nRT
	 M1uHWvuJ1/n6g==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: corbet@lwn.net,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/6] Docs/admin-guide/damon/reclaim: remove a paragraph that been obsolete due to online tuning support
Date: Mon,  6 Jun 2022 18:23:05 +0000
Message-Id: <20220606182310.48781-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606182310.48781-1-sj@kernel.org>
References: <20220606182310.48781-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 81a84182c343 ("Docs/admin-guide/mm/damon/reclaim: document
'commit_inputs' parameter") has documented the 'commit_inputs' parameter
which allows online parameter update, but it didn't remove a paragraph
saying the online parameter update is impossible.  This commit removes
the obsolete paragraph.

Fixes: 81a84182c343 ("Docs/admin-guide/mm/damon/reclaim: document 'commit_inputs' parameter")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/reclaim.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 46306f1f34b1..6510baa91109 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -48,12 +48,6 @@ DAMON_RECLAIM utilizes module parameters.  That is, you can put
 ``damon_reclaim.<parameter>=<value>`` on the kernel boot command line or write
 proper values to ``/sys/modules/damon_reclaim/parameters/<parameter>`` files.
 
-Note that the parameter values except ``enabled`` are applied only when
-DAMON_RECLAIM starts.  Therefore, if you want to apply new parameter values in
-runtime and DAMON_RECLAIM is already enabled, you should disable and re-enable
-it via ``enabled`` parameter file.  Writing of the new values to proper
-parameter values should be done before the re-enablement.
-
 Below are the description of each parameter.
 
 enabled
-- 
2.25.1

