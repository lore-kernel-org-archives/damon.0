Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5123A2571A7
	for <damon@lists.linux.dev>; Mon, 24 Feb 2025 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419911; cv=none; b=WnAYcFoU++jmMJCLYeasb+Aa5h8Pfktjmi24Xbo/VTbgdLCbI5J2HjjoQJc4PpRmHReo8UZ5If6J6ffc/CHcvYRRVNHc9e/Q/7WNfmVeVPjfpMkqoylGT2XGBLQoPAG8FNqypxvMMXpofh62iaC3rO/onWPNZlorWirzs/OOZRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419911; c=relaxed/simple;
	bh=SGHntMcMChDkFhb6LJNZb+a8cGzq/mjs4x/4wYQZgNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rb5LNXenaGEPMHZDSAWMECZHP30FMCy7n/6mHJEMEkPwmxFE025HehM38NUudOvgq69DVqGqH1+DOqS8aPCb98mxkOMjtnhqkRMDpMH6loN+V35RDdI5Jg6PirhK4stGbLMIU5Ls/aA30yLOt7VUQq8S986dYu1AQbJxH+Hcn3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5yvTF1s; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5yvTF1s"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22185cddbffso96283405ad.1
        for <damon@lists.linux.dev>; Mon, 24 Feb 2025 09:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740419909; x=1741024709; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LBbeEId7i/cSXb4dEgtCny6CFfYIY2sekZzyFq/WebM=;
        b=f5yvTF1sb9zHuACVemSUltpj5fmVTd4WZ8TlgTMAckBkZPr+bBfJHnYoJgaFaE3ttL
         vwrmnMSX4dgTWtfrAZEUJn5l7gb/Dp9JrSNHuKhlD99pZfpkO/Pd9L9eKTDRgoaMxr6/
         thceei88E/RDA9k+ofbAstu1xazuVgovC2t/spMm2sGtNgQaKoCDFlKr7nyPv3CGfny6
         4Dl4Wju/ytXasFy5b25VSjOKABR4D6vVzMDxEhVDkFOJRciioaQch9d57nZUWvWLDmMP
         xZ8h9/3DT3r6O8g3B/77Rd3z/I7WIpGnrfUeWHhWTbIzhWtMshoXe1pBp9sUTNaTz4LK
         jdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419909; x=1741024709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBbeEId7i/cSXb4dEgtCny6CFfYIY2sekZzyFq/WebM=;
        b=HR+2LZr3gSMxrGr3y0TzpId/f+fOe0KPHydDv3Kpt5TimCi+slbqh4Z6EkY72gmrce
         Dw2rGso+fxIoSCH7X44AHIm2ANf3CeD5o41IuB9c9B2ADAbwcKIJy6JaYZbr/1qHS85o
         hGvhb23lYcjHMmav8XrLOEYK7jWr1hsilNf8KEJcbNuN4Wg0VwOJ+RocIYI8B9BUGoqm
         W6DbGutrKXYki3fzuX9wsOAUEl3t8v8/9fIXR63V7Q3GYHNmoZX5onwjuEg2fORpXSdd
         YimLruWqffvAKBKzChoB6PxnfBpTRhohlSnC6N19puDWz/4dDv+RkqLRUCFTX0JCNKHE
         ruKQ==
X-Gm-Message-State: AOJu0YyCQ6tRi6byw/fYVBTZ3iPf/uWuBOI18KMfuRIN8raQaYSacFg3
	1AGn7kfAoKOwJkweuPapYgL8BtTjlySEGQ/viDBJ1wfgWyMzf7nweAJ3jw==
X-Gm-Gg: ASbGncuE2ep0JKLu6Y9qTjRsRktQKzo82WtBfHpdYmgwdlN5MGmFlXBnaWtqW0jNaP5
	KlkaARp5hJzR2jdNAi+GcAoLJ3oku3JyA6CWDKopMKqIPnS7ZYIUDHffwqdEAWuBb4k5l23OUD1
	lu1D3oLzBbSMYsGFC9xTmdhSpA27abLRYNytcUjcMeK25jGXbePSjhIdL7vo8A+nF2cE4Ls39IC
	gF4oX3HBS+nJPPAXU0tac5NleoCYYJgYrWzHMiQCg093QuFUOCFg68RR5UaprI45y/fEIzVmo1A
	tf/GTLcWa8Govk2zGK6kYvN5JptTS0eRpBCedpP1LE/sxCAbfZ1xZUTCjjFsDC0kT7v1uDZwVw=
	=
X-Google-Smtp-Source: AGHT+IF6iEsx0gc1UzIoEvuQz/ZEsYpf1n9bHFuNrg6mOKPLnq7Fy3nWhSlFK4y4VK15GdnAlGeEAw==
X-Received: by 2002:a17:903:64e:b0:21f:40de:ae4e with SMTP id d9443c01a7336-2219ff862dbmr175807435ad.9.1740419908750;
        Mon, 24 Feb 2025 09:58:28 -0800 (PST)
Received: from localhost.localdomain (syn-075-080-158-112.res.spectrum.com. [75.80.158.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d62dsm180289335ad.149.2025.02.24.09.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:58:28 -0800 (PST)
From: bus710 <bus710@gmail.com>
To: damon@lists.linux.dev
Cc: bus710 <bus710@gmail.com>
Subject: [PATCH] A typo in the kconfig - sameple
Date: Mon, 24 Feb 2025 09:58:20 -0800
Message-ID: <20250224175820.2162409-1-bus710@gmail.com>
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

