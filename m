Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96415CAE
	for <damon@lists.linux.dev>; Mon,  5 Dec 2022 23:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1305AC433B5;
	Mon,  5 Dec 2022 23:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670281718;
	bh=ew0j918CPCZ3BCkCfl4ilV0ZC0sdlaLXkkNEQyNFiwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8qG/90jufBB/qjSVpiIuoor4XnhnFVzjtYHepc2rpNDuU7yo7naKqYbm+xUemT+p
	 qIttT3rUj6KqPG8THzAwmC5df/LY0OlN9RZ0cAdXuYxrbHF2EQ9HU6Cb8XcOYdQcZ1
	 QQBc5DPFKjaAX3t0XTQ6D1HhaNWGA2Z+ZXyttXmz+77vKn0Vg2BxQHkOHWmFplAXzc
	 /Cvnc01ns3hEKs/Oni+zs1nc1xnb1fLJa/63pUGo0MYGcW83Da8UJdc2xuwCIec8QL
	 sj4CwRnbiNZ0pcCt7pWD+OzHOuqxbfF24jjEWG4kzF7RNn0ryU/e0lOmoMAfTVjeXo
	 R8sA1F0+fiwCA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 04/11] Docs/admin-guide/damon/reclaim: document 'skip_anon' parameter
Date: Mon,  5 Dec 2022 23:08:23 +0000
Message-Id: <20221205230830.144349-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205230830.144349-1-sj@kernel.org>
References: <20221205230830.144349-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the newly added 'skip_anon' parameter of DAMON_RECLAIM, which
can be used to avoid anonymous pages reclamation.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/reclaim.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 4f1479a11e63..ff335e96e0d8 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -205,6 +205,15 @@ The end physical address of memory region that DAMON_RECLAIM will do work
 against.  That is, DAMON_RECLAIM will find cold memory regions in this region
 and reclaims.  By default, biggest System RAM is used as the region.
 
+skip_anon
+---------
+
+Skip anonymous pages reclamation.
+
+If this parameter is set as ``Y``, DAMON_RECLAIM does not reclaim anonymous
+pages.  By default, ``N``.
+
+
 kdamond_pid
 -----------
 
-- 
2.25.1

