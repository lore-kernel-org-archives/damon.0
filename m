Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590981FC7D2;
	Tue, 15 Oct 2024 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014864; cv=none; b=gmmba/2d6LNUViE1SUhydynZGF13u3UgQgsMQczRm31uWJlRKEumIjEi/pkmAH/K6OO6pvK7tn3kU0YtJsqhCgrUX0icTK4HeA2FBabX9ByndWMiq2oBakZ2OYGhFPPZhDy2eRO7Fbgbb/tzG8I6spf78CNgii0V2hhYKFO5iJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014864; c=relaxed/simple;
	bh=wNqTcFJIxQW0DGiFjvquOYDznG7ET2BviVO3AFzePVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r5kIEL1QTVaLYz//KAb681doEOR+w3d8uM5IME0/lqb0Gc8swZMX5myF/kIG1Un2RD8JzTfzscd8NaDbjhEQ8NW3IGatOFlfKT/mmwM0Pi74TiFlfP36nl/SISsUhFCH8djWW4yfE97mttw+kofJ6D29JEPggKy9dumvbTFe7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN553IGY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN553IGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FACC4CEC6;
	Tue, 15 Oct 2024 17:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729014863;
	bh=wNqTcFJIxQW0DGiFjvquOYDznG7ET2BviVO3AFzePVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IN553IGYCEU2daGjInivP6wG0GqSAzY1UIjJtoUptobp/Mi1e1SbYGZ8c4FCruTm/
	 qtklAPy3K+bvswTj4bT2cK8UcYo4ZqYGYn38LIzSYHJxpWBj5AEOi3Ijba8AE2PLW4
	 SKVTgx9GC6L2qKGAsYaYEr6akbFYH74Sgna3lEReGrulejAW95EsdPLDpN2cnkguSs
	 zvldwUqzg77Ayt+TqxcrMl8pXczmm0hwtKydMSW6w56qSBhyPljk6mlEDKADUaBu7T
	 OdMJHJAVLYmvWdrccFdnWpQPnk7As+zzqBH7d8KVPruAmReCP1sgUOA41v8MnjR7eF
	 sdZVR9Jm02dRg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/7] Docs/mm/damon/design: update for removal of DAMON debugfs interface
Date: Tue, 15 Oct 2024 10:54:07 -0700
Message-Id: <20241015175412.60563-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015175412.60563-1-sj@kernel.org>
References: <20241015175412.60563-1-sj@kernel.org>
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

