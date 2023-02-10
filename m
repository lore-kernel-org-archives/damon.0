Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E567F4
	for <damon@lists.linux.dev>; Fri, 10 Feb 2023 04:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20213C433EF;
	Fri, 10 Feb 2023 04:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676004525;
	bh=x39PRc/T046lvvssIPKrbvAhJnKd48hEXRslXo6G51Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FMLebj8IqIs5vo3DVpcyJ7/HYGRcBna7bSZLxkCSGshx/DP4CdpuHOVAaOReZtRS+
	 mvg6Lcq2EvaItJZPKIFui4VtCK8HVABM7HJGyxpj5ZGGmKpXW0kQyBXfY2fUYKtXOc
	 b5aOsOV2S2N6G4fwtA249ibOtNcjB+m3qgzqcTtlLBnImql24nHqtawmTX0sBceEtc
	 OB2CmTl4Auf+1ifxMouvM7y9Es+WBzZOujAgRbNQ1TSfqoSz/PizZds/CK1iJm0L85
	 Hw3gZtC98Ki9w3YCcHiUvF58EOttEltnfi8IHvB2yQjDSobfBf1fgqIaLvbwZDEOQl
	 tZieONTUe/zXA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] Docs/admin-guide/mm/damon/usage: add DAMON debugfs interface deprecation notice
Date: Fri, 10 Feb 2023 04:48:36 +0000
Message-Id: <20230210044838.63723-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210044838.63723-1-sj@kernel.org>
References: <20230210044838.63723-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON debugfs interface has announced to be deprecated after >v5.15 LTS
kernel is released.  And, v6.1.y has announced to be an LTS[1].

Though the announcement was there for a while, some people might not
noticed that so far.  Also, some users could depend on it and have
problems at  movng to the alternative (DAMON sysfs interface).

For such cases, note DAMON debugfs interface as deprecated, and contacts
to ask helps on the document.

[1] https://git.kernel.org/pub/scm/docs/kernel/website.git/commit/?id=332e9121320bc7461b2d3a79665caf153e51732c

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 9237d6a25897..9b823fec974d 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -25,10 +25,12 @@ DAMON provides below interfaces for different users.
   interface provides only simple :ref:`statistics <damos_stats>` for the
   monitoring results.  For detailed monitoring results, DAMON provides a
   :ref:`tracepoint <tracepoint>`.
-- *debugfs interface.*
+- *debugfs interface. (DEPRECATED!)*
   :ref:`This <debugfs_interface>` is almost identical to :ref:`sysfs interface
-  <sysfs_interface>`.  This will be removed after next LTS kernel is released,
-  so users should move to the :ref:`sysfs interface <sysfs_interface>`.
+  <sysfs_interface>`.  This is deprecated, so users should move to the
+  :ref:`sysfs interface <sysfs_interface>`.  If you depend on this and cannot
+  move, please report your usecase to damon@lists.linux.dev and
+  linux-mm@kvack.org.
 - *Kernel Space Programming Interface.*
   :doc:`This </mm/damon/api>` is for kernel space programmers.  Using this,
   users can utilize every feature of DAMON most flexibly and efficiently by
@@ -487,13 +489,17 @@ the files as above.  Above is only for an example.
 
 .. _debugfs_interface:
 
-debugfs Interface
-=================
+debugfs Interface (DEPRECATED!)
+===============================
 
 .. note::
 
-  DAMON debugfs interface will be removed after next LTS kernel is released, so
-  users should move to the :ref:`sysfs interface <sysfs_interface>`.
+  THIS IS DEPRECATED!
+
+  DAMON debugfs interface is deprecated, so users should move to the
+  :ref:`sysfs interface <sysfs_interface>`.  If you depend on this and cannot
+  move, please report your usecase to damon@lists.linux.dev and
+  linux-mm@kvack.org.
 
 DAMON exports eight files, ``attrs``, ``target_ids``, ``init_regions``,
 ``schemes``, ``monitor_on``, ``kdamond_pid``, ``mk_contexts`` and
-- 
2.25.1

