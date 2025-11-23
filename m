Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502A02DA765;
	Sun, 23 Nov 2025 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763923426; cv=none; b=GwT26yUqwAPhajtaovtuFzwM5myxXAlrZPyJZOfZArezlS8HJEjrMojJhTXUyeHPiGbw+0yjNwp3vo0VhRPdkLi2ZN4PnyV9+nZBhUxGdOAIHU1E/PDhLPCu5kpAr3gPwvMgSOGXw5T04a+3ovS9WXvaTJAftROMS+a2Kk+x4Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763923426; c=relaxed/simple;
	bh=kDwIvFb8VodbxVEv7dJbhD0yz/eOfjwBbqy33WSlBfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+OYa2wJUEXyjOWoF3KX6s/gN0gZZxC+0dTgY92gNUEnoLH/DtwSx2wyXLCS8fcSO7OT38bupZNd7PByuWTIsWcrzksvOm1ickocPewFzkcG5LyHiiDi62OHpPek8Pi6LS9F1ExawVStqqpGB9SskifrNR1J8oQHZHMZAymXBm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjvbOznx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjvbOznx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23A2C19422;
	Sun, 23 Nov 2025 18:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763923425;
	bh=kDwIvFb8VodbxVEv7dJbhD0yz/eOfjwBbqy33WSlBfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BjvbOznxo38hdVc7pIPFkgfrNu+WIMZYz0mAohaEy2nWJ54GQBMuSPhyqfb2lxsex
	 lkg73PzpS8fc0nixCljxRLfc9hx3clm7eM6zTewVD9dQcDjqO0ACcoYZdcwwLJdlhI
	 RCfMqWZ4BehSZ2m7P6kZPdSaSAp3n5NBu2HfqFwmTJDfOyzAZNH2FmZTWHHZixq4YW
	 iNKkFu9BkypGWj5kYxFtkIFo1mp0yGF2Mng7CylilvjlpYnVM7FoW5yL1vvsOGKnu0
	 FjAoJPbFuA7fcCJPwT7OOpKlOxl7xfbFs3Cws77mIDVTRQ2d+nwlkKOmQegXW85Tk6
	 VMqGJd3WTjEVQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/12] Docs/ABI/damon: update for nr_snapshots damos stat
Date: Sun, 23 Nov 2025 10:43:19 -0800
Message-ID: <20251123184329.85287-6-sj@kernel.org>
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

Update DAMON ABI document for the newly added damos stat, nr_snapshots.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 4fb8b7a6d625..8ec469eb4471 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -516,6 +516,12 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Reading this file returns the number of the exceed events of
 		the scheme's quotas.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_snapshots
+Date:		Nov 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the total number of DAMON snapshots
+		that the scheme has tried to be applied.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/total_bytes
 Date:		Jul 2023
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
