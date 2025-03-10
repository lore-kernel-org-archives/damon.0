Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D2E22A804;
	Mon, 10 Mar 2025 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614707; cv=none; b=qQXf5dRklX7e/c4R95SFchwhqWCrqsx7PBMpZfl0xfHZhu85hQ8G/tnoygaONcv/p+sgdk30W5DNd/L/Hd7qnXRyMDT31kFpYBohMLQdN+8XmC6IGSYEpjYzpzcEYtPjuxpZ4p5LT/WW5CPJX9vENcIcybbJO4nk/7nzQAJ53So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614707; c=relaxed/simple;
	bh=a+lFZ0YwCbTM+uSgXmIyMxhwWDrnxR3g5GHAb9Vg+38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hKKIod9W3aMy28AkiGn47VukVECQvtPOr5WKRxbuvXXydWbuO3H2sjhPGGN3qaHhRBfCQ6nOHH9qKh/8R2dzoMxVi/RxMkzlEVhGMgES6T1s+kmm9r4Zk+dnYWFcsK+C+Ux3eD8ZBAHycMqZhor5/0w9g6zkAR8eQkyzSQZkkVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4P6hSR1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4P6hSR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642E4C4CEE5;
	Mon, 10 Mar 2025 13:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741614707;
	bh=a+lFZ0YwCbTM+uSgXmIyMxhwWDrnxR3g5GHAb9Vg+38=;
	h=From:To:Cc:Subject:Date:From;
	b=n4P6hSR1A5/XvBEponlCkImC7nEEJ7usnFTBuvewSUI+xmkLJkU53hL7wgBMm1W1B
	 5mXea52sCjuhcTqioS093M5fJncP1nxJG75VlUzEtYuXmcbbS2F1EMeIE7u85DZu0R
	 /PsV1vw5zr5o7D2Vg3DB7dcWopjjWRbuhlx1GiuBBSO177txLR/d0Sfv4iXaCz7N1x
	 0QqxXlzHKochi7eGvqsfUEUqyeLllastqzxlGfu+WUETaJPtx31RtWHpI4PT50aAwK
	 kRmGg/b8GPsNhTae9aTbJU84sMC1GBtDlxatdnQ6yC57A58ZI/2yfA1CzGSJiD7BML
	 8X/lYArwEyymQ==
From: Arnd Bergmann <arnd@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/sysfs-schemes: avoid Wformat-security warning
Date: Mon, 10 Mar 2025 14:51:37 +0100
Message-Id: <20250310135142.4176976-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This warning is for potentially user-defined format strings:

mm/damon/sysfs-schemes.c:1664:4: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
 1664 |                         name);

Change this to use "%s" as the format and the name as the argument.

Fixes: 92bc039dd72e ("mm/damon/sysfs-schemes: let damon_sysfs_scheme_set_filters() be used for different named directories")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/damon/sysfs-schemes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 50e6907515e6..23ac98dd6451 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1661,7 +1661,7 @@ static int damon_sysfs_scheme_set_filters(struct damon_sysfs_scheme *scheme,
 		return -ENOMEM;
 	err = kobject_init_and_add(&filters->kobj,
 			&damon_sysfs_scheme_filters_ktype, &scheme->kobj,
-			name);
+			"%s", name);
 	if (err)
 		kobject_put(&filters->kobj);
 	else
-- 
2.39.5

