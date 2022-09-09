Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233A46137
	for <damon@lists.linux.dev>; Fri,  9 Sep 2022 20:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D210C433B5;
	Fri,  9 Sep 2022 20:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662755349;
	bh=c/LlClDFkomglVBmI+e/AfXU1bu10Srp2u/iwk3ayRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SKFDbBEJPpu9o71DSKWucKzDnYfHJ46Mw5IuVdh4sib1buz9UJZY9VFsxJ9TmVpfv
	 9W/+Ijx7nGgKZJYWkUigQUJIrgiiN6YW3+QP0VMvmtRG51ij1jf7yZXr/pUZmMfx4M
	 xhsfQSlc4wwOZgOdr+5LGwolssAveCxQEMewgp4SDM2BDeNZwTt6j0gMzDBshvizuS
	 P+r19tASMND//x7KTOpqkILncHfSczF9fgmPJYoBKilS+v0bQZmQZFdVbi8ZaYuShk
	 3O/2RBFW1U8gxrYkeQgi2GKm+FEvYQCcmWMRPv95JPuYMqkiKwjGg+5UYoUMAd3mZ+
	 bqCHFxBWTgHhA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 7/7] Docs/admin-guide/mm/damon/usage: note DAMON debugfs interface deprecation plan
Date: Fri,  9 Sep 2022 20:29:01 +0000
Message-Id: <20220909202901.57977-8-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909202901.57977-1-sj@kernel.org>
References: <20220909202901.57977-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b18402726bd1 ("Docs/admin-guide/mm/damon/usage: document DAMON
sysfs interface") announced the DAMON debugfs interface deprecation
plan, but it is not so aggressively announced.  As the deprecation time
is coming, this commit makes the announce more easy to be found by
adding the note at the beginning of the DAMON debugfs interface usage
document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d52f572a9029..c050b882ddc1 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -393,6 +393,11 @@ the files as above.  Above is only for an example.
 debugfs Interface
 =================
 
+.. note::
+
+  DAMON debugfs interface will be removed after next LTS kernel is released, so
+  users should move to the :ref:`sysfs interface <sysfs_interface>`.
+
 DAMON exports eight files, ``attrs``, ``target_ids``, ``init_regions``,
 ``schemes``, ``monitor_on``, ``kdamond_pid``, ``mk_contexts`` and
 ``rm_contexts`` under its debugfs directory, ``<debugfs>/damon/``.
-- 
2.25.1

