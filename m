Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E406D39
	for <damon@lists.linux.dev>; Mon, 19 Dec 2022 17:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC991C433AF;
	Mon, 19 Dec 2022 17:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671470294;
	bh=DScbhf2qkPduKtfJPNLimXEH2D1WRTFQEhM+/Oib0wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOziWT8N2rcIsbd8XCtsN/2zVXLABdKcySmLCpBta5IIK1AbrIdh374l0ZaLtosiG
	 gbnRriNLCXYfshbWV9jQ9HRSRkUHCayl/lrReaGA6EBOuaceR8TUmX33CKAfIyDNup
	 HCMJ/FHq9vg3Ud3o5/2z1kJFMp+lTAGvj+P5FQidAawhTCRFJxaOSLPTDBzJ5ortF3
	 uYDWENSn9ijdKmTSM2dr1gfcb4YqXtXxWEg0OdbkHVwRbduwofspwvetzMa+K2H//I
	 JeS5Ro7NCgsFRW+6xdPv+cFZ/WG1Bqh9tEMFD+AtcBLxPDJRFOHnPsguWYZsqIYRLS
	 nUO3EeTmg9OWw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH mm-unstable 2/2] mm/damon/sysfs-schemes: Return an error for filter memcg path id lookup failure
Date: Mon, 19 Dec 2022 17:18:07 +0000
Message-Id: <20221219171807.55708-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219171807.55708-1-sj@kernel.org>
References: <20221219171807.55708-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f36f860207ef ("mm/damon/sysfs-schemes: implement scheme filters")
on mm-unstable introduced damon_sysfs_memcg_path_to_id(), which returns
non-error even if it didn't find the memcg of the given path.  Caller
could check the failure by seeing if the 'id' has really set or not, but
it's unnecessarily complicated.  Return an error for the case instead.

Fixes: f36f860207ef ("mm/damon/sysfs-schemes: implement scheme filters") on mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5d3ac3107927..f0dabe3e2dc0 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1418,6 +1418,7 @@ static int damon_sysfs_memcg_path_to_id(char *memcg_path, unsigned short *id)
 {
 	struct mem_cgroup *memcg;
 	char *path;
+	bool found = false;
 
 	if (!memcg_path)
 		return -EINVAL;
@@ -1433,12 +1434,13 @@ static int damon_sysfs_memcg_path_to_id(char *memcg_path, unsigned short *id)
 			continue;
 		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
 			*id = mem_cgroup_id(memcg);
+			found = true;
 			break;
 		}
 	}
 
 	kfree(path);
-	return 0;
+	return found ? 0 : -EINVAL;
 }
 
 static int damon_sysfs_set_scheme_filters(struct damos *scheme,
-- 
2.25.1

