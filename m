Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3824EA9
	for <damon@lists.linux.dev>; Thu, 25 May 2023 21:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628EAC433A1;
	Thu, 25 May 2023 21:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685051006;
	bh=AEj9qz2MGylaqhssIqrE5GKEjpK4WMFP3qXqID5+yXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyX8pFa7iyjjjRl1mWdTIaxIwE+6WFCkNPN3hr1dMZUbd+dPKp0C5ADoR9CsBve9e
	 bnXfddX2Lx5JKSre0HSsSFXWjoS0veM3uj+tf9iB6+Z3B731NSUoWlbJviUioTQ2T+
	 TKiuM2414KdPdO+JIp3/GNkwfs/OPQ8Kv2HhHogrZ9mMs1xAmQ3Qf9buiZMjoEaKiK
	 Kyz8vNjhJVeAsCPtdFGbqmUnKclrt1FiidxrBYcPx3a9bTxGCHM2JVKZ9hKVBwngoN
	 4YbweD3aLPcS6BAaaKehmKagw4Rjm1HyNFMbf+Tz63hB2AVFEEhlTZRQGCXYuzgqq0
	 D1HuQ9bJBt11g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] Docs/mm/damon/design: add sections for advanced features of DAMOS
Date: Thu, 25 May 2023 21:43:12 +0000
Message-Id: <20230525214314.5204-9-sj@kernel.org>
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

Add sections for advanced features of DAMOS including quotas,
prioritization, watermarks, and filters of DAMOS on the design document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 86 +++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 9f9253529c3d..706dbc17c6cb 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -272,3 +272,89 @@ the access frequency, and the age.  Users can describe their access pattern of
 interest by setting minimum and maximum values of the three properties.  If a
 region's three properties are in the ranges, DAMOS classifies it as one of the
 regions that the scheme is having an interest in.
+
+
+Quotas
+~~~~~~
+
+DAMOS upper-bound overhead control feature.  DAMOS could incur high overhead if
+the target access pattern is not properly tuned.  For example, if a huge memory
+region having the access pattern of interest is found, applying the scheme's
+action to all pages of the huge region could consume unacceptably large system
+resources.  Preventing such issues by tuning the access pattern could be
+challenging, especially if the access patterns of the workloads are highly
+dynamic.
+
+To mitigate that situation, DAMOS provides an upper-bound overhead control
+feature called quotas.  It lets users specify an upper limit of time that DAMOS
+can use for applying the action, and/or a maximum bytes of memory regions that
+the action can be applied within a user-specified time duration.
+
+
+Prioritization
+^^^^^^^^^^^^^^
+
+A mechanism for making a good decision under the quotas.  When the action
+cannot be applied to all regions of interest due to the quotas, DAMOS
+prioritizes regions and applies the action to only regions having high enough
+priorities so that it will not exceed the quotas.
+
+The prioritization mechanism should be different for each action.  For example,
+rarely accessed (colder) memory regions would be prioritized for page-out
+scheme action.  In contrast, the colder regions would be deprioritized for huge
+page collapse scheme action.  Hence, the prioritization mechanisms for each
+action are implemented in each DAMON operations set, together with the actions.
+
+Though the implementation is up to the DAMON operations set, it would be common
+to calculate the priority using the access pattern properties of the regions.
+Some users would want the mechanisms to be personalized for their specific
+case.  For example, some users would want the mechanism to weigh the recency
+(``age``) more than the access frequency (``nr_accesses``).  DAMOS allows users
+to specify the weight of each access pattern property and passes the
+information to the underlying mechanism.  Nevertheless, how and even whether
+the weight will be respected are up to the underlying prioritization mechanism
+implementation.
+
+
+Watermarks
+~~~~~~~~~~
+
+Conditional DAMOS (de)activation automation.  Users might want DAMOS to run
+only under certain situations.  For example, when a sufficient amount of free
+memory is guaranteed, running a scheme for proactive reclamation would only
+consume unnecessary system resources.  To avoid such consumption, the user would
+need to manually monitor some metrics such as free memory ratio, and turn
+DAMON/DAMOS on or off.
+
+DAMOS allows users to offload such works using three watermarks.  It allows the
+users to configure the metric of their interest, and three watermark values,
+namely high, middle, and low.  If the value of the metric becomes above the
+high watermark or below the low watermark, the scheme is deactivated.  If the
+metric becomes below the mid watermark but above the low watermark, the scheme
+is activated.  If all schemes are deactivated by the watermarks, the monitoring
+is also deactivated.  In this case, the DAMON worker thread only periodically
+checks the watermarks and therefore incurs nearly zero overhead.
+
+
+Filters
+~~~~~~~
+
+Non-access pattern-based target memory regions filtering.  If users run
+self-written programs or have good profiling tools, they could know something
+more than the kernel, such as future access patterns or some special
+requirements for specific types of memory. For example, some users may know
+only anonymous pages can impact their program's performance.  They can also
+have a list of latency-critical processes.
+
+To let users optimize DAMOS schemes with such special knowledge, DAMOS provides
+a feature called DAMOS filters.  The feature allows users to set an arbitrary
+number of filters for each scheme.  Each filter specifies the type of target
+memory, and whether it should exclude the memory of the type (filter-out), or
+all except the memory of the type (filter-in).
+
+As of this writing, anonymous page type and memory cgroup type are supported by
+the feature.  Some filter target types can require additional arguments.  For
+example, the memory cgroup filter type asks users to specify the file path of
+the memory cgroup for the filter.  Hence, users can apply specific schemes to
+only anonymous pages, non-anonymous pages, pages of specific cgroups, all pages
+excluding those of specific cgroups, and any combination of those.
-- 
2.25.1

