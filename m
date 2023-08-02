Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5BF134AB
	for <damon@lists.linux.dev>; Wed,  2 Aug 2023 21:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92052C433C9;
	Wed,  2 Aug 2023 21:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691012600;
	bh=0npm47qE7mM3V04g26fYupZB0KuQfvcIrbkch6jch58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DmuvGpQGlAkUw9hAqOZXqKjRKwBsAsxuCPkSHgm3kIYifPfLVO8FNIUzDNc0uD73H
	 T2bNTn8jozkgprT0X4+pUyK4KHv5/i/rCTnZ5ZNvSDKiGsTwE+/VopQNhY15M1vXzo
	 HVlFk0wPQygfnrmkrsbp0AlO7ROtpMId1UtWLbaeuX48W2/Zo2wcsLHJwxkPNew9Ul
	 NR/JuPLAV/rjcCR5zCCzk8ohmpZm4BA/mdMSi7G4f7r2JRvO2Ki+EG/KPdskeYJz9s
	 oQJjc9Q5Uq6DZv+iMiYuBJkS0fS3AyLf+dplficscCvhTwev1ZKXzRzcTv5YcRmW/+
	 vc8M30ajpgunw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] Docs/ABI/damon: update for address range DAMOS filter
Date: Wed,  2 Aug 2023 21:43:05 +0000
Message-Id: <20230802214312.110532-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802214312.110532-1-sj@kernel.org>
References: <20230802214312.110532-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for address ranges type DAMOS filter files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 3d9aaa1cafa9..0bc074d4618c 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -271,8 +271,9 @@ What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/
 Date:		Dec 2022
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the type of
-		the memory of the interest.  'anon' for anonymous pages, or
-		'memcg' for specific memory cgroup can be written and read.
+		the memory of the interest.  'anon' for anonymous pages,
+		'memcg' for specific memory cgroup, or 'addr' for address range
+		(an open-ended interval) can be written and read.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/memcg_path
 Date:		Dec 2022
@@ -281,6 +282,21 @@ Description:	If 'memcg' is written to the 'type' file, writing to and
 		reading from this file sets and gets the path to the memory
 		cgroup of the interest.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/addr_start
+Date:		Jul 2023
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	If 'addr' is written to the 'type' file, writing to or reading
+		from this file sets or gets the start address of the address
+		range for the filter.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/addr_end
+Date:		Jul 2023
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	If 'addr' is written to the 'type' file, writing to or reading
+		from this file sets or gets the end address of the address
+		range for the filter.
+
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/matching
 Date:		Dec 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.25.1

