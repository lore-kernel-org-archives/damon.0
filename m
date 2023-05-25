Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C65824EAA
	for <damon@lists.linux.dev>; Thu, 25 May 2023 21:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C31EC4339E;
	Thu, 25 May 2023 21:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685051006;
	bh=APr09IDiXGykzuGGa19YHF7doztMwWo2QuV04whzSE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nzbBk6KCaeEKjgaCqUIVU5hTiLijuoQ2H2aJfAUzxi/UVr0w7ei8EnEamotAgKXfL
	 1JF/RgO5UylZl9FlBIpP399R6mpJfXhfU8jx72dyC0YDzfWvAjkDaf22nyQ9VIRqeY
	 Xc1e1uEfUPDeYFysPQ5t9qDZVJhWXzg5djp9FRE5fSGQuimSe0YWEqmJwuoR1rQPUG
	 G6i6YnbO3iJYJqgyTvJVVAByL5/4lUEU039yAGDyAX0TIFjzqJFJatQ/no1KeLwdNx
	 G84vkoXyWM1gRPfQVIfhW57qQ2wnQ8HyVM7PXxMOYP2YxHQXN6+/hlIyR+gXywy4Pt
	 niR+/fxAA9vmw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] Docs/mm/damon/design: add sections for basic parts of DAMOS
Date: Thu, 25 May 2023 21:43:11 +0000
Message-Id: <20230525214314.5204-8-sj@kernel.org>
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

DAMOS is an important part of DAMON, but the design doc is not covering
it.  Add sections for covering the basic part of DAMOS.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 41abd0430dd7..9f9253529c3d 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -202,3 +202,73 @@ monitoring operations to check dynamic changes including memory mapping changes
 and applies it to monitoring operations-related data structures such as the
 abstracted monitoring target memory area only for each of a user-specified time
 interval (``update interval``).
+
+
+Operation Schemes
+-----------------
+
+One common purpose of data access monitoring is access-aware system efficiency
+optimizations.  For example,
+
+    paging out memory regions that are not accessed for more than two minutes
+
+or
+
+    using THP for memory regions that are larger than 2 MiB and showing a high
+    access frequency for more than one minute.
+
+One straightforward approach for such schemes would be profile-guided
+optimizations.  That is, getting data access monitoring results of the
+workloads or the system using DAMON, finding memory regions of special
+characteristics by profiling the monitoring results, and making system
+operation changes for the regions.  The changes could be made by modifying or
+providing advice to the software (the application and/or the kernel), or
+reconfiguring the hardware.  Both offline and online approaches could be
+available.
+
+Among those, providing advice to the kernel at runtime would be flexible and
+effective, and therefore widely be used.   However, implementing such schemes
+could impose unnecessary redundancy and inefficiency.  The profiling could be
+redundant if the type of interest is common.  Exchanging the information
+including monitoring results and operation advice between kernel and user
+spaces could be inefficient.
+
+To allow users to reduce such redundancy and inefficiencies by offloading the
+works, DAMON provides a feature called Data Access Monitoring-based Operation
+Schemes (DAMOS).  It lets users specify their desired schemes at a high
+level.  For such specifications, DAMON starts monitoring, finds regions having
+the access pattern of interest, and applies the user-desired operation actions
+to the regions as soon as found.
+
+
+Operation Action
+~~~~~~~~~~~~~~~~
+
+The management action that the users desire to apply to the regions of their
+interest.  For example, paging out, prioritizing for next reclamation victim
+selection, advising ``khugepaged`` to collapse or split, or doing nothing but
+collecting statistics of the regions.
+
+The list of supported actions is defined in DAMOS, but the implementation of
+each action is in the DAMON operations set layer because the implementation
+normally depends on the monitoring target address space.  For example, the code
+for paging specific virtual address ranges out would be different from that for
+physical address ranges.  And the monitoring operations implementation sets are
+not mandated to support all actions of the list.  Hence, the availability of
+specific DAMOS action depends on what operations set is selected to be used
+together.
+
+Applying an action to a region is considered as changing the region's
+characteristics.  Hence, DAMOS resets the age of regions when an action is
+applied to those.
+
+
+Target Access Pattern
+~~~~~~~~~~~~~~~~~~~~~
+
+The access pattern of the schemes' interest.  The patterns are constructed with
+the properties that DAMON's monitoring results provide, specifically the size,
+the access frequency, and the age.  Users can describe their access pattern of
+interest by setting minimum and maximum values of the three properties.  If a
+region's three properties are in the ranges, DAMOS classifies it as one of the
+regions that the scheme is having an interest in.
-- 
2.25.1

