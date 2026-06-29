Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3253793B4;
	Mon, 29 Jun 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744497; cv=none; b=Ej2pNvTTcusit4AnSe9vW1ZQRBfrZPpw5EJzu24wIJjqmzRPpfaG+/EeQNk6N3uTkUsPRIwfmbK1QXodn6ROt/gLo3mv3F4exicghRKVuX4/z1K8hfsYW3An00PqqOidJq+SlSBQLT+iRacuAZmq699Z+7q4LvbRiyOTCD2D5YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744497; c=relaxed/simple;
	bh=6IlV4sy55Ni5byGqDjVzcW6OMClRbHRDFUCkgTKs3aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiKfC2XXYJWjVaUvQjVnVvUldmFh2hMyv3mjkz/SZ/2n2UCuPNT489Te7fTYrTFh5ZUh7u5bnZJhf6HVV8m65g0/9B853RI889hCOIrl0PDhsjkWah0a3oFbxxZoNIX9ycvBmywvIXbsNPfyu4vYoaqFYMq+vnorg5X5gVjOEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMyUZu0P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMyUZu0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40991F00A3A;
	Mon, 29 Jun 2026 14:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744496;
	bh=2yxnk7FH9lXDjwhbBu4C9JlpZuxnrq1wW91k5ivVgec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DMyUZu0Pq+zo4eZxxoOn74Zaolckd9dEMMSeylV8rzYmiroI1kZ4wcYPq/MU9o5hZ
	 srmTi+u98fnrttnQdAe+GWjGn1JiL3E07ud2xkZHVNae8eANx8qvT6QCiKMPmg64pD
	 N6W88poOrLhdIp98xHQlxQnqhiXmBOxEnrGv+hiUIfzPZc56sLd0g3VtdEvG2UQhGP
	 n1wAKtILukUZvQTNEK4VWSDBjJFa+Wq3Qn08JPhiatvXCFz9/Ubh1MhKHubeTsx6A5
	 1kzT6vsmV1qVjudSgDiBZPt+0WTXylwIpsUtaG5v607jb3m3CXug34sHJCLUns0ESI
	 A8s1oOLcvgrqg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Cheng Nie <niecheng1@uniontech.com>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 1/2] selftests/damon/_damon_sysfs.py: fix memcg_path assignment
Date: Mon, 29 Jun 2026 07:48:10 -0700
Message-ID: <20260629144812.134159-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629144812.134159-1-sj@kernel.org>
References: <20260629144812.134159-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Nie <niecheng1@uniontech.com>

DamosFilter stores memcg_path for sysfs staging, but the constructor
assigns it with a trailing comma and therefore turns it into a tuple.

Fix the assignment so memcg_path is stored as the intended string.
This makes memcg filter staging and follow-up validation use the
written path correctly.

Link: https://lore.kernel.org/464AE12D4BC6B6F4+20260601090519.240482-1-niecheng1@uniontech.com
Signed-off-by: Cheng Nie <niecheng1@uniontech.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index f6127081dfb2e..c197ab99bcc0a 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -271,7 +271,7 @@ class DamosFilter:
         self.type_ = type_
         self.matching = matching
         self.allow = allow
-        self.memcg_path = memcg_path,
+        self.memcg_path = memcg_path
         self.addr_start = addr_start
         self.addr_end = addr_end
         self.target_idx = target_idx
-- 
2.47.3
