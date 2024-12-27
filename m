Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6901F9ED8;
	Fri, 27 Dec 2024 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735333716; cv=none; b=NIGKkUtAP6xuTDNZlt4C/24NB0qHX4BtN/mqyx3uVxmNQAgraEeFzFUj5CMJmCJlSIRtB0/0VlvSp2k8ylr1IqOHkmLglSednTIb7WQNtYFgvqkXTXC7Q9iW58s1038xyQ7r7lNE6Rydx/eTNxprKDfBFY80JTXvdPECRMniDMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735333716; c=relaxed/simple;
	bh=juadYvUhIrNs11RvqR4w499ufNXf6y5+YZmNZP0gQvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nGjqglVa7SYYWjY2IpfYqtvt46c8bwxmvL0uDK3Y6Y61Uwp4WyWKKCBPWXj5XYG+HqCDCfLZLopX3kguFvIAf8Ih7QOhlS+KEvtpQpsc+aWQEr+khmwwmlGPYJCVHF+kUNhJqOfqnApRxHTm+T69pAKBpAKTEgshdz6wYo4e7W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4IyBksl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4IyBksl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B803C4CEDE;
	Fri, 27 Dec 2024 21:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735333715;
	bh=juadYvUhIrNs11RvqR4w499ufNXf6y5+YZmNZP0gQvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m4IyBkslGMKYZNJiLFIYRx7cTpBwDbq/1qFhzl7L6T1PYTVFM1+OgorJmrz4xylvM
	 ao/itzf0xuv7qUN1uUK+TDDbpsTvfI2MesZHMaXTES2pHVNTg3dsJaPn3NSh2yptbh
	 bnqNuivcLLBtEoYId3SzgGlnQhBymT+h9mLn+3e5IU3Vsp1DFNmC8jA4xzszug34ov
	 YsB06gbpCsEDW/aFHYlm3o1Jh1yhSOlXd1WI22AYYnzAC+ombVa0jUEZ8YU2SdXfPG
	 2H1GP6jbShzIYX5XItEvjiRjCc9mjDSuNB/oLoXw2+4B5FtL8xMM/PZifQF0M5I+54
	 aq2LTcsIhiUGA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 08/10] Docs/ABI/damon: document DAMOS filter pass sysfs file
Date: Fri, 27 Dec 2024 13:08:17 -0800
Message-Id: <20241227210819.63776-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241227210819.63776-1-sj@kernel.org>
References: <20241227210819.63776-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for added DAMOS filter 'pass' file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 8c0acb31638b..688bd27d8602 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -355,10 +355,16 @@ Description:	If 'target' is written to the 'type' file, writing to or
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
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/pass
+Date:		Dec 2024
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing 'Y' or 'N' to this file sets whether to allow (pass
+		through the filter) or deny (be blocked by the filter) applying
+		the scheme's action to the memory that satisfies the 'type' and
+		the 'matching' of the directory.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_tried
 Date:		Mar 2022
-- 
2.39.5
