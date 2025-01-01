Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC61E3799;
	Wed,  1 Jan 2025 21:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735767338; cv=none; b=Esb94OFda3BkCI9jtYOwQWet0caVJBWp1JS3Ka/vSXgBwmbZNLgR7S7xMSUhTWJdUNliXpz7TVcsF2XM2D8IMdNaz3qe2LKMcM90stMYtzrXyMPaVQ4nxcVSqnWFJa7YAfHgG2bCwfxL9aWm+5bYKvpNTKFQ1n0iyaXxVmb+nQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735767338; c=relaxed/simple;
	bh=wNqTcFJIxQW0DGiFjvquOYDznG7ET2BviVO3AFzePVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JRag7y5lrLxNsqVWqhGRAY9/S8o793GEKUZ1x0axpg3R2i61B4FHQD/3BUCHYGztmaZ9JRsdWAjvpkI+hIS9bgCxbcy/ckFl3cvWYuA1QI0sa1kHRyTa/hExVJEV+mShVP7GGRoo2d65Gev4amS3oHX5uxfHwqXhpzFaqsb47U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHhA5gxk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHhA5gxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C76C4CEDD;
	Wed,  1 Jan 2025 21:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735767337;
	bh=wNqTcFJIxQW0DGiFjvquOYDznG7ET2BviVO3AFzePVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UHhA5gxk1kOay39rsNUMKcL5VNJIKngUbHyRxQ9Q1uNVT9bpE167KT+wbWqY7jeXE
	 Q6VljzQGUcn31tWCvYMnC42Y9dqiQwIkgNpKoMGY5K7XPlboVZia/IAq060pbGC08g
	 m6R6JSOsavS5oJwxWrI/7qjrHltRR5jz79FNGq1CAslofemo5IM0mChUMidBNFescB
	 11B/VEeCQIdXETPDq2ypVc5GKvRoflw4GhiCqkBZvc7OqHoHhRQe7PJmzqG07GHm0c
	 +h5rA9hIPz/ZjNY6p6lLVSG8kEQLtZZO5p+xkJqFmnqgSOL5/9bxMM9+JyUTQHqQCB
	 tmrn/SSH3DCQQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/7] Docs/mm/damon/design: update for removal of DAMON debugfs interface
Date: Wed,  1 Jan 2025 13:35:22 -0800
Message-Id: <20250101213527.74203-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250101213527.74203-1-sj@kernel.org>
References: <20250101213527.74203-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's time to remove DAMON debugfs interface, which has deprecated long
before in February 2023.  Read the cover letter of this patch series for
more details.

Update DAMON design documentation to stop mentioning about the
interface, to avoid unnecessary confuses.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index f9c50525bdbf..1c8a43b07b00 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -573,15 +573,11 @@ General Purpose User Interface Modules
 DAMON modules that provide user space ABIs for general purpose DAMON usage in
 runtime.
 
-DAMON user interface modules, namely 'DAMON sysfs interface' and 'DAMON debugfs
-interface' are DAMON API user kernel modules that provide ABIs to the
-user-space.  Please note that DAMON debugfs interface is currently deprecated.
-
-Like many other ABIs, the modules create files on sysfs and debugfs, allow
-users to specify their requests to and get the answers from DAMON by writing to
-and reading from the files.  As a response to such I/O, DAMON user interface
-modules control DAMON and retrieve the results as user requested via the DAMON
-API, and return the results to the user-space.
+Like many other ABIs, the modules create files on pseudo file systems like
+'sysfs', allow users to specify their requests to and get the answers from
+DAMON by writing to and reading from the files.  As a response to such I/O,
+DAMON user interface modules control DAMON and retrieve the results as user
+requested via the DAMON API, and return the results to the user-space.
 
 The ABIs are designed to be used for user space applications development,
 rather than human beings' fingers.  Human users are recommended to use such
@@ -590,8 +586,9 @@ Github (https://github.com/damonitor/damo), Pypi
 (https://pypistats.org/packages/damo), and Fedora
 (https://packages.fedoraproject.org/pkgs/python-damo/damo/).
 
-Please refer to the ABI :doc:`document </admin-guide/mm/damon/usage>` for
-details of the interfaces.
+Currently, one module for this type, namely 'DAMON sysfs interface' is
+available.  Please refer to the ABI :ref:`doc <sysfs_interface>` for details of
+the interfaces.
 
 
 Special-Purpose Access-aware Kernel Modules
@@ -599,8 +596,8 @@ Special-Purpose Access-aware Kernel Modules
 
 DAMON modules that provide user space ABI for specific purpose DAMON usage.
 
-DAMON sysfs/debugfs user interfaces are for full control of all DAMON features
-in runtime.  For each special-purpose system-wide data access-aware system
+DAMON user interface modules are for full control of all DAMON features in
+runtime.  For each special-purpose system-wide data access-aware system
 operations such as proactive reclamation or LRU lists balancing, the interfaces
 could be simplified by removing unnecessary knobs for the specific purpose, and
 extended for boot-time and even compile time control.  Default values of DAMON
-- 
2.39.5
