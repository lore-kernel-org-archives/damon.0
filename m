Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C6535E1DB
	for <damon@lists.linux.dev>; Tue,  9 Jun 2026 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015699; cv=none; b=KW9GfKrQV7STxatFMKMmaxw5OrBV6PFcfyI/s789o47NE22Juzd7oDvkWGuVDI2IllzB66xMZ4VdYinVFsnl4z/PPLQ7dd2LhauoNF+m4rFbNfxLNKZaUp807Li8DbttkZlkNnLRX4Z940Uvc3csnNyyseNiVN/8Bvi+ePSP088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015699; c=relaxed/simple;
	bh=pnHV3Ye+jcw8HhYnQc+Fnxg3Gl5lWmUXPzdc9v3HAMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSlcfM7NQOyhqkUJKZq1K2XOaiiJoVaBmNeEA/7iOS5gCqzgLTGp2CKxhr7/OCsnuh69mIJshRi2csmldylMPw2liYpamBxj1BZgXuoXb+aory0vpP6q+MN0oDgfCWlyD6hCI8m1AZkbD3g3Lv2N3FDW0HObmOryKBGcheEoovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHKmuRnX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHKmuRnX"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b1aefe1cso5968935e9.2
        for <damon@lists.linux.dev>; Tue, 09 Jun 2026 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781015696; x=1781620496; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zR5qTeZU+1AMo8bRv3wnu4lu6ZsL0raW9iT7/dFj7UM=;
        b=PHKmuRnXa8GZxbevBGS0Adsf8cOe3WE8VhqMdOTprdCOkOQEPIk2ynmfg3d0AykE9A
         4qY5lgxNl85htQjWng6MhetLpVvszzSx6VPfnN6IGF7CCg+Y/NFFbhuOwb87viukO3Hh
         jBFffAYJYrjxS0M0PhqU5SAKXIge8gc3Z0F2h1kpL71kKJki/En2zv2LSxX5ZAr5J5c5
         r+aVary0LVAgocV6O8etchjIJbBQW0aMUf8Z8Mf5OeCqFbunlrZnkqVk0MW9HKAht5F+
         MRcphdLR7I//NVONd/RtH584G4NC4OI7TsUdhrBmuMxz8fiacaP5xFbgskaDxTHH300a
         z66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015696; x=1781620496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zR5qTeZU+1AMo8bRv3wnu4lu6ZsL0raW9iT7/dFj7UM=;
        b=c0BHz5g2M56lSEOsnnuSv4lZnFED2KlJvp1pP5metU9BcxvVpWd+HAA6Ign5K5/U1u
         4UCE2FtxYXYlmJHBHGJd0cyX1OkvJAKk7ecPXjbPiCZVfINyUYuzeq1mSA/JlY1n/wHF
         H57nK5VTHrLP4byHGkNRzif+m8gVJzWW5E5RRPewqqnp3Cp45EYog/6PTD9OzyAj9DhB
         2WrthwXETRoTsL+Wc8l+4MhN8KAxoOJ/s1og5Tox73VgGSGj3lsiQU2PKj8SavDaHh4Z
         oSpPxwgoE4lW33zE+4HD5p+F+TtFuNkHx/oAipQVx8NTfUbNxaatLBbuGxTdqluqZcgb
         ylgg==
X-Forwarded-Encrypted: i=1; AFNElJ8jAolZD/zmnygW8RuXPA/iZRoolTds/eDpuUz9qoSMoRgh4GMRvmq4uZ23JB+ydmAq2G9Q1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLRlZ+WU4yu6e0WeEzwQ1HTM6vSBoUiBB+PDd3VjfqXzosaRTk
	fiNPTTU4Xkvtdfxo4KFVP5HD1XYItUx9yVg9rm3zN6bhuFOL4FZLguZn
X-Gm-Gg: Acq92OGDDO+zalA/0PkQoYHZfrR8u97MrA3NMKo5nxDY5wnfwcVF0QUQv9VyvmrhkSD
	e93B584/Y1e1cWUyS2f6LvULXNEFpICj2w5G029/TMCcy2DUHuum1gKQlWsOUsUuJjMUXfuj6go
	RqZaC+pPXCP1b4I2fegyrkzJu7q3ImzUaxnmDtwf2dp9KODgFYhsHWr1BaLGWuezaY9BuWp/Y/v
	oaYio/6sMCdOtzh9gSFa1ZYNMdrY0NyKNLGC3WAnLAQrFtoyMI8KjPL6A9FtoqljilyrQkrx6Tl
	foeUBaUd7HYCEyIGiQKq9cnf72b0YSQzqvTzGcisbTk1YIs+7PnAMq9h5VmkQG67d0qxa8QfHyi
	19Z3eJ2BZ0Qe9i1jwS0M+eUoQEuJd5gqQ1fz5CYcK/99SaFdDPZtd2Ie84+lnkT5CVFyxMOAQX9
	vaIjmEF4ndqlv+dtIsU0bu/cDez47KNSiv0Tax2oWG5KzJ5vKwfkXM0Rv+5ifxNblcS39Mm1VEB
	CdHdE4pHIxr+1z1dCEJVrKrNIId5w0H8nO8LQ==
X-Received: by 2002:a05:600c:8b82:b0:490:abf1:2ddb with SMTP id 5b1f17b1804b1-490c2603825mr148448535e9.6.1781015696216;
        Tue, 09 Jun 2026 07:34:56 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm68670615f8f.5.2026.06.09.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:34:55 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: Dongliang Mu <dzm91@hust.edu.cn>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	SeongJae Park <sj@kernel.org>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	Doehyun Baek <doehyunbaek@gmail.com>
Subject: [PATCH v4 1/2] docs/mm/damon: fix DAMON documentation details
Date: Tue,  9 Jun 2026 14:34:25 +0000
Message-ID: <2ef77f90822cdd3231b6d4b0acd5f4b458f9b1bc.1781015560.git.doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781015560.git.doehyunbaek@gmail.com>
References: <cover.1781015560.git.doehyunbaek@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix minor DAMON documentation issues.  Correct the sysfs scheme file name
apply_interval_us, the scheme directory count, the DAMON_STAT module count,
a malformed reference, a misplaced label indentation, and a few typos.

Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>
---
 Documentation/admin-guide/mm/damon/usage.rst | 12 ++++++------
 Documentation/mm/damon/design.rst            | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 534e1199cf09..e6ad1b4106ef 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -232,7 +232,7 @@ writing to and reading from the files.
 Under ``nr_regions`` directory, two files for the lower-bound and upper-bound
 of DAMON's monitoring regions (``min`` and ``max``, respectively), which
 controls the monitoring overhead, exist.  You can set and get the values by
-writing to and rading from the files.
+writing to and reading from the files.
 
 For more details about the intervals and monitoring regions range, please refer
 to the Design document (:doc:`/mm/damon/design`).
@@ -250,7 +250,7 @@ Please refer to  the :ref:`design document of the feature
 <damon_design_monitoring_intervals_autotuning>` for the internal of the tuning
 mechanism.  Reading and writing the four files under ``intervals_goal``
 directory shows and updates the tuning parameters that described in the
-:ref:design doc <damon_design_monitoring_intervals_autotuning>` with the same
+:ref:`design doc <damon_design_monitoring_intervals_autotuning>` with the same
 names.  The tuning starts with the user-set ``sample_us`` and ``aggr_us``.  The
 tuning-applied current values of the two intervals can be read from the
 ``sample_us`` and ``aggr_us`` files after writing ``update_tuned_intervals`` to
@@ -337,10 +337,10 @@ to ``N-1``.  Each directory represents each DAMON-based operation scheme.
 schemes/<N>/
 ------------
 
-In each scheme directory, eight directories (``access_pattern``, ``quotas``,
+In each scheme directory, nine directories (``access_pattern``, ``quotas``,
 ``watermarks``, ``core_filters``, ``ops_filters``, ``filters``, ``dests``,
 ``stats``, and ``tried_regions``) and three files (``action``, ``target_nid``
-and ``apply_interval``) exist.
+and ``apply_interval_us``) exist.
 
 The ``action`` file is for setting and getting the scheme's :ref:`action
 <damon_design_damos_action>`.  The keywords that can be written to and read
@@ -677,7 +677,7 @@ show results using tracepoint supporting tools like ``perf``.  For example::
 
 Each line of the perf script output represents each monitoring region.  The
 first five fields are as usual other tracepoint outputs.  The sixth field
-(``target_id=X``) shows the ide of the monitoring target of the region.  The
+(``target_id=X``) shows the id of the monitoring target of the region.  The
 seventh field (``nr_regions=X``) shows the total number of monitoring regions
 for the target.  The eighth field (``X-Y:``) shows the start (``X``) and end
 (``Y``) addresses of the region in bytes.  The ninth field (``X``) shows the
@@ -687,7 +687,7 @@ counter).  Finally the tenth field (``X``) shows the ``age`` of the region
 (refer to :ref:`design <damon_design_age_tracking>` for more details of the
 counter).
 
-If the event was ``damon:damos_beofre_apply``, the ``perf script`` output would
+If the event was ``damon:damos_before_apply``, the ``perf script`` output would
 be somewhat like below::
 
     kdamond.0 47293 [000] 80801.060214: damon:damos_before_apply: ctx_idx=0 scheme_idx=0 target_idx=0 nr_regions=11 121932607488-135128711168: 0 136
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index afc7d52bda2f..aff89f73ca56 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -79,7 +79,7 @@ To know how user-space can do the configuration via :ref:`DAMON sysfs interface
 documentation.
 
 
- .. _damon_design_vaddr_target_regions_construction:
+.. _damon_design_vaddr_target_regions_construction:
 
 VMA-based Target Address Range Construction
 -------------------------------------------
@@ -858,11 +858,11 @@ control parameters for the usage would also need to be optimized for the
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
 
-- 
2.43.0

