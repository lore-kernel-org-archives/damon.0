Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A78C24EAD
	for <damon@lists.linux.dev>; Thu, 25 May 2023 21:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B759DC4339E;
	Thu, 25 May 2023 21:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685051003;
	bh=NrQxqhDPJ98oboAlR28uGqZUlrS5AmTee+Fa9XTxEmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HMEhL3qQzSUfgwpeBq+8adhjQX0oA4pjhIziNSyjvfCrbF07AwIQT5mklBCXNW4El
	 ROYP9lK+EThF92y9nRLfHJuEWU1NKEtpaIIT3mXlie0WS4ayg6fTmMMImd9+G3nRcY
	 rJ6eJlL4H6bqb+IIyAikKIcjHEgRmAm/WCk3WEBYhgNB1wsoa+ihRuDldcZhlI7erU
	 JSKB8p5tAF8CiYaxOprLoQhCBSkcvD0IOpIMrA9tHfym3lVX38jT5MD1NMFtDVc0mB
	 vvrrDIAKi7niiwB8aSS7dmA0rjtv9HQpKPqXvVqRW2ZO6Uo7dfTRWRdGDVpzr7f8vG
	 ItX0vPPjynI1Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] Docs/mm/damon/design: add a section for overall architecture
Date: Thu, 25 May 2023 21:43:07 +0000
Message-Id: <20230525214314.5204-4-sj@kernel.org>
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

The design doc is missing overall picture of DAMON.  Add a section for
overall architeucture and layers.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 0cff6fac6b7e..3b4ce873fa71 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -4,6 +4,21 @@
 Design
 ======
 
+
+Overall Architecture
+====================
+
+DAMON subsystem is configured with three layers including
+
+- Operations Set: Implements fundamental operations for DAMON that depends on
+  the given monitoring target address-space and available set of
+  software/hardware primitives,
+- Core: Implements core logics including monitoring overhead/accurach control
+  and access-aware system operations on top of the operations set layer, and
+- Modules: Implements kernel modules for various purposes that provides
+  interfaces for the user space, on top of the core layer.
+
+
 Configurable Layers
 ===================
 
-- 
2.25.1

