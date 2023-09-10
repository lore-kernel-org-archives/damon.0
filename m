Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FE415BC
	for <damon@lists.linux.dev>; Sun, 10 Sep 2023 03:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606FBC433C9;
	Sun, 10 Sep 2023 03:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694317252;
	bh=P7zQCwnjvNM/0KUc4+YEr5PqkR+all9uO1LM0PE/RX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrXyTnttdpLzVeZIEYQ1KlPf1eGSXzz5UV1gKdhzO3/x5aa0WKFyKpbq5vjX+2YPa
	 k1Gdsop+MdQM08S0rG5L+8BsW1Pl12AMmtn0AU7TlzZBlbItisrpjdTgcYeBdIE7H2
	 8UpeGBcJO685O3hytod/LaJ+8cyLzSi7hJiW0WJsCjt5e9C3PV77c/bVTk8jtsn/zP
	 8AMzsjEInb8mB/y5NWGGMGe6Bf0+IRcXNYw873mvEdT4tZ40aBQ6Yc4MWa4npct0Oc
	 TgvrV+xEAsxQJR7081G3Y3uW2HmYFPbRPRSitFZnTa/nS8H+fVV2natp1V34kA95J2
	 5TBv/I1QLkwJQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 2/8] mm/damon/sysfs-schemes: expose nr_accesses_bp via tried_regions/<N>/nr_accesses
Date: Sun, 10 Sep 2023 03:40:42 +0000
Message-Id: <20230910034048.59191-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910034048.59191-1-sj@kernel.org>
References: <20230910034048.59191-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface exposes access rate of each region via DAMOS tried
regions directory.  For this, the nr_accesses field of the region is
being used.  DAMOS was using nr_accesses in the past, but it uses
nr_accesses_bp now.  Expose the value that it is really using.  Note
that it doesn't expose nr_accesses_bp as is (in basis point), but after
converting it to the natural number by dividing the value by 10,000.
That's for not making unnecessary confusion to the old users.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 527e7d17eb3b..093700f50b18 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -31,7 +31,7 @@ static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
 		return NULL;
 	sysfs_region->kobj = (struct kobject){};
 	sysfs_region->ar = region->ar;
-	sysfs_region->nr_accesses = region->nr_accesses;
+	sysfs_region->nr_accesses = region->nr_accesses_bp / 10000;
 	sysfs_region->age = region->age;
 	INIT_LIST_HEAD(&sysfs_region->list);
 	return sysfs_region;
-- 
2.25.1

