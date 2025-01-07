Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CC71F8AE9;
	Tue,  7 Jan 2025 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281098; cv=none; b=ST85vV5+dos6Pjw+jpLzxXDnaPxp2t50kjgPQjc8Yha8N9+zYB5hV4GciV9ulCpOEtMS4Sug1LYZYLQnOO0qf+GPSZbMQKUmarlrFvMkiLVeQU2EzUTc2VbonHeufblNE2ZTG08Sae5ZmiFFJVdYf6HyP1lQiQF2Rx/3QWiq500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281098; c=relaxed/simple;
	bh=juadYvUhIrNs11RvqR4w499ufNXf6y5+YZmNZP0gQvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q63VSiVb1/QHk3f9Dy2hZUSGPx7CzZNHw0FVbllGXtmNsjeL1psWnHbpkRb1Ib9b/pq+q/je4eL42umzwKyW1DsBeBjO0B2mEZbOZLFhDhKG71EPegqiYVERwuJTHwFFzA6fJZMvLee8O+pSDB/8luZA2QVbCOPKBwaiTR3B3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbdBW1E9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbdBW1E9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20F9C4AF09;
	Tue,  7 Jan 2025 20:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736281097;
	bh=juadYvUhIrNs11RvqR4w499ufNXf6y5+YZmNZP0gQvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VbdBW1E9YONp1KjOtXnLbXq53XWAzctVY97ritUODquibRxUPZZWiU5WkzWFXjWRY
	 kU2UIFngMpXjNhx655Rrt+wkjr2ZCe5TRPd/ek/hZ6zWiYaNUm5vrpDbW6/Zh4BEHj
	 D8iSZ005boFIlqHbL5Ml5NfI1Pv7D9s946fqPhleNWK8z0DW61x0o/Bnth/rP/bSJ4
	 SR9DGqZJ/0fJ0mIw7A4zcp2NXX2edgROmOyrZ+PpvFj3fObM3QtELW2Knf5e/F2I2I
	 shbTXX1RbNLRguI7G75mWmQA3Y2IKE9EyRCd8uwvOI3o8DlKWYjXlJmhESDXDyskhz
	 z1pmCBCFhzegA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/10] Docs/ABI/damon: document DAMOS filter pass sysfs file
Date: Tue,  7 Jan 2025 12:17:37 -0800
Message-Id: <20250107201739.79484-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107201739.79484-1-sj@kernel.org>
References: <20250107201739.79484-1-sj@kernel.org>
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
