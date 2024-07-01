Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752D2172BAB;
	Mon,  1 Jul 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862037; cv=none; b=HaZxmNg3S7oL9/FePB2/95a4H/x0jNtEttFpEwv1VbyxiuRVqnoRLFmKVKVWqI64oGlPlMJH32ShgQ7PQwxEYoRpkVd9RP7PmBir1J4wzHmJAw1AZJO5R8qrnlqlkCw4l/YYQBjw/3nqytESyt7oFJaVZxd5mtUX4qT6h59uI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862037; c=relaxed/simple;
	bh=W9d4cUx1EjXG3O2nC/ytqNez6Roq0dChgJMH8XJ7CE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YFsDXDJoirRyPZhqPTJRKK9q4SGU/NJoPE1UTEOltkUuiaeiZerl2Gb6UXd1SmvDCUQXQh16rY4F75QIxEkKQqvrwmn5DA0bbqTls/g0lLtNql46fZzaIJUs7BRN/2LJgzJwZEFlbI5Ak22x6oQdRsnFZXE+ziUvh3vmejsxPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXU6KryR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXU6KryR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9226FC4AF0D;
	Mon,  1 Jul 2024 19:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719862037;
	bh=W9d4cUx1EjXG3O2nC/ytqNez6Roq0dChgJMH8XJ7CE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXU6KryR88jDAsOwngkduDOqIYRUMZ3Zx6gSiN32pgbA9QsG3NtQ71mfMPlhVZpsV
	 3DTrttmY6WafRHkIIVnDhir3Nw3hQa7//04K5Ucxf92WnBeG92/BlbHKEj+NWfv0ke
	 nH58B14RusmqUVBu8o1UA89LsYIs441aD8Vk3PiyWsW5uegD7pPUWS4I0pfAdV5JE3
	 EFD+zqjVWjGWOXksvVlKhX4IRRnygeY3kA/qu8orOL3eFt1A0Bm2uxMJ3vwReE8ZBS
	 mb68L1pa8dImiQoboeisyLrVx1jQ5NAIDEUt34bVZwS7LLEu4gPhozkKAyCLKuQDWg
	 jtvxepdW0s4Bg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] Docs/mm/damon/index: add links to design
Date: Mon,  1 Jul 2024 12:27:05 -0700
Message-Id: <20240701192706.51415-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701192706.51415-1-sj@kernel.org>
References: <20240701192706.51415-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON subsystem documents index page provides a short intro of DAMON
core concepts.  Add links to sections of the design document to let
users easily browse to the details.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst |  1 +
 Documentation/mm/damon/index.rst  | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 89f5330e003f..8730c246ceaa 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -141,6 +141,7 @@ as Idle page tracking does.
 Core Logics
 ===========
 
+.. _damon_design_monitoring:
 
 Monitoring
 ----------
diff --git a/Documentation/mm/damon/index.rst b/Documentation/mm/damon/index.rst
index 5e0a50583500..3d3b345d8889 100644
--- a/Documentation/mm/damon/index.rst
+++ b/Documentation/mm/damon/index.rst
@@ -6,7 +6,7 @@ DAMON: Data Access MONitor
 
 DAMON is a Linux kernel subsystem that provides a framework for data access
 monitoring and the monitoring results based system operations.  The core
-monitoring mechanisms of DAMON (refer to :doc:`design` for the detail) make it
+monitoring :ref:`mechanisms <damon_design_monitoring>` of DAMON make it
 
  - *accurate* (the monitoring output is useful enough for DRAM level memory
    management; It might not appropriate for CPU Cache levels, though),
@@ -21,10 +21,11 @@ users who have special information about their workloads can write personalized
 applications for better understanding and optimizations of their workloads and
 systems.
 
-For easier development of such systems, DAMON provides a feature called DAMOS
-(DAMon-based Operation Schemes) in addition to the monitoring.  Using the
-feature, DAMON users in both kernel and user spaces can do access-aware system
-operations with no code but simple configurations.
+For easier development of such systems, DAMON provides a feature called
+:ref:`DAMOS <damon_design_damos>` (DAMon-based Operation Schemes) in addition
+to the monitoring.  Using the feature, DAMON users in both kernel and user
+spaces can do access-aware system operations with no code but simple
+configurations.
 
 .. toctree::
    :maxdepth: 2
-- 
2.39.2

