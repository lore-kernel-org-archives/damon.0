Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534611;
	b=JyKyDdejgVL4xmaEDPpl27zTZLSP74rourdwVFeyz5K+lf8EqZFbXHXABsWATFCrx43B
	 4bzKuhMRXCRuNHkuIHqvzBSP3/UmsgtEwwumeOey3FW5+XQzoSEJNbCNpRrEAgrWo6eG1
	 wuGqxliTgsCV/7PBxtfOD5/kCUSyAZm/khl/y7a/XVSU4J7+2kCBOW81q0AffWLI0QoGj
	 ev61y0TEbpzPNG/lGgr1catH9uRt0II1MpzawZLfh+Kzb5YMEtv7d4qWA07YXm1yEXA8E
	 n289fMIp76l3KQYxnfTY8VWuQoA5x1ZoecY3O4JFP+ftAiOT09Xys9o1UeYF9uX+uXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534611;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ptv4jOAXRZnBZ5AEQq8DinI9EbwsThp4y5iPRRjm17w=;
	b=f0evFzqpKH7Ui1/wh9MkLKGrvJkthawyIVXJot3iHR/04EyUGTHecxIAMYSm8CcBzHmQ
	 HfPOuWiUKIcGboMZY++rMRR1BhOrUV9H3KfwQRTCKP85j4C1OKvgasGnJ1c4wi0M7xy0S
	 dHoNN/7m7dXG5X/mtF8OOLlosOi/HeJAwmE1JYct814btKy1ZHoayewSrKIURnITLpFSt
	 TxmBsZ4w1Uro/ZMni2Y5XuBugVLqglc3Ujc/UGctG3jD75gwFb2Dja6tv7RxPHA7Gmbld
	 EmQ/kOwzgKiK2J3RGIHpMZYNlEQSYGjJ8EgnDPkwtEJTxM7ujSMJO0m+qsK9PuYT5dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UKk60pAG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43622606A683;
	Tue, 24 Nov 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UKk60pAG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F28C1F000CF;
	Tue, 24 Nov 2026 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534610;
	bh=ptv4jOAXRZnBZ5AEQq8DinI9EbwsThp4y5iPRRjm17w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UKk60pAGDh5L4v3L+u9Q5Y1hz3ltvr3bLxQPUjl1NuXsleEZEAKn4BHswNJmgYHS2
	 puJYwhMZIzFsG/bx+fp/z7KzFXdEuPYBRIGuoLFj52dS8JkIw+V2qwIM/9r5XoSaTU
	 4SlSR7wGfaIF2i3wI/e4oMupDdp3bijVZB/GHrnpV2/Mdde9DHGlMENKUXEaE5Q3Xz
	 RGNK5R/gGd9u6gFmkBEWP1lxIrNMUGm0lwDro2yqAUmjWqHBNSbRR2yBJEIfpe2LCo
	 GtdU3ppiSks1GFB9yYZak3RrNxGrCi0CJcPtPr5/ntauKU4BmIHUEklax8NOSNLe63
	 da3M/4zxcjkxw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 09/27] Docs/mm/damon/design: update for report system
Date: Tue, 24 Nov 2026 07:36:15 -0800
Message-ID: <20261124153636.91854-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design for the data attribute report system.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index ca8fbf93d556f..59dba2fe0dfbf 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -356,6 +356,32 @@ monitoring.
 Refer to the :ref:`admin guide <damon_usage_sysfs_probes>` to know how users
 can use the mode.
 
+.. _damon_design_attr_reporting:
+
+Data Attributes Reporting
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+DAMON-external entities such as other kernel components and users may have
+special data attribute information.  DAMON provides a system that let them
+report such information to DAMON.
+
+DAMON provides the kernel API for submitting a report of data attribute
+information to DAMON.  A report describes what type of the report is,
+representing the reporting data attribute type.  A report also describes the
+address range of the memory that the report is made for.  Depending on the
+report type, the report can have additional information.  The report is saved
+in DAMON's internal queue.  The queue is automatically managed by DAMON with
+its best effort.
+
+DAMON provides the user :ref:`ABI <damon_usage_sysfs_reports_producers>` for
+configuring report producers.  Each producer is configured for a specific
+report type.  Users can dynamically enable and disable those.  When enabled, it
+can generate and submit reports of the given type.  The generations and
+submissions could be done automatically by the kernel or manually by the user,
+depending on the type of the report.
+
+For now, no report type is supported.
+
 Dynamic Target Space Updates Handling
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.3
