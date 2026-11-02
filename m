Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633339;
	b=R6veulTkdnFwWX5oIdRuLkRjeOa4qMLN1c1gZHwyoKRfdlEAr1ZI3ZGzPO10n9U1u/ca
	 ogNIdolRwXT/ciskh/ZS2GB2Qvs4vUabQjGocwYFqoBM/0sL8KXQego+ifGyME6UPS4N2
	 Zz+qc7whu1elE2V/ttjwWu2U2kDdDvKaIePmED76U7pbqI4Z3Oq7GoUFwTL7foFXSCSqB
	 MPGT934RbbAlpqz+mdlbLKyzc1uLEPYZ03eTWe/K7//yxnyxxyWtiRYXEYr5aa2GcYTCT
	 aUBIHW3fELoy/tOOLS1KNYYvDTnlpV5kklLM4XeFsW/t6gKa5wInKRSPEvtTfcIwd9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633339;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=a4P5FOKS7FmEJpE6+fz4O6cuWQUWbxagUHKZklOqdlI=;
	b=CNmTP4zcdWSvvfmAJyehx15O3ZLrrOTj6XbaGzEh5LsYeu/1qmmJWYVh9mJta3PNkqy/
	 HL468c+zqI/50f2WlAkTo6XC3v+huU8+5CrLR7q5VNgyNqF3fmf8I4U6vRCrABjL4xDdf
	 TZ1Yc+okzZmE3CpZG5WkTAzWlKoXfdrvWqVB5QOsDGL1Cy1qRS68BJFxak+vrNwpwdKbA
	 YbNUsCFsDLZxqDZDbIOumRCh32yHphaeoZaKMcUNM5Sw04qKqwTuEbzKPlQUltVqT7nOC
	 K4m7cZ3cCLZU3qlvQtMKDTh/HSeuvrAnqBxgEZ6xz5gVVZ3DxARcZ1w/jK9mvGLLI3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eD1h06hZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719E3609D137;
	Mon,  2 Nov 2026 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eD1h06hZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85231F00A18;
	Mon,  2 Nov 2026 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633339;
	bh=a4P5FOKS7FmEJpE6+fz4O6cuWQUWbxagUHKZklOqdlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eD1h06hZhD6ZYQdF9GG6DwkBrd9Qz6+vOdJQq/5lCM3rL9KuHY8R5OgeJKRESUkFG
	 W5n5I2VfakNz3O7cZgetbMye+rYRt4WMLvMyVSpejl1oHWVBs5+VNA/1gOn6XfyBM2
	 wMhJhaLrxrn2k03gkXJuWqaes3am26H7Hvs4SUkAsg0Bop7eZXltpJPY4ouMRnn9UW
	 2V2DYah4HtUhfX6V9AEwLJGGBZvwBHP1BoyyjirrDK/SoSWhyBrDEks7B6BKOEPAek
	 p/fOz92wVJOc+sbM/e6OrBZPlKAZ1ZGOVuQkist1yjLrafRmxToA59O3ZqMW8Dd8bq
	 bDaxrUVkcmnuQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/3] Docs/admin-guide/mm/damon/lru_sort: fix copy-paste mistakes
Date: Mon,  2 Nov 2026 07:28:46 -0800
Message-ID: <20261102152849.96057-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102152849.96057-1-sj@kernel.org>
References: <20261102152849.96057-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>

The DAMON_LRU_SORT documentation mistakenly refers to DAMON_RECLAIM
in a few places.

Fix these copy-paste mistakes to correctly refer to DAMON_LRU_SORT.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 02ea694426b2c..aa4cc90ca57c6 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -263,7 +263,7 @@ addr_unit
 A scale factor for memory addresses and bytes.
 
 This parameter is for setting and getting the :ref:`address unit
-<damon_design_addr_unit>` parameter of the DAMON instance for DAMON_RECLAIM.
+<damon_design_addr_unit>` parameter of the DAMON instance for DAMON_LRU_SORT.
 
 ``monitor_region_start`` and ``monitor_region_end`` should be provided in this
 unit.  For example, let's suppose ``addr_unit``, ``monitor_region_start`` and
@@ -346,7 +346,7 @@ memory regions that not accessed for 120 seconds.  The prioritization and
 deprioritization is limited to be done using only up to 1% CPU time to avoid
 DAMON_LRU_SORT consuming too much CPU time for the (de)prioritization.  It also
 asks DAMON_LRU_SORT to do nothing if the system's free memory rate is more than
-50%, but start the real works if it becomes lower than 40%.  If DAMON_RECLAIM
+50%, but start the real works if it becomes lower than 40%.  If DAMON_LRU_SORT
 doesn't make progress and therefore the free memory rate becomes lower than
 20%, it asks DAMON_LRU_SORT to do nothing again, so that we can fall back to
 the LRU-list based page granularity reclamation. ::
-- 
2.47.3
