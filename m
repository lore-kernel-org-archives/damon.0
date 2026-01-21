Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D252765FF;
	Wed, 21 Jan 2026 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768957310; cv=none; b=bSMJTZ4kX90aeE6WNTzLJaj0UNQ2cfrmxRS78BLZwxQBQ+FuUYYCmU72tNSomWHzZpr78Tlq9Tj0TN6WJLq5JYa4RuYK+/me/HHu4XXDbSc+/ZB/MbEzQsxiYrjQuWy5Tr/Wu7auxndJi7UKrnJ0XIjOUi/kdi4FWlA5Sar5E8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768957310; c=relaxed/simple;
	bh=iV8yYyldsyVgf0MLQ6q20iYKrC4CTz5izeYo8EqsSa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvNQeT2eNEXNWC98wiQOpUOGhXA5WONcazNSdxf+8UPwNzZ/WzhIGaoud0i+cPL5Z2XJF7Ek9yibwQWqiWbdAldISVaDhDB/kFNUnARJJhgJZnW+y3iS9MJtCslzNW5jB+AoRkBn6DFlrhLMOXCWTWOojp4xQoZoToHkVHtGhvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSTu3bKA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSTu3bKA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F34C16AAE;
	Wed, 21 Jan 2026 01:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768957309;
	bh=iV8yYyldsyVgf0MLQ6q20iYKrC4CTz5izeYo8EqsSa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WSTu3bKAhqLOjE2/B56d5curF53+khQED3uKmcBX+p5Ec+8wBW7mjGAMGn4UoDDsv
	 kRpCiZdsRoxSmGVfNRGRNuimfh5FLkp0As8ETeXmhK2NaVFa3gEsifG/QI3WjijkWW
	 XRo4y//3KxdPxFYY4WQL8/sQoMVGXsx2uWlGSxpTWt50fj2J2tvw7PvQp5fAKDeBws
	 Zgg6MshIwqk5sqxWr2z5ld9i7NwCsy22OEMProS7e6FlSOydOE6RE3Eklmg5JELNWZ
	 yYge4Th18ZCZUw57uhqV1AohoYKBeMXOgQ6mwgfdQZcMMfo4JrATU9T9Cu84FUecOV
	 6Zv7eBtRQaOKA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	chongjiapeng <jiapeng.chong@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/sysfs-scheme: cleanup quotas subdirs on scheme dir setup failure
Date: Tue, 20 Jan 2026 17:01:39 -0800
Message-ID: <20260121010139.111262-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026012001-endurance-retrieval-1f57@gregkh>
References: <2026012001-endurance-retrieval-1f57@gregkh>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a DAMOS-scheme DAMON sysfs directory setup fails after setup of
quotas/ directory, subdirectories of quotas/ directory are not cleaned up.
As a result, DAMON sysfs interface is nearly broken until the system
reboots, and the memory for the unremoved directory is leaked.

Cleanup the directories under such failures.

Link: https://lkml.kernel.org/r/20251225023043.18579-4-sj@kernel.org
Fixes: 1b32234ab087 ("mm/damon/sysfs: support DAMOS watermarks")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: chongjiapeng <jiapeng.chong@linux.alibaba.com>
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit dc7e1d75fd8c505096d0cddeca9e2efb2b55aaf9)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index d9e01648db70e..c7c2972c7c8a9 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1609,7 +1609,7 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 		goto put_access_pattern_out;
 	err = damon_sysfs_scheme_set_watermarks(scheme);
 	if (err)
-		goto put_quotas_access_pattern_out;
+		goto rmdir_put_quotas_access_pattern_out;
 	err = damon_sysfs_scheme_set_filters(scheme);
 	if (err)
 		goto put_watermarks_quotas_access_pattern_out;
@@ -1630,7 +1630,8 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 put_watermarks_quotas_access_pattern_out:
 	kobject_put(&scheme->watermarks->kobj);
 	scheme->watermarks = NULL;
-put_quotas_access_pattern_out:
+rmdir_put_quotas_access_pattern_out:
+	damon_sysfs_quotas_rm_dirs(scheme->quotas);
 	kobject_put(&scheme->quotas->kobj);
 	scheme->quotas = NULL;
 put_access_pattern_out:
-- 
2.47.3

