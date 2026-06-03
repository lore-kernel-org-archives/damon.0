Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9D33CAE9E
	for <damon@lists.linux.dev>; Wed,  3 Jun 2026 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485811; cv=none; b=ocP/gOs5PteZeT25iAgNzRX8exwyj9WtVnuVgNzw9WuYjlPcfKmoRYoqVEvBcSd6AHzBcLzPQ4c4i4fvBIUcroAMRLlLqUcJLkA4AyKZ0nCBVqSFqCyCWtZZbOsdoMO5oXcTInwYaG9BQ1o2E2beC+RDwvhxdEaA8SBrnlkMOfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485811; c=relaxed/simple;
	bh=T0Vlo84Bo3Cs7lFyOZ7y0jeOb5xQH3o0RelkxTSp1/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlGujEZZcS+gfcPDFkQY21QA4iJQBfanKxlPRPZDcdX/ntYuDccBWi5RDm7Rf0L+LEFA/nablDgHiUnxv+Ci2aaJ0NMpta3ZWHwRDIFfBEfLLP9FQa6+mt24bz/cUMOIyK841opUXxUOhxTZlLSkGFvAFfG+smquz2ZslpEHxlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/yDt/Sl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/yDt/Sl"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8419ab3a297so4096683b3a.2
        for <damon@lists.linux.dev>; Wed, 03 Jun 2026 04:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780485810; x=1781090610; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cF71AS3h+3BVCoCWP3BBEK0Pv+5PmyaBoL8qfGMYsPg=;
        b=C/yDt/Sldp52ZpS27owckHiWGrIu3907+z90PNIS0qGoebOlYlQqBGnoPoe8FCAKGA
         4GiSz5a+BewFqSSxLBTkUEDV6awuAYVGTspZYY0h47QdFekAZ9/W4Vn9l8oN+Tc9cZrA
         QVAKk7nQZQYZ5ot/1nr2zpnGviD2OHXF+n6i8tO+IZ3NshE5xzvEZjDr4+ZRcBvdG+6w
         cZ2vslhCgiTU6hVb9eaTsLfuvMgFLUQtI8xS1x32Z70+Sg5zWy9yKZspADoluV71bpxj
         kXBuN3i/sVjkFJlOtOYrxGCuipfCuIq7W3LMYuU3JMAGR5yI2s831IREe+5PX6DaYlhR
         U54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780485810; x=1781090610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF71AS3h+3BVCoCWP3BBEK0Pv+5PmyaBoL8qfGMYsPg=;
        b=D+B9jfWoBKg4xho0vHN6/tLgwhxKHnIVTLqO4UqMj0IwLAInpRIHWIhzHVEhbCFO5E
         JLFmdEkgoQd8U6YLbvqgMBrUxgz+P2H/GSTWaK03uKgDCbZFdWtbwnSuPBDTzArx++A+
         dpe1vTkBdhMpvB3JkqtfzxfCXjGSsz+E6y+gdlOBs+FpqT/8gGdERupZ//xhzzm79MbO
         JhRv3dr5X7T7lRRdW9ZYZdXLIY+5eX/coDkh24QixmxObm06sppbmSL8iO2Jgftk72zE
         vOmJjPHJpMZ9h1jPQlxTH87fcbsV9+spv4unovsVj1ad65p7uxB4Ux6NT5f6F3sDrn4J
         s9yA==
X-Gm-Message-State: AOJu0YxFChXf6dvExmBkstK1Uv90kD3+HqXVwjuDmkMy+VcXQhydyCY4
	TQOqMraA07SHm3XLZ/kd/zRZjZyKuvV9KCBXYh3npfL9RKygUudGsqAZKHs4BA==
X-Gm-Gg: Acq92OGm1FXyfGSPnD0MILzA+OiRUBxOC0n9d7Im2O+v1mC73dM2ZD1j6xK5inhW45q
	wQG1Eyj92euFIKIptTZ/iLEbE+NCmQTnrnOkLUjiMz3weXz6U9UvgzGNSX+4YtxRC+XHAtWnM/J
	bLesJmI1L9EfFpayjcNTXU/mVRZKzpxYKTN/XP8vnEwjJONUevOzS8V1uZjvEalfRXpRMVg45r4
	YYC24A1oK1gOkOxIYrPPgM7WSGEjjtJK8qgqS9Q0lTdTEJo0LwRYQZ0CLbALNfZZHa9TPHB3mof
	xjUXlcVBCfRYtAzvOxhmfv8cRiKw8gNH1yvDleM0FcCrAuDC9oVwSFkmguJosonSOyNbZE9U89x
	x6DqGrC38tH6r/9O5zp0TGWfLSuHz9WOGDk8Pg4IDeBzd+19CnDWGg5Qul10MVUgc4Js181IZxV
	JZWbpP7jljYP78J6EJp+1eNLPWyQjsVKk/gv4oMCOL62vrAgLu
X-Received: by 2002:a05:6a00:391e:b0:842:4681:eb1a with SMTP id d2e1a72fcca58-84284ef184emr2817428b3a.39.1780485809688;
        Wed, 03 Jun 2026 04:23:29 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:83c8:877d:4e1c:aa88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428325d9a3sm2661384b3a.34.2026.06.03.04.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 04:23:29 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: akinobu.mita@gmail.com
Subject: [PATCH] mm/damon/core: use kvmalloc for target regions array
Date: Wed,  3 Jun 2026 20:23:06 +0900
Message-ID: <20260603112306.58490-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_commit_target_regions() temporarily allocates a single contiguous
memory region using kmalloc to store copies of all damon_regions of the
damon_target.
However, if the damon_target has a large number of damon_regions, the
total size may exceed KMALLOC_MAX_SIZE.

This problem can be avoided by using kvmalloc instead of kmalloc.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 mm/damon/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 265d51ade25b..08e5ce53a7b8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1358,14 +1358,14 @@ static int damon_commit_target_regions(struct damon_target *dst,
 	if (!i)
 		return 0;
 
-	ranges = kmalloc_objs(*ranges, i, GFP_KERNEL | __GFP_NOWARN);
+	ranges = kvmalloc_objs(*ranges, i, GFP_KERNEL | __GFP_NOWARN);
 	if (!ranges)
 		return -ENOMEM;
 	i = 0;
 	damon_for_each_region(src_region, src)
 		ranges[i++] = src_region->ar;
 	err = damon_set_regions(dst, ranges, i, src_min_region_sz);
-	kfree(ranges);
+	kvfree(ranges);
 	return err;
 }
 
-- 
2.43.0

