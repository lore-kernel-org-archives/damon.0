Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B805224EAC
	for <damon@lists.linux.dev>; Thu, 25 May 2023 21:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD41C4339C;
	Thu, 25 May 2023 21:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685051007;
	bh=ZSCtM5xpPfxl9ZcGY7kbIAlY3W8XFj4VJBVoZq5mrJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nUwAJi3+gowT9HAFkMA0ZZUXqK2ioGmXpGUdjFB/arrg1Po32AkJnMJW3vr1F8fVE
	 qRIBYNlqXONIP0Ej+C7cc/MCaVrcckNuW4yEzQ7sIBvgdjWCbVpn/lCXKn9b9fu0oI
	 dnlfRUcIp1zYYpGfvXXb55umKr+yvpGgN6M8KjTixK6MXezkXnfeA8fDKIZecHpPWf
	 LGfcobjbi87gaaplEvo3xfU+sQkC+jAp+vvInameYiGl+KrtIbhVILbRJUl+1HcQeX
	 7mgDcXYZqiVLlOp1U/byyRYiOev/QYdoYXqSwsMA4SMhMeCfWNDbss1MhsUNGpdt+1
	 8LcZKj9Jmx1eA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] Docs/mm/damon/design: add a section for DAMON core API
Date: Thu, 25 May 2023 21:43:13 +0000
Message-Id: <20230525214314.5204-10-sj@kernel.org>
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

Add a section covering the API of DAMON core layer on the design
document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 706dbc17c6cb..0ccdd2f6af9f 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -358,3 +358,15 @@ example, the memory cgroup filter type asks users to specify the file path of
 the memory cgroup for the filter.  Hence, users can apply specific schemes to
 only anonymous pages, non-anonymous pages, pages of specific cgroups, all pages
 excluding those of specific cgroups, and any combination of those.
+
+
+Application Programming Interface
+---------------------------------
+
+The programming interface for kernel space data access-aware applications.
+DAMON is a framework, so it does nothing by itself.  Instead, it only helps
+other kernel components such as subsystems and modules building their data
+access-aware applications using DAMON's core features.  For this, DAMON exposes
+its all features to other kernel components via its application programming
+interface, namely ``include/linux/damon.h``.  Please refer to the API
+:doc:`document </mm/damon/api>` for details of the interface.
-- 
2.25.1

