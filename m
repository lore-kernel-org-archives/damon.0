Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25F42DF6F5;
	Sun, 23 Nov 2025 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763923428; cv=none; b=EXLsuzGfVR3tugsJezRtUxhxStsrwKYe0KQ9TEhaZXKNTcZXLyWRnR7a5iP1rhiIjJgKq5tAE/fK58bHjBB0JqsdRfzadrXE3bmO5YUrSsV2xDIUXV/qGTKE90OLH5hhvyOMqAyAF7Fddw44iabYTAITgIuNlkTwwExjvG27oG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763923428; c=relaxed/simple;
	bh=Ybb1QxrTxcSMGL/dvuVAmRcZVW1T/bi0bFKyjCzx1os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dstQnUaLOdDonSMtFYzY0myP073tnurgM5b8iOu/w2OAwGJqsNwB3l28abjLUOhwhvs8wayoLHJ/xxIv3jBjMNFH8FD8OSOri91owlzafiHdBou+VY4gj+Hn/BOWBGMx5+F952nUMuKKYZ8AkWey1ITE77WmLj5zIhhjBdrZC/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYi9f6Rx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYi9f6Rx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1A3C116B1;
	Sun, 23 Nov 2025 18:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763923427;
	bh=Ybb1QxrTxcSMGL/dvuVAmRcZVW1T/bi0bFKyjCzx1os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BYi9f6Rxc+0CMnIHUHMDz+lfgFgknCKtvqjVXfYl+ve/HQa7T34ClRr6hEVo0/svZ
	 tBbqdU/pAr3Wx4t6yoqbOGnxB7At1cegTkOf63a7/Z91Y42MYkE61i65+LgDRitFFR
	 NpFSrSWW39sMVdAFNy1K6+pZ8qteehu2Ve4Wz8kS8AgkJ/ug9qmG072Xo7B9ikNjOV
	 r8iHDaN/UmObSd4WTqCejsHaKE5Xa/7T2QWj4c3Piwqlv5xe3ALScwDzhPZDGyLrHO
	 jEQpkBey3hUJIxrRLfH3ekhusmaCYgLuxArQAM1Mc2uepF0ypmKzzTj4gVLpM2V208
	 h1X+1I6NtwkIw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 11/12] Docs/ABI/damon: update for max_nr_snapshots
Date: Sun, 23 Nov 2025 10:43:25 -0800
Message-ID: <20251123184329.85287-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251123184329.85287-1-sj@kernel.org>
References: <20251123184329.85287-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added DAMON sysfs interface
file, max_nr_snapshots.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 8ec469eb4471..4504a0f8b446 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -522,6 +522,13 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Reading this file returns the total number of DAMON snapshots
 		that the scheme has tried to be applied.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/max_nr_snapshots
+Date:		Nov 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number to this file sets the upper limit of
+		nr_snapshots that deactivates the scheme when the limit is
+		reached or exceeded.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/total_bytes
 Date:		Jul 2023
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
