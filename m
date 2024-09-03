Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419361C3D
	for <damon@lists.linux.dev>; Mon, 23 Sep 2024 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074722; cv=none; b=W/OCkGch2/Fh73D/WMM0TXpOvlRF20Qi5BBaxkrVH7IOjHSYOQJSXYC+qbscTjiR+d04y39Tav9aiaydYmv1UsoFmWMMB1iwmh2Or2GgoJYfmDYIwrfcymkkzgCm2An5E93lDmmHwbU//YmlC6EadcsEW1TggMSCYHC/TPljdpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074722; c=relaxed/simple;
	bh=/2JVorIG7th0ajxlD50o5U0sBCabrYn/8381IRn39OU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IQNtZf7xCMQabpjYzjP0ml75YytBNEJzQqf8u3Kijlv8fcc6cXyuyB4jbGIU6rkFKcqWRU6WyzHbjeCwqpBHg3BKd0Wk1jJ2Trm3YtJBlOWdoPOk27sjatoMnD2m/kYZnHwia59Qze26aCLpp6/GCmV5Cmm+1eFVn5hQeqhSYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee466f1119a2f1-48be8;
	Mon, 23 Sep 2024 14:58:37 +0800 (CST)
X-RM-TRANSID:2ee466f1119a2f1-48be8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee566f1118bd55-540c9;
	Mon, 23 Sep 2024 14:58:37 +0800 (CST)
X-RM-TRANSID:2ee566f1118bd55-540c9
From: Ba Jing <bajing@cmss.chinamobile.com>
To: sj@kernel.org
Cc: shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] damon: access_memory_even: remove unused variables
Date: Tue,  3 Sep 2024 11:43:00 +0800
Message-Id: <20240903034300.10443-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These variables are never referenced in the code, just remove it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/testing/selftests/damon/access_memory_even.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/damon/access_memory_even.c b/tools/testing/selftests/damon/access_memory_even.c
index 3be121487432..a9f4e9aaf3a9 100644
--- a/tools/testing/selftests/damon/access_memory_even.c
+++ b/tools/testing/selftests/damon/access_memory_even.c
@@ -14,10 +14,8 @@
 int main(int argc, char *argv[])
 {
 	char **regions;
-	clock_t start_clock;
 	int nr_regions;
 	int sz_region;
-	int access_time_ms;
 	int i;
 
 	if (argc != 3) {
-- 
2.33.0



