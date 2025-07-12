Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F9522A4CC;
	Sat, 12 Jul 2025 20:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752353218; cv=none; b=dS2wEJl7ud5MZtf+rPLNlDB/2CYqWCpC3XdBUnD80X1ZLCdRSkyqC9u9CfR/Otr2uQ7LrIVHdY6PRQnUVGwst24NkPTvYTknFBaUitp2m11karnPaej2OmVVjKMQ2RF029gk1SCnWTYLLPnGMrtF0kCsCS5A74gvpCMQuPRpi80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752353218; c=relaxed/simple;
	bh=oDJKqZFFqV/IVUvVAZh+/YozTjWBAbZi/gNGteq41Is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwoeWUr1wvAbL7g/oYApyDNXtm/R9n8a0+857H38Hpopv24ohu7TRin6i8v+Fqfvc9YO0ArbDg4/C7jvDGv8hWKzPY1Jf0IoDOh7CnkZMbMoweMKhft6JJTRP/cG8aP1sePf7nEnahR6j+6pUzpXLtSlh9/X781a+K5bOt3PWS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4P9c6Js; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4P9c6Js"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F35EC4CEF5;
	Sat, 12 Jul 2025 20:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752353217;
	bh=oDJKqZFFqV/IVUvVAZh+/YozTjWBAbZi/gNGteq41Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4P9c6Js+zvo8A4MsqkzVMy5O2C/43OLwBhMKP59zA5ydz/3ZMhrDhBmNy+ZH6uhM
	 v4Kgto6MfSdBu1/HAUaYEHRGavO3n6rekuoQB0ir4i2IzeHbKfOeOCL6sJNd1v1NvE
	 Z++XKQoDdYAnvqQ4ANHkQi8bNO+8hgC+1s7qcqx1V7sjmUh6AmZzP9PXiGeI4JImDv
	 VstlJLPm3HmMR8Vv8sIklDswlMw2htH6TL2pftIduH4i+R1vUF/cT/iO2IUOOaSwnB
	 Q+zGbv3Y9M16mYBRHFlGZzNJ8TVF+hNwuh6UxfkdMjzQbI14mwOwLt0ZRn40UYoVk4
	 kOzvJX1Isbo6A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/4] Docs/admin-guide/mm/damon/usage: document refresh_ms file
Date: Sat, 12 Jul 2025 13:46:48 -0700
Message-Id: <20250712204650.155988-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250712204650.155988-1-sj@kernel.org>
References: <20250712204650.155988-1-sj@kernel.org>
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
