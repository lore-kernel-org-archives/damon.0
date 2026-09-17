Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8694E3812DB;
	Thu, 17 Sep 2026 04:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617947; cv=none; b=H/BZ6nZfqhONssm7PxpEnWbD1KpH+sRvmjs3lhMNX/0QLsVLcuBtP6Jp6y1TNAElLfpKzA1LRziwmgyDr8cE35E+rgcHbXKMmYx28t116pnc9zweLNBTmql0+yPyR2uKa+99XbJVMa9CNbdiSutnOLQXIOxiBsMWXH3LodyqimQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617947; c=relaxed/simple;
	bh=5HJTnDNhiF64IPu/ybSD7Z1IbDO0pZhnSblqS6GJ/0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Njy8jsYR3q5kOo4Y9esYhcDKMULJD5Xb64oK2VDMJhiGedamcQIcnBXCgCaI4qc07qIzbgX9kY+xbNxNOZB8iFSJwCnP5xf0Q4AUkd/ikAlENaDJzJ2ZFNRPe85JaPEGqyxmLI+3jgUK8O9T/p5Mq3HdmEJB5QDZrVFptfwH5oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV54DsBz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV54DsBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9C91F00899;
	Thu, 17 Sep 2026 04:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617946;
	bh=t4wob7RRQ/fb9yIvPkmCYITSEq7R5wOfYsN9M2cgFSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eV54DsBzc5z8y7fr/46oE/Wnq1D8InCVloq5Z/hxf5F7EqYunqzmqPJJD80u1swlv
	 11TJGJrgnsZvPSDp3rPVU0ExhAWklD17ZypmXAOTHWVzN2W0LuwlJvHkgBVuPggPWH
	 VOrh8gqtv7cuI+WcqlHsUN+7y7uMVOJ8z+u3rYwzr/+gEXeZRhqj1q0n+4RvUuHU8C
	 4WqzwAf3D1jDEs7vWRR823CBv9pCMOTichPSMSGktRPTjsw1pyZX6f7H1TcCwc/DtD
	 qyhU9vZlgqrwdIp6S4wUaUB1h8XTG8Q9qmH7fjm7nJQ6BJcWZu4TtdA00icDlNs/sk
	 LRey78S7YZ1eQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 03/10] mm/damon/core: use mult_frac() in damon_feed_loop_next_input()
Date: Wed, 16 Sep 2026 21:05:29 -0700
Message-ID: <20260917040537.107341-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917040537.107341-1-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_feed_loop_next_input() does its best effort overflow protection.
score_goal_diff is always smaller than goal (10,000).  Hence the
calculation can be replaced to use mult_frac() without concerning the
overflow.  Use mult_frac().

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0299729e79ed9..7bbbd44379301 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2928,11 +2928,7 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
 		return min_input;
 
 	score_goal_diff = abs_diff(score, goal);
-
-	if (last_input < ULONG_MAX / score_goal_diff)
-		compensation = last_input * score_goal_diff / goal;
-	else
-		compensation = last_input / goal * score_goal_diff;
+	compensation = mult_frac(last_input, score_goal_diff, goal);
 
 	if (over_achieving)
 		return max(last_input - compensation, min_input);
-- 
2.47.3
