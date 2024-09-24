Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659A64414
	for <damon@lists.linux.dev>; Tue, 24 Sep 2024 02:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727144096; cv=none; b=aA4jKvozb+DEronJkGCjQTKAHeD6+9RhyfDOwSakn8ztkNXRkzGwAKae4L+EULn/KMPiSaeLW/6KXH6n+JzZTZcmQ25nIcSk/5uPsEw2XzaBAKS5HNhgun/uFhA9ESHb3OAr0IZkRRXFg4S1ltYTmcgHJSKtw2oFnN1VAdJBMII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727144096; c=relaxed/simple;
	bh=oykfzB6nHLUfE9J1mnEXpZRH3mzaUWEh/zaEMy/bYcs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MN4SFLvKXQ1KiikRXjqQVP4bxd0XJ/hIR/XgG+TW7OTQ9ZQsz4Yo81yxfKzf/KtAG+w85RFXF5Y/rW1BhjOmQv0BaYmtshMRAqsDEQOwpe8PJZy3RrBV5/Rcv1t4nXsvwQsb3Qw9el3Hso9iV42/l9vf0+OLW6h12+yN9Iobvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee466f220971fe-4faf5;
	Tue, 24 Sep 2024 10:14:49 +0800 (CST)
X-RM-TRANSID:2ee466f220971fe-4faf5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee566f2208a446-7c9a7;
	Tue, 24 Sep 2024 10:14:49 +0800 (CST)
X-RM-TRANSID:2ee566f2208a446-7c9a7
From: Ba Jing <bajing@cmss.chinamobile.com>
To: sj@kernel.org
Cc: shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH v2] selftests/damon/access_memory_even: remove unused variables
Date: Tue, 24 Sep 2024 10:14:26 +0800
Message-Id: <20240924021426.1980-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By reading the code, I found these variables are never
referenced in the code. Just remove them.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
Notes:
v1: https://lore.kernel.org/all/20240903034300.10443-1-bajing@cmss.chinamobile.com/

v2: Modify the commit subject and commit log.

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



