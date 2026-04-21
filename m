Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254602868A9;
	Tue, 21 Apr 2026 04:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776746986; cv=none; b=Sn2CrO1BmQNTniMoGCoYJ9eptEqT/6iEusXR0CaITzsmzhrdL8/aHgKO1Q8Jy7GDa7p80psX/iP7Tb5ET+gF0Ix5h3P9uOPb6HcW43+asN2gE0rFghKTYwkrLo1RhDh56C8XtOULY8QB7kKGLfwZ4muHcpjnG+CQe1AgfdbUFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776746986; c=relaxed/simple;
	bh=58RqIGxjkE+DGlcSy5aHIfF8jnvuEdtFZZsL+mLllnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5KJ70LUX0Np9cQLVjAmZj4EmVB5p9TLM8U7ePqG6uv5bL7mdVmKbCwnMeCsaWE/uuUDr13g6O6zVWyzorepz1/OSD30yKO7yS6RVNlRtN0GUzDQ1nb08oC8C7SUtK9CbtXYIL3U5NKjJGfHOp42MYDTDvVFfMEMDH+h7k6jjFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULln33mB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULln33mB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC367C2BCB3;
	Tue, 21 Apr 2026 04:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776746985;
	bh=58RqIGxjkE+DGlcSy5aHIfF8jnvuEdtFZZsL+mLllnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ULln33mBNTI3tL5SwpU2ppT2qiQ22TC5bpbiUC5rjOoQj1IpPFMqFMUFXCw6yE/cv
	 KaG90NotlnowFbXifeKAOAwW2xcmatGracrelf8vM5cRj49xOylnI4IVRJBempzfBt
	 p3n7uRjBh1eG3WdDuw8r8kGLojkP72NQli8YgW+HLRZyiQRxSiH5hDPJpwq+Ky33D+
	 AqBrNbQFN0BGmV5qeIsj+kcsoCdSG0DEvtLtHsoe73Op/m2ATggp2KGYDhB1jMwsFA
	 2NR7UYZnxwm6KZ9HohH8QFJ1+cdEs/X+BLtuZPJ4KhyzJ1m5FqDjggB2eqe7BNfwex
	 4u3OkwntHcJ5g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/2] Docs/ABI/damon: mark schemes/<S>/filters/ deprecated
Date: Mon, 20 Apr 2026 21:49:27 -0700
Message-ID: <20260421044928.141388-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421044928.141388-1-sj@kernel.org>
References: <20260421044928.141388-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the 'filters/' directory is deprecated.  Update ABI document to also
announce the fact.  Also update the descriptions of the files to be
based on 'core_filter/' directory, to make the old descriptions ready to
be removed when the time arrives.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 62 ++++++++++---------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 971c22e34e722..ee29d4e204ffa 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -396,15 +396,20 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the low
 		watermark of the scheme in permil.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/nr_filters
-Date:		Dec 2022
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Directory for DAMON core layer-handled DAMOS filters.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters/nr_filters
+Date:		Feb 2025
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing a number 'N' to this file creates the number of
 		directories for setting filters of the scheme named '0' to
-		'N-1' under the filters/ directory.
+		'N-1' under the core_filters/ directory.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/type
-Date:		Dec 2022
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters/<F>/type
+Date:		Feb 2025
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the type of
 		the memory of the interest.  'anon' for anonymous pages,
@@ -412,77 +417,78 @@ Description:	Writing to and reading from this file sets and gets the type of
 		'addr' for address range (an open-ended interval), or 'target'
 		for DAMON monitoring target can be written and read.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/memcg_path
-Date:		Dec 2022
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters/<F>/memcg_path
+Date:		Feb 2025
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	If 'memcg' is written to the 'type' file, writing to and
 		reading from this file sets and gets the path to the memory
 		cgroup of the interest.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/addr_start
-Date:		Jul 2023
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters/<F>/addr_start
+Date:		Feb 2025
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	If 'addr' is written to the 'type' file, writing to or reading
 		from this file sets or gets the start address of the address
 		range for the filter.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/addr_end
-Date:		Jul 2023
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters/<F>/addr_end
+Date:		Feb 2025
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	If 'addr' is written to the 'type' file, writing to or reading
 		from this file sets or gets the end address of the address
 		range for the filter.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/min
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters/<F>/min
 Date:		Feb 2025
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	If 'hugepage_size' is written to the 'type' file, writing to
 		or reading from this file sets or gets the minimum size of the
 		hugepage for the filter.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/max
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters/<F>/max
 Date:		Feb 2025
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	If 'hugepage_size' is written to the 'type' file, writing to
 		or reading from this file sets or gets the maximum size of the
 		hugepage for the filter.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/target_idx
-Date:		Dec 2022
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters/<F>/target_idx
+Date:		Feb 2025
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	If 'target' is written to the 'type' file, writing to or
 		reading from this file sets or gets the index of the DAMON
 		monitoring target of the interest.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/matching
-Date:		Dec 2022
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters/<F>/matching
+Date:		Feb 2025
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing 'Y' or 'N' to this file sets whether the filter is for
 		the memory of the 'type', or all except the 'type'.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/allow
-Date:		Jan 2025
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters/<F>/allow
+Date:		Feb 2025
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing 'Y' or 'N' to this file sets whether to allow or reject
 		applying the scheme's action to the memory that satisfies the
 		'type' and the 'matching' of the directory.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters
-Date:		Feb 2025
-Contact:	SeongJae Park <sj@kernel.org>
-Description:	Directory for DAMON core layer-handled DAMOS filters.  Files
-		under this directory works same to those of
-		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters
-		directory.
-
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/ops_filters
 Date:		Feb 2025
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Directory for DAMON operations set layer-handled DAMOS filters.
 		Files under this directory works same to those of
-		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters
+		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters
 		directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters
+Date:		Dec 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Directory for DAMOS filters.  Files under this directory works
+		same to those of
+		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/{core,ops}_filters
+		directory.  This is deprecated.  Use the core_filters and
+		ops_filters instead.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/dests/nr_dests
 Date:		Jul 2025
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
