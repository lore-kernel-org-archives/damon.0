Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F65D7B
	for <damon@lists.linux.dev>; Tue,  1 Nov 2022 22:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF57C433D7;
	Tue,  1 Nov 2022 22:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667340218;
	bh=NEW3Do9blxs64Lr6AHVrrQw2/a54TWTrLKMR+YeGsds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1CFkxeL+dqHmMQeH8SDS0lCGzwBkhf2aHgFfgMOEqNRvCflCYHQI12Oy5F8avJc3
	 Agchqu719Zx4qxQ1F9QY9Fmuu9lScWN27OlP+GSN8ENks8z6FLxr7PFcWxFVcFTwgj
	 gA6AGQFnZ8ZCWiBLhAIvR1411jLd8UqsVpR/3edr9frW/3xlDwPnoik0xeNFjhX7nI
	 tGGbpkm6EWWV+g9CuX2snpTvjQH70mGLcHELAUY+wfCG2fW3gocNniE8fHFu0uWy/l
	 y+4kDCJjON198FMyUp6iPw83AtZSxfKqgh9DjTGVQG83gSze8ypd8Xtc/pKTHBXRCf
	 WoKgOp7KKNYKg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 8/8] Docs/ABI/damon: document 'schemes/<s>/tried_regions' sysfs directory
Date: Tue,  1 Nov 2022 22:03:28 +0000
Message-Id: <20221101220328.95765-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101220328.95765-1-sj@kernel.org>
References: <20221101220328.95765-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the 'tried_regions' directory of DAMON
sysfs interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 08b9df323560..13397b853692 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -27,6 +27,10 @@ Description:	Writing 'on' or 'off' to this file makes the kdamond starts or
 		makes the kdamond reads the user inputs in the sysfs files
 		except 'state' again.  Writing 'update_schemes_stats' to the
 		file updates contents of schemes stats files of the kdamond.
+		Writing 'update_schemes_tried_regions' to the file updates
+		contents of 'tried_regions' directory of every scheme directory
+		of this kdamond.  Writing 'clear_schemes_tried_regions' to the
+		file removes contents of the 'tried_regions' directory.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/pid
 Date:		Mar 2022
@@ -283,3 +287,31 @@ Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Reading this file returns the number of the exceed events of
 		the scheme's quotas.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/<R>/start
+Date:		Oct 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the start address of a memory region
+		that corresponding DAMON-based Operation Scheme's action has
+		tried to be applied.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/<R>/end
+Date:		Oct 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the end address of a memory region
+		that corresponding DAMON-based Operation Scheme's action has
+		tried to be applied.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/<R>/nr_accesses
+Date:		Oct 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the 'nr_accesses' of a memory region
+		that corresponding DAMON-based Operation Scheme's action has
+		tried to be applied.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/<R>/age
+Date:		Oct 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the 'age' of a memory region that
+		corresponding DAMON-based Operation Scheme's action has tried
+		to be applied.
-- 
2.25.1

