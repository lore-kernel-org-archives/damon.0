Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C657E
	for <damon@lists.linux.dev>; Wed, 19 Oct 2022 00:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B29C4347C;
	Wed, 19 Oct 2022 00:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666138413;
	bh=doMLACqMRf7Btau3UrqaKpcKCYcm6Tf1YUcPhkzG85U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZpkZct+MGl/kPwXvu5owcWOZkTGvEhusLDqCBwQowrbpD9aBaG8itl8JomQE8YCXL
	 XI2gqeIiY6YRP/F9xg5LgXNgb9+GNp2IrPKGRziwUiUn02hZnADKe1fcnJa4UcUcc9
	 vi8Dox0gN3fmvy7qfXiKC3JbWIyqMl+/w2gPQ4cDBUQ3T8/LN0elYfmpWZB21B7GEj
	 QM9Ms7R2PkVWgIVR3fpPx3bxekl938iVdVuf2LjQxWjq3BoH2wc6uolfc8och3iEY+
	 oRjOjkq4XIgXC6Uu7yIUpQettP1jGY3wGlm7mJPlzY67M6493Gby0Q68MYn8NESwSa
	 KG8hFhX53do1Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 18/18] Docs/ABI/damon: document 'schemes/<s>/tried_regions' directory
Date: Wed, 19 Oct 2022 00:13:17 +0000
Message-Id: <20221019001317.104270-19-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019001317.104270-1-sj@kernel.org>
References: <20221019001317.104270-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for added 'tried_regions' directory of DAMON
sysfs interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 08b9df323560..7ba95e35b427 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -27,6 +27,10 @@ Description:	Writing 'on' or 'off' to this file makes the kdamond starts or
 		makes the kdamond reads the user inputs in the sysfs files
 		except 'state' again.  Writing 'update_schemes_stats' to the
 		file updates contents of schemes stats files of the kdamond.
+		Writing 'update_schemes_regions' to the file updates contents
+		of 'tried_regions' directory of every scheme directory of this
+		kdamond.  Writing 'clear_schemes_regions' to the file removes
+		contents of the 'tried_regions' directory.
 
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

