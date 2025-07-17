Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062532063E7;
	Thu, 17 Jul 2025 05:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752731698; cv=none; b=lIvWk1asQ7Yef1dLe6kK1Xmt3K85ZijXjB4vrCyU6G2j59KAelCrGDjoYqHgKGgRkPJzb4gwhohNOLQONNhArgMwgOzKyvJQOQQtFWFUB5UMbqHPqZ+BTLpckcpKkBGAqgAiwEAEho06lKwo0KGy5DOOaiD4uYLQx817yfTvpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752731698; c=relaxed/simple;
	bh=oDJKqZFFqV/IVUvVAZh+/YozTjWBAbZi/gNGteq41Is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLFmfsSjQ5UnRnORvUER6qARDfc0hNpExhrRPCeq1g9kgWKv9tjw6bQxzpKwrRvbK4K0AwHn7jG3cZxmuJcqQuaC7AMv5xIKxWtfweHUmnuWPJuvOftPO8+I2UOnbNe/iDVoB4pw/bvHSrA0m23y8K3+ZQ1YnhWQnis5LcnC14E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqcjhw6G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqcjhw6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF790C4CEE3;
	Thu, 17 Jul 2025 05:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752731697;
	bh=oDJKqZFFqV/IVUvVAZh+/YozTjWBAbZi/gNGteq41Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqcjhw6GVDPq42JmF+087KxOshGgfz/uX4ZEkd92PHdTye6Dte6ITWRxIUIkHmP2m
	 hvXmTElpj7rffA10WZL8HMFNChZeWOUvOhos/xUZ84Qns899/LnmJso1h+yPaqu9J0
	 rF1JPP/2eS9HRUpbmZ38+4l620kuqu+bVLGe/t0K1cuR0wB+5oyf3xBZNYI0VOIO7R
	 iTyozrcfh0gozmotU4IwgOcLK0hyIMnf++HlwogjsoS4VIkEOOn4awtRS+o2LWrZ1b
	 QxM0c85JhmUPF9GxZb4GBgJxoKGVINUbSm+ksgeRAls8+u4e3KBk2/pKg4I0gIK9Wl
	 VFPt9ZcVNUABA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/4] Docs/admin-guide/mm/damon/usage: document refresh_ms file
Date: Wed, 16 Jul 2025 22:54:47 -0700
Message-Id: <20250717055448.56976-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717055448.56976-1-sj@kernel.org>
References: <20250717055448.56976-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document the new DAMON sysfs file, refresh_ms, on the usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index fc5c962353ed..ff3a2dda1f02 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -59,7 +59,7 @@ comma (",").
 
     :ref:`/sys/kernel/mm/damon <sysfs_root>`/admin
     │ :ref:`kdamonds <sysfs_kdamonds>`/nr_kdamonds
-    │ │ :ref:`0 <sysfs_kdamond>`/state,pid
+    │ │ :ref:`0 <sysfs_kdamond>`/state,pid,refresh_ms
     │ │ │ :ref:`contexts <sysfs_contexts>`/nr_contexts
     │ │ │ │ :ref:`0 <sysfs_context>`/avail_operations,operations
     │ │ │ │ │ :ref:`monitoring_attrs <sysfs_monitoring_attrs>`/
@@ -123,8 +123,8 @@ kdamond.
 kdamonds/<N>/
 -------------
 
-In each kdamond directory, two files (``state`` and ``pid``) and one directory
-(``contexts``) exist.
+In each kdamond directory, three files (``state``, ``pid`` and ``refresh_ms``)
+and one directory (``contexts``) exist.
 
 Reading ``state`` returns ``on`` if the kdamond is currently running, or
 ``off`` if it is not running.
@@ -161,6 +161,13 @@ Users can write below commands for the kdamond to the ``state`` file.
 
 If the state is ``on``, reading ``pid`` shows the pid of the kdamond thread.
 
+Users can ask the kernel to periodically update files showing auto-tuned
+parameters and DAMOS stats instead of manually writing
+``update_tuned_intervals`` like keywords to ``state`` file.  For this, users
+should write the desired update time interval in milliseconds to ``refresh_ms``
+file.  If the interval is zero, the periodic update is disabled.  Reading the
+file shows currently set time interval.
+
 ``contexts`` directory contains files for controlling the monitoring contexts
 that this kdamond will execute.
 
-- 
2.39.5
