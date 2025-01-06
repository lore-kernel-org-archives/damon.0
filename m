Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F241DFDAD;
	Mon,  6 Jan 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736191191; cv=none; b=RSKMSWOAOuNR/IiaiNzRSJslX2jf+UPhLS85sY/Ab+oASGYoVRJ9OqWPa/GIxPz4MofLVArYrQlXzSs9TFAxoh1Nvv7py3vmvWDMMBfBcxCbmDnb6z9DuxApflfGYTNgZLJNoFSjij5gdecvDQbgfKTp9L13lmcXOyg2fyA9O3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736191191; c=relaxed/simple;
	bh=5+ILY6AWLzSiGMYwsHx0+z4eLxwhpFGbZnepiwaDSm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F9ENy6z0sjDrhJJad3ZIMtx3wMPcNxfrfnT9ZrWVUDJ7vA5svrOZEvOW2baEcDsfJR8cFBk5Z/GxL8AzjlJAA2LffetdA74VhYxmSxcVXIOOdB4wYSoWC+93dsf/E1VnB741lZByUozzPdQ5hpgxc47VqlUqHRvO1LBMfMQGH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmPu+efe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmPu+efe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E968CC4CED2;
	Mon,  6 Jan 2025 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736191191;
	bh=5+ILY6AWLzSiGMYwsHx0+z4eLxwhpFGbZnepiwaDSm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GmPu+efeoqikvP1zk66C6wepvQMNgRqweO36kmpptHzpBTfI5raPgt9l4iTKjih7v
	 n0X/ErppPDIXQjurzFYWed2Ow60ezLNo0CdpzpddrBLf6hhw40hot7CZiR50n1TIYO
	 TmtEjJU2w0nmCSse8TveeP+IdR2TMJd6+s9D/Na4eLaz9gwpZ6ATm4f2gGgUnvHdMZ
	 MB64IAxu+7Uc+zOIBrvlJHuX6S5odNIyMgyYKGz2QjZnlYRazLHpw16lHezsDe5uQ9
	 IGpMBllE1OhDc/NmLNCqTkMtqU3owKyS4YLGX1u8FuMMY6jQJu8/mPuzfhtPVRkVqJ
	 i/IgEwykZFaMg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 3/8] Docs/mm/damon/design: update for removal of DAMON debugfs interface
Date: Mon,  6 Jan 2025 11:19:36 -0800
Message-Id: <20250106191941.107070-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106191941.107070-1-sj@kernel.org>
References: <20250106191941.107070-1-sj@kernel.org>
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
index a577ae40e71c..5385ea04c2fd 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -584,15 +584,11 @@ General Purpose User Interface Modules
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
@@ -601,8 +597,9 @@ Github (https://github.com/damonitor/damo), Pypi
 (https://pypistats.org/packages/damo), and Fedora
 (https://packages.fedoraproject.org/pkgs/python-damo/damo/).
 
-Please refer to the ABI :doc:`document </admin-guide/mm/damon/usage>` for
-details of the interfaces.
+Currently, one module for this type, namely 'DAMON sysfs interface' is
+available.  Please refer to the ABI :ref:`doc <sysfs_interface>` for details of
+the interfaces.
 
 
 Special-Purpose Access-aware Kernel Modules
@@ -610,8 +607,8 @@ Special-Purpose Access-aware Kernel Modules
 
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
