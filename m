Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E351632DD;
	Thu, 13 Feb 2025 01:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411100; cv=none; b=krCm4oG5mIbFAgd1kmZhxd0Zq+9bikbLh4xHrR23lPe5oh5mYcXsNQG7NLuVXOxd9ExuObV53Qi/x8plEd+w8a0sQky3JG2oqUaz39so4RJcT6LDoRUNZXJS1+WficBuv5+zKJ78RQ4QwHwsVocj/9a7/VMcCctQ/8EOp/bMj/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411100; c=relaxed/simple;
	bh=0wEx+LJOEK19dZIr4jkJc7A6zYxo+0xSxmNO8FVmzUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pff3c8kqGu74junJ2qjHJTfWr72m7ohGCD9bfePNh4HYyg61agBNAP7W6Jgayd/+tyJtffR2LdjWTe0VNETXmPsglsqQryGse6AgfwTm39Y2+jfwp0wSrbDjWpU3IDzGsrvBic/eWU+MRnpeBksaldmGY63tDQYNlt9OqdFXf5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyEbhvxt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyEbhvxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2F6C4CEE4;
	Thu, 13 Feb 2025 01:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739411099;
	bh=0wEx+LJOEK19dZIr4jkJc7A6zYxo+0xSxmNO8FVmzUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kyEbhvxtr1t+x2oavCe+QyKXEw8qJ00hlkxy6X/ohrCqozW7BMOb6O6UGLvp98fVO
	 2VFoA+iIdl40G45gDTTQ0UQ5Z5wOv4hdFTDs4NFUDWOutPm9kdLMBlIQm0pwl5vEhC
	 q0kXajprvSiVDOWE+vf1X/bREANPA3suqYUY3Ao1cUnfYVnqonxt/Rl2ETD+T6PB1s
	 QEt5WwqlGh395DHe0Mo1DsyjwfQestlBl42wPeBgQ0jeWuQZHr9iMiNLPD+HzahW8Q
	 D8immH3lmtEs+0GWWaG9R5Uc+URycBeV8ozvk1LanA8AGH+HTV/sFpXFFfZ66Ecrxb
	 K66CQWoMjq1rA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/8] Docs/mm/damon/design: document for intervals auto-tuning
Date: Wed, 12 Feb 2025 17:44:36 -0800
Message-Id: <20250213014438.145611-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250213014438.145611-1-sj@kernel.org>
References: <20250213014438.145611-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document DAMON sampling and aggregation intervals auto-tuning design.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index e28c6a1b40ae..c8e906ac3965 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -313,6 +313,10 @@ sufficient for the given purpose, it shouldn't be unnecessarily further
 lowered.  It is recommended to be set proportional to ``aggregation interval``.
 By default, the ratio is set as ``1/20``, and it is still recommended.
 
+Based on the manual tuning guide, DAMON provides more intuitive knob-based
+intervals auto tuning mechanism.  Please refer to :ref:`the design document of
+the feature <damon_design_monitoring_intervals_autotuning>` for detail.
+
 Refer to below documents for an example tuning based on the above guide.
 
 .. toctree::
@@ -321,6 +325,36 @@ Refer to below documents for an example tuning based on the above guide.
    monitoring_intervals_tuning_example
 
 
+.. _damon_design_monitoring_intervals_autotuning:
+
+Monitoring Intervals Auto-tuning
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+DAMON provides automatic tuning of the ``sampling interval`` and ``aggregation
+interval`` based on the :ref:`the tuning guide idea
+<damon_design_monitoring_params_tuning_guide>`.  The tuning mechanism allows
+users to set the aimed amount of heats to observe with DAMON within given time
+interval.  The target can be specified by the user as a ratio of access check
+samples that gave positive result to the total samples (``samples_bp``) that
+measured within a given number of aggregations (``aggrs``).  The mechanism
+calculates the ratio of access check samples for ``aggrs`` aggregations, and
+increases or decrease the ``sampleing interval`` and ``aggregation interval``
+in same ratio, if the samples ratio is lower or higher than the target,
+respectively.  The ratio of the intervals change is decided in proportion to
+the distance between current samples ratio and the target ratio.
+
+The user can further set the minimum and maximum ``sampling interval`` that can
+be set by the tuning mechanism using two parameters (``min_sample_us`` and
+``max_sample_us``).  Because the tuning mechanism changes ``sampling interval``
+and ``aggregation interval`` in same ratio always, the minimum and maximum
+``aggregation interval`` after each of the tuning changes can automatically set
+together.
+
+The tuning is turned off by default, and need to be set explicitly by the user.
+As a rule of thumbs and the Parreto principle, 20% access samples ratio target
+is recommended.
+
+
 .. _damon_design_damos:
 
 Operation Schemes
-- 
2.39.5
