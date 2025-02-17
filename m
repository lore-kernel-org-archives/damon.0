Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F0224F0
	for <damon@lists.linux.dev>; Mon, 17 Feb 2025 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739829320; cv=none; b=fqQ95pMKStmEekzhHcaklSs4WVDp7Cd4oXrjySXbWCKd6teHq61DIJt8iwH0VUhtuX/FH6CuO/x9mEvXyaRqXO1yv5IZXhTbpK66R0d30ARZ+g5jW4amOdd+RVnCsdpahxSqAJ9i0DlOOxAZCcoi7BvEHTTzH1hnWgWUfYLlOB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739829320; c=relaxed/simple;
	bh=Klq5PffbptHsOJVEB2b5DtQvJLo5pgHVICeP/mMF60Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C4KbRIMEl2xFM0/qGYdOjNIDShCFZx0dwZT5QXtlVjB2P36uHAe5YoF9/ZIZNQNkSVKVzBjGopG2bKtRAj3aRx+A88pvG4qXlb1+Dc/2EZpxGZUFXSqwpX1fAT0ObrtfscmlmXjPvb31EoR0IiHMj/Ru5DndrjsxCXW1Rh8hYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8ywTygp; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8ywTygp"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-726819aa3fcso2982206a34.0
        for <damon@lists.linux.dev>; Mon, 17 Feb 2025 13:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739829318; x=1740434118; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYbyfH/z3kCWKfyK+UZYlz7QdA/EN+W4bn8ufKQeJxw=;
        b=h8ywTygpls+VavRbVwu6oRP7afWiIcFnEl9NlZsvw3WTW6qiit9yquP+UmJPBs0Gqe
         IbL+TtT0M/wa5qgl1k/otcEhxM9iBHKot/sxQIfPxSu7TbXwA2Zn3d//k8kwTYI6jP7c
         PKmVipIGdOaIXCsMwnFwQxrzjtU2eowBHb+C7UjbpdhNk16yG3JBFDk+Bv3d+ge5A2x5
         tHbYNRnn9x4tJXwpQVYbD+nj61nUP0W3N7+vkeu2DYQNYUvG3La9puuIN+UeTTFhqvEe
         cJp0OfCff9nkbTjJY7aF2Bx0epPE/sTHg9dnjiaFx54HmQavHHaokzz7lsST/ZUl7NKm
         qOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739829318; x=1740434118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYbyfH/z3kCWKfyK+UZYlz7QdA/EN+W4bn8ufKQeJxw=;
        b=TBsi+iJhrA26CVo4iDnwnBzPlx+3QQrFeRX2KCk8rls5FOKEDKQFQdwjkhnh9hhJzx
         pXYw7NoAnAHBMfr8fH3eSPb/DXMR+w53fAhmqWbxTSDjGPgNx6mqQZ72OUNxOFUkhc6w
         qdrLsz1ExneeZ2OrSehIYlF6HVgk8zB3mswH/NHjBREZwGedd990UtEV7/9p6nF+yQ8G
         lb+r8qP17K6jeeG41vhBF1ek1bWmCkJHvLF2HZiOq+bKXv9mqyCGAP7FPgXVfO9UvRwz
         3XJ85hzl/ZWf7EpTMwgkgpmAhFN14pTFpOALv/3Vy0HdfHz+IdggfFHrgtoEMkUy92sV
         RtKg==
X-Forwarded-Encrypted: i=1; AJvYcCWmiQwEviMz3MjC8oJqCPr8bGaQtZo+TctpVL7OwpqV3CIpqflf4lct8Q7EQ0nQuJZXgDC+bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAw2Dd+hNkK+c1H72kb928z2a1C2pLXM190nmpRelH1d9oGw5P
	eLm2XcrIQGELef9znI9KQCxgknNYnDAQDLGk1ocfTAIosa30X5LiJiSrfEey
X-Gm-Gg: ASbGncuyUWuNeBVSZXjs5DDaK3oKDU9D0hzgNediUhS7b65Q7ge+6edyFAs1IrExs/I
	ej3Hlzt2memCjGnKB0ZMAO7EWt+vhm66h/LvzHSn63RximKApsTBeXKaHDfsCK0eWPtdBE34cfZ
	c3ZNo9WBzYag1V/Bl1y8MQnu93rCdLX1j1ZfvNVF9TAO0XZRV+wrwWnPBB7wetkgsIQ1J9vBF4y
	52djL38msztxrgPllQBXTskiPSGeIri9TsWPgwRabteEXrro6AdXc0HSwYyDrk/wUI/Wdgmyhv2
	St4d
X-Google-Smtp-Source: AGHT+IE/Z8qDavaEeJ7asNwxo7RVPa/QkzcDHNrjSkiIXGWHCNus7ijcxp/G6T/9w64ZpoGE6m7fbA==
X-Received: by 2002:a05:6830:25d3:b0:727:10dd:ca2c with SMTP id 46e09a7af769-7271203f2a9mr8475106a34.10.1739829317811;
        Mon, 17 Feb 2025 13:55:17 -0800 (PST)
Received: from fedora.. ([2804:14c:64:af90::1000])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72728549a33sm518922a34.2.2025.02.17.13.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 13:55:17 -0800 (PST)
From: Marcelo Moreira <marcelomoreira1905@gmail.com>
To: linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] Docs/mm/damon: Fix spelling and grammar in monitoring_intervals_tuning_example.rst
Date: Mon, 17 Feb 2025 18:54:31 -0300
Message-ID: <20250217215512.12833-1-marcelomoreira1905@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch fixes some spelling and grammar mistakes in the documentation,
improving the readability.

- multipled  -> multiplied
- idential   -> identical
- minuts     -> minutes
- efficieny  -> efficiency

Signed-off-by: Marcelo Moreira <marcelomoreira1905@gmail.com>
---
 .../mm/damon/monitoring_intervals_tuning_example.rst      | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/mm/damon/monitoring_intervals_tuning_example.rst b/Documentation/mm/damon/monitoring_intervals_tuning_example.rst
index 334a854efb40..7207cbed591f 100644
--- a/Documentation/mm/damon/monitoring_intervals_tuning_example.rst
+++ b/Documentation/mm/damon/monitoring_intervals_tuning_example.rst
@@ -36,7 +36,7 @@ Then, list the DAMON-found regions of different access patterns, sorted by the
 "access temperature".  "Access temperature" is a metric representing the
 access-hotness of a region.  It is calculated as a weighted sum of the access
 frequency and the age of the region.  If the access frequency is 0 %, the
-temperature is multipled by minus one.  That is, if a region is not accessed,
+temperature is multiplied by minus one.  That is, if a region is not accessed,
 it gets minus temperature and it gets lower as not accessed for longer time.
 The sorting is in temperature-ascendint order, so the region at the top of the
 list is the coldest, and the one at the bottom is the hottest one. ::
@@ -58,11 +58,11 @@ list is the coldest, and the one at the bottom is the hottest one. ::
 The list shows not seemingly hot regions, and only minimum access pattern
 diversity.  Every region has zero access frequency.  The number of region is
 10, which is the default ``min_nr_regions value``.  Size of each region is also
-nearly idential.  We can suspect this is because “adaptive regions adjustment”
+nearly identical.  We can suspect this is because “adaptive regions adjustment”
 mechanism was not well working.  As the guide suggested, we can get relative
 hotness of regions using ``age`` as the recency information.  That would be
 better than nothing, but given the fact that the longest age is only about 6
-seconds while we waited about ten minuts, it is unclear how useful this will
+seconds while we waited about ten minutes, it is unclear how useful this will
 be.
 
 The temperature ranges to total size of regions of each range histogram
@@ -190,7 +190,7 @@ for sampling and aggregation intervals, respectively). ::
 The number of regions having different access patterns has significantly
 increased.  Size of each region is also more varied. Total size of non-zero
 access frequency regions is also significantly increased. Maybe this is already
-good enough to make some meaningful memory management efficieny changes.
+good enough to make some meaningful memory management efficiency changes.
 
 800ms/16s intervals: Another bias
 =================================
-- 
2.48.1

