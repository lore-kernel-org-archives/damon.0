Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CB5188596;
	Tue, 13 May 2025 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747096048; cv=none; b=gR2urQ3Tusw3JsyRrpJP/4P6REXY81n9MZH5/9EQrCDK4oCI3Q2mu/L7HF7qkXKwjNpF3KNrEYd94lxCuuVpzVEHkhoSwMMikuG/5cj7jkKTsgwWFcl3SETW0wkkpI56eFFm5Oh6HImKYvk0mgmeg98Px3h/2Cbths4VofBeUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747096048; c=relaxed/simple;
	bh=kXvluihMNMWvXVIh9NrJQXQKlW2y25lXBUZDLEXI/WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SN0ATPwhXVMUYhpux7h5QFv3s2kWlxPTRfLeyXHLhDmkOse7T0goy5vHHZefBZUXjOVlga7wHdkphn+/f5AJ5CDQzDHSooRcAKH8wSi2r3YyxrY7j6cMzcKJGQyjSiGT7EQPHFedYxUYRnqhuQJK4lnPJdspBTB1XSis0YXB9ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9EcfgqH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9EcfgqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD292C4CEEE;
	Tue, 13 May 2025 00:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747096048;
	bh=kXvluihMNMWvXVIh9NrJQXQKlW2y25lXBUZDLEXI/WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9EcfgqHtoB6ntSBYpKDbE2bsmlHPDDlnuBt9qKx9PmWq8mqZnUDfbxSeWiFjZ1bP
	 hdOTFuBVgmyQ2PiR8C2cgyKaESGy/2F/k0RkQpv0RGbaBqlVs4YbIHFyVtwU7yHZ5Y
	 AVB+e3R3xJ8NZ2DvnPoILVqsczzlRzMYFgABcuBfpRB9JcAlQ4v+ck1T850KRua+yf
	 uvizGCLwGJCbsRy7iW8fC+P37sFuXZQ1o02tQ0Ul/Ld6TOdbPvdFXU7/Ycxv/glRpC
	 8Dpy0kslsKhRwGDE5Bdn86SCBmlOvpdsEBtK9fc8qthdyZHmRKHCJj48M/HK1JFA6Z
	 zkwQzLbzw/E7w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/6] Docs/damon: update titles and brief introductions to explain DAMOS
Date: Mon, 12 May 2025 17:27:15 -0700
Message-Id: <20250513002715.40126-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250513002715.40126-1-sj@kernel.org>
References: <20250513002715.40126-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON was initially developed only for data access monitoring, and then
extended for not only access monitoring but also access-aware system
operations (DAMOS).  But the documents have old titles and brief
introductions for only the monitoring part.  Update the titles and the
brief introductions to explain DAMOS part together.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/index.rst | 11 +++++------
 Documentation/mm/damon/index.rst             |  6 +++---
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/index.rst b/Documentation/admin-guide/mm/damon/index.rst
index 33d37bb2fb4e..bc7e976120e0 100644
--- a/Documentation/admin-guide/mm/damon/index.rst
+++ b/Documentation/admin-guide/mm/damon/index.rst
@@ -1,12 +1,11 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-==========================
-DAMON: Data Access MONitor
-==========================
+================================================================
+DAMON: Data Access MONitoring and Access-aware System Operations
+================================================================
 
-:doc:`DAMON </mm/damon/index>` allows light-weight data access monitoring.
-Using DAMON, users can analyze the memory access patterns of their systems and
-optimize those.
+:doc:`DAMON </mm/damon/index>` is a Linux kernel subsystem for efficient data
+access monitoring and access-aware system operations.
 
 .. toctree::
    :maxdepth: 2
diff --git a/Documentation/mm/damon/index.rst b/Documentation/mm/damon/index.rst
index 5a3359704cce..31c1fa955b3d 100644
--- a/Documentation/mm/damon/index.rst
+++ b/Documentation/mm/damon/index.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-==========================
-DAMON: Data Access MONitor
-==========================
+================================================================
+DAMON: Data Access MONitoring and Access-aware System Operations
+================================================================
 
 DAMON is a Linux kernel subsystem that provides a framework for data access
 monitoring and the monitoring results based system operations.  The core
-- 
2.39.5

