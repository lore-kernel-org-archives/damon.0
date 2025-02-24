Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D87BAEC
	for <damon@lists.linux.dev>; Mon, 24 Feb 2025 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420437; cv=none; b=DPKkDKtsAw5Cigih4/thJt/kqgwWz/zqpj7RTAwjPJQZw67wrXOmWrj6nZ8rPRHbi7vU+XzTCdf4UsgJ1SwxEH/MzS97V3skATuWdTqRVmW3NKFzaFu9i466OxsvGBFN6MLAgQV1N/pf/7Uc2BW0fbTgWbkVy98wY35cFKiiT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420437; c=relaxed/simple;
	bh=Z4/w5Qv4+XJhiMCfAA99IiMLe+CIHW9n1rHbnqVcd9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xg9No9wJktnWbyme44lW18MVlUcFUFz6KVanMbiNWonnORoyejOBqxYN6EumRndCQiso2KRYsDiul6iqbfKB6aghiG/xTMHUdtZsTZBrqrUiu2siaAW4fb/19Cg6sK4n13Y6bY8VLSvNdSKfxxfu1xJKFkDmCDSpbiGh/9ejAFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkxVH7xY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkxVH7xY"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220d28c215eso73068145ad.1
        for <damon@lists.linux.dev>; Mon, 24 Feb 2025 10:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740420434; x=1741025234; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NB42FWkAwVgmX4/ranLUNLsMfoD5beB/svuxxZIvY4k=;
        b=JkxVH7xYZ426Noy3QUHjK9o8w/nnLvqY+gm/zAd+LybHmrt02Na9bYjXhqzcml/sZu
         6F70bf0gkIEN+BzEHgaBprjsrbv29ifpNCOWudTd8rIx93P3+CrlyNHtytR9fzlcmbv7
         +GAUzsZtoSXWk6xPB+WK/hMj4hVckagHSFWkPKKMkli6yeRV1cMjzspWfNI9gJvq5EAC
         aMbqjACGmhoQDJqILxzNzyWee+NvjMtvukJKJDSnmYI62WoHoQ2tvBmqEv+Uwt8q5O9d
         7MY1JD6tCCrD7RFoiERo0lp7NYbnVJmEELZCQpZx1phSIBkkd/0FH14jKXYGo/ulEqh2
         Il9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420434; x=1741025234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NB42FWkAwVgmX4/ranLUNLsMfoD5beB/svuxxZIvY4k=;
        b=TxemHdX4XuyFGNSP/AsVFJdT6vB2QzGKl3lmJjRVgnIc718vLUeYYLwoKjRahjANrQ
         9ZGzuOElkKASx3ohRAUuz4g4bcXWlo7bvi8UlYclLmfBo1fN/iJJknLbR0dKP5lYgmnw
         4R0phBEvNDbVvuGVl6r3wGw28l7wob9vIB1J6sF0w4CyeaauvG0iax6/WZKn4dK+Y/dK
         swtLcsHgZZLGTI0PukDDpfK3cBbKq71GvVlhovREU54ob5G5hIHLadFGThF891fiD7zm
         GCmazwLjNJ1xyL16iB5D7GJQqDHjqXQ1I5i3k8bhV7lixcD47/hLh7O7K9bXYLpTFG4U
         4dbw==
X-Gm-Message-State: AOJu0YwvKrKlQek3xnnF4evXgoWTzVFC0pWqdnQuABMolcTLC2CfNF2f
	8Pk497qmY5KNvHovprEFtW0FbRD6rhGhDP9jzJZoOe0g54BEHAYLh0r/Ig==
X-Gm-Gg: ASbGncvIscq/6l82Rh5Hv3sHxxQwiVlRoVYvgIivNeiY4pxPMNcZX/ftfwuXuSewdyc
	QNXCaPDPJn1DPrQJ3POv9YFS1hMFJ7cWpoxIGF294QiIOKC+XCIeSllDbcl/IMY3wB50w8uFWkr
	Je7O4uocmCbg/GCDUJ1sndVDS8ocN3YXgYkY3eFW3CBTBBT34a8DIh/RXNjSBuiSQY9jkB7Ffat
	qxqHtsOGRXuZvzwxSh9lDfKZ2oUEQn6X57RKRCmKSgpWk5LO4NQTPfXYgUiSJhV1xMqJg72VPg4
	xyVRv/bZtTbAxGv/jkR1Y8J/aDgU98+jYoYlMvSUuJaXKtE40QimatZStQZ5jcg907jh7kuM0Q=
	=
X-Google-Smtp-Source: AGHT+IEuFWs8SCsWt5nlJ5iLBBRYGXb/IdISBOdIR4gWRosOSQ2YzGozdec1BkZbqy+HE03vMX6EqA==
X-Received: by 2002:a17:902:e5ce:b0:216:6283:5a8c with SMTP id d9443c01a7336-22307e67561mr2478405ad.39.1740420434408;
        Mon, 24 Feb 2025 10:07:14 -0800 (PST)
Received: from localhost.localdomain (syn-075-080-158-112.res.spectrum.com. [75.80.158.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d072sm183088615ad.107.2025.02.24.10.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:07:13 -0800 (PST)
From: bus710 <bus710@gmail.com>
To: damon@lists.linux.dev
Cc: bus710 <bus710@gmail.com>
Subject: [PATCH] samples/damon: a typo in the kconfig - sameple
Date: Mon, 24 Feb 2025 10:07:09 -0800
Message-ID: <20250224180709.2167187-1-bus710@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: bus710 <bus710@gmail.com>
---
Hi SeongJae Park, 

I found a trivial typo in the Kconfig file of the damon sample module
while I was trying to do some experiments with sample codes.
The word "sameple" should be "sample", I believe. Please find the diff below.

Since the title should follow the format of the project, I sent a new
email to the mailing list. Sorry for the inconvenience.

Thanks for the interesting project! DAMON will be very useful for many
projects.

Thanks,

Ps: I found I didn't change the subject! Sorry this is my very first
communication with the project.


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

