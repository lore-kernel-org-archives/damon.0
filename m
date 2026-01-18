Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DC72FFFAB;
	Sun, 18 Jan 2026 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768759393; cv=none; b=c2PIfkvXJ3Fn51Dd2QdWfId68zqEExg3TKqUDEgWEg38RVQdjRYeXUGxV2o2LnD7j6JtZ4tLOsZSOugAiLPuCJm1ebzQ8sZih9f/3FyBD2v0PobDZfMqETQT1hEQeaWLFEAhvJZiqCTGAjvPUhinVREwXAmQblqta5jo5rSa1D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768759393; c=relaxed/simple;
	bh=CpkInp8OpjPiUKQxZORXcWjG5Pmwu5eA5tM4rzL8LFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYXAWQID5DTw178dJbporNDV1K6w2+TMmErV/hbdZwKgDcjp832UPjB/pv8AhwG3HmSCAitkxCLpk+ODT7D4EwmEdORunXd+i+mb63W4pLw9v7+6LAqI9rcdEu3uEgTI0rx8CwfouR/r2QcRZWpvYJr3BLtaKty6NtW4DZVb5DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9Lg8HKk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9Lg8HKk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304EEC19425;
	Sun, 18 Jan 2026 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768759393;
	bh=CpkInp8OpjPiUKQxZORXcWjG5Pmwu5eA5tM4rzL8LFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9Lg8HKkYM4sv5a6oLEZG9b89pl/Fd++MYtPd4kiHVDHOHfpfpdzZw0FX4WliRbZm
	 TaLCVsdHX4ji3hbO85tBz2FhQ2JJWa+8aEIICc3n+lcPOLcEl+KxrD19C1j3vBgz1F
	 fpPYtfEUQ2d3fGKiXJpzMtpY2CWSmx3QsRvO4LNh+7nczjOsdZigYW2P6OtDXCy+0t
	 cJGYEztROSVCdULhwwRhUSqWMiLkhTU82CJHSZLtF0MCR7IbUMP80cXRX5taizIDZ9
	 3Q3d3Yv5qBxSMyL4Iip3d+NyqsLH4wQXijKdnt4L7YvrXZYTON1Bt1Td8fRgvYcjJi
	 R9zbvlfIFMyLg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/8] Docs/admin-guide/mm/damon/usage: introduce DAMON modules at the beginning
Date: Sun, 18 Jan 2026 10:02:56 -0800
Message-ID: <20260118180305.70023-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260118180305.70023-1-sj@kernel.org>
References: <20260118180305.70023-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON usage document provides a list of available DAMON interfaces with
brief introduction at the beginning of the doc.  The list is missing
DAMON modules for special purposes, while it is one of the major
suggested interfaces.  Add an item for those to the list.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 5 +++++
 Documentation/mm/damon/design.rst            | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 7da4c002cb39..bfaee977c37c 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -6,6 +6,11 @@ Detailed Usages
 
 DAMON provides below interfaces for different users.
 
+- *Special-purpose DAMON modules.*
+  :ref:`This <damon_modules_special_purpose>` is for people who are building,
+  distributing, and/or administrating the kernel with special-purpose DAMON
+  usages.  Using this, users can use DAMON's major features for the given
+  purposes in build, boot, or runtime in simple ways.
 - *DAMON user space tool.*
   `This <https://github.com/damonitor/damo>`_ is for privileged people such as
   system administrators who want a just-working human-friendly interface.
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index c10a3dea3aa8..dd64f5d7f319 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -817,6 +817,8 @@ available.  Please refer to the ABI :ref:`doc <sysfs_interface>` for details of
 the interfaces.
 
 
+.. _damon_modules_special_purpose:
+
 Special-Purpose Access-aware Kernel Modules
 -------------------------------------------
 
-- 
2.47.3
