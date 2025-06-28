Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D512580E7;
	Sat, 28 Jun 2025 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751129511; cv=none; b=dEVpgpW55Kk2c1EW5yJmVGvJYlive1HFQ33hIS2EdS6Kuf7UYFtAv7vz+fm7IN5u+HXW/jH1a0kBQGsruwzFNmM9hSwn8VKb7upaubrfl2HTF1P6WzakPk2Phl3YT7qzOXhdzPFpWaGjNXxIzKB3vr8Mtc8i28LBnAQk7+K9/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751129511; c=relaxed/simple;
	bh=/0dCUe11qKby9u3vEyXqRJSVAYTCVRTpv2OM8A5msCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2RzXrY/Wd2yDWQaWxSpasbNUyJ1kfvN7lM5l/YKAY4RPxeJlJdI8gJmzGd6bkWH1Qi5j4nVWCIwamuu8zifREszF/LjNezHpzgUUSqvX/WA3EZo/VlWMQWCRUaYZ18bdPTbGi/dUhDJJRoYk9HSExD31qAY7BwuA0gJUFun/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVqv/iAQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVqv/iAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD940C4CEED;
	Sat, 28 Jun 2025 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751129511;
	bh=/0dCUe11qKby9u3vEyXqRJSVAYTCVRTpv2OM8A5msCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVqv/iAQmQTec0pT+CG3bWPgayEsJbxNNvvNWTv00bptdssc2b3QQZ0PIBIQpEVJ0
	 H6ThLDoMqHS692LBCUYhCmwTFYsIVy9fx7CmBrFLH9FtRraA9F8zXeGQdEl/VFYwGb
	 A+HQku7tbqCP5plBmEYd29zMc642+5IzsKOLxxlg0qv/2uuBG1zfDEZNO5IfgEDeUu
	 9+Lcq/PcAxgtj1zwnB7ZhmeKuQ8Y7+2i06UuSJiOKjWPaunRBUEr/zhLTLRSl7PKe+
	 w0COfErWZ3iGjunEfYJyJxeNySCHLGfyWIh1fJFfCX1wnpZOdirhobUNBfy+7oSN+O
	 ho+fjeh8KGXlw==
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
Subject: [RFC PATCH 03/11] Docs/mm/damon/design: document DAMOS_QUOTA_[IN]ACTIVE_MEM_BP
Date: Sat, 28 Jun 2025 09:51:36 -0700
Message-Id: <20250628165144.55528-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628165144.55528-1-sj@kernel.org>
References: <20250628165144.55528-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update design document for newly added DAMOS_QUOTA_[IN]ACTIVE_MEM_BP
metrics.  Note that API document is automatically updated by kernel-doc
comment, and the usage document points to the design document which uses
keywords same to that for sysfs inputs.  Hence updating only design
document is sufficient.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 2290ebefc648..ce8c389f0c68 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -570,6 +570,10 @@ tries to make ``current_value`` of ``target_metric`` be same to
   set by users at the initial time.  In other words, DAMOS does self-feedback.
 - ``node_mem_used_bp``: Specific NUMA node's used memory ratio in bp (1/10,000).
 - ``node_mem_free_bp``: Specific NUMA node's free memory ratio in bp (1/10,000).
+- ``active_mem_bp``: Active to active + inactive (LRU) memory size ratio in bp
+  (1/10,000).
+- ``inactive_mem_bp``: Inactive to active + inactive (LRU) memory size ratio in
+  bp (1/10,000).
 
 ``nid`` is optionally required for only ``node_mem_used_bp`` and
 ``node_mem_free_bp`` to point the specific NUMA node.
-- 
2.39.5
