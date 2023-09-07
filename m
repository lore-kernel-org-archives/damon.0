Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8F9A29
	for <damon@lists.linux.dev>; Thu,  7 Sep 2023 02:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4271BC43391;
	Thu,  7 Sep 2023 02:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694053779;
	bh=DPwXZPd8fZ7k76FJchCmgeNiFjKUbh+BZTC85e+typU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VfeGOqRlnm1Nvu7Y2kpqlsGEtfB0Kla59hAm6h5Y/p0nAKX8Y+yr52/mK2U5nrH+2
	 hfS//w3W7c4ET/DXTDnly0qtrnvotoU8irI8jZt6PdrASx/nf/QCHupesbiS82wbFj
	 KiEcIUhAXFG2uDrfO7LiMuLy2Rl8udgQmP0xafcIhBpkH7aY7lDryUSN0oIFlsieQ6
	 w46kYv6osQmpIdkqCMMZ7FT6hb0JL4NY4ZUNEszYWhQrH29kzmKstStqhSqFr9tdTC
	 teVpDaZxwOf9lyI69y4dN4BLbnN/YZPQNcQueIoGSoDt4n070hfVug2XT9bl33UsZ8
	 IXUNAIM0JHyvA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] Docs/admin-guide/mm/damon/usage: move debugfs intro to the bottom of the section
Date: Thu,  7 Sep 2023 02:29:21 +0000
Message-Id: <20230907022929.91361-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907022929.91361-1-sj@kernel.org>
References: <20230907022929.91361-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the DAMON usage introduction section, the introduction of DAMON
debugfs interface, which is deprecated, is above kernel API, which is
actively supported.  Move the DAMON debugfs intro to bottom, so that
readers have less chances to read it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index bffe9dd9b0d6..e48101c777e1 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -20,18 +20,18 @@ DAMON provides below interfaces for different users.
   you can write and use your personalized DAMON sysfs wrapper programs that
   reads/writes the sysfs files instead of you.  The `DAMON user space tool
   <https://github.com/awslabs/damo>`_ is one example of such programs.
-- *debugfs interface. (DEPRECATED!)*
-  :ref:`This <debugfs_interface>` is almost identical to :ref:`sysfs interface
-  <sysfs_interface>`.  This is deprecated, so users should move to the
-  :ref:`sysfs interface <sysfs_interface>`.  If you depend on this and cannot
-  move, please report your usecase to damon@lists.linux.dev and
-  linux-mm@kvack.org.
 - *Kernel Space Programming Interface.*
   :doc:`This </mm/damon/api>` is for kernel space programmers.  Using this,
   users can utilize every feature of DAMON most flexibly and efficiently by
   writing kernel space DAMON application programs for you.  You can even extend
   DAMON for various address spaces.  For detail, please refer to the interface
   :doc:`document </mm/damon/api>`.
+- *debugfs interface. (DEPRECATED!)*
+  :ref:`This <debugfs_interface>` is almost identical to :ref:`sysfs interface
+  <sysfs_interface>`.  This is deprecated, so users should move to the
+  :ref:`sysfs interface <sysfs_interface>`.  If you depend on this and cannot
+  move, please report your usecase to damon@lists.linux.dev and
+  linux-mm@kvack.org.
 
 .. _sysfs_interface:
 
-- 
2.25.1

