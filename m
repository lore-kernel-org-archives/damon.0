Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3EA292B2B
	for <damon@lists.linux.dev>; Tue,  5 Aug 2025 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410849; cv=none; b=sp3h43OWa8JWNsuHcOphwYhe0C/FrnfxP0UeRgptNuD7NJ+WW5QnwUdBBWrPj5sdf4I9eKobiejgHp7Jsoa+NmlRWxdT5bUE8Q0HsfRBAc0/uo+4kTax6i1fKcvwADOnQcSX+oq0Od9jIICMCmafeRp6inpDXN+V0sCrC2Jvn2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410849; c=relaxed/simple;
	bh=kGu6ateMi7sVTdbqTnQdM6yz9XUdSnjZndgL63CO8s8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fVPWzKD9OKdoEFOlfp1N5Mz5GH3CyHSFaNZ+8pNiDArDV11CubLzt5OJPhi0HRmwoYC0hhb3R2wOJCm/kPiK+jepTeqLW+bK+eTYYKze0IrfmuyOCqgAKr+o3MPtu0uXUG5i49gGMKNukPMg5/5hjoCC158mn0FCBzbA6l8l760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+xE56Sw; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+xE56Sw"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71b4b36d0bdso45324037b3.1
        for <damon@lists.linux.dev>; Tue, 05 Aug 2025 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754410846; x=1755015646; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KPqctxuj25XobMQhW4L+Lm26tm0IYdYeYBgTx2rSnRk=;
        b=S+xE56SwKt21l0BPGGTbcTL1o2LXiZcjOV0cDysG78iDBgBdEr2EHVW033dLjEYdzX
         H5qpOQscydNedRegzDkygg97RMLVNE2gUxgzGm6coWBmuXWYnaUCikATZswaDsKq+1Zh
         2A/OSaAAS20v02vviJHtHqxwc/p1yH6JivbcyCxR33S8FBCw+f8bgxxXU8aS6/JPIHGG
         mZbI6VxVpsPMhW3czKARHOsXMAPEaCArTyj2LWLmMpW4VNYwUDwSn0ZoH8cq+I2/4sLg
         7yb5kTiJgAYB2BCmDmRDkCd8kRN7BnMNQPobgKz+K+iUX4l68Au853Atl0N3M85wn2gs
         6KcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410846; x=1755015646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPqctxuj25XobMQhW4L+Lm26tm0IYdYeYBgTx2rSnRk=;
        b=g2sPnLeOJUs39mnRMAGvUqqMPQ6xBf/DaZkbOPCBqGhkg7qQdw7LHfIy2sqQFlxlY0
         rRRtG2r1wveycy9jddJiIJrnWDTJr2Kxbkwm137Kf1iN/kSoBcazCm2sxoRYfiQembXv
         J6fs84KcEpnUYEBCT2bSR37d2nLih/o14N84myJlBZakNlszxEad4gyAoEbj+wNi5fDG
         QZKxLGzq5BQB2LVARoYTQPSAMHBTSfZrSCb4BiFp+hLfpGD8d9XviVsOftK+O18rIsWp
         C9jxfYy9CDg+Ov3iE50udwuu4g6167gDLY2FwKs506/zfVimQpbxh7Pq7/nfpcD16b8m
         f5hA==
X-Gm-Message-State: AOJu0YwZyLoILrXdDC5u25ExMi38IX1dXUkgkE9dUz1udtbhf1LkjtvN
	bt0qiIKhu6SVaCzF5//DD7KbdWXm78BwIn4AZPqYLOFmgz4LHggLFxYks1UtYQ==
X-Gm-Gg: ASbGncuYxsRxJhpBXASn6yYGXNl0CgNFp6hclSqXPkRLvDoDulwfccRZzP8jQiuL8SH
	IeARGDaX5nf9fo4eIQ1+2sJ/+xKPc9IgarrLEAYVQDMJAKsdjt9EVArdwSkY/kNxpbqKiDAJSvw
	tD+AQ4IfCSATL6FaPG6+uhnrJ346dhBlRddHufFDfgEM88IpYUwIOkXRn0WkndiQTsJyuAXx9dK
	TvUfoIfJF5wND5dkssWeOoyhFSY+pXIPFSAZn+lL4jobUde1FKlHAXoSR/kvfua6h8h7Cg7ngWm
	eB4y2Qw4m2xF4RhZi+skB1jRh6s0zPVTQGhyObrzejNxSI45KI51CQODYFEEGaeErx88okmSIFB
	8b0PdHB09ZMCr1iec3ogf1EfSpxcdwYxDaNj2ERAsT5vIuRhMzm0EZw==
X-Google-Smtp-Source: AGHT+IE88seSdzpVdkIzCqTZrsRMzATgLnxXnAhDA3siqgjEUV7PlZGlyUYJyltEuCGK7VDVUQpqGg==
X-Received: by 2002:a05:690c:a0ad:10b0:718:96c2:b426 with SMTP id 00721157ae682-71b7ed887c8mr121416667b3.15.1754410846171;
        Tue, 05 Aug 2025 09:20:46 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:2c65:e45a:e7d5:5f0e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cdfc5sm33098757b3.77.2025.08.05.09.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:20:45 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	corbet@lwn.net,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: [PATCH 0/5] mm/damon/sysfs: Add commands useful for using migration dests
Date: Tue,  5 Aug 2025 11:20:17 -0500
Message-ID: <20250805162022.4920-1-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

This patchset adds two DAMON commands, commit_schemes_dests and
wait_for_schemes_apply, that I have found useful for using a migrate_hot
scheme with migration dests.

The commit_schemes_dests command, similar to the existing
commit_schemes_quota_goals, is used to commit only the dests fields of
schemes. This has a couple of benefits:
1) It is more efficient than recommitting all the DAMON data.
2) Doing a full commit resets the aggregation and ops_update intervals. If
a user sends the full commit command frequently (relatively to those
intervals) the aggregation and ops_update events will be prevented from
triggering. Having a separate commit command side steps this problem.

The wait_for_schemes_apply command causes the calling thread to wait until
all schemes have been applied. It does this by calling damos_walk() with a
NULL walk_fn. This can be useful, for example, if a user wants to know when
new scheme parameters they've committed have been applied. Another use case
could be if a user wants to record the system state every time a scheme is
applied for debuging purposes.

The functionality of wait_for_schemes_apply can be achieved with the
existing update_schemes_tried_bytes and update_schemes_tried_regions
commands. However, having a separate command avoids extra work and makes
user intent clearer when used in scripts.

The first two patches implement the commit_schemes_dests command.
The third patch implements the wait_for_schemes_apply command.
The fourth and fifth patches add documentation for these new commands.

Bijan Tabatabai (5):
  mm/damon/core: Add damos_destroy_dests()
  mm/damon/sysfs: Implement a command to only commit scheme dests
  mm/damon/sysfs: Implement a command to wait until schemes are applied
  Docs/ABI/damon: Document new DAMON commands
  Docs/admin-guide/mm/damon/usage: Document new DAMON commands

 .../ABI/testing/sysfs-kernel-mm-damon         | 21 ++++----
 Documentation/admin-guide/mm/damon/usage.rst  |  4 ++
 include/linux/damon.h                         |  2 +
 mm/damon/core.c                               | 12 +++--
 mm/damon/sysfs-common.h                       |  3 ++
 mm/damon/sysfs-schemes.c                      | 35 ++++++++++--
 mm/damon/sysfs.c                              | 54 +++++++++++++++++++
 7 files changed, 116 insertions(+), 15 deletions(-)

-- 
2.43.5

