Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B01C1FA272
	for <damon@lists.linux.dev>; Wed, 27 Nov 2024 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709358; cv=none; b=MYnKWqHbvqRrzz2Wr7fzB+ftzf2lKBrlKamM2gX2uX/Jca5KeHpYehZ9wTWLxCQX6mN3oMHbN2dRiynR15dHA1a2AzFAY4yhqPDSL0BHxu3PJ4Mwn7JzHSnKlMQYYLI1wNa2ZnN15vD1o5ZqCkF1k9vf97pnbucty9PFbhsxr20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709358; c=relaxed/simple;
	bh=Q/dXYurK0EJ5vp1EIci5u/hmGbtY2myVy1kxDXW9XI0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LJD0gPdj+BjpEbz9+CwHOm2ZOGXQXAlafrfolYSC3bPYAKjR9TNAxi6ggvyNBKZuBkNKW6Y/4BqaS0p+j4VFQsB3ppIl6jDqizHCPWaNXcOOxyV6Ju4kgq9mZ75wpQV0AtQoFUtf4+9SOVG8cKJ0oY2WkLizovOxAVi8uA7Xo4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=mNUZMkBd; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="mNUZMkBd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1732709356; x=1764245356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7U+yTr2d7RwRRaM5HvKRT7wsyxGZ2Fy6IJZvrr/C3zo=;
  b=mNUZMkBd3BreptclaiHDKkjew+dK7d6a7uSHsbkHjHsdgIZ6uJ+xTSgG
   1bBX0Gh5eOhWF/CiSj/kQaxlg8nFsepYyYk7czeckBgpDJ2tZJitqIvp8
   +SvXEQelrZZlsQ1YPTwD2o5WM5j1Ng3o2OpUmRhUrid/cekIz1uy+ZML/
   o=;
X-IronPort-AV: E=Sophos;i="6.12,189,1728950400"; 
   d="scan'208";a="677134088"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 12:09:12 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:28394]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.34.163:2525] with esmtp (Farcaster)
 id 8af6d9b3-8276-40da-89f5-2af5a6b7ed7d; Wed, 27 Nov 2024 12:09:11 +0000 (UTC)
X-Farcaster-Flow-ID: 8af6d9b3-8276-40da-89f5-2af5a6b7ed7d
Received: from EX19D008EUA003.ant.amazon.com (10.252.50.155) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 27 Nov 2024 12:09:11 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D008EUA003.ant.amazon.com (10.252.50.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 27 Nov 2024 12:09:10 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Wed, 27 Nov 2024 12:09:10 +0000
Received: from dev-dsk-mheyne-1b-55676e6a.eu-west-1.amazon.com (dev-dsk-mheyne-1b-55676e6a.eu-west-1.amazon.com [10.253.68.42])
	by email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com (Postfix) with ESMTP id 79DD880411;
	Wed, 27 Nov 2024 12:09:10 +0000 (UTC)
Received: by dev-dsk-mheyne-1b-55676e6a.eu-west-1.amazon.com (Postfix, from userid 5466572)
	id 0E730B899; Wed, 27 Nov 2024 12:09:10 +0000 (UTC)
From: Maximilian Heyne <mheyne@amazon.de>
To: 
CC: Maximilian Heyne <mheyne@amazon.de>, SeongJae Park <sj@kernel.org>, "Shuah
 Khan" <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] selftests/damon: Add _damon_sysfs.py to TEST_FILES
Date: Wed, 27 Nov 2024 12:08:53 +0000
Message-ID: <20241127-picks-visitor-7416685b-mheyne@amazon.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When running selftests I encountered the following error message with
some damon tests:

 # Traceback (most recent call last):
 #   File "[...]/damon/./damos_quota.py", line 7, in <module>
 #     import _damon_sysfs
 # ModuleNotFoundError: No module named '_damon_sysfs'

Fix this by adding the _damon_sysfs.py file to TEST_FILES so that it
will be available when running the respective damon selftests.

Fixes: 306abb63a8ca ("selftests/damon: implement a python module for test-purpose DAMON sysfs controls")
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 tools/testing/selftests/damon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 5b2a6a5dd1af7..812f656260fba 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -6,7 +6,7 @@ TEST_GEN_FILES += debugfs_target_ids_read_before_terminate_race
 TEST_GEN_FILES += debugfs_target_ids_pid_leak
 TEST_GEN_FILES += access_memory access_memory_even
 
-TEST_FILES = _chk_dependency.sh _debugfs_common.sh
+TEST_FILES = _chk_dependency.sh _debugfs_common.sh _damon_sysfs.py
 
 # functionality tests
 TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

