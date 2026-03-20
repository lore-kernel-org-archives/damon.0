Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577893264F2
	for <damon@lists.linux.dev>; Fri, 20 Mar 2026 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033502; cv=none; b=B8Jyi02Cg0BmEA5bO1qFl1L5tSAwMt+5nsbzm0fn8i43XY5t32VmtUFjoEv/fm/hrhyNT6RSWMV8sqSa1bYsLgZzLAISeecv8kis1L0CZxdn/KR81WVI/TdRMdjiF3grdZV2/sFXW2D1wVapzV+kiikHWPz/MdhLyiFkjlxUnJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033502; c=relaxed/simple;
	bh=38WZSCo5lv+k+5ZznusrVk4MfUht3WxQ2DgEfRCxPzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DfutUjTsygXUn8GA2ABIYRop41kzVPrPOp1F01TeA6N99YiZd8ev7qDCpHFEFE4iPW05od4rtRwPO3QAtgsmU89bFsPnQZKgDddx7vs0iAx+jZDz4+jijp5zw5kY/WHjDh88Fbkrm92EtyBiYLWD53cJim3Nvz1UGod8DHebCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0A3OHK3; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0A3OHK3"
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-64c9a6d7f81so898293d50.3
        for <damon@lists.linux.dev>; Fri, 20 Mar 2026 12:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774033499; x=1774638299; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrbpczjmQlWdU+8xGkQY54294j65e0aZRYcB8uO4mU0=;
        b=Y0A3OHK3iD5qBufSN8IP4gMRM2KpuEJgax7GLgJ+63aAj7zSQXZtv+4YMdbKo9OImm
         FHqsyFVR119/zLnRKLUWWjUVv3vg9xKcQg0eO5I11Dcuob2b+Lvh0Z7DowJX0V3p/w1h
         1tWVRVi2yya84Qms55wfImH99Gle1elTG/9j6MNC6gFRkUq1PtzSo2jIylBLzdxXRYde
         sSDzLeK8z3kvXmGrAatc/IVkuzNUBihj4pCNy6zgA1ub16RJg5ynQSRvwYPBAc0CRdcT
         aHjEHUBLnYGXtrNTGYLYUToVu9dJIl3G8CXf02Tmf2ZLByU5Put/SIwOGEYplZEaZ6BG
         xLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774033499; x=1774638299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrbpczjmQlWdU+8xGkQY54294j65e0aZRYcB8uO4mU0=;
        b=QoD0AFcK2S/2pi7GHWRVaMXx7es+1Nuy+9K3hsmFg+bEruq6/mKkUR7sBzp4CoNTD8
         kDJwNFw1SA5ft8dOpl+guIoXrmOtADcOqZEpf5FOVgladqGLu6eweDK49Wd2LVvGO/9o
         weoLxPcQgSM7Z+qfOcTgZ3aXhdRx/UMv6lHX3ndetzzIJuoNPcgKVU+wzVPvkFRb6GAA
         Wrtl0ECQaBa3ZAUYqYI5ny142J5SdkjBggs1EEDsrA+KYnaji8OQFb9mY5Nuqp0y7uQX
         lihk7GWydxlIXmkQPeWCseTdhydwE1HB6G34d45wHW41Urw476C0QbYjPw+ogQKJuPSz
         8rSg==
X-Forwarded-Encrypted: i=1; AJvYcCXqz+Gw/lucvh4/CxqJdaOZv8UyDCDDheMJ34FnM9z/pRrR7m7TC2EnULR8NTFm5cwVkp3PIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnRGu05ic2JbT/jcaal7fTChOM3KZujxT1nvBZRSY8tEZEo41C
	IeQxeRiHhZ2gE0VU+O/cbiP0w4BnCYmAlhc/Vwwq7FPafmyoL1NL5XE=
X-Gm-Gg: ATEYQzyo16LVo/yLgqXL06yNK7qQ3W/nhvaMLfacwxmNiaywMthu6WIt/dN5UFW6xPo
	fXl+8B6XcAz5jFPnCe8WuZxU4KfnPQzrVA2LdT7gMemYGgCtyP+LCT5JCGGhlJwuRbJjiMoQpXd
	iqukjMBFmtidwOwqN+0FI6eEFMmlIixI930gL3IfmQ+ZdFW57ehF80bju6nXCyWBZMcedp/bQ70
	cRm0yTMDm9TCpJ2j6EsdE2rLAC9qpvbeGW9HOXdypVFrEnSEBnVgmbP6mxg8gbpvOm735h94DI5
	7j7arjrCFSsLopiyToHmdpFBJnXvBE2sb9EhFcPZPp7KSh+JiKPBfm02C7HkXPewR9r1l1kgTDs
	fYdOZ4sa7MJNY5wdxYMRAzIhE3ehk/Ur7rvHnp3175CjLERHAjInvml747Rv0dNLhCtdAUvp36e
	twOT+LVRAw4VaeGEvKpr+uKaW0PtcO1SGJRlpHPfpUO+xgZ2ZkAU2YacYQCPdwhxNqJ/qz4k/RN
	Q==
X-Received: by 2002:a05:690e:16e4:b0:649:e501:21a6 with SMTP id 956f58d0204a3-64eaa6b8bdbmr3383035d50.16.1774033499004;
        Fri, 20 Mar 2026 12:04:59 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabecf140sm1983409d50.17.2026.03.20.12.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:04:58 -0700 (PDT)
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
	ravis.opensrc@gmail.com
Subject: [RFC PATCH v4 0/1] mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
Date: Fri, 20 Mar 2026 12:04:52 -0700
Message-ID: <20260320190453.1430-1-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces two new DAMON quota goal metrics for controlling
memory distribution in heterogeneous memory systems (e.g., DRAM and CXL
memory tiering) using physical address (PA) mode monitoring.

v3: https://lore.kernel.org/linux-mm/20260223123232.12851-1-ravis.opensrc@gmail.com/

Changes since v3:
=================

- The first two patches from v3 (goal_tuner initialization fix and
  esz=0 quota bypass fix) are now in damon/next. This submission
  contains only the core metrics patch, rebased on top of those fixes.

- Simplified implementation: removed per-node eligible_bytes array, now
  iterates scheme-eligible regions directly for each goal evaluation.

- Handle regions crossing node boundaries: uses damon_get_folio() to
  determine actual NUMA node placement of each folio rather than
  assuming uniform node placement within a region.

- Pass scheme pointer directly to metric calculation functions, avoiding
  container_of() derivation from quota pointer.

- Fixed 80-column wrapping issues.

Background and Motivation
=========================

In heterogeneous memory systems, controlling memory distribution across
NUMA nodes is essential for performance optimization. This patch enables
system-wide page distribution with target-state goals like "maintain 30%
of scheme-eligible memory on CXL" using PA-mode DAMON schemes.

What These Metrics Measure
==========================

node_eligible_mem_bp:
    scheme_eligible_bytes_on_node / total_scheme_eligible_bytes * 10000

node_ineligible_mem_bp:
    (total - scheme_eligible_bytes_on_node) / total * 10000

The metrics are complementary: eligible_bp + ineligible_bp = 10000 bp.

Two-Scheme Setup for Hot Page Distribution
==========================================

For maintaining 30% of hot memory on CXL (node 1):

    PUSH scheme: migrate_hot from node 0 -> node 1
      goal: node_ineligible_mem_bp, nid=0, target=3000
      "Push hot pages out until 30% of hot memory is NOT on DRAM"

    PULL scheme: migrate_hot from node 1 -> node 0
      goal: node_eligible_mem_bp, nid=0, target=7000
      "Pull hot pages back until 70% of hot memory IS on DRAM"

The complementary goals create a feedback loop that converges to the
target distribution.

Dependencies
============

This patch is based on SJ's damon/next branch which includes the
TEMPORAL goal tuner required for these metrics.

Testing Results
===============

Functionally tested on a two-node heterogeneous memory system with DRAM
(node 0) and CXL memory (node 1). Used PUSH+PULL scheme configuration
with migrate_hot action to maintain a target hot memory ratio between
the two tiers.

With the TEMPORAL goal tuner, the system converges quickly to the target
distribution. The tuner drives esz to maximum when under goal and to
zero once the goal is met, forming a simple on/off feedback loop that
stabilizes at the desired ratio.

With the CONSIST tuner, the scheme still converges but more slowly, as
it migrates and then throttles itself based on quota feedback. The time
to reach the goal varies depending on workload intensity.

Ravi Jonnalagadda (1):
  mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal
    metrics

 include/linux/damon.h    |   6 ++
 mm/damon/core.c          | 158 ++++++++++++++++++++++++++++++++++++---
 mm/damon/sysfs-schemes.c |  12 +++
 3 files changed, 164 insertions(+), 12 deletions(-)

-- 
2.43.0

