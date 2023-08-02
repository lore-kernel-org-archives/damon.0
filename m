Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85707125C4
	for <damon@lists.linux.dev>; Wed,  2 Aug 2023 21:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12A5C433C7;
	Wed,  2 Aug 2023 21:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691011950;
	bh=hZi4JMj8VgF69C/0cI6pgbuOwe9TusEzinxMwIrTwRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8XK8bu8QUF7j5mokMLp4WthiMSkYqCy1cY7HO0GbwC4arQZLodLipZSG5aSuS0s0
	 a3brhyuqU3Czlf8mRzp//Te0l/DLvozy4eCLuUXIeVuGhH9oAjBoGX4Kgw2glbMFfr
	 r8ZRcAJavf+7zMP6kgLEFRY5NZlrtUIdQ966iL4IIWKYkl/wj4g46mtFXYANURfcCv
	 5ZKTfkfycATaFOVl56xgsVul41YgKaWOm/C1gG2UuYJBSUjCDXbBaSNr7qoX6bnPcX
	 aoMTHxcWDg4YbhqjwA9oiUrVf6TTHyEEk+ESpebMbe+tARmMq//AJ+I2leTRzzfyls
	 z6yzxG2O4nt8A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Docs/ABI/damon: update for tried_regions/total_bytes
Date: Wed,  2 Aug 2023 21:32:20 +0000
Message-Id: <20230802213222.109841-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802213222.109841-1-sj@kernel.org>
References: <20230802213222.109841-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the DAMON ABI document for newly added
schemes/.../tried_regions/total_bytes file and the
update_schemes_tried_bytes command.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 2744f21b5a6b..3d9aaa1cafa9 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -29,8 +29,10 @@ Description:	Writing 'on' or 'off' to this file makes the kdamond starts or
 		file updates contents of schemes stats files of the kdamond.
 		Writing 'update_schemes_tried_regions' to the file updates
 		contents of 'tried_regions' directory of every scheme directory
-		of this kdamond.  Writing 'clear_schemes_tried_regions' to the
-		file removes contents of the 'tried_regions' directory.
+		of this kdamond.  Writing 'update_schemes_tried_bytes' to the
+		file updates only '.../tried_regions/total_bytes' files of this
+		kdamond.  Writing 'clear_schemes_tried_regions' to the file
+		removes contents of the 'tried_regions' directory.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/pid
 Date:		Mar 2022
@@ -317,6 +319,13 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Reading this file returns the number of the exceed events of
 		the scheme's quotas.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/total_bytes
+Date:		Jul 2023
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the total amount of memory that
+		corresponding DAMON-based Operation Scheme's action has tried
+		to be applied.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/<R>/start
 Date:		Oct 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.25.1

