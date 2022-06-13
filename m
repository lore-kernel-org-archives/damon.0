Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBBA7C
	for <damon@lists.linux.dev>; Mon, 13 Jun 2022 19:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43251C341C8;
	Mon, 13 Jun 2022 19:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655148192;
	bh=/ZIOfIXjUyDL/E317WytkrmVVIeFLDByyTBTkw3FhHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQbrkfuor7ndKRkLJR3NUU84zVZPei00GRr2otDJiT+VZlwEryFoOHCX1Syn6t9Xe
	 8oJZnO+PJBBUrPCdzUv8PWssdHiL3vSPi+rOYH1y/sHRyySHTWhGs4oZjVgKlELfip
	 ziKC4IXJ9o+lMKCzodXTrfhm4w38F9ZlbpWSs4rJ32h8Uc5vbUaYWRSQ17NcxjPaQ9
	 ARph6Dsherb3IPwUe7Nh+g/K1qPB0pVoMg5BfE7hiuar8OmAy0tFaQx5YNm8UMDP5Q
	 j8G/4Md/ii7Ni/TvrE3v22zCWouPhR0BzoRkAjiC+m+1jcjbKWHoGwElUnqYzizREd
	 Xd/6ZOkRAY6Vg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] Docs/admin-guide/damon/sysfs: document 'LRU_DEPRIO' scheme action
Date: Mon, 13 Jun 2022 19:22:59 +0000
Message-Id: <20220613192301.8817-8-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613192301.8817-1-sj@kernel.org>
References: <20220613192301.8817-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit documents the 'LRU_DEPRIO' scheme action for DAMON sysfs
interface.`

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index af4e15ee81cd..d822bf6355ce 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -265,6 +265,7 @@ that can be written to and read from the file and their meaning are as below.
  - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``
  - ``nohugepage``: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``
  - ``lru_prio``: Prioritize the region on its LRU lists.
+ - ``lru_deprio``: Deprioritize the region on its LRU lists.
  - ``stat``: Do nothing but count the statistics
 
 schemes/<N>/access_pattern/
-- 
2.25.1

