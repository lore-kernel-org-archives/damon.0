Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10C391E51;
	Sat, 17 Oct 2026 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792267078; cv=none; b=iAIkpsvbPA5WDgI31AEc/Q1v0LgFbCsGtxlqsNvuiEm+v/QED3XQiIhKh8uzUsx4GAFMiy0/k+MW/XnxEr8bH0BGGsq3bp0rxz7uytwHOVzpiLXiRF2fFvE0RGVLs7IUex7j7aogsYcj3pv3YjDYX1/zDhsW9FRvO3XUYMxjWA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792267078; c=relaxed/simple;
	bh=ngT9CW6ATjwRZ78Dua5Ai4cubz3BDjpMM/lBP7wbMnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCs7Q7vBAlcHE+vIwF8JWLaXw7L1RZHUE+HKNaqaFyvRPO1Zm2q2byyB5MlkULtoYw5yVgSSXOWDbXJrck15f8YQXC+BJJ1WYxXXR8GHZsMsryVYikmkY0yGwVZtXBiwdQUyB5VPj2nTdwVxaebN/JKpW9L6e8bAKOEzzoe8mgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAT9mExM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAT9mExM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478AC1F000C4;
	Sat, 17 Oct 2026 19:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792267076;
	bh=nOAWu4jgToYD6PgI6zHtuU24uPZsxbnLY8EkUxNpZ08=;
	h=From:To:Cc:Subject:Date;
	b=OAT9mExMcAsH9A03H+uqHOHGRrErNT9JglY8WLHBEOMAsVM7+9hyfYOyFuCPP6rA3
	 XI94TuJWLQNDPYo3WPzZhD9y3jvHCRSI7yJGMa5tF8Qf+CAAD4WkdQISyuaI5dVvUF
	 cNH4pqDWMW98r8IUx0G9NLBp6UJ3OWeULU7qGqGWZJsIGLJfLUZWRvRHcoUnYQJTvC
	 bZ6nWok9uPD48Mo0LkqskZE0VFtDTSbbR4bOjePimVqZL9FyrKIR/Cq4O1GWRVxNyn
	 3mYsPzvO/tbP7NEytc/CDuWFgUIeAXMUf4/d8smoKL2+9+zjLOsyCq/RL+TenDWN9y
	 ytlYDWDs3w5Vw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v0] Docs/mm/damon/design: document data attributes report infra design (beyond page table accessed-bit milestone 2)
Date: Sat, 17 Oct 2026 12:57:45 -0700
Message-ID: <20261017195747.89961-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "beyond page table accessed-bit DAMON extension" project [1]
milestone 2 is for building the basic infrastructure for continued
extension.  After starting it, I studied perf event little and found a
few demons in details.  I therefore spent time on high level design.  As
it started looks like making sense to me, I'd like to share the humble
design first and get feedback from more eyeballs.

Add a blueprint of the milestone 2 as a high level design document.
Describe the API and ABI of data attribute report infrastructure, and an
example use case of it for per-CPUs write-only monitoring.  The API and
ABI will later be extended for more data attributes reporters utilizing
AMD IBS, Intel PEBS, Arm SPEs like h/w features and any possible
DAMON-external reporter kernel components.

Request for comments
====================

This is an RFC for high level design discussion, so no implementation is
provided.  Comments I want to receive include but not limited to below.

Does the idea for perf CPU cycle sampling based access monitoring makes
sense?

Does the design provides clear idea about how it can be extended for the
future extensions that already scoped for milestone 3 (AMD IBS, Intel
PEBS, Arm SPE)?

For the foreseeable extensions (AMD IBS, Intel PEBS, Arm SPE), would the
required change minimum and maintainable?

Next steps
==========

I will start implementing the infrastructure and perf CPU cycle sampling
based access monitoring as described in this patch.  It will go through
the normal development process.  Delivery of it will be the completion
of the milestone 2.  As set on the initial roadmap [1], ETA of the
delivery is LSFMMBPF'27.  No delay is expected so far.

[1] https://lore.kernel.org/all/20260525225208.1179-1-sj@kernel.org/

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index a465e34bb1d9c..1e699e3f8a496 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -433,6 +433,50 @@ monitoring.
 Refer to the :ref:`admin guide <damon_usage_sysfs_probes>` to know how users
 can use the mode.
 
+Data Attributes Reporting
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Infrastructure for receiving attribute information from DAMON-external kernel
+components.
+
+Because DAMON is not hooked in every place but runs in its own worker thread,
+it cannot retrieve some types of data attribute information by itself.  Many of
+those are available to DAMON-external kernel components such as perf event
+callbacks and page fault handler.  For such cases, DAMON provides attributes
+reporting infrastructure.  Using its API, any kernel components can report
+their finding to DAMON.
+
+The API for doing the report is a function, damon_report_attrs().  The function
+receives the attribute information and saves it in DAMON's internal buffer.
+The function is safe to be called in any context including NMI.  The internal
+buffer has a fixed size and keeps only latest reports of the size.  Because one
+buffer size doesn't fit all, multiple report buffers of different size and
+rules can be generated and shared by multiple reporters.  DAMON provides API
+for such management of report buffers.  damon_report_attrs() can specify into
+which buffer the report should be saved.  DAMON user interface (ABI) for doing
+the buffer setup, and enable/disable reports of supported types is also
+supported.
+
+The data attribute probe supports the reports.  The probes can be configured to
+hit for a given memory region depending on the existence of specific types of
+reports that associated with the memory region in given report buffers.
+
+For example, per-CPUs write-only monitoring can be configured using this
+infrastructure like below.
+
+The user sets a report buffer and enable CPU instruction sampling report for
+the buffer.  DAMON will enable perf event counter for CPU cycles sampling.  The
+sampling callback will save the sampling time CPU instruction and the id of the
+CPU that was executing it, into the DAMON report buffer, using
+damon_report_attrs().  DAMON can automatically adjust the perf event sampling
+frequency to minimize old report drops due to the buffer size limit.
+
+The user further sets a DAMON probe.  The probe hits for a given DAMON region
+if a store instruction for a memory in the region that was executed from a
+given CPUs group exists in the report buffer.  As a result, the probe hit
+counts represent relative frequency of writes from a given CPUs group to a
+given memory region.
+
 Dynamic Target Space Updates Handling
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 

base-commit: 366c6418699768dba5826d412700a29d562ca039
-- 
2.47.3
