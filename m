Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB96A490
	for <damon@lists.linux.dev>; Wed, 30 Nov 2022 20:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE43C43470;
	Wed, 30 Nov 2022 20:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669838984;
	bh=ew0j918CPCZ3BCkCfl4ilV0ZC0sdlaLXkkNEQyNFiwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsbL+COvjvgKot+WGk8Bh1WRZz9wpWt4QxI1jWnHQ/jgVRU2/BaOelw9lolBjfLR3
	 QuyMEav1UneZQ7KX6Sf9YHsC4PXGGzmDlUR8h5+UCmFG82UfT+l31rF38bUhYWgjfV
	 xnh5oDuMGSpfh49FDo7tamV37HyCyqOLo7WIOqoV7IB1ZY3Zcenprk0xewGVhvXHmt
	 kMQo3Y8sHjWjNtFKu0nhSSEpgu7HZpFwCbv1T6PhgFYvY97AIDC+Q8ELPYLaBHa3QM
	 +Bt/qATHcq9FV4BaPZQuaPELjNt0gDnbJDd00kHwfj5uYMv3xVxnntP57vD2UAhv5P
	 UV72nW8PC4oOQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 04/11] Docs/admin-guide/damon/reclaim: document 'skip_anon' parameter
Date: Wed, 30 Nov 2022 20:09:30 +0000
Message-Id: <20221130200937.118005-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130200937.118005-1-sj@kernel.org>
References: <20221130200937.118005-1-sj@kernel.org>
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

