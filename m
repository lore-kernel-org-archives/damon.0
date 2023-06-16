Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66719BBB
	for <damon@lists.linux.dev>; Fri, 16 Jun 2023 19:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C470C433C9;
	Fri, 16 Jun 2023 19:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686943070;
	bh=aJtinuQE5hnsMJprwvOnjBhsLDj5P+RjjV73H7HUq2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NxTPy+3OTB1zZ2p0KOifG1NKvCKG0RPDaSG85QRPUoigBNHlTUZu4IbuDIX1BN/r6
	 0+nWVeeA4PP8KxacmnmdoMm28huF1hDRuC3xDPquhxJ9hgJhhpngED2RmZ6zH6kEyu
	 vOm2l99AeV0gY6VxJKIc+q6c86nnHp8VLuRBybH05MJ14lf4M3Ud0Tplt+AhqMnPhH
	 W71TKq1CqbVD8hCBBNAwHmx02Yp1kwjtV/BEnhE2hT4VQM2Wr+OsPXz5lUtKzPkY+A
	 xFXbHLwoDdVbARv4s+MCH8i6Ft0nXc8fQ5morIYwX0LYBsCcf98vRU6AC9zqngPjCv
	 nzMOLdQ3vE3iQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] Docs/admin-guide/mm/damon/usage: remove unnecessary sentences about supported address spaces
Date: Fri, 16 Jun 2023 19:17:39 +0000
Message-Id: <20230616191742.87531-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616191742.87531-1-sj@kernel.org>
References: <20230616191742.87531-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Brief explanation of DAMON user space tool and sysfs interface are
unnecessarily and repeatedly mentioning the list of address spaces that
DAMON is supporting.  Remove those.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d2435dcc22f4..82a79838a47d 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -10,9 +10,8 @@ DAMON provides below interfaces for different users.
   `This <https://github.com/awslabs/damo>`_ is for privileged people such as
   system administrators who want a just-working human-friendly interface.
   Using this, users can use the DAMON’s major features in a human-friendly way.
-  It may not be highly tuned for special cases, though.  It supports both
-  virtual and physical address spaces monitoring.  For more detail, please
-  refer to its `usage document
+  It may not be highly tuned for special cases, though.  For more detail,
+  please refer to its `usage document
   <https://github.com/awslabs/damo/blob/next/USAGE.md>`_.
 - *sysfs interface.*
   :ref:`This <sysfs_interface>` is for privileged user space programmers who
@@ -20,10 +19,9 @@ DAMON provides below interfaces for different users.
   features by reading from and writing to special sysfs files.  Therefore,
   you can write and use your personalized DAMON sysfs wrapper programs that
   reads/writes the sysfs files instead of you.  The `DAMON user space tool
-  <https://github.com/awslabs/damo>`_ is one example of such programs.  It
-  supports both virtual and physical address spaces monitoring.  Note that this
-  interface provides only simple :ref:`statistics <damos_stats>` for the
-  monitoring results.  For detailed monitoring results, DAMON provides a
+  <https://github.com/awslabs/damo>`_ is one example of such programs.  Note
+  that this interface provides only simple :ref:`statistics <damos_stats>` for
+  the monitoring results.  For detailed monitoring results, DAMON provides a
   :ref:`tracepoint <tracepoint>`.
 - *debugfs interface. (DEPRECATED!)*
   :ref:`This <debugfs_interface>` is almost identical to :ref:`sysfs interface
-- 
2.25.1

