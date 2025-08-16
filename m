Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4F241CB7;
	Sat, 16 Aug 2025 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755363368; cv=none; b=kCC6cpJTP9mVr3q5z73C/apVHz+MfVcMhKzNXTNiGHRdd+DrEV3uULTiAWTVQzmdOyVJrTzus5iDhvzSdF3koGFLXmviPUhwpVstfGMwMxYWmV4qYAD34PvlB9A463XkxW+Bow0bt40sHpWQ1DNgCLPYSqnnNI7bbQSW3cLyWY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755363368; c=relaxed/simple;
	bh=v3c00vABdRpksOJBgZaWwWtGx/wcPhBRtyST+3P9e6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eRIoHzFyEUPV8dqj86Wmf4F/OhlOnfEGGAcdSO6O/AKHoutIBoNMV2tTQZC5UhIdbDXo9U0Rn5O28LUqJ7iBWBjw6j0iBYj6r/DtRsa4mtlJrQev3ZSyhPtf1Dr9+56vP0KILm5pcGPTBjWNAUhaBaL/RsP1ijYJZYyuaAZ+FZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0CIZP3h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0CIZP3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88435C4CEEF;
	Sat, 16 Aug 2025 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755363367;
	bh=v3c00vABdRpksOJBgZaWwWtGx/wcPhBRtyST+3P9e6k=;
	h=From:To:Cc:Subject:Date:From;
	b=R0CIZP3h74gVXo0whJ9net0psnUn5uiaiskWOLdiTuTMkr+HkWuLuRqMXmZxaJrAQ
	 AKeTdsBBznAhFd2vxOkEdWSXqI5TxCuvo945WlHaxWOhuRcBpFw9j+60V2x8k5PwGE
	 v2kcx/zdhR2VCxqsPGdvZeXYs1/x8BiYvot/Oe1gFZEryqu0pMzBU5qUI6CwGFuWTZ
	 eaE58FT6wC0izKnd8ipPPlNzZ/xo+ht/IQBeFbgzSG4uEKdn3kJ60GH6gv6N5gACy1
	 ZNNZPA4MbOj4toljR/dVrwLT2BkjXbRgdE1PK6h2NXUgfFOnucViBzQHxmUFTYXKAT
	 kndscDg3hdtTw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] mm/damon/sysfs-schemes: put damos dests dir after removing its files
Date: Sat, 16 Aug 2025 09:55:59 -0700
Message-Id: <20250816165559.2601-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_scheme_rm_dirs() puts dests directory kobject before
removing its internal files.  Sincee putting the kobject frees its
container struct, and the internal files removal accesses the container,
use-after-free happens.  Fix it by putting the reference _after_
removing the files.

Reported-by: Alexandre Ghiti <alex@ghiti.fr>
Closes: https://lore.kernel.org/2d39a734-320d-4341-8f8a-4019eec2dbf2@ghiti.fr
Fixes: 2cd0bf85a203 ("mm/damon/sysfs-schemes: implement DAMOS action destinations directory") # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Not Cc-ing stable@, since the broken commit is in 6.17-rc1 and hence probably
this fix will land on the mainline before the release of the first 6.17 stable
kernel (6.17.1).

 mm/damon/sysfs-schemes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 74056bcd6a2c..6536f16006c9 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2158,8 +2158,8 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
 {
 	damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
 	kobject_put(&scheme->access_pattern->kobj);
-	kobject_put(&scheme->dests->kobj);
 	damos_sysfs_dests_rm_dirs(scheme->dests);
+	kobject_put(&scheme->dests->kobj);
 	damon_sysfs_quotas_rm_dirs(scheme->quotas);
 	kobject_put(&scheme->quotas->kobj);
 	kobject_put(&scheme->watermarks->kobj);

base-commit: 9aa69ba9d9e220ea1d8ba62592fe7ffba376b2cc
-- 
2.39.5
