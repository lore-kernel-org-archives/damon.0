Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCF91EB9F9;
	Thu, 20 Mar 2025 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742449188; cv=none; b=L6VuOjHNtU5PVa1X24ulHr4xpQdnmQRhAUcOHpeEsdM1HcVVqkln8ldOTC2DmNySXqcQAb8m9LZIuOVWBGvAYKQTaT6pfnpLZSFt7l0MLEY3QKlEaThAlhZfsc05gmbhTyefj0cyEI3vMQnLDwM34ats5bf50dujCGjOJbIuURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742449188; c=relaxed/simple;
	bh=XQaaK4k+JMUnTnVG3VsB0CorNexnddJX0Ik+pe2BQNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YwHXiK1w9y8btyGDZW5BytGL6A9+KWMd1zRIqY/YbetS4/zf+mQIvvcKndJ7GDhjlA5MAQApytadO9voBy8Lpvt5tP+9EDO3tsGS+BmFutiF0AFHgUiMxr6SlV0mJnLZtt533kaWEX49s1h8XHtACq1kxIPX4hoI/tIAT9DW6Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3UdBg7N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3UdBg7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45791C4CEEC;
	Thu, 20 Mar 2025 05:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742449187;
	bh=XQaaK4k+JMUnTnVG3VsB0CorNexnddJX0Ik+pe2BQNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3UdBg7NUn2KJfiPTiy4xitiLKXZyJ9KCW0pGb2YpljslkUGavw7Hz1A9+QTikZuh
	 95N4Z9LwkdglOzUKA5qla1QGc9Bg59LBHcBXuJKpdMmZz9m8VbzuuEXZtWw7pqqutN
	 0ns5GIeZKr6gRh34POdwaW9Tpfnhcn2hEQX0OBGgkIQgCGqGEMHrNLdELRDnjSU1vP
	 XKfHhbW3OEh6cC1ghgs6xenERVoDnvmbWTsDLW7GEuR1VZpLTIT6JPc2ODo8sef7ut
	 wV/8KJoZtrgxym1XE3aY9yYlhyEr9Prm1XY0i5GHDS55EX1NxAIfZeuiDJH2qNfEXu
	 XNS5UeA09+4og==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/4] mm/damon/sysfs-schemes: connect damos_quota_goal nid with core layer
Date: Wed, 19 Mar 2025 22:39:36 -0700
Message-Id: <20250320053937.57734-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320053937.57734-1-sj@kernel.org>
References: <20250320053937.57734-1-sj@kernel.org>
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
index 8c51906c8268..e85559b16d6e 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2153,8 +2153,17 @@ static int damos_sysfs_add_quota_score(
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
