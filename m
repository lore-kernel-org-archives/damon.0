Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F113CB550;
	Sun,  6 Sep 2026 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788728725; cv=none; b=GDOoRhMxnPvPXz30YGv1yO7nlHjGJi9mmxwBr+gQbGa09PVFs/KZJUm1RNCRWIjJpZ2zh/0RmWxlphe/WOyaj4z7vK8/5M/9py9rollRptEsama9ICI2A3depF/sCjXLfC3TJmisdLnHeA0Vjn5o8rIY9zQ4QEF/b7JlViPbxeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788728725; c=relaxed/simple;
	bh=+pwt7ytLNv7N/tXD0TT/aWOG89chC7GSwPZ5TDexaSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQzwX9d2PMJXPtZCXW7ec+jHInGBQ3l3tOfuOUCCwsxXPPzXfsavqiMlw7eg3t9RvDkS7uP2XAwX2DJzVEtnzvlwuoFJ5iWlK2KR10yOgvIMvsxvzSPMvNIB5rGWrAf+zXk8m/G31wQ6H8U3t/PRQbgsKQUQmGlp4+Iskqm3VPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htbz0YDU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htbz0YDU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468DA1F00ACA;
	Sun,  6 Sep 2026 21:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788728723;
	bh=3QelAmhdJ8KPxvwLkmNC9X/53BNSeYX//IkIfked+Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=htbz0YDUclUY/USoVqbx+699rw+fijvDqArrnnwYlY32YFEjMnKjnrH05v6egTGJD
	 1+MZUPoGg3ElOWf2EI1tvjZCzjRL28nQDsNidGwjJROUEKiZsyoH9L8p4Pe8wVRJpp
	 iuJL4VMhuURn5Q1vTxPFzY/uJ0yoRAt4d6CQEwr8z4HZnU3nINn/QLsTFqPQlEZHew
	 +YuJcrKhF4T/hyaWUs79Vb0RlQxVmWeId9ObSd8CFyR8wNfSxbw1I71MxjRIg+OEoI
	 l+6gvp0FSLV8vQgL0qG6i/rPG0OEJALLvNOnELFHg7tSjK+yXD7vQ2H7lOTHXdbN/O
	 NIoJr2g/+L/mQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/6] Docs/mm/damon/design: update for probe_hits_wsum DAMOS core filter
Date: Sun,  6 Sep 2026 14:05:11 -0700
Message-ID: <20260906210513.106895-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906210513.106895-1-sj@kernel.org>
References: <20260906210513.106895-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added probe hits weighted sum
based DAMOS core filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aac84de261aa8..8e980dde362de 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -822,6 +822,9 @@ Below ``type`` of filters are currently supported.
         - Applied to pages that belonging to a given address range.
     - target
         - Applied to pages that belonging to a given DAMON monitoring target.
+    - probe_hits_wsum
+        - Matches to monitoring regions having a given range of :ref:`probe
+          hits weighted sum <damon_design_attrs_only_monitoring>` value.
 - Operations layer handled, supported by only ``paddr`` operations set.
     - anon
         - Applied to pages that containing data that not stored in files.
-- 
2.47.3
