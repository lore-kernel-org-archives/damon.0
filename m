Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F83845C0;
	Mon, 23 Mar 2026 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307743; cv=none; b=SN8D4KVbxS7sza2azN9H3ABICSq+1vweSiF0polIpy6wVFGKtbv/4qsyLMhDqXs82pnjsekkABr087sCU6YHfvvI2VOtBg+Ceef3mhSXiN7FFVCfCLXPq6XpXj1PuILhaGiqGDKodajj1rNRrAMKze0ZERBow5moze+HU7jVUys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307743; c=relaxed/simple;
	bh=qt20gza/ZGfZPnGlsbY2CkGg3eBlVlFouLw/z7b3qI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2fGBEwrKEIgRtJ5F/2ufmsYmmcwxA31akkYG+DFwUoUJcHcdW4usUvYhlOWKLf+5UrHBWrIcoBNKgsiYiyrAVdL/D83q3qxSoLjUYHrkJY2IMjStP2iDkjmZjlOTnAo/WddHJABURrOa1oqvI4fzMpwnwaSJVp7fB8d4bdnRQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtcnUefe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtcnUefe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2382BC2BCB0;
	Mon, 23 Mar 2026 23:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774307743;
	bh=qt20gza/ZGfZPnGlsbY2CkGg3eBlVlFouLw/z7b3qI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtcnUefe5isd+iu1bOQ8wFtyEdgurzuxLAhYdpRs7TdAXyBqAPivTn0clXdqmucRZ
	 MvbCxhKza0TRTEGnE7WI+M0r72G7TTpQEsbRPOuUYNaNvekbEm2SBySi/GxC2hFOyV
	 pMinKZjeUOem+ULSSRrIbEYe8FFhQbnHbfmCdAd3QolLxeiRU0j4AJ2H0DWIAoD6+S
	 OcSsllTbBXwd44+SacwVNMwNBKmVhX3f3U9/JZKSrJdYJY669gXsTBMbno9kgOC3xm
	 3sksolXHcg79ASGnhVk6ONDh8394Vn/Rkcn5klWaZVnDBfI8DsysfRoFAlD81bys8p
	 oSQllZsjRUh/Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 03/10] Docs/mm/damon/design: update for context pause/resume feature
Date: Mon, 23 Mar 2026 16:15:28 -0700
Message-ID: <20260323231538.84452-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323231538.84452-1-sj@kernel.org>
References: <20260323231538.84452-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the context execution pause/resume
feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index afc7d52bda2f7..510ec6375178d 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -19,6 +19,13 @@ types of monitoring.
 To know how user-space can do the configurations and start/stop DAMON, refer to
 :ref:`DAMON sysfs interface <sysfs_interface>` documentation.
 
+Users can also request each context execution to be paused and resumed.  When
+it is paused, the kdamond does nothing other than applying online parameter
+update.
+
+To know how user-space can pause/resume each context, refer to :ref:`DAMON
+sysfs context <sysfs_context>` usage documentation.
+
 
 Overall Architecture
 ====================
-- 
2.47.3
