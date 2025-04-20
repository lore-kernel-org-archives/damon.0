Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA91D5ABF;
	Sun, 20 Apr 2025 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745178041; cv=none; b=pXAIZN4oD3HG8BcaByLLgbW+oT2k603XYvlMrQ2fOt9XCCN0ZFaK0SRG82I7XKvt4Wdqf89tMALWDPsKdSa7e4nL8ebkR5bAn4Ig7Ohf++x2npBVgSsFfCJ5CCdMoTi0zBKTPkUzPPb+NWqlMv9yszvUSEty2uYQ3Yh7ncV863E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745178041; c=relaxed/simple;
	bh=3TYJVSgc9rMx2w0Ytz6/FAhhzHJ5CZhkTze93ru2E9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aXHG9CfwYMgIiAEeoYJ1Mos3GWU7eGDjA3GUk2wVVjJe3Vh/PJV1tZBnrCiLlV742Q3qK7TOlG09wDd12r0kn1bdCJOxyzxk9kBIZSd17gdMgnLRvbe1+S8vuuZxWAWiUsO7pGC8dXaHwF6Cr7TrvHXNKzDMYUUblu9WvNwz3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dB/+9hkd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB/+9hkd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69E1C4CEE2;
	Sun, 20 Apr 2025 19:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745178039;
	bh=3TYJVSgc9rMx2w0Ytz6/FAhhzHJ5CZhkTze93ru2E9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dB/+9hkdeS/+vtFexHDFckLptSB20GvfwhNr1k6nuTTS1RPNyQA4Y6KkmNEGRZPrA
	 YAV+H9DxanIbrPOiYBlR9UqNMONiI+l2494Ut7MMJ9Hpdy/ILtDAncUIdyENvV5Z0w
	 Jz5bKfYKGfm9TLH2SG7oUDyedGxBTP7zILupwXU5yk0CQADf/oq8xLltjoCx0t//Mm
	 bj82gWSmKoUuapR2lp8vlkr3K/10mABvRZ3V7L2+8MM5OQm4ALCdyepMOH1X0ABpcc
	 +OiXELPZIYgR+y8NFlmWOIVagM4WO3QX5R+IHTvm/VdOQ9S01gR711CQj7Pj76Fduf
	 jFmAWfDGrloxg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/7] mm/damon/sysfs-schemes: connect damos_quota_goal nid with core layer
Date: Sun, 20 Apr 2025 12:40:26 -0700
Message-Id: <20250420194030.75838-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250420194030.75838-1-sj@kernel.org>
References: <20250420194030.75838-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface file for DAMOS quota goal's node id argument is
not passed to core layer.  Implement the link.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 7681ed293b62..729fe5f1ef30 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2149,8 +2149,17 @@ static int damos_sysfs_add_quota_score(
 				sysfs_goal->target_value);
 		if (!goal)
 			return -ENOMEM;
-		if (sysfs_goal->metric == DAMOS_QUOTA_USER_INPUT)
+		switch (sysfs_goal->metric) {
+		case DAMOS_QUOTA_USER_INPUT:
 			goal->current_value = sysfs_goal->current_value;
+			break;
+		case DAMOS_QUOTA_NODE_MEM_USED_BP:
+		case DAMOS_QUOTA_NODE_MEM_FREE_BP:
+			goal->nid = sysfs_goal->nid;
+			break;
+		default:
+			break;
+		}
 		damos_add_quota_goal(quota, goal);
 	}
 	return 0;
-- 
2.39.5
