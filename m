Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E982819BBB
	for <damon@lists.linux.dev>; Fri, 16 Jun 2023 19:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E20C433C0;
	Fri, 16 Jun 2023 19:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686943069;
	bh=LvC4YT4/e0KgspEdK+7PadxzOaV+ZKDN40FmhrIY1TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pjRyPXBjPdmD/CCyo3c/TOJEl8Pc/wVwxfP/HY+a9sa6wUtE1ECgVtVOC0x4Dm/EZ
	 /FBoIRXKO64a0/wO29ZO4g1VWHNl4FtGc08wRZkiCOXa9vgfri7swZffPkGk1mlY4s
	 2bzaL1IeFZdWGH2AtwoG651fSafZC15/aa/H/OTI90JKO07q82eEgVXnqkwvIMkwyx
	 /n8msXEZh2z8+ptNjDMD5vJQRYUOEhjW93jFNuQbPZ9asQRgRXDBuSXDo5EaQsSGQ4
	 l2v9YABAJtr+MjpYWV0t4y8pIOqxzmot/AkRtdU2KHUxTWA3rIuQEx092Tlf8UZpY4
	 nRF+N3RE8K5Ww==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] Docs/admin-guide/mm/damon/start: update DAMOS example command
Date: Fri, 16 Jun 2023 19:17:37 +0000
Message-Id: <20230616191742.87531-3-sj@kernel.org>
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

DAMON user-space tool, damo, has deprecated[1] its old DAMOS schemes
specification format.  However, an example of DAMON documentation is
still using it.  Update the example to use one of the alternative
options.

[1] https://github.com/awslabs/damo/commit/e9950ae68f6c

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/start.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
index 9f88afc734da..7aa0071ff1c3 100644
--- a/Documentation/admin-guide/mm/damon/start.rst
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -119,9 +119,9 @@ set size has chronologically changed.::
 Data Access Pattern Aware Memory Management
 ===========================================
 
-Below three commands make every memory region of size >=4K that doesn't
-accessed for >=60 seconds in your workload to be swapped out. ::
+Below command makes every memory region of size >=4K that has not accessed for
+>=60 seconds in your workload to be swapped out. ::
 
-    $ echo "#min-size max-size min-acc max-acc min-age max-age action" > test_scheme
-    $ echo "4K        max      0       0       60s     max     pageout" >> test_scheme
-    $ damo schemes -c test_scheme <pid of your workload>
+    $ sudo damo schemes --damos_access_rate 0 0 --damos_sz_region 4K max \
+                        --damos_age 60s max --damos_action pageout \
+                        <pid of your workload>
-- 
2.25.1

