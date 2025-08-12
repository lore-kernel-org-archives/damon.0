Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA752D46A2
	for <damon@lists.linux.dev>; Tue, 12 Aug 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008005; cv=none; b=pml3sbRfv2U/QCfzGKRk5HrJYzP2Uumwynl+QBHu/vhe3JLE9JVNOHvLu7uXTvqHxprES0r/hFEikGX0D24byPQpkEzRx6Cy1R67OpNrXy0YN8bfHyaggmPSZ87kffeHmRPZkusesvwWwlpQGZH696p0Q2ZIm+e4jHTnkbJfDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008005; c=relaxed/simple;
	bh=YnBi+fYr3rM0e22INNVCVv3vAIuTanrmE6vBvg9qITo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fituEMrpVnYEV+q365bsM5TX8vAhTm7GiQV6aZvWtEcUHZ1p0beYDpcvqblc1w1ReL1peO117Iqn6ZUjrfrdjvs0KyOvojJbsvUkldYY6E+4/n/q3w3aXERAkAYuB5uDsKAsCymgQv9Nwl+FqsJhOsdniV/ib2yqgA7RUlOoQp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dswMSMjR; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dswMSMjR"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b422b31b1c0so3444329a12.0
        for <damon@lists.linux.dev>; Tue, 12 Aug 2025 07:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755008004; x=1755612804; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0qIlZAnbmsEop7bXptIK6g/iAVRWR9GRGYEwk+FqxE=;
        b=dswMSMjRHx5/q54NFSYxC25Rl+lxSbR395ATgsD1rc7aJIUCD18TDMRiCtCZEuOXYo
         FuQf6ukAlDx9zLDx0O4nfNvDEnp7LlAiUDU6sF54PhSZvXwT5Py2cRdNjIF+t4dIMQ40
         rHr8AGD7GeQAU4BRNi2wdL6N85WH+ElcLxseluGoiRg+B9xnbzvjG4cFqptYemO3LNzL
         u/5sRd9gYrxHudGtwdvpaiBdNbOCSa1R9XKrjqEccvgwFGBV3vmmRvFSDOVG6m+AZUkk
         aIreJX8qIckoEGeL2T3rJn3YNz1yZRrvhOH6ygaLl2xZJDUE3r++eUdo3iQA/CeKFvNp
         SLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755008004; x=1755612804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0qIlZAnbmsEop7bXptIK6g/iAVRWR9GRGYEwk+FqxE=;
        b=rSQclpE8BPyhUPr3W9/+0LMtXCPYHVCOphkMHmxQ7K9TKngpiANETtJmH8Dy9eLYKL
         bsy5z5zJFpG5TL5U2x6Vy8nxs9I6OenuowLxzD1fLtMcNhZiDceLCvO6enyTOKapWwjR
         L/oaQrTwhiOOT1frUSHTGCmGpNi2U4HzNqI6oWerp04syUS7XEpyJWnUssT453+lXknw
         JB/OKLu10igASSw7Ei1Uwrml6K2Y7OKVfU8lQWSXxoIIExAsotqN/X10zu2kXmX+SegC
         U0s/7qnNPiV4JJt1rA/TCxruA7me3PkZ9WAaIHn0JJiruPkIQJx45AlBKGP/34fizcD8
         zpEg==
X-Gm-Message-State: AOJu0YzR+Fwam4fv2OM/ytv3a7uB9KPFem8k+1Hrm8edGf9kQCp63Fns
	yIe2zPqgbR6zT50C4Tgf5HMALwTTAlENMzZrNn0sSNhUeQCEPd97V0K7
X-Gm-Gg: ASbGncu3Erj0QzCnrQiCUAlrslYAYy4O1b5IZoA8U6/qpJlyDESvQUtXmVf8mADekm7
	sEGECTFMhy3OC9FIpu1KMlsivdZpHDI6cGNK8unrmu3g1Ir8td/sdyI8MX2R1HqyysWd+Uo2lMe
	zsF5SYCkKs4c3RZ7mTV7LJW3HpuhTzT+e52twQetkl1O/z/THUGNuyjfo2bYloaA8Xw8CustYj2
	8UUOcljKII6LzR/+ZWXrQxxuC4VTONzShj+vXQza2kFra8RvVJWADbHBkSlDKlh4vM7zG9duxlj
	usyphG/m9lR1MvvhqXfXXKg3G9mNDmURGPujQhtRYg72CZZepXuic9ul0417SkPTgE+o9l7ZUID
	decwnFy7UOMMmj7GU
X-Google-Smtp-Source: AGHT+IFgK5KRRqi8Qvf5NAZ4PCDhsz+QvcKxV1nn7l8sqcD1xBfuhyD90pduF5AubqT1xPb72OCNDw==
X-Received: by 2002:a17:90b:55ce:b0:31f:867:d6b4 with SMTP id 98e67ed59e1d1-321c0a3ce48mr5270805a91.10.1755008003647;
        Tue, 12 Aug 2025 07:13:23 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216121ec0esm17978865a91.10.2025.08.12.07.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:13:23 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] selftests/damon: fix selftests by installing drgn related script
Date: Tue, 12 Aug 2025 23:00:46 +0900
Message-ID: <20250812140046.660486-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drgn_dump_damon_status is not installed while kselftest setup.
It can breaks other tests which depend on drgn_dump_damon_status.
Install drgn_dump_damon_status files to fix broken test.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
---
While setup kselftest executable environment and test this patch [1],
I found similiar issue. Honestly, I don't know exact solution for this
situation. So I just make a new patch. Sorry if it is wrong direction,
then please let me know how to do next.

[1] https://lore.kernel.org/damon/20250812-alex-fixes_manual-v1-1-c4e99b1f80e4@rivosinc.com/

---
 tools/testing/selftests/damon/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 44a4a819df55..029de547f31c 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -4,6 +4,7 @@
 TEST_GEN_FILES += access_memory access_memory_even
 
 TEST_FILES = _damon_sysfs.py
+TEST_FILES += drgn_dump_damon_status.py
 
 # functionality tests
 TEST_PROGS += sysfs.sh
-- 
2.43.0

