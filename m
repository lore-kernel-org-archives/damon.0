Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2E8312821
	for <damon@lists.linux.dev>; Thu, 29 Jan 2026 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723901; cv=none; b=SwD7UkkUOwFn/6IXAb0pRlnPhuesJiUXfkNvBAg3DTrW2/AVlr6zwjmWIhU6lBw521idsUj02MlOxnNVT8O5gz/XhBe5dGwNntbXUYVjf3EhC+ogMmLrY0CPnF/Jb0MrDJBjdicSEno0EbmHDUDOQ8l8ziu71Zlo+fw8sn6zQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723901; c=relaxed/simple;
	bh=fy8EK8PWQZsqSffsYil7YART3hXT+T+mHqmJlgR9iak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onvY1Blcz16RoUwm0safZFPNwceBzJkZ4d4uahctYTun02TBTsc5Z7vM0MU8IilDFgiTf1thRVVRTf5J8xiQstxm7uZ4lIymS2oIZ8AdC83kt/+0cS7uBI16kfrLwYxMQdesMkj4owzmO0mcCXLWbek+2Fx06Cy6MaXf5fgrmIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S22DOWrG; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S22DOWrG"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1233c155a42so2488075c88.1
        for <damon@lists.linux.dev>; Thu, 29 Jan 2026 13:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769723899; x=1770328699; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C7ZtJvE3dpFWqwjZMa9omEQRwNhNuc19ZVJnJ8avCkY=;
        b=S22DOWrGumb3z8CH/RA/gnQ6c816dxAwtYM6UElew3GU/IFxtty7O5l09rN1Bf/a/y
         0ejeuVfH9EGBfciN01XCVBesj2OAII+O6eElsTFIs3PEGR0kh9YJkcUA5kHJ05PtNqRm
         5dTDsPbJ2amiETwEsFgYs1wY9m9/C+sAlq40ZTD3pGJgYhkG3BVyMsgychrIEJI3aaVd
         yNsNl84jeEE2lQckTRtL6r5oGkbvhZWOmn1/IT2E78TXlzviA1J6tTpxjHVADeKd7qtw
         b1KUUDyAEmHjX2fTT7TWU60wkfdbqIqrJakQ+ERTWrRmXNGQTf0K3FHkSKeebaKjGGVu
         rr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769723899; x=1770328699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7ZtJvE3dpFWqwjZMa9omEQRwNhNuc19ZVJnJ8avCkY=;
        b=QSPfKyeqvqp3tF0orIhQppzOoKn38hCxNx+FVL1GNyBI6ziEGWm5XomvteVaARq35r
         /4H84pJ3U0UHEA0n+4WeKuh+LoTFU2GG7qMSLPP+cCtSbyS40zWFgmsX2OQGqpsPdHIl
         IE57+vZuPdiBvYHz3oXyD5v0m1vQ2BVWsnG5ZVmZ2ohdFPcZ40STAhKcKc6k+6gEkgYD
         YC7uRrt5HRgJ1QHucYswD9x8MFgcN/UgUURHSF7cweGKYZFwf/5wb9e/e36J9sYnwvE4
         U71IFCgYqBrH/7top1jo7mtdjgL812S3gQMl1bnwA5hgC39oW9dTNdI2Ms4Wr+DgpifQ
         e3sw==
X-Forwarded-Encrypted: i=1; AJvYcCVbosc6dK4LBle4Wh2AOga0UpJSIF+SySi91HKH9nU/m2hO69cDRyO/M+8Nn5h8jYJBdQhjNA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywsuozi7duTaL3Q/iOTsOc8TR7Ma4dAU9fd8CA/3zKu9P399MUU
	ui58gQaAGmibXjDn+lBxjU73IUe7XsH7SCw7Lav6PTRwpI92cE6+nAE=
X-Gm-Gg: AZuq6aJq+FhubT7ZyOKymB9gvAnLU8AvJWz8/NnIwp+fBxCvOs6oyzCFKHb7UW1lEiX
	S3n00zhBF0lzwzUiTkAnkH+0+JdRcu9p1q6AH15ch1S3zThmSXs5ccF/9ay2cWC+CHMmM+KoCcN
	SzWLSn5WKsmSpP4tTSsSQh+WoW61EYk3aYRJXFpIAZ+RiRmeAUuY/CnA/9sHOmLuVxgZpt1H8V4
	DQ12s4jLN6srOjzLPwEvfSNG6c3240ihSZEHzQxCYTmkJIhpist394J6H3cnLA+kA2Bo1/xafx1
	Vn3HNZmxqI0Nt1pcr0mPo6X/OObMegQ0wKntlGXA2DXU2NoCZdWizTd/EioDgVMGimFGs0nWSa+
	ip795EkJjbTYz5iUxt0ZklVSiJfhMKbmVd98VBgaxwc4SlbHuBLat9kXpcTSZpGlLJ8OK0NGjj2
	uoyB5GRvMxUw==
X-Received: by 2002:a05:7022:68aa:b0:124:a610:62f6 with SMTP id a92af1059eb24-125c1006e73mr427951c88.44.1769723899034;
        Thu, 29 Jan 2026 13:58:19 -0800 (PST)
Received: from localhost ([137.201.204.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af8a7bsm8593035eec.34.2026.01.29.13.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:58:18 -0800 (PST)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: [RFC PATCH v2 0/3] mm/damon: Introduce node_target_mem_bp Quota Goal Metric
Date: Thu, 29 Jan 2026 13:58:11 -0800
Message-ID: <20260129215814.1618-1-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a new DAMON quota goal metric, `node_target_mem_bp`,
designed for controlling memory migration in heterogeneous memory systems
(e.g., DRAM and CXL memory tiering).

v1: https://lore.kernel.org/linux-mm/20260123045733.6954-1-ravis.opensrc@gmail.com/T/#u

Changes since v1:
=================

- Renamed metric from `node_sys_bp` to `node_target_mem_bp` for consistency
  with existing node-related quota goal metrics (node_mem_used_bp,
  node_mem_free_bp) as suggested by SJ.

- Fixed the metric calculation:
  * Numerator: Now correctly counts only scheme-eligible bytes (regions
    matching the scheme's access pattern criteria).
  * Denominator: Now uses node capacity instead of total system memory.

- Removed the get_goal_metric() ops callback. The implementation now
  resides in core.c, following the existing pattern for other metrics
  that have ops-layer dependencies.

- Removed the early-exit optimization patch. As SJ noted, this would
  introduce a behavioral change for existing users and should be an
  opt-in feature with a properly designed interface. This can be
  addressed in a separate follow-up series.

- Removed capacity clamping logic (was tied to early-exit behavior).

Background and Motivation
=========================

A previous patch series [1] added weighted interleave support for DAMON
migrate_{hot,cold} actions for vaddr schemes. That approach requires VMA
offset information to determine target nodes, which for paddr schemes
would require costly rmap walks.

This series takes a different approach for PA-based migration control
using basis points (bp) target-state goals instead of weight-based
action rates, avoiding the need for rmap walks entirely.

What This Metric Does
=====================

The `node_target_mem_bp` metric measures:

    scheme_eligible_bytes_on_node / node_capacity

expressed in basis points (bp, 1/10000).

"Scheme-eligible bytes" are regions that match the scheme's access pattern
criteria (size, nr_accesses, age). This allows users to specify goals like:

    "Migrate hot pages until node N contains X% hot memory"

Unlike weight-based approaches that specify ACTION RATES, this metric
specifies a TARGET STATE, which naturally prevents oscillation issues
that would occur with weight-based PA migration without rmap.

Two-Context Setup for Hot Page Distribution
===========================================

For distributing hot pages between two NUMA nodes (e.g., DRAM node 0 and
CXL node 1), two DAMON contexts work together:

    Context 0: monitors node 0, migrate_hot -> node 1
      goal: node_target_mem_bp, nid=0, target=6000
      "Migrate hot pages out when node 0 exceeds 60% hot"

    Context 1: monitors node 1, migrate_hot -> node 0
      goal: node_target_mem_bp, nid=1, target=4000
      "Migrate hot pages out when node 1 exceeds 40% hot"

Each context migrates excess hot pages to the other node. The system
converges when both nodes reach their target hot memory ratios.

Complementary to Existing vaddr Migration
=========================================

This series complements rather than replaces the vaddr weighted interleave
migration:

  vaddr migration (weight-based):
    - Per-process control
    - Fine-grained interleave patterns via VMA offset
    - Deterministic placement based on weights

  paddr migration (bp-based, this series):
    - System-wide control
    - Target-state goals for node capacity management
    - No rmap overhead

Patch Organization
==================

1. mm/damon/core: add DAMOS_QUOTA_NODE_TARGET_MEM_BP metric
   - Adds new enum value and documentation

2. mm/damon/core: implement NODE_TARGET_MEM_BP metric calculation
   - Adds damos_get_node_target_mem_bp() function
   - Updates function signatures to pass ctx and scheme through call chain

3. mm/damon/sysfs-schemes: expose NODE_TARGET_MEM_BP metric
   - Exposes metric as 'node_target_mem_bp' in sysfs

Status
======

These patches have been compile-tested but have NOT been tested on actual
hardware. Feedback on the design and approach is appreciated.

References
==========

[1] mm/damon/vaddr: Allow interleaving in migrate_{hot,cold} actions
    https://lore.kernel.org/linux-mm/20250709005952.17776-1-bijan311@gmail.com/

Ravi Jonnalagadda (3):
  mm/damon/core: add DAMOS_QUOTA_NODE_TARGET_MEM_BP metric
  mm/damon/core: implement NODE_TARGET_MEM_BP metric calculation
  mm/damon/sysfs-schemes: expose NODE_TARGET_MEM_BP metric

 include/linux/damon.h    |  5 +++
 mm/damon/core.c          | 66 +++++++++++++++++++++++++++++++++++-----
 mm/damon/sysfs-schemes.c |  5 +++
 3 files changed, 69 insertions(+), 7 deletions(-)

-- 
2.43.0

