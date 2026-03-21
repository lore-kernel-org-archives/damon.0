Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55026347FE1;
	Sat, 21 Mar 2026 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774116834; cv=none; b=RTUE71RX0YxYEyLENmaLWGTHdGnpBK4ir7G/CcqBNwXZFp5girMNNycQOpEeUplVryCKQIl/ioitZWPXTlmjYAHz0mUMcjkI6SrpzR+2DHN44vVyQ0/mtvvC1XcvvMty03KWEXc8yVajI2y/jZM6EEV2UQ3vyf2AejalihLk3Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774116834; c=relaxed/simple;
	bh=O8n0uNGYuU+EcM7S/clzxsj2TzvWbNFjQtjX/Z2/CrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mB9Pd88pP8xU1bA4WeN8ocPQINaJIVGjOP5cksOrs9WxhCEa/L2FM0z470//mIXLipMCL9w8hANdtwb+WOl4bqdo+jYNbBdMwR/KUm5/2WiuI/zbmaxu9CeE3Y03Ogb0Yk5fiY/62ecKlgZapRPCy5uZ0yQ2J383Zj24dEFBvTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrR4UXi0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrR4UXi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB239C2BCB3;
	Sat, 21 Mar 2026 18:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774116834;
	bh=O8n0uNGYuU+EcM7S/clzxsj2TzvWbNFjQtjX/Z2/CrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrR4UXi0nK1kQpMZ5iRYxPX/pdwns5ZatpwG3yQgGCIEtlLCId7ZAvruFy1cgdgQi
	 vsqZpHR+8Tc4Q/LFukZp3ZOhs7OLRbQ8PWHI7LdIoZGbN1OiKTV4tubclAklUgzT+M
	 QZQ0LB0/UkuBUZY4xNU0HWRAxAPH2P4xp6UuQn3/iMFMkYLzEZU+5KW88m9u+CSenQ
	 RxDXJ0GlbZ7tBjOwW5CtxYgRYmE8LlEX7u8+h1ux+IOT43agtLjbCWqpBIAszczAV5
	 obX3FPwi2R+N/ROTin2Vjg6dUyEKSMvrEla9dJ3JSPZMm6fkbXVgdhrL/iQk1kiUTL
	 L7rt0DNdmKOyQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [PATCH 04/10] Docs/admin-guide/mm/damon/usage: update for pause file
Date: Sat, 21 Mar 2026 11:13:34 -0700
Message-ID: <20260321181343.93971-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321181343.93971-1-sj@kernel.org>
References: <20260321181343.93971-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the DAMON context execution pause/resume
feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 534e1199cf091..bfdb717441f05 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -66,7 +66,8 @@ comma (",").
     │ :ref:`kdamonds <sysfs_kdamonds>`/nr_kdamonds
     │ │ :ref:`0 <sysfs_kdamond>`/state,pid,refresh_ms
     │ │ │ :ref:`contexts <sysfs_contexts>`/nr_contexts
-    │ │ │ │ :ref:`0 <sysfs_context>`/avail_operations,operations,addr_unit
+    │ │ │ │ :ref:`0 <sysfs_context>`/avail_operations,operations,addr_unit,
+    │ │ │ │   pause
     │ │ │ │ │ :ref:`monitoring_attrs <sysfs_monitoring_attrs>`/
     │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
     │ │ │ │ │ │ │ intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us
@@ -194,9 +195,9 @@ details).  At the moment, only one context per kdamond is supported, so only
 contexts/<N>/
 -------------
 
-In each context directory, three files (``avail_operations``, ``operations``
-and ``addr_unit``) and three directories (``monitoring_attrs``, ``targets``,
-and ``schemes``) exist.
+In each context directory, four files (``avail_operations``, ``operations``,
+``addr_unit`` and ``pause``) and three directories (``monitoring_attrs``,
+``targets``, and ``schemes``) exist.
 
 DAMON supports multiple types of :ref:`monitoring operations
 <damon_design_configurable_operations_set>`, including those for virtual address
@@ -214,6 +215,9 @@ reading from the ``operations`` file.
 ``addr_unit`` file is for setting and getting the :ref:`address unit
 <damon_design_addr_unit>` parameter of the operations set.
 
+``pause`` file is for setting and getting the :ref:`pause request
+<damon_design_execution_model_and_data_structures>` parameter of the context.
+
 .. _sysfs_monitoring_attrs:
 
 contexts/<N>/monitoring_attrs/
-- 
2.47.3
