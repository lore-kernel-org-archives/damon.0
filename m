Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662E037C0F2
	for <damon@lists.linux.dev>; Tue, 24 Mar 2026 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363759; cv=none; b=skAa5P4j+83KYTYOToyh4Y8dzZsYed1jHV6zlJR3x/8Uwt5cg+PwZwofGgHpRhVyBAPdzIUrEC2nWTZTZaVNQLS6QNhBGATBYG/a4hCz0FRlizG+oOtGKv7yTfykPZbkNlxu6v6RtXIchwfjBfQBNTEmC1bx+1IVEsmAhDtpSjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363759; c=relaxed/simple;
	bh=XvSZWxaAXywlzabKR7BIDShF6Tq9Q+3wmC3P9wsxAqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAoohkjeDmQE3D3Y6vDWj1uAR1zHHSqTAr6gYfxp5whca129ZgrOKNgTivjZl0n1iiKdJCAk4FkxTmUy7dFf9UMliJFgC8ILEKrKq/NlJgkLWkhLNl2sExLhYRLdnlaPkeK5FNnteXeGkV2qsLb/GnOtKVYfb5xub83oLGSWsrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doUTNJS3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doUTNJS3"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b07069e2efso9139275ad.3
        for <damon@lists.linux.dev>; Tue, 24 Mar 2026 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774363758; x=1774968558; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSh9sYTNfvPCviCi4VjGmuUXLd20wXWnwnWNNQiCwBQ=;
        b=doUTNJS3yAJB1sdr9qWQIGL91AEL95zmTgaVc4dKCjz4lYWDuGdsg1KXa8G6hRMHnM
         Ofjmrmv8eJgYF+iSifyoIB/G63G5xbJ3YCbhaOwVMcQ8olP9hM9yeYGAJyr4JX04iGK9
         0lfUKFRUwFuKcm89Wg2+CKB5LL6rhhW8sQTymsXQFwKe0FS+jLT79URISZflvVcEHEf5
         r3Gm4p4k8LBZi7K6UdMB02m8O3EA8AA+0vcF9IJjOZ0m2cjv26dCWpK+gSh87FGCj+fL
         f7MNGMvW3SXapgDygOnXCL7hIHKOLLa11w5I1gJLrCTyADyMUmgsanpJeaizjreZsFty
         zqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774363758; x=1774968558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSh9sYTNfvPCviCi4VjGmuUXLd20wXWnwnWNNQiCwBQ=;
        b=Cvuewne+7nI3Dq/vdyhwFwy+NlJ+sb6dNQsv0NolSUxPkhK0akOjYUUxeEKA6hkHou
         Ycmvb+XQu//FXqDUHB+2x9YYXjwWR0zFh7FiF/k/nkXTpUbvRB0BOaISWZvF7BLrNgDu
         tnJ8GR5J+dqyM2+lFZZpiaCStytq7b4/vw7sDiGn8++7M8fI5dKHk3fLgm10Xrb4oFJy
         n3t2KW+Sdr9rhIow7Yn6V2WMGUA6qascCoMzm2wOTwbhc3Mri8+qsnpCoxr5HrL5nTYi
         s/2mZo4Rggf9uyMyu0p2+kz/QsCnFAC2q/4pLtc+FpU5MjQAwh/JHzgYRdDDIPB4HttY
         f6Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVrvcVTxIJU+ryApY/Q3PypK+OzH9OqFAxB/bw/P4pOSwtFXNMGdUYGRlmKGdgs9b4SXZg2Lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwR1Z7kFxqUtAXjnfxMq3t/lNKB4mkHwEZRZ9MBcBij9t7X44j+
	kIIQcT51YDwqRr+i+4ddUQN/Uo86soMRiZUHHCKseXgqD5BHoVOD7d1X
X-Gm-Gg: ATEYQzwkny+csHFjoBAfEULdLSBY0zTWSHMykJBq6bPL9RAwR6+4wXbHcRtVpXGrDCG
	63GjkbqhlCPCUfA8woRJeasgEZBkxODQyZMpubta2G8ss1NbeUkop0o/eOsC640V1MKou6CGp4E
	D6kCTLArRSxvyW8+e2VV7HOefjUjkP3GPoTFXuC4i5q5wqO+GbrkQcSOGA62cpZ0+vmqA0Qturr
	yCDhGE5hZBGW31fyGXhxhO0M37+35nJBqIeh274DnhONI1zhBWyusYEtzuKX9nFjux1y+vU0YdZ
	0b5zWEaFbgTcp3M2G9BBGvx8TMKTZgBiMa3cgljsfIbc5UWLZ1TQ2ZPeMqagqWVYfOM0TRHYBmF
	jM45OQajGT+6eTN+5yn7/ZMSICfS8e1mfEGAXyx0t0NbqShhqyoJpRFTSoPAaYesUOlqOwISHVm
	fgHOsPhHgn4WHgpKgfQ7NtwFk=
X-Received: by 2002:a17:903:32c6:b0:2ae:55eb:f82d with SMTP id d9443c01a7336-2b0826d751dmr162082965ad.1.1774363757621;
        Tue, 24 Mar 2026 07:49:17 -0700 (PDT)
Received: from fedora ([2402:7500:a2e:a774:5078:e5c1:bc34:6044])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516ab1sm201252325ad.5.2026.03.24.07.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 07:49:16 -0700 (PDT)
From: Cheng-Han Wu <hank20010209@gmail.com>
To: sj@kernel.org,
	corbet@lwn.net,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	Cheng-Han Wu <hank20010209@gmail.com>
Subject: [PATCH] Documentation/admin-guide/mm/damon: fix 'parametrs' typo
Date: Tue, 24 Mar 2026 22:48:51 +0800
Message-ID: <20260324144851.12883-1-hank20010209@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the misspelling of "parametrs" as "parameters" in
reclaim.rst and lru_sort.rst.

Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 2 +-
 Documentation/admin-guide/mm/damon/reclaim.rst  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 20a8378d5a94..4f6a644be2ff 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -75,7 +75,7 @@ Make DAMON_LRU_SORT reads the input parameters again, except ``enabled``.
 
 Input parameters that updated while DAMON_LRU_SORT is running are not applied
 by default.  Once this parameter is set as ``Y``, DAMON_LRU_SORT reads values
-of parametrs except ``enabled`` again.  Once the re-reading is done, this
+of parameters except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_LRU_SORT will be disabled.
 
diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 8eba3da8dcee..1f54a2d270f5 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -67,7 +67,7 @@ Make DAMON_RECLAIM reads the input parameters again, except ``enabled``.
 
 Input parameters that updated while DAMON_RECLAIM is running are not applied
 by default.  Once this parameter is set as ``Y``, DAMON_RECLAIM reads values
-of parametrs except ``enabled`` again.  Once the re-reading is done, this
+of parameters except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_RECLAIM will be disabled.
 
-- 
2.53.0

