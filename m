Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1976D37C0F7;
	Sun, 15 Mar 2026 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773608424; cv=none; b=arWWxkFbaa1rj7rMJuaHphJ0w6TPRH3W6sM04SgzdoSYcmiW2sVeA6uiM6NVujknKR6Wr5GNMqBBXe09UoLeizo7PUlXx7MUUHVBCCikf2i7IpUxzQ0Qo2RejPPVzoTEvUMAaIC3sFtYlFre0/L29i+oeFcrg1ky1xRGbS8B48Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773608424; c=relaxed/simple;
	bh=ZFcnqfyAW4BGE18Wt14ay/AwA/gxtaEmh1rLITl8M3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfx36alKeNUs7vpxnC4o9Vp9KNO7Uum9ySZ4BifU2v1jXsSjPzo0u7ips2CpsIu+A56A6HJbYPXhzbWHjrfg0EGD/ECbqpMMWeslNEmpsL3c6Z1yaLzBqwEFYzDRTjaaZ0Bc0cez8YIMTu0trQhEnsjih/zkLQRLd89ngks0dVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TztPq/Xd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TztPq/Xd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994FCC2BCB0;
	Sun, 15 Mar 2026 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773608423;
	bh=ZFcnqfyAW4BGE18Wt14ay/AwA/gxtaEmh1rLITl8M3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TztPq/XdarWP317/J+QUEhiIvSmkoULqcTmaP7DcnRcmKg1qhTO1AVyUMzPGaBDj1
	 tbMOTnARI7GPnhOEOdNV5Mb+fZhuYVsAp69dg5RXpR09GNmgcfIVlmoA1NAkc2af+b
	 w58LkdXXf7h9DDs4NbZP6ldKGXv5TLhnRnfMM01y+D7JmZDPOMdT9DysTX4vWxFnfI
	 n46QpEnYCcYS3x5s8ObGh2QVXh9Pvc5pv4U23/1KY/rOLKbJ0Ls7EdqrzQJ6SfV8VU
	 4XE9c5CNufrkLCw5tgqtLZ1w/gclkzkMzLFuyGR3rBCgdbtITIELa7VJ677RIkIysj
	 U9Cp5X9uMmR2g==
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
Subject: [RFC PATCH 03/10] Docs/mm/damon/design: update for context pause/resume feature
Date: Sun, 15 Mar 2026 14:00:02 -0700
Message-ID: <20260315210012.94846-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315210012.94846-1-sj@kernel.org>
References: <20260315210012.94846-1-sj@kernel.org>
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
index dc37402c0fee9..5723ffe8b51be 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -19,6 +19,13 @@ types of monitoring.
 To know how user-space can do the configurations and start/stop DAMON, refer to
 :ref:`DAMON sysfs interface <sysfs_interface>` documentation.
 
+Users can also request each context execution to be paused and resumed.  When
+it is paused, the kdamond does nothing but only online parameters updates
+including resume request handling.
+
+To know how user-space can pause/resume each context, refer to :ref:`DAMON
+sysfs context <sysfs_context>` usage documentation.
+
 
 Overall Architecture
 ====================
-- 
2.47.3
