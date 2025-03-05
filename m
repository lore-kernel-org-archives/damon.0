Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9A1A840E;
	Wed,  5 Mar 2025 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199268; cv=none; b=AZHTGvNNKMaRjgSnSMSaHyM7ey8CoSSMmhWCy/APXxoa4UnWbpuAPL4WtXghOoEpxcMj/me0Mb4AxADr/wB21DQSnmL77HsQaLttLCr5p5yA7o8rHqUWCTL2/Tsr6/9oKdDDtv6Cf/q+1rbMlMYuD4gehklgtq3qyB/0YmzY2iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199268; c=relaxed/simple;
	bh=0JRn2oL0d/efGPIRUs4rL6RIsM6eUgDNL8o7HUvZE5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I9pn1ySPI59V1T4QOjDQIUeNTiin/uPUjXB9Z40P2vJFKB8bfrDh09s9kCTUZt7JL3aJqICTFEb4NBhP2rRiUINzxMCWauVgkYyvKKaryEDktgtWB1oOxm8fi7mT1KYGTRTYS9xMa7ypnHdBdO0IsbfGjZKvKy8zelHdPOL9YK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKtTTZ7b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKtTTZ7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEAFC4CED1;
	Wed,  5 Mar 2025 18:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741199267;
	bh=0JRn2oL0d/efGPIRUs4rL6RIsM6eUgDNL8o7HUvZE5o=;
	h=From:To:Cc:Subject:Date:From;
	b=LKtTTZ7bnfEa99KvTde2cZCQdxHqRZMwGJS+alYW/UzhFH2zTeN6XpqFdPBg3XsPr
	 vAH+sd9JpZtqJWpagxqPecSEzgRtMsPxwe49leQm50LiW5sA53CTleEOoZFcBV/HQ/
	 T+ilklfz/VGITY/NbhsMbaVjDy7wZD15Qlx3g/pzhc9VgX8IfObbpO9PqTdRvq6jGP
	 ruCSavkYDM5CfMsTqTTEyz7CRFERYzs5TygQWDeru73jNHAznR4uoAUQ9PjcnFhLNp
	 BrX9K1t6Q6NGRJiNmshwLmGT8CuL3MU2ofqr3Ln6vgVhowcAdAo6EN2TdR9apxukYZ
	 Zc/Jx+cpi0lug==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH mm-unstable] Docs/mm/damon/design: fix a typo on 'intervals auto-tuning' section
Date: Wed,  5 Mar 2025 10:27:44 -0800
Message-Id: <20250305182744.56125-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8a2e41c7ecfd ("Docs/mm/damon/design: document for intervals
auto-tuning") on mm-unstable tree made a typo on a cross reference link
in monitoring intervals auto-tuning section.  It causes document build
warning.  Fix it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/20250305203312.6f30e9c2@canb.auug.org.au
Fixes: 8a2e41c7ecfd ("Docs/mm/damon/design: document for intervals auto-tuning") # mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 0cf678d98b1b..aae3a691ee69 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -340,7 +340,7 @@ DAMON-observed access events to the theoretical maximum amount of the events
 (``aggrs``).
 
 The DAMON-observed access events are calculated in byte granularity based on
-DAMON :ref:`region assumption <damon_design_region_based_sample>`.  For
+DAMON :ref:`region assumption <damon_design_region_based_sampling>`.  For
 example, if a region of size ``X`` bytes of ``Y`` ``nr_accesses`` is found, it
 means ``X * Y`` access events are observed by DAMON.  Theoretical maximum
 access events for the region is calculated in same way, but replacing ``Y``

base-commit: b6e1916d98e95c70d059da8803c2b3c46151303c
-- 
2.39.5
