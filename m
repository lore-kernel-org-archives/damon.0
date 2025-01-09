Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DD1FCCF3;
	Thu,  9 Jan 2025 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445106; cv=none; b=VSJ0jKW3eUO4KBZT4Z47biZkPOzFWYdKzAHM8W79Ln8AMuJ7/jNQRk1fbqU2aHZpCVV0uhNyWV4CwtRj5/pyW1NLwBEO/7Uyr7VKssbaCj4ctirZT8WmT0pnV1vMgWWnEbhet3fH9vrYFOE9GPxdsy+2C1STuTTnXImkuyDHo3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445106; c=relaxed/simple;
	bh=gKQlLARsVrrph5NrbcUYgL9T8fplC1mlIWF/4YxuHGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mHK3spckl5zMNVXc/tHCn47KXyViG3CUjGDypPBG5hjkeopsJWPVMdb0tHmhBo6pRvEmpeqoUJ3LAAsmgDUJuzpydsl9MteQ0X6zF43TCxL5vFA97Jb1WabMSiAJo43Rti8/bvIeITecUBXEqbh6f3PJWQ9YqzG9sGsjcVW3axw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REsmlWwh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REsmlWwh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E17C4CEDF;
	Thu,  9 Jan 2025 17:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736445105;
	bh=gKQlLARsVrrph5NrbcUYgL9T8fplC1mlIWF/4YxuHGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REsmlWwhB0dudPGHboz+PDVelqGDAeP6LkzFmqYWSqf1lAqHKMJxvJZa6W0K+z687
	 0Tzm84jAynQdcg7cHsGQNJNoBsNT85GuJrSqH6a9FbQ+tIdkuW5Kd7YYRf7fec7btw
	 4+S9cbMoAT1ZIt3cOGSyUyZIlREp1jbEdBarzaHzGx4uKzgehkl/K10y29is4Jy9N5
	 t/TP56RX5xrZFvovNwENPFm5ceSUyXhrcYqkTTkgP5+9FAB27r1xqRzLABV190knSq
	 ou/hNqpn2JjORBElpBaNQIdAe5iIAlWbH9s39eUTXTRtcLbSWdExCMRa7Uk387r05b
	 Uq6JDI1p6oikg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 08/10] Docs/ABI/damon: document DAMOS filter allow sysfs file
Date: Thu,  9 Jan 2025 09:51:24 -0800
Message-Id: <20250109175126.57878-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109175126.57878-1-sj@kernel.org>
References: <20250109175126.57878-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for added DAMOS filter 'allow' file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 8c0acb31638b..b057eddefbfc 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -355,10 +355,15 @@ Description:	If 'target' is written to the 'type' file, writing to or
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/matching
 Date:		Dec 2022
 Contact:	SeongJae Park <sj@kernel.org>
-Description:	Writing 'Y' or 'N' to this file sets whether to filter out
-		pages that do or do not match to the 'type' and 'memcg_path',
-		respectively.  Filter out means the action of the scheme will
-		not be applied to.
+Description:	Writing 'Y' or 'N' to this file sets whether the filter is for
+		the memory of the 'type', or all except the 'type'.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/allow
+Date:		Jan 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing 'Y' or 'N' to this file sets whether to allow or reject
+		applying the scheme's action to the memory that satisfies the
+		'type' and the 'matching' of the directory.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_tried
 Date:		Mar 2022
-- 
2.39.5
