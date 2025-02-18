Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889DC1DE2D7;
	Tue, 18 Feb 2025 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918240; cv=none; b=psBl0Wc8lUvJFETv6jpKJQ4rqQ++WFy8pXQEzQwbZtubeVO0J6TOcUIuyfSeyiDId7it8wPU1kxMSY6nPB07+TfI8Pw3lHfecBy8cbQJ9y0SYQ4FMgig7AKLOfDGEprmKahFw4UL2v9FNm8R7LMha5UjAnZ8EPAdZgN9RdtBf7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918240; c=relaxed/simple;
	bh=vUxLfkCpY88Ji5OMZq0cqa7fD684OUmQSZGkIOTWbog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hlkEK2yYdj7S4M9JpY1U2bZkzF8ElcMhPRK0RjFHLiVWABj2avSNHh/ucqBwonpJnpMPaIi/PHI2hNBeSdZGtueYq0XrYiZX1Y8y1Ng1XAt3qv5hmAGyDsScUQNxhylQlpEw2lQpS65C6UY0TogA+0p9vbjteP+JsGfVsm/7JBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBf8IcQ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBf8IcQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A982C4CEE9;
	Tue, 18 Feb 2025 22:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739918240;
	bh=vUxLfkCpY88Ji5OMZq0cqa7fD684OUmQSZGkIOTWbog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZBf8IcQ7SBqxOHl6shx9kpwOG8zyvVKn1o0yGS+ABt/RZa37ik+go4oxPnyWKBXXw
	 xs63aJ2cPumV1wbfLpy7KOFfanMr5BUOgp6V+iHTBkXUjBduRoCWkgxO2bKS31w4LV
	 4prXRBiq6SBBTjbeBsqH+NOZL+2UCa5bvvkJDplBtndyufgvthbfBo5vnndYsf0OU7
	 A6sAcK1F1kBuiOv2jGAZ0sowBt24oJigB08yD4BPGBIFJpxShDFlONutU4CXbalMzd
	 AhDIB54oRkG3FFpDfQtTuc1nMwMTz/lZcZg34sQQ2qeSsrnD5mPVrhZgy7NDXMh2sW
	 FbdbNMwV+XHlg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/5] Docs/mm/damon/design: categorize DAMOS filter types based on handling layer
Date: Tue, 18 Feb 2025 14:37:08 -0800
Message-Id: <20250218223708.53437-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218223708.53437-1-sj@kernel.org>
References: <20250218223708.53437-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On what DAMON layer a DAMOS filter is handled is important to expect in
what order filters will be evaluated.  Re-organize the DAMOS filter
types list on the design doc to categorize types based on the handling
layer, to let users more easily understand the handling order.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 34 ++++++++++++++-----------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 8b9727d91434..6a66aa0833fd 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -602,25 +602,21 @@ filters-checking overhead.
 
 Below ``type`` of filters are currently supported.
 
-- anon
-    - Applied to pages that containing data that not stored in files.
-    - Handled by operations set layer.  Supported by only ``paddr`` set.
-- memcg
-    - Applied to pages that belonging to a given cgroup.
-    - Handled by operations set layer.  Supported by only ``paddr`` set.
-- young
-    - Applied to pages that are accessed after the last access check from the
-      scheme.
-    - Handled by operations set layer.  Supported by only ``paddr`` set.
-- hugepage_size
-    - Applied to pages that managed in a given size range.
-    - Handled by operations set layer.  Supported by only ``paddr`` set.
-- addr
-    - Applied to pages that belonging to a given address range.
-    - Handled by the core logic.
-- target
-    - Applied to pages that belonging to a given DAMON monitoring target.
-    - Handled by the core logic.
+- Core layer handled
+    - addr
+        - Applied to pages that belonging to a given address range.
+    - target
+        - Applied to pages that belonging to a given DAMON monitoring target.
+- Operations layer handled, supported by only ``paddr`` operations set.
+    - anon
+        - Applied to pages that containing data that not stored in files.
+    - memcg
+        - Applied to pages that belonging to a given cgroup.
+    - young
+        - Applied to pages that are accessed after the last access check from the
+          scheme.
+    - hugepage_size
+        - Applied to pages that managed in a given size range.
 
 To know how user-space can set the filters via :ref:`DAMON sysfs interface
 <sysfs_interface>`, refer to :ref:`filters <sysfs_filters>` part of the
-- 
2.39.5
