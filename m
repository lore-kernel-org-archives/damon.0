Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC59430CFA
	for <damon@lists.linux.dev>; Tue, 11 Aug 2026 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443550; cv=none; b=H0MGNEdQlPxraQzXCCEWxevm4aGuVmyJ/gxpo2rPwe0LVdNVNykVsw/VABrRM2BQH0i1vtRNAa2IGOU5AcxRyji2DX2ETOWVkq3end+jeGzMPaWI7KRKdmr1xN6X/iKosyHvq7KobRiqz6CppdQ2wIzMkZNy33Sh6GmBFt9v2G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443550; c=relaxed/simple;
	bh=PCSKBzP8iDDG6WcChwnXOznum65VFch39UGYJoD7bfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNdndtMHx986VTKywJR8zMkyAxRN9xFO7VHeVEjqqkTBPbHgX47DgqmvY8x3Xq7fLuW7ltAYAjQWjR+jdaJP7Mu0P9Ahhs9Zj3+9USq4WIqu06H6qduBKdBs6UMiB/97/IV1g0Kkr8atgQxMZGpEDiCmGqLjC/zeWAdkcS2DD0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY3Mhdlb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY3Mhdlb"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf50c6f235so7397305ad.0
        for <damon@lists.linux.dev>; Tue, 11 Aug 2026 03:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786443530; x=1787048330; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I31AMd/F7pqHT/q95Yi0izk7wYmZR/DesQa+ulu0/Xk=;
        b=nY3MhdlbWvTq8gIiDyW9inivXKltA40ddTEXTqYYoLZCiku1DDhHd8Y6XdIKjYWw0f
         CV+RdzLErYZ7L6nCttglxvuqX95+Eb8lEyYFp9XZOxRosY8daRfEK2qdkqzIf5n+ncjt
         Q3vpkNrdtjRG8OG943PY0mnIsXLt6tTEXZkF28ryOLmU5Oh2BaPQJzsCteUTIV1f6SHL
         PaLDIJKrWrd5z2D3xdG+/PtfZT24XSceg5uLjv9e3MmC3AhEfFBwpCXHyptW0+EqTrb6
         0GuT7GaPZvcjBFc/en/ddMrBSKLuxNHAywJZBTLZ4swhvrQ+DrAttnqEai5mz15An2GV
         kXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786443530; x=1787048330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I31AMd/F7pqHT/q95Yi0izk7wYmZR/DesQa+ulu0/Xk=;
        b=mZkxTAPMqZyuBgo0mxb1rOLtvLALe69CfQUGTxvYuCo6I0eEHfIyAZWydYhfGvPGvd
         8b4CJ2IsCD0TzizcjQyaWQU7sEXLamDj8+5Tdx5Gb4lgYU7IU4x/MMje8Qd5qGNWliuD
         K7Mb0nQa8AIjPdsL++tKbKiC7TYpjTlWxmqh1YAmvQ5ELTQLTg4wJ8GmAtTgcdggwJX2
         TSFrTmwfdaV4J9hQAXmCaHfNQzyXp8SpK3QZ9D9JdbyUp7Txj4UGSNy9bTkbw2vt8n5z
         5d1uvv5c/Amy3NvnUNWDpc4zf5m5bC1WhmRgyWtMc3fY4GrnGl8dlljX0iWaYv32nPAJ
         NcFQ==
X-Gm-Message-State: AOJu0YzRa8J9zvpB85KGKnCTcksf0JB9daNua5aI5OngMGzCL2Qz4d5S
	WaAqgR2xlySLZJob6jFnHHxu/5OOESkO2JCo7sgk+aNvwIC1rzYM5gBSYbAZ/A==
X-Gm-Gg: AR+sD12sVv1+KdkcgoOZT7BlT3AHIwn5I1vARtkWqWNRUAeBHCAevnYpJpDbicir8VQ
	y4PkNQvKuBhB8Gpqsvac6omvL5sJ6rrFYvWpfXFFh8YDlXlIRfyZkzxIZOyuGtU38FWnpH9mGA3
	sP1tou4A/q449gMsnG63IHjrnfTlc6xV+1y2LpLFfHCZm0amLaREhxv4dV4RW1jEMgZ8i+dAG+A
	OxcWJiBKtrx22UxVsBh3lxfV5B+oqOg5dGHrv5j7/GsHORUHKW9/lX1xQ6xcNHmCqyjzsaH00Ol
	SzGRB+K32mDOTw6mZ2p4u4YMvNdLBBa8Zmc0RaaGiOTQx2tDm8V6BXjfP4/lc28LaSAr5Eq6ul8
	+8KIzLrSOw4s8+GuhGaMe77crBCiZOWo+3Kuuv9Pr+H6lbfT9EJ2Qsq8aaukRf3L+WUyqhXAHKk
	RX09pNJMcqmqfgedidhGzu2+yGIQcyAqswvWp1L55BCEbeFAjMLLt9axZrvweYAGk=
X-Received: by 2002:a17:90b:3842:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-392ec13bb9bmr1723772a91.0.1786443529788;
        Tue, 11 Aug 2026 03:18:49 -0700 (PDT)
Received: from celestia ([2402:1980:85a:5c46:85a5:ec7:8aa8:72be])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1412042dd37sm3752328c88.11.2026.08.11.03.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 03:18:49 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH 3/3] docs/mm/damon/design: fix typo of max_nr_snapshots
Date: Tue, 11 Aug 2026 18:18:41 +0800
Message-ID: <20260811101841.804596-4-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811101841.804596-1-aethernet65535@gmail.com>
References: <20260811101841.804596-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a typo (nr_snapshots -> max_nr_snapshots) and corrects a grammar
error.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 Documentation/mm/damon/design.rst | 4 ++--
 include/linux/damon.h             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 1fcf0b8c044b..62ba6cc2e999 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -871,8 +871,8 @@ action is ``pageout`` while all pages of the region are unreclaimable, applying
 the action to the region will fail.
 
 Unlike normal stats, ``max_nr_snapshots`` is set by users.  If it is set as
-non-zero and ``nr_snapshots`` be same to or greater than ``nr_snapshots``, the
-scheme is deactivated. Note that, unlike watermarks, even if a scheme's
+non-zero and ``nr_snapshots`` equals or is greater than ``max_nr_snapshots``,
+the scheme is deactivated. Note that, unlike watermarks, even if a scheme's
 ``nr_snapshots`` reaches ``max_nr_snapshots``, monitoring will not stop.
 
 To know how user-space can read the stats via :ref:`DAMON sysfs interface
diff --git a/include/linux/damon.h b/include/linux/damon.h
index d642ce4fc83c..75ece3d03be2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -549,7 +549,7 @@ struct damos_migrate_dests {
  *
  * After applying the &action to each region, &stat is updated.
  *
- * If &max_nr_snapshots is set as non-zero and &stat.nr_snapshots be same to or
+ * If &max_nr_snapshots is set as non-zero and &stat.nr_snapshots equals or is
  * greater than it, the scheme is deactivated.
  */
 struct damos {
-- 
2.55.0

