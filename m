Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7991A5B90
	for <damon@lists.linux.dev>; Wed, 10 Jun 2026 05:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781070008; cv=none; b=SoYYCQ6YFhMAIoHOzp3sFOaRQC7AAoS3O89+iCzBvw0v45mY0Fvu6du9//4ilXjpe74cjYkPKx5slUtGSgIsVDxS5Jo+wZxEnYm8utr6FPvpgFiww4/lGfFRxx/U2v1tUJLJ98Md72wl8I5r13BTfgyDYq5mYnTT4ilkTsn4Zcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781070008; c=relaxed/simple;
	bh=Qux6qw0K8leQGi/4WMI+uwr8oZG72FXB/rZyakTsEdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PUBC9pOh5Xp4dDwv/RcOFzWWu6Axkr8Nexc2RNb3pAo7ExWmMoCFQdRC4OuiijMkCeK77l3nGqEqix1NzWEyFhfGbfxrw6aF6Kf4bUNu7rZg70gSztNJq9kxxI0DMdXXOpM2dS6a/gQday8pBmFw+Cv55V/jUq9QvgqZjofc9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMLeh+hg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMLeh+hg"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef9df68bcso354183f8f.2
        for <damon@lists.linux.dev>; Tue, 09 Jun 2026 22:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781070006; x=1781674806; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXdRRa/zk7c1is5MErVAcERRsYOulHfSrsDOswfrhUg=;
        b=UMLeh+hg+L4wgsjjT4fL3MupMfABn0CaphGjKxHRhxWajOuQsUHJBMdNALMgYGAsGy
         bTYt/xOF8ouP8dMpiZdjhRfx91hYw8t8wRqEu/GiK6RalzzqFQGJj+D3r5ojla5MGtcg
         RkFK0mBQ/FfEUGlSE6Q/Jyobyt5i+QUyQ4d/MmIeFVHqd8BMcXUmtRdurqxJqxGOFHMU
         mvRaXutL1yktz0OYavDYWYWsZ9nSAw9BIWaq8q7fss7IjH7g7l9lYOnIpe5W4NzoyiYC
         zPRmjXJP1Acnp3pSSBPDTODjpwWtV0/tisK9vAGLWHAy2wTnw57a5s3cpH87p9xFNT0O
         Mq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781070006; x=1781674806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXdRRa/zk7c1is5MErVAcERRsYOulHfSrsDOswfrhUg=;
        b=mP4dRL75+gi4C61Nv2wDcmqSB2oal2hd2JDEcaX2tW7YsROACnwVCS6fDyhvzvvlgN
         iOABRIAn3ZwhtZdCzaF3P3Izgqdj8kdtA7llGql8gNC5WGOVHvyjfpblkZ4KE1Z8GWE6
         O4nLoPUSwm4d/U26gcMUrRTdnZQ4QA2yhDQxdk1BuRv8/g4iyP4FBEtlh/r6cmTZmkXV
         I1F7zdKeAXa3sCKlnSfymQucNQO+Tb7pCQk498reeO+HKNgOtcK3sotXElpkVZpXTE6a
         SIIuzNzB7YzUhWwGr6RrBubrO06knKt5AT/4sVmGVlBXwqt8qd8w/t11D+POYUrDS8b7
         y/Vw==
X-Forwarded-Encrypted: i=1; AFNElJ8HdubsEFRtZrhH7wcCloGEAkg6B6AmNlYJocetRNVWOnsdsbEvo3S3OHznXuot9k2O8HZjXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwuEskccazr2RZsvUh0WghtyIZcZpY6hmyo06cqtCURia6rHTCN
	AICfkx0tXaFvwMGywPHSQROoVBuUNBsf2kwPvCRbdmFcMfAU3n9ZM2JT
X-Gm-Gg: Acq92OGaBO/8Vby8nV3CoqXwlfukjcQTFSU+91RqMO8uDp+kSLxX50p12PpUN/6Stl6
	kvCtHw8IJFNTUurQ5lfrugmqL/gC4hyZ4B430tLy0LT7WBT7WQTmBQmxpJRwjAwnVsLUODgPH+7
	kTBUbboL/wR7HD10IwzzNPWrBd5BXZl5wLT7q8O2pAsrg9eOq64qeP1raEnIMjtK4q7AolkT75J
	6bbvj8MPrOpW6XXrbCgGTh6o0zL1Gr/4CeiYEqXV4l99GVK+8t146+yE7WTv+vu5yO69s18W6i3
	wkBhO7bc1RUGKsSovLFlB26TIUxN7EnHRNV4jra6nNXmgkrLGa8T/7lUsp9bw8g3ZF3QENwuHgk
	C23I43sgVuY4Oos+XOZLHd9zSgmBffvSSkLcyYPigFioNDZEqScQ3Dx4+hfJjxKIfYNCpz4u+SY
	Qw/Tz6AOWQXI1/i1rT6ARoi70dfmE7ztbw9uDVnkfBsmIRogll9sfUwpTZ3QS9F+860N3RKuFgA
	5wNONZ12ESFPN+0kETdYC57bzOEvragMU8K12AaI4tgz6x0
X-Received: by 2002:a05:6000:70f:b0:45e:8a08:93fa with SMTP id ffacd0b85a97d-460566c1c21mr3027030f8f.4.1781070005579;
        Tue, 09 Jun 2026 22:40:05 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm53831009f8f.14.2026.06.09.22.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 22:40:05 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Doehyun Baek <doehyunbaek@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] Docs/{admin-guide,mm}/damon: fix DAMON documentation details
Date: Wed, 10 Jun 2026 05:39:50 +0000
Message-ID: <20260610053951.553739-1-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix minor DAMON documentation issues.  Correct the sysfs scheme file name
apply_interval_us, the DAMON_STAT module count, a malformed reference, a
misplaced label indentation, and a few typos.

Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>
---
Changes from v4:
- Rebased on mm-new.
- Sent the English documentation fixes as a standalone patch.
- Dropped the Chinese translation patch from this submission.

 Documentation/admin-guide/mm/damon/usage.rst |  8 ++++----
 Documentation/mm/damon/design.rst            | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 011296f1e7c2..b2649ea011f9 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -246,7 +246,7 @@ writing to and reading from the files.
 Under ``nr_regions`` directory, two files for the lower-bound and upper-bound
 of DAMON's monitoring regions (``min`` and ``max``, respectively), which
 controls the monitoring overhead, exist.  You can set and get the values by
-writing to and rading from the files.
+writing to and reading from the files.
 
 For more details about the intervals and monitoring regions range, please refer
 to the Design document (:doc:`/mm/damon/design`).
@@ -264,7 +264,7 @@ Please refer to  the :ref:`design document of the feature
 <damon_design_monitoring_intervals_autotuning>` for the internal of the tuning
 mechanism.  Reading and writing the four files under ``intervals_goal``
 directory shows and updates the tuning parameters that described in the
-:ref:design doc <damon_design_monitoring_intervals_autotuning>` with the same
+:ref:`design doc <damon_design_monitoring_intervals_autotuning>` with the same
 names.  The tuning starts with the user-set ``sample_us`` and ``aggr_us``.  The
 tuning-applied current values of the two intervals can be read from the
 ``sample_us`` and ``aggr_us`` files after writing ``update_tuned_intervals`` to
@@ -377,7 +377,7 @@ schemes/<N>/
 In each scheme directory, nine directories (``access_pattern``, ``quotas``,
 ``watermarks``, ``core_filters``, ``ops_filters``, ``filters``, ``dests``,
 ``stats``, and ``tried_regions``) and three files (``action``, ``target_nid``
-and ``apply_interval``) exist.
+and ``apply_interval_us``) exist.
 
 The ``action`` file is for setting and getting the scheme's :ref:`action
 <damon_design_damos_action>`.  The keywords that can be written to and read
@@ -743,7 +743,7 @@ counter).  Finally the tenth field (``X``) shows the ``age`` of the region
 (refer to :ref:`design <damon_design_age_tracking>` for more details of the
 counter).
 
-If the event was ``damon:damos_beofre_apply``, the ``perf script`` output would
+If the event was ``damon:damos_before_apply``, the ``perf script`` output would
 be somewhat like below::
 
     kdamond.0 47293 [000] 80801.060214: damon:damos_before_apply: ctx_idx=0 scheme_idx=0 target_idx=0 nr_regions=11 121932607488-135128711168: 0 136
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 2da7ca0d3d17..c16a3bb288d0 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -86,7 +86,7 @@ To know how user-space can do the configuration via :ref:`DAMON sysfs interface
 documentation.
 
 
- .. _damon_design_vaddr_target_regions_construction:
+.. _damon_design_vaddr_target_regions_construction:
 
 VMA-based Target Address Range Construction
 -------------------------------------------
@@ -930,11 +930,11 @@ control parameters for the usage would also need to be optimized for the
 purpose.
 
 To support such cases, yet more DAMON API user kernel modules that provide more
-simple and optimized user space interfaces are available.  Currently, two
-modules for proactive reclamation and LRU lists manipulation are provided.  For
-more detail, please read the usage documents for those
-(:doc:`/admin-guide/mm/damon/stat`, :doc:`/admin-guide/mm/damon/reclaim` and
-:doc:`/admin-guide/mm/damon/lru_sort`).
+simple and optimized user space interfaces are available.  Currently, three
+modules for access monitoring statistics, proactive reclamation, and LRU lists
+manipulation are provided.  For more detail, please read the usage documents for
+those (:doc:`/admin-guide/mm/damon/stat`, :doc:`/admin-guide/mm/damon/reclaim`
+and :doc:`/admin-guide/mm/damon/lru_sort`).
 
 .. _damon_design_special_purpose_modules_exclusivity:
 

base-commit: ce70d5abbf4f9930a07eddb06f40a0ea3494e33a
-- 
2.43.0

