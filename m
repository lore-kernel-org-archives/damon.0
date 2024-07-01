Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CAB171064;
	Mon,  1 Jul 2024 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862034; cv=none; b=aWCBPdZEqLD5aOJj4AmlmHk12WQ7m800JnnLow246iypsDK14ghguk1TSbLglXBbJSmboeFFrhJtoKjOqPoRD2YMtpfbubrKDiaIOcJMHQa5CI9gnpBjpuWAtWIfXMhyQRs0zB71dX4XGhgP/IxB9UhK80G37+UXgrH3D0bVF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862034; c=relaxed/simple;
	bh=KZDwSh9p7bgKe4AljWzfhXg05QxoAGNbBrR/qAsRtMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cuR21GCRiZ9jPXmJfo60sfXayqjkCpNCkgnNCWnQgyEyCUyztBn20cV+jLl3EsdS62QsF1qB3N1iph1/zfhFNW31EoCEfzyryi9fP15FbDHossgZqZcwBnR0Wg55ojLax1dbe56FwIUfCfo7pcNgHaDqt518rYcnlDd7uaLN8go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acEBW/Cf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acEBW/Cf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC91CC32786;
	Mon,  1 Jul 2024 19:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719862034;
	bh=KZDwSh9p7bgKe4AljWzfhXg05QxoAGNbBrR/qAsRtMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=acEBW/CfXYpxJ7Qs4Hki2GqyCzUUrPw4pqEv3Nlh57QhGTmKz28R5rbpX5MY2czmS
	 q9DDEMMHeykfSZN5ecFSIgfCjSl8dMqFEawJFaG/X2Rx6omwQBB5WjyJB6jmvfaZhf
	 vBg8NNBZijEK6ydJeaz7l7CgJyXoA/OF3cPuLhNrTf+Ioml4t7W/SsHyA0XiqZEqnu
	 8uQ/n/1WNwUKR2oGEji4eLpUyXjY92uWAdBU7b5ka9byhyJN/Pw+2ppDu/1R9GlcF9
	 v/kmZGNwOf62Pl3G8xNksQuc3hf3pcoHdh7Eg68z/t9/Ei9NrmTWc5vBBCNR3EXPVb
	 qJf9xR92LDAbg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] Docs/mm/damon/design: add links from overall architecture to sections of details
Date: Mon,  1 Jul 2024 12:27:01 -0700
Message-Id: <20240701192706.51415-5-sj@kernel.org>
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

DAMON design document briefly explains the overall layers architecture
first, and then provides detailed explanations of each layer with
dedicated sections.  Letting readers go directly to the detailed
sections for specific layers could help easy browsing of the
not-very-short document.  Add links from the overall summary to the
sections of details.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index fe08a3796e60..991839200f80 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -22,13 +22,15 @@ Overall Architecture
 
 DAMON subsystem is configured with three layers including
 
-- Operations Set: Implements fundamental operations for DAMON that depends on
-  the given monitoring target address-space and available set of
-  software/hardware primitives,
-- Core: Implements core logics including monitoring overhead/accuracy control
-  and access-aware system operations on top of the operations set layer, and
-- Modules: Implements kernel modules for various purposes that provides
-  interfaces for the user space, on top of the core layer.
+- :ref:`Operations Set <damon_operations_set>`: Implements fundamental
+  operations for DAMON that depends on the given monitoring target
+  address-space and available set of software/hardware primitives,
+- :ref:`Core <damon_core_logic>`: Implements core logics including monitoring
+  overhead/accuracy control and access-aware system operations on top of the
+  operations set layer, and
+- :ref:`Modules <damon_modules>`: Implements kernel modules for various
+  purposes that provides interfaces for the user space, on top of the core
+  layer.
 
 
 .. _damon_design_configurable_operations_set:
@@ -140,6 +142,8 @@ conflict with the reclaim logic using ``PG_idle`` and ``PG_young`` page flags,
 as Idle page tracking does.
 
 
+.. _damon_core_logic:
+
 Core Logics
 ===========
 
@@ -512,6 +516,8 @@ interface, namely ``include/linux/damon.h``.  Please refer to the API
 :doc:`document </mm/damon/api>` for details of the interface.
 
 
+.. _damon_modules:
+
 Modules
 =======
 
-- 
2.39.2

