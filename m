Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11EE230BE9;
	Mon, 10 Mar 2025 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625413; cv=none; b=tsDNGA1WrMSW/ubL0gEd2PimZDTPjlpe0rBr9kRcssfwkZiH5vbFC2GbInDv7NDilQY8FBu6LC/2IU9D8K1bvafEUVRfzaIC/oouxP/l14Sw36zD27IE9Jmp9cyy6WU1dD1g9X4H1LNSOeMYN4m65WUtwWt2Z3tLdhg9l3VuqtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625413; c=relaxed/simple;
	bh=r+gxmdE5yHVk2NLqBJ7jgPXUGZjq3hJsyPbNAJS1jpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=he1kg8Q0GR61retaU9CBPfhhcH2b2iw6eqYUp9weZLDJYzox2d/4yAS9v/TMKfS75QLeNGR15IxtDIXpxQpQT6Wzir80EECdnPY6fNYWsr4ZBg5SRZfBzdzioA4GLHi9klxTwUOpPNVvEjymNtyiZGG+euk2TGYZMTxdlq99oXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+wulOte; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+wulOte"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EC7C4CEE5;
	Mon, 10 Mar 2025 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741625413;
	bh=r+gxmdE5yHVk2NLqBJ7jgPXUGZjq3hJsyPbNAJS1jpY=;
	h=From:To:Cc:Subject:Date:From;
	b=h+wulOtenKcgq0y3IC9kIRcBuoWfIdw6VkUowo4Ia/Db2h2iL7ijIiqyXAk8fueFJ
	 1cWkwbdn94I3RQLcjfiEwW4HSWACZw0Omde22mWGB/57rrPyuFqdcLu1vDakpssnNP
	 gRiDv7YdbqW5uoLng8OW6z38TrANpggGqeOSMN7hJJJuS+d32ilA1kodKu7raZ0QA/
	 Icf3KA3PgL1K+DA00ewRY2TukolPZjaFq2dF8wS/vcBJ83gXcAysYKiQq+nhhY5cit
	 BUQ3qSI2ERPxbOIiVg57joM702CN7We1uZA7Gg3evExnK8gCySaGCilNFXCw7jlerG
	 BEdoYqunnUCDw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/sysfs-schemes: avoid Wformat-security warning on damon_sysfs_access_pattern_add_range_dir()
Date: Mon, 10 Mar 2025 09:50:09 -0700
Message-Id: <20250310165009.652491-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When -Wformat-security is given, compiler warns as a potential security
issue on damon_sysfs_access_pattern_add_range_dir() as below:

    mm/damon/sysfs-schemes.c: In function ‘damon_sysfs_access_pattern_add_range_dir’:
    mm/damon/sysfs-schemes.c:1503:25: warning: format not a string literal and no format arguments [-Wformat-security]
     1503 |                         &access_pattern->kobj, name);
          |                         ^

Fix it by using "%s" as the format and the name as the argument.

Fixes: 7e84b1f8212a ("mm/damon/sysfs: support DAMON-based Operation Schemes")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 985cfc750a90..5023f2b690d6 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1471,7 +1471,7 @@ static int damon_sysfs_access_pattern_add_range_dir(
 	if (!range)
 		return -ENOMEM;
 	err = kobject_init_and_add(&range->kobj, &damon_sysfs_ul_range_ktype,
-			&access_pattern->kobj, name);
+			&access_pattern->kobj, "%s", name);
 	if (err)
 		kobject_put(&range->kobj);
 	else

base-commit: 0cc6442f34b553e5718892b818d691b8fd0b5642
-- 
2.39.5
