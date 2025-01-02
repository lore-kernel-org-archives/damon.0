Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50381B6D1F;
	Thu,  2 Jan 2025 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844510; cv=none; b=OVKKA5CIryG864/jiXexBZPqpp64vdCnBBqqsPe4gIGfYhn9PecRhHJtBOum+kTv4wdS4zJ7p3livlleRApCcjxCCt9OpE4D1SyPZQj0jM/clvl1Ebqf91DmQBDtUmsaA+l4Ix8T8YAWuo98gGT3pn1Gr0g24kSVohh2DH0RjSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844510; c=relaxed/simple;
	bh=aWAtO/ukWuo+Gw+e1jsTvL0mxpCCcaLZzb38C60eEgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZ7yDgbI/h3uDR4K9t1fGhQigdJKBKK+AShttULvWSN2hZbvsukgMWj9OCJCZ5pE9Ii/1QLD4Nlun2HWLM6DzekcYHadweGmmBfoYzY7MTcv6aF8NeZf2LVLKmWEKp6OKPzReUwc3lDaBBZ6MS838hGPCmGwCWZzOJYtbhYEmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnu/jGrb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnu/jGrb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199EAC4CED0;
	Thu,  2 Jan 2025 19:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735844510;
	bh=aWAtO/ukWuo+Gw+e1jsTvL0mxpCCcaLZzb38C60eEgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nnu/jGrbpuhadcwOnHRbzxn0EStgfKpQid5p2XQm3f1ageFh1KPxqlmR0bShY0i3+
	 HlbaWJyNJ7fKIB1OulkK6Hq9HfPLQZxpFtDFtOn4RsqkkBZzpLPk6p0FmlRcNzmKP3
	 Uepoo1sTpBVhZSNFVtQPbd3cD6V9DLl1OWs/rAwezKWPX8LW7DtwDiGdZbWYXhhVP5
	 IJ4iZmX/W8b4NP21naNNJTYBnbBVgXr9rayGPlyosMvpsF7uOiwj5/0N8Bf1+A6Ta5
	 of7y5RSiUFzkZClAmb4HJFI3xHcTTQnzLEj44zYoBN4hYZ1iVJPPZdDIulovSkdaau
	 12aTN3H48Rllg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/5] Docs/admin-guide/mm/damon/start: update snapshot example
Date: Thu,  2 Jan 2025 11:01:37 -0800
Message-Id: <20250102190138.47258-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250102190138.47258-1-sj@kernel.org>
References: <20250102190138.47258-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two of DAMON user-space tool (damo) commands that are used for examples
on DAMON getting started document, namely 'damo show' and 'damo report
heats' are deprecated[1,2], and replaced by new commands that provides
same functions with a simplified user interface.  Also the example
output of 'damo show' is outdasted.  'damo schemes' command is not
deprecated, but users are recommended to use 'damo start' instead.

Update the examples to use the replacements, recommdnations, and
up-to-date output formats.

[1] https://git.kernel.org/sj/damo/c/3272e0ac94ecc5e1
[2] https://git.kernel.org/sj/damo/c/da3ec66bbdd9e87d

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/start.rst | 67 ++++++++++++--------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
index c4dddf6733cd..ede14b679d02 100644
--- a/Documentation/admin-guide/mm/damon/start.rst
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -42,32 +42,45 @@ the execution. ::
 
     $ git clone https://github.com/sjp38/masim; cd masim; make
     $ sudo damo start "./masim ./configs/stairs.cfg --quiet"
-    $ sudo ./damo show
-    0   addr [85.541 TiB  , 85.541 TiB ) (57.707 MiB ) access 0 %   age 10.400 s
-    1   addr [85.541 TiB  , 85.542 TiB ) (413.285 MiB) access 0 %   age 11.400 s
-    2   addr [127.649 TiB , 127.649 TiB) (57.500 MiB ) access 0 %   age 1.600 s
-    3   addr [127.649 TiB , 127.649 TiB) (32.500 MiB ) access 0 %   age 500 ms
-    4   addr [127.649 TiB , 127.649 TiB) (9.535 MiB  ) access 100 % age 300 ms
-    5   addr [127.649 TiB , 127.649 TiB) (8.000 KiB  ) access 60 %  age 0 ns
-    6   addr [127.649 TiB , 127.649 TiB) (6.926 MiB  ) access 0 %   age 1 s
-    7   addr [127.998 TiB , 127.998 TiB) (120.000 KiB) access 0 %   age 11.100 s
-    8   addr [127.998 TiB , 127.998 TiB) (8.000 KiB  ) access 40 %  age 100 ms
-    9   addr [127.998 TiB , 127.998 TiB) (4.000 KiB  ) access 0 %   age 11 s
-    total size: 577.590 MiB
-    $ sudo ./damo stop
+    $ sudo damo report access
+    heatmap: 641111111000000000000000000000000000000000000000000000[...]33333333333333335557984444[...]7
+    # min/max temperatures: -1,840,000,000, 370,010,000, column size: 3.925 MiB
+    0   addr 86.182 TiB   size 8.000 KiB   access 0 %   age 14.900 s
+    1   addr 86.182 TiB   size 8.000 KiB   access 60 %  age 0 ns
+    2   addr 86.182 TiB   size 3.422 MiB   access 0 %   age 4.100 s
+    3   addr 86.182 TiB   size 2.004 MiB   access 95 %  age 2.200 s
+    4   addr 86.182 TiB   size 29.688 MiB  access 0 %   age 14.100 s
+    5   addr 86.182 TiB   size 29.516 MiB  access 0 %   age 16.700 s
+    6   addr 86.182 TiB   size 29.633 MiB  access 0 %   age 17.900 s
+    7   addr 86.182 TiB   size 117.652 MiB access 0 %   age 18.400 s
+    8   addr 126.990 TiB  size 62.332 MiB  access 0 %   age 9.500 s
+    9   addr 126.990 TiB  size 13.980 MiB  access 0 %   age 5.200 s
+    10  addr 126.990 TiB  size 9.539 MiB   access 100 % age 3.700 s
+    11  addr 126.990 TiB  size 16.098 MiB  access 0 %   age 6.400 s
+    12  addr 127.987 TiB  size 132.000 KiB access 0 %   age 2.900 s
+    total size: 314.008 MiB
+    $ sudo damo stop
 
 The first command of the above example downloads and builds an artificial
 memory access generator program called ``masim``.  The second command asks DAMO
-to execute the artificial generator process start via the given command and
-make DAMON monitors the generator process.  The third command retrieves the
-current snapshot of the monitored access pattern of the process from DAMON and
-shows the pattern in a human readable format.
-
-Each line of the output shows which virtual address range (``addr [XX, XX)``)
-of the process is how frequently (``access XX %``) accessed for how long time
-(``age XX``).  For example, the fifth region of ~9 MiB size is being most
-frequently accessed for last 300 milliseconds.  Finally, the fourth command
-stops DAMON.
+to start the program via the given command and make DAMON monitors the newly
+started process.  The third command retrieves the current snapshot of the
+monitored access pattern of the process from DAMON and shows the pattern in a
+human readable format.
+
+The first line of the output shows the relative access temperature (hotness) of
+the regions in a single row hetmap format.  Each column on the heatmap
+represents regions of same size on the monitored virtual address space.  The
+position of the colun on the row and the number on the column represents the
+relative location and access temperature of the region.  ``[...]`` means
+unmapped huge regions on the virtual address spaces.  The second line shows
+additional information for better understanding the heatmap.
+
+Each line of the output from the third line shows which virtual address range
+(``addr XX size XX``) of the process is how frequently (``access XX %``)
+accessed for how long time (``age XX``).  For example, the evelenth region of
+~9.5 MiB size is being most frequently accessed for last 3.7 seconds.  Finally,
+the fourth command stops DAMON.
 
 Note that DAMON can monitor not only virtual address spaces but multiple types
 of address spaces including the physical address space.
@@ -95,7 +108,7 @@ Visualizing Recorded Patterns
 You can visualize the pattern in a heatmap, showing which memory region
 (x-axis) got accessed when (y-axis) and how frequently (number).::
 
-    $ sudo damo report heats --heatmap stdout
+    $ sudo damo report heatmap
     22222222222222222222222222222222222222211111111111111111111111111111111111111100
     44444444444444444444444444444444444444434444444444444444444444444444444444443200
     44444444444444444444444444444444444444433444444444444444444444444444444444444200
@@ -160,6 +173,6 @@ Data Access Pattern Aware Memory Management
 Below command makes every memory region of size >=4K that has not accessed for
 >=60 seconds in your workload to be swapped out. ::
 
-    $ sudo damo schemes --damos_access_rate 0 0 --damos_sz_region 4K max \
-                        --damos_age 60s max --damos_action pageout \
-                        <pid of your workload>
+    $ sudo damo start --damos_access_rate 0 0 --damos_sz_region 4K max \
+                      --damos_age 60s max --damos_action pageout \
+                      <pid of your workload>
-- 
2.39.5
