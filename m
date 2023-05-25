Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111024EAA
	for <damon@lists.linux.dev>; Thu, 25 May 2023 21:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A86C433AA;
	Thu, 25 May 2023 21:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685051004;
	bh=kRx7Ql+X4ob3mmhrjF9h89mhxljZdGi0sjiE1FJX5Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRtNgrzlQpPWHCCJkCxIGW1T5QYX30ZV8PyfpuCpNijZF9fG2o9gwhI6hI1HuJuXB
	 hEwvfN7QVmwNyqjHfLLBfdaSIwkwvAeh4ai3YycdDhNdLrn/guKnvJYpJxeSa1o32c
	 m2WjEJiDsMxQNDzClBhV3o2/T/UchbSiFGGtIQ+d0lsE1tOsOIlXxCuEgOEhMSMPla
	 JQJBV6ZYCoZXflk0PqwtzFGyYe6sLxQAQ7MU1tQjmuPzm2vL+AiCHkc4D7ehrXqizE
	 HD1eVdUSAJxbUwSnSU5CRNkR6EqAb+1My+CxxAybPlhXoNzE+GHkvt7oYzk5/Nb5Bk
	 kz20ij5EG1pUQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] Docs/mm/damon/design: rewrite configurable layers
Date: Thu, 25 May 2023 21:43:09 +0000
Message-Id: <20230525214314.5204-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525214314.5204-1-sj@kernel.org>
References: <20230525214314.5204-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'Configurable Operations Set' section is a little bit outdated.
Update the text.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index eaf52f3a9144..4a22bab124cf 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -22,24 +22,23 @@ DAMON subsystem is configured with three layers including
 Configurable Operations Set
 ---------------------------
 
-DAMON provides data access monitoring functionality while making the accuracy
-and the overhead controllable.  The fundamental access monitorings require
-primitives that dependent on and optimized for the target address space.  On
-the other hand, the accuracy and overhead tradeoff mechanism, which is the core
-of DAMON, is in the pure logic space.  DAMON separates the two parts in
-different layers and defines its interface to allow various low level
-primitives implementations configurable with the core logic.  We call the low
-level primitives implementations monitoring operations.
-
-Due to this separated design and the configurable interface, users can extend
-DAMON for any address space by configuring the core logics with appropriate
-monitoring operations.  If appropriate one is not provided, users can implement
-the operations on their own.
+For data access monitoring and additional low level work, DAMON needs a set of
+implementations for specific operations that are dependent on and optimized for
+the given target address space.  On the other hand, the accuracy and overhead
+tradeoff mechanism, which is the core logic of DAMON, is in the pure logic
+space.  DAMON separates the two parts in different layers, namely DAMON
+Operations Set and DAMON Core Logics Layers, respectively.  It further defines
+the interface between the layers to allow various operations sets to be
+configured with the core logic.
+
+Due to this design, users can extend DAMON for any address space by configuring
+the core logic to use the appropriate operations set.  If any appropriate set
+is unavailable, users can implement one on their own.
 
 For example, physical memory, virtual memory, swap space, those for specific
 processes, NUMA nodes, files, and backing memory devices would be supportable.
-Also, if some architectures or devices support special optimized access check
-primitives, those will be easily configurable.
+Also, if some architectures or devices supporting special optimized access
+check primitives, those will be easily configurable.
 
 
 Operations Set Layer
-- 
2.25.1

