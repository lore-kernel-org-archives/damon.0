Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C262EA172;
	Sat, 25 Apr 2026 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777149199; cv=none; b=lC4MjgCw10yRwOqYRk/SgKVAYefEAmpPcbld+35wu+Cc0j++uC2oeaJmooVu1Xl0vd0/hz2hs+sheGqyN5xnAFU6fKKNJptXRMeh0L6itJZsktDQGhRS70+a2GUFHLssqgOHKnGlI2RCYyxVSEZ61imdODScT+HzMNj6e5P2mWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777149199; c=relaxed/simple;
	bh=CjM5lHlUhKQqvVPvH7UjU4XdbEsk9yGpjrvSpB7psBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JwMQrjqRzwv7t0aOzjviVztEbstIOL/0nMNfGCzXPyjnOUDX0HE0ccywBHxifv/Cuq65Xl+cIXXuuN7hDJ7aOoJq/rhf8ZnwayZbCMUBV7CbZICS3mhGUKVUrKudnvj3H87lYUeD6uI1yOX+r4zyAbm892zesWUnFWtQwww3WxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISMfSf8B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISMfSf8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE07CC2BCB0;
	Sat, 25 Apr 2026 20:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777149198;
	bh=CjM5lHlUhKQqvVPvH7UjU4XdbEsk9yGpjrvSpB7psBw=;
	h=From:To:Cc:Subject:Date:From;
	b=ISMfSf8BKWaQOyhRKMyF1fdfzSjS6trY71nemW+erw60DWG+tyXf1QJGLa36u79WG
	 XhFSPMfUCdO7cTgp+8EAcJH9gYB1iVv19yJARhMo9rNZ/aKsVOEaUW8cFYn94qvVlA
	 Bdj/N2gio+kSw4fT4UrP8rsExEgqHZkSX2AfLDyouuop8mS+YE9Zo8LLApj5nj7EZx
	 5RK3jsK2xCcIwYdXmUPvDe1WrmZRYlt40hhifvJFVvHb5MaJfkJjUV6+G0Q5n8DHJh
	 QAzhTrz8+YOmLNth0V21SWMysRzYa/Ugi171v9dqdQY+oZddFr6jRJGJVaIgFDeE68
	 x9oc89H1ZOQuQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [RFC PATCH v2 0/2] mm/damon/stat: add kdamond_pid parameter
Date: Sat, 25 Apr 2026 13:33:05 -0700
Message-ID: <20260425203309.108879-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_STAT doesn't provide the pid of its kdamond, unlike DAMON_RECLAIM
and DAMON_LRU_SORT.  This makes user-space management of DAMON_STAT
unnecessarily complicated.  Provide the information via a new parameter,
namely kdamond_pid, and document it.

Changes from RFC v1.2
- rfc v1.2: https://lore.kernel.org/20260416002149.87090-1-sj@kernel.org
- Detect and use fresh kdamond pid.
Changes from RFC v1.1
- rfc v1.1: https://lore.kernel.org/20260414235912.98174-1-sj@kernel.org
- Close the parentheses of error handling block.
Changes from RFC
- rfc: https://lore.kernel.org/20260414053742.90296-1-sj@kernel.org
- Fix damon_kdamond_pid() failure handling.

SeongJae Park (2):
  mm/damon/stat: add a parameter for reading kdamond pid
  Docs/admin-guide/mm/damon/stat: document kdamond_pid parameter

 Documentation/admin-guide/mm/damon/stat.rst |  7 ++++
 mm/damon/stat.c                             | 38 +++++++++++++++++++++
 2 files changed, 45 insertions(+)


base-commit: 4eb752fe1ea250a5339f1e70398c5fa3a18afb87
-- 
2.47.3
