Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5705539E177
	for <damon@lists.linux.dev>; Tue,  6 Oct 2026 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791267430; cv=none; b=Us5x9/9FYxnuVvxlQ+J6+f9oGdhxvJaRgiztnFSKUvVdV/VVI4un6NuZPCz6fupkNqhQlpJKwu00GBH/YEJMsZ3xT2dX8xP+DnrxcXkkYTzWEdZGWoWcrZhQX26LunQoZv+edraMc07ezYjNAw/0HF9um+BD6nDqQbgvld7TENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791267430; c=relaxed/simple;
	bh=c52s+1rtQJ0Q70cxAwYJIZomn2o6AOpxotKtFgeYSpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ld+qYpWB0nlUZjR8WiylI4k1QBImxCOAEGIb7fGERoYHW8HHfgZBchq7zNgVAyEzsHLR+QuvITakLBCd/Rwk+jzmPdahheXRTIiD2fnbRzzPOHamEIkJ9Jjfg1ifUiFoqu3JoHVFkNQr2GUUPIVzod7FXws7nZgKi6EuT57YAuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVMn0c14; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVMn0c14"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3a7d283e017so1451354a91.3
        for <damon@lists.linux.dev>; Mon, 05 Oct 2026 23:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791267427; x=1791872227; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXj+ppi34PaHFxHHINamngQe5IHrKp/NnyfjPYvY7jg=;
        b=eVMn0c14V/2uJ18FbSzKjinRyPs969zN4DlnNchH+rOL5QSwzEVosNdNiqI0MN/cEg
         LcSlysQyEiHfV3J/AbixaOCCcn6ZXbZejeN+ELSVuEiazXCL5j0t4EI+KQi4Cf55yA40
         B4lqHR0sf3ny7JV7VHSDLn24d1DGkbkfxn8t4r2vhkQATVQlDqVJYjDedBK4WoLpIddj
         eg6/XuvSrm1cyL91M5KFqeNmbusa1C4uhwoEkSrI+yOvzMB1q/sQNGLtXZa23gvTS186
         qvzY8ldP7HDS1rVZWzw3B+2080Zwm50Zd07hoAVCGV+l+XrTAwyy7tEVi02N7Mweel3q
         41pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791267427; x=1791872227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kXj+ppi34PaHFxHHINamngQe5IHrKp/NnyfjPYvY7jg=;
        b=QsC6rOVEha1yQpxAk6vdgFye1bPhQJ2/Ff7hfx0ArPldabKRCUWXqZ8XsfDQaXbh6d
         ipLmBsPbx7F5xVZC6bDNq0bfelbBFRhFMewP9HLcoIkLQWfAVmB2EGlDXadJI8HsFqPS
         zVR+INywSiGePEoE/aKZJ4fxOMaF9CYanxTyD0OBreT2JnjE/fxCKTSPo3hAxMje+2n9
         Pw+nLqIcje84U4poNOuzOY3RN7zRuj7rpEhpLJ7iaWcd63WeuWuY/F0w2Mey+9i2gsci
         iRh1yzM9TUWCRC4n33xwHWC0VEh4dIgT5wFyMeqlqDj1PT11mKw42HwUFEG4U4f0IkZl
         dU/w==
X-Gm-Message-State: AFq9FYKoxJ1dSjm/wK6BbK8eivokdIQSmfdEHfp0GcxDU61fO3wBhFjQ
	rSYOHWajMCO3enS87F7F1pfPAA4h7e38Yulwq+yHc0bA7f2nhzbQH2xC
X-Gm-Gg: AYBFou2vmGnvUrJw/blrPLG/FybK7Lj3/bXUJ6F7CCEiJ1KEh1AEhT8J77ioiotmJqp
	Sie/G/1RujPMNEplYtClKbu1Qw/gPyIG82cNFhDwgNiMgiLOYdcW9qtSVoCoxMhUlNbMquFHn7R
	Poxj0uoszaPJNSpsxM3K433CLo/McfPfL2KhfNcc+ou0ZfbjF3RvAQ9Jydsu0cTTTUn0V1dkj8F
	NgbSk2T57KTvryrK8Pfhgb8evGKnZJRgpJfEfkV490Hpl7qCogiebYMQDBTh0vlGn6lJatseYDG
	GrO0LdTEh2K3zYxUWJEEE4mg7HBSN6oTt19PmGWps9fauPMOf5E8xC4LkwnnNsSD5tq0O135a9U
	u5WV1wU+DNWyjq6xz+xLvoa2aMDB6Z1N1zvEm1YceYQAF1NHFX9ucyeJJbnTW1QnYOhT1MGxYu6
	QvZcxNepeFAWxu7iMf93/bLafGaD8/d4EPPZSGnRL6la+yju8cCb6Aw+CsbHUeMk4PyDLGW0sbc
	D0TAHLg27jJxbb0uoSgcCvtih0yLJJdFlNreTSDxaN8RezogVMJUXuXdxVxLKMQ6omGiCZyP8Xc
	FGKIvCcg5JFuKTpY
X-Received: by 2002:a17:90b:3912:b0:3a4:bc68:e867 with SMTP id 98e67ed59e1d1-3a87268878cmr360148a91.7.1791267427477;
        Mon, 05 Oct 2026 23:17:07 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (61-221-208-111.hinet-ip.hinet.net. [61.221.208.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8533aba95sm3662789a91.2.2026.10.05.23.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 23:17:07 -0700 (PDT)
From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	ahuang12@lenovo.com,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Subject: [PATCH 1/3] Docs/admin-guide/mm/damon: Fix various typos
Date: Tue,  6 Oct 2026 14:15:47 +0800
Message-Id: <20261006061549.627-2-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261006061549.627-1-adrianhuang0701@gmail.com>
References: <20261006061549.627-1-adrianhuang0701@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several spelling mistakes found while reading the DAMON
documentation:
  * trusworthy -> trustworthy
  * DAMON_RCLAIM -> DAMON_RECLAIM
  * charget -> charge
  * hetmap -> heatmap
  * colun -> column
  * evelenth -> eleventh
  * idlee -> idle

Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 2 +-
 Documentation/admin-guide/mm/damon/reclaim.rst  | 4 ++--
 Documentation/admin-guide/mm/damon/start.rst    | 6 +++---
 Documentation/admin-guide/mm/damon/stat.rst     | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index b93ca9b0853d..c3b688385681 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -7,7 +7,7 @@ DAMON-based LRU-lists Sorting
 DAMON-based LRU-lists Sorting (DAMON_LRU_SORT) is a static kernel module that
 aimed to be used for proactive and lightweight data access pattern based
 (de)prioritization of pages on their LRU-lists for making LRU-lists a more
-trusworthy data access pattern source.
+trustworthy data access pattern source.
 
 Where Proactive LRU-lists Sorting is Required?
 ==============================================
diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index ec7e3e32b4ac..e4e2ffa52e26 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -55,7 +55,7 @@ enabled
 
 Enable or disable DAMON_RECLAIM.
 
-You can enable DAMON_RCLAIM by setting the value of this parameter as ``Y``.
+You can enable DAMON_RECLAIM by setting the value of this parameter as ``Y``.
 Setting it as ``N`` disables DAMON_RECLAIM.  Note that DAMON_RECLAIM could do
 no real monitoring and reclamation due to the watermarks-based activation
 condition.  Refer to below descriptions for the watermarks parameter for this.
@@ -125,7 +125,7 @@ quota_reset_interval_ms
 
 The time/size quota charge reset interval in milliseconds.
 
-The charget reset interval for the quota of time (quota_ms) and size
+The charge reset interval for the quota of time (quota_ms) and size
 (quota_sz).  That is, DAMON_RECLAIM does not try reclamation for more than
 quota_ms milliseconds or quota_sz bytes within quota_reset_interval_ms
 milliseconds.
diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
index ec8c34b2d32f..d98b0eb8e771 100644
--- a/Documentation/admin-guide/mm/damon/start.rst
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -69,16 +69,16 @@ monitored access pattern of the process from DAMON and shows the pattern in a
 human readable format.
 
 The first line of the output shows the relative access temperature (hotness) of
-the regions in a single row hetmap format.  Each column on the heatmap
+the regions in a single row heatmap format.  Each column on the heatmap
 represents regions of same size on the monitored virtual address space.  The
-position of the colun on the row and the number on the column represents the
+position of the column on the row and the number on the column represents the
 relative location and access temperature of the region.  ``[...]`` means
 unmapped huge regions on the virtual address spaces.  The second line shows
 additional information for better understanding the heatmap.
 
 Each line of the output from the third line shows which virtual address range
 (``addr XX size XX``) of the process is how frequently (``access XX %``)
-accessed for how long time (``age XX``).  For example, the evelenth region of
+accessed for how long time (``age XX``).  For example, the eleventh region of
 ~9.5 MiB size is being most frequently accessed for last 3.7 seconds.  Finally,
 the fourth command stops DAMON.
 
diff --git a/Documentation/admin-guide/mm/damon/stat.rst b/Documentation/admin-guide/mm/damon/stat.rst
index 46c5dd96aa2e..4a9db755a526 100644
--- a/Documentation/admin-guide/mm/damon/stat.rst
+++ b/Documentation/admin-guide/mm/damon/stat.rst
@@ -81,7 +81,7 @@ Per-byte idle time (milliseconds) percentiles of the system.
 DAMON_STAT calculates how long each byte of the memory was not accessed until
 now (idle time), based on the current DAMON results snapshot.  For regions
 having access frequency (nr_accesses) larger than zero, how long the current
-access frequency level was kept multiplied by ``-1`` becomes the idlee time of
+access frequency level was kept multiplied by ``-1`` becomes the idle time of
 every byte of the region.  If a region has zero access frequency (nr_accesses),
 how long the region was keeping the zero access frequency (age) becomes the
 idle time of every byte of the region.  Then, DAMON_STAT exposes the
-- 
2.43.0

