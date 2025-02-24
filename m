Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FBF1448E3
	for <damon@lists.linux.dev>; Mon, 24 Feb 2025 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740376522; cv=none; b=cLthafwH6m65LxcXskkVYd0nl2Liql4OIrS1/goE7esUN4TwYHG6Ug7Z1Z3uQfbIOKfJMjLwelGyiJ7UHnW8gDYytelMQMtEDqOjGre/McmBOD9uchHXkUdQfTAfmWA9+MGUCva+/WWmcXigx/hrrQ6u7ufrh7L2PvQLIvxQvDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740376522; c=relaxed/simple;
	bh=19F4f0Fv9n9XmIoTCJjRjkiXW7iMW62lSYY/Uub5oko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S5jq35ou5Nbm4oDple7ioIgk6cs1keQuhJOXL6IsD9VKyE76UahfKLhr5uZzwnYOSYZezemOyyVIJWfq/KGMx3muWj5fAhvzg9erFzliGawz7dCz+OPq8uvC4/+cbwNFAxu/j7CsDudjnBnRh/LHP+szkwJHfczjbRcrFFH2zDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRkTWtAk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRkTWtAk"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220e989edb6so107452575ad.1
        for <damon@lists.linux.dev>; Sun, 23 Feb 2025 21:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740376519; x=1740981319; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IyxinwRoWfIUvi07BO+24CfRMm8ewsee8IjOwDzSvK4=;
        b=DRkTWtAkUhdm9wA74ogAdrNQVp6hrGlGJloNTUuqyKzpK4tr44atX71UEiE+OeGcvQ
         t5SH6AEnpAmTettX3CqxpTu2QEEMJSfhA9YXaC1bDaEcZfZLByUdjvqMjkLRNqwXQj8H
         oVjvnMq7SuPGv+UJ6vw3IqFBrwpRASL4wN8H2kAViEfeSQ3vZCX+JCTZ5ea2/S/mLFrN
         NCSCPm9JGr8s9YB7E6HMFEl5XQICFy3ixW8BgyVhtl7QPzQDRQAIA/jHxFvmB9Evlmo8
         U9ToHkbAoQQvwDVTmV+jUMTniAexxP7xdzajFkipf4GVu7dPudnNO1dnRl4jUKGaoJgD
         GNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740376519; x=1740981319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyxinwRoWfIUvi07BO+24CfRMm8ewsee8IjOwDzSvK4=;
        b=KJdzzfDaF13fI4rRIkWqK4WMCZl0583Ba1UkhAP5aTpbbdYnN0AgLIim7dWn6JuMQ3
         JG5n+KPI+8dd0Q0oIeVvITIxlstHH0TuPZRhsGCjFmcgaxfLoBQ6yYAvrdHFXODKstn7
         COrX1bNJEKRBdvQD/trJ+brglRk/5QzXKiD8dOYd9fsvS4IeVRryoYfmh78n4zNLGqlx
         B8j066vSCnxrU0J629mkQJv1ii/3/N1wd664xWuZs/ubZNT3q3FwMGDdeTKt40CvHroF
         EIcJMLUaqm1UbepwgxRdNuwuB/Q0JRfbWqovzWLoNHbgNtb14lbqn4JtxwsDbfqfizmM
         SbsQ==
X-Gm-Message-State: AOJu0Yz1f9UK1+y4B0lsgzsmPK/MviMlyJslyiVr1ot6kWKZeat2mApQ
	Rz7XM7yxKBdXVeR52pfTabdbeexKQFBSlmEe6HOFz2VOTanjTGkAidJsYQ==
X-Gm-Gg: ASbGncsKocFO+D5OB54n4tRVazhpXnCk7DrmpOCU0fmK4hYDMhoXJG/gJW4jyYaIpec
	bo08kys1jVkpjb4ogVqudgfTvtsEQLO62HLqi3U0z9eudlj8hUhF2zOT7f3pL48xfExMzA+QdP5
	qoQqc4OFUYcmQ6/mRApzhYnuymeJpvA2AZuq1cY4+BH4EjE8xZC94a9YC6pFzUdryTZuvSejg2N
	Iy6vkyMpJ+xNgzlk2fdgi81wLiHL3IAn0YYeegaVmJcrrtFGThIdIGkALxkVIk3I5c2ybdXIcyc
	shyhdQcaBwQ420nntAQemQv2MjVENmXIHqcDMb9h3080Ew6hJln4ug19ZUHGZ/Wib5Hfep3x3g=
	=
X-Google-Smtp-Source: AGHT+IGJuBcdIUwmgSxrgJKNYromlNp3fHBCB8Qbgkq9hM9jEv5MZJG+yXytrolwN11Z12O8oq5Chg==
X-Received: by 2002:a17:903:32c1:b0:21f:564:80a4 with SMTP id d9443c01a7336-2219ffb68b1mr198659925ad.33.1740376519301;
        Sun, 23 Feb 2025 21:55:19 -0800 (PST)
Received: from localhost.localdomain (syn-075-080-158-112.res.spectrum.com. [75.80.158.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55866f9sm170292775ad.230.2025.02.23.21.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 21:55:18 -0800 (PST)
From: bus710 <bus710@gmail.com>
To: damon@lists.linux.dev
Cc: bus710 <bus710@gmail.com>
Subject: [PATCH] A typo in the kconfig - sameple
Date: Sun, 23 Feb 2025 21:55:15 -0800
Message-ID: <20250224055515.1614285-1-bus710@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 samples/damon/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
index 63f6dcd71daa..564c49ed69a2 100644
--- a/samples/damon/Kconfig
+++ b/samples/damon/Kconfig
@@ -3,7 +3,7 @@
 menu "DAMON Samples"
 
 config SAMPLE_DAMON_WSSE
-	bool "DAMON sameple module for working set size estimation"
+	bool "DAMON sample module for working set size estimation"
 	depends on DAMON && DAMON_VADDR
 	help
 	  This builds DAMON sample module for working set size estimation.
@@ -15,7 +15,7 @@ config SAMPLE_DAMON_WSSE
 	  If unsure, say N.
 
 config SAMPLE_DAMON_PRCL
-	bool "DAMON sameple module for access-aware proactive reclamation"
+	bool "DAMON sample module for access-aware proactive reclamation"
 	depends on DAMON && DAMON_VADDR
 	help
 	  This builds DAMON sample module for access-aware proactive
-- 
2.47.2

