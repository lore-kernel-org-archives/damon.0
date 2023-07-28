Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E261BB2D
	for <damon@lists.linux.dev>; Fri, 28 Jul 2023 20:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50472C433C9;
	Fri, 28 Jul 2023 20:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690576496;
	bh=vyjBGWyxBLS7yKk1ryFlF7UDmbUqwEQwLNgOkCH6QUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rea+yT0IiwPGhhE0KEND4yApkw5a3ILg6BoIRM7AwSF2wCqS1qY+//EtMqzze8Odt
	 xvJ58ujCsX21oar+Bcm3nIwbXsznDchR6t7ykIJ8WteZ9IBaM+SRQAItGePyDKRyoz
	 nFJCVeodxBpFWwK5n9pfFfio1UJcbio51qqREQquQDwnokFsyrUJSTouI/uELCp8r9
	 58W76e0TNy8z/akRdaoJ9tfVPEhPZKvI1TP8Nah4cKXlumcE6G+/wuIOAksrqLZMO1
	 NaJLOWwoPrUT5MdfTpg+xPu8M9V2XqZhalpiWr9NQRPFw3tshGmQOjTYgHwt2Y0CB3
	 pMGiohUJ4mCOw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 12/13] Docs/ABI/damon: update for DAMON monitoring target type DAMOS filter
Date: Fri, 28 Jul 2023 20:34:43 +0000
Message-Id: <20230728203444.70703-13-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728203444.70703-1-sj@kernel.org>
References: <20230728203444.70703-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added DAMON monitoring target
type DAMOS filter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 0bc074d4618c..334352d198f8 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -272,8 +272,9 @@ Date:		Dec 2022
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the type of
 		the memory of the interest.  'anon' for anonymous pages,
-		'memcg' for specific memory cgroup, or 'addr' for address range
-		(an open-ended interval) can be written and read.
+		'memcg' for specific memory cgroup, 'addr' for address range
+		(an open-ended interval), or 'target' for DAMON monitoring
+		target can be written and read.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/memcg_path
 Date:		Dec 2022
@@ -296,6 +297,12 @@ Description:	If 'addr' is written to the 'type' file, writing to or reading
 		from this file sets or gets the end address of the address
 		range for the filter.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/target_idx
+Date:		Dec 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	If 'target' is written to the 'type' file, writing to or
+		reading from this file sets or gets the index of the DAMON
+		monitoring target of the interest.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/matching
 Date:		Dec 2022
-- 
2.25.1

