Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E1D3D5C38
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906854; cv=none; b=k17bvD+hNsF8fY+kGqbgJnQk0RqGRoygH5kulbIjlPYUTsIMMFeW5PcHHpJe/xp1U73q9XkrUjOkapE4murnR3fx4RFvI4MT4GYBOZUyXPR/Zn53o/UY//mIMuQh5TbqOg46ieiL8lWVsh9QH5twoXVoVdDBnFEg/a/tCYLutXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906854; c=relaxed/simple;
	bh=7YC0d3Lq199IvXL7FoCsyY5HhEMvPtTx5vxAZ5uu1NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vn6dsON+H/8agGwoe5FP75S6BdJOLF4MSQOBxM0+BymtFfehqDKGS1luYHRRR21jdLuNNXBxduhiMHfAEDtyNKsU2Q3E1pw2nhJhqGD8KGbmn8Dwc19XuB9Yolv0xyXN4dXIk+UAvM33l8MMB8Uovl8G9d0J6NhvGlJKwQcIA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2buQ8Ue; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2buQ8Ue"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so1515743a12.0
        for <damon@lists.linux.dev>; Fri, 28 Aug 2026 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787906852; x=1788511652; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RXLz3Xl6C6oGFGDAhFniglml06HtyDSEVADuwjc8Bss=;
        b=V2buQ8Ue4OObsa08IMvyuMH08NRmDMjWqmNbJ/GjDvDNiEBPAU3B+hT7oO1HgmBYCg
         pB14mnjSQsRFLJ4d955nDBrSKZG0ugEyICeIiqpbGV377nz+OGwaby1sIUxFm5LL3kS2
         Fb1wYmdF4x/GflS3W7fp64Y7n/Z/MFmPJbFikBD751uf0fwT65MbxrSUcx3OJCFluR78
         o5yk11dVVbEa4WgzqJTtcXFt+TRbYsZmJcsQI3dxqFklpC59FhZKZvgJmMSJ7lyQbZiP
         UiRs4NiTpOc5VvHOwAnE8eboMDbu8lmoUsqCIx64rAs0opYZM57J9T8cGjpdBCxeCezt
         d7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906852; x=1788511652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RXLz3Xl6C6oGFGDAhFniglml06HtyDSEVADuwjc8Bss=;
        b=hWjEtbDo6dIiPfF7B3WQpKCgrs6J/2PWgtntl3igEFh7vTDNQSOs3LIDCHbFco/TSO
         gYPfUzsfT1Ozlj/sqjz2v4WDMUfQXeyEWXI0cxhUq5eYtas4EJn/4WF/0P62/yytUom/
         QOuKwKMwJsVcippJw8Zg7f2Qj2ml6tt9x+egRAhh6nv1iDzAxQOeR2p4tQDrt73MxXI+
         NApTEosQguaFiH/6B3RJ5h6hWqT3iJiq6/aZK9A0Xflbg4uVqx8zuvReYJB5mp9750ha
         yVkwoGPGqgPACkvM0A1OabuB9xej+Qkck9DcX+z0j6bUEOPManEHHcHNoVjJMioNvcME
         5GWg==
X-Forwarded-Encrypted: i=1; AHgh+RpbELbf2v0OQGYQ7mR/dsVpeqhi5bLs1Z0ZUpj0B3YkFFndz2J5klpb7pCxZ+dzQiIQxiZNXw==@lists.linux.dev
X-Gm-Message-State: AFuF++mX0TtHw4kWVq7/ngkpleFU9P19KjhCZbejcmCv4m4aClAvl2y5
	m3qXn6O7qC5SZUcnkrQmIj7v718c8qML/mJdExuBCFJ0CN2h2pMJ60tJ
X-Gm-Gg: AR+sD10vGQsJPG135eSGGWGx7OOYI8c4guKt4A1hRmvUONq6/9ZT6ClEjqSBLuB+pX0
	0HUfedYylxzIsPgQs1iVMfnLdJM8MRs2Q0mfjGKdKf75vcSzFvaurYR3+2N+qMFBcE9lzHV0pAp
	s+OL5CS1U2Yb8rmr8QvNtOr8cW/4jEg59+g+v8FqZ6fUq1npvpwWThx7XCBCaHqCyTljq0ll8OV
	oF1lTlmLBW8kXf3xUD/MVrTlnhn9nD9fRvUY0PMjlXSKEeFZ+TbPPIcRCqyOGFkzJf3sLzlvaxW
	gTPqxDD6vCThGCtFFD7BwwzaYOyXKZBXTpqdf2vH1dumM5eYBqcltDi2OOURJc0efRQQw6nze7m
	uvN5klsT6aFtiJzDeFAH5c9ZrVCbKlr9WZnT6BAiL/dAYl6ZVv0Att4QYv/eITxthIEVTxnTcLq
	OSqqOC5s2kKNj7zKsUFi3LIHWpLYYk8KP8Il1RDFclKVpFRAYqsN2WoMHJCd/ZZGGnQg==
X-Received: by 2002:a17:90b:1a92:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-396d0d35e02mr5577342a91.1.1787906852389;
        Fri, 28 Aug 2026 01:47:32 -0700 (PDT)
Received: from celestia ([2402:1980:88cd:27c4:5897:46d2:587d:19e7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b1992e05sm6292591a91.15.2026.08.28.01.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:47:31 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon: fix unconditionally skip last region
Date: Fri, 28 Aug 2026 16:47:37 +0800
Message-ID: <20260828084737.290024-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once quota set, the charge_{target,addr}_from unconditionally skips and
resets at the last region of the tracked target, so the last region can
be skipped even when it has not been processed.

Example:

    1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
    2. Quota is configured to process only 50 bytes per window.
    3. Window 1: Processes R1 (0-50).  Quota is full.  Cursor is saved
       at (Target, 50).
    4. Window 2: Skips R1 (0-50).  Processes R1 (50-100).  Quota is
       full. Cursor is saved at (Target, 100), which is exactly the
       start of R2.
    5. Window 3: The loop reaches R2.  Because R2 is
       damon_last_region(t), the old code unconditionally returns true,
       skipping R2 entirely and resetting the cursor.

    Result: R2 is permanently skipped even though it has never been
    processed.

Fix this by only skipping the last region after it has been applied.

Fixes: 50585192bc2e ("mm/damon/schemes: skip already charged targets and regions")
Cc: <stable@vger.kernel.org> # v5.16.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---

Changes from RFC v1:
- Minimal fix, only fixes the issue where the last-region is skipped.
- Add an example to the commit message to demonstrate that this error
  occurs very rarely.
- RFC v1: https://lore.kernel.org/damon/20260825124616.5129-1-aethernet65535@gmail.com

---
 mm/damon/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..21dc6b086c42 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2347,14 +2347,15 @@ static bool damos_skip_charged_region(struct damon_target *t,
 	if (quota->charge_target_from) {
 		if (t != quota->charge_target_from)
 			return true;
-		if (r == damon_last_region(t)) {
-			quota->charge_target_from = NULL;
-			quota->charge_addr_from = 0;
-			return true;
-		}
 		if (quota->charge_addr_from &&
-				r->ar.end <= quota->charge_addr_from)
+				r->ar.end <= quota->charge_addr_from) {
+			if (r->ar.end == quota->charge_addr_from ||
+					damon_is_last_region(r, t)) {
+				quota->charge_target_from = NULL;
+				quota->charge_addr_from = 0;
+			}
 			return true;
+		}
 
 		if (quota->charge_addr_from && r->ar.start <
 				quota->charge_addr_from) {
-- 
2.55.0

