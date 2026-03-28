Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61E293C42;
	Sat, 28 Mar 2026 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774659256; cv=none; b=CsaPkFqb3uhnZecjiFmGwuTiNBdMOZvXihNrWxM3/K9BHrknTfC4FiL4ZlwUNpZrre9Gh1XzsmFFid39oK98B9nXU1yxZ1cNqzsl4N/eNSNH3Uhh6v12Y3e5XiJgZn9QldPepu/aleHu8r/2EVO/a3z06Ngnn/vm2RbXxYC638M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774659256; c=relaxed/simple;
	bh=eqhm9Aq5Rmy+djcCUmMPesUDKO1sEknpkkUB6CDAm+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlxfBYEAPIrPLI9YVfS3+pXuHkS6+B8xSK+R06926CURXE3nclyZ+GEO2HlQyZrpYsUkr0zIY+RBnpfq57WoOSQPAP2tY5uIyY//NYqpNxmFkYuy7g4zwojZUHrcT71IGk7IEjaCMC4x00jSnuGK3g7SXHyt++81z1ZdQnj9pgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFCSSc/2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFCSSc/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7F6C2BC87;
	Sat, 28 Mar 2026 00:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774659255;
	bh=eqhm9Aq5Rmy+djcCUmMPesUDKO1sEknpkkUB6CDAm+M=;
	h=From:To:Cc:Subject:Date:From;
	b=HFCSSc/23NanR4XsIuzvw0l1DNRe67PZcYr5rpdC+unT7lDLwnmnHVoZHVMbDXNeW
	 4ViAhTUYX8STYy6HUjLOOUq3Mhrf7LXxtec9l6SJ9Njta7pVwYeGUCrG9xIjelMJdo
	 noGWmSGemPgTi//MkGwY/95WwuGvJtx9D6pyCLjeZQQ7o4KG9VIVR4xI46yoQelvpE
	 /v0T41RB8MoDhneqA2t29DJCLDylRWjB0O4w4khxDwIoxsjHNR3catYhwDg0ULwhD2
	 4y1VvF64zfdtYJ5WbwIWsd+33A/Lz2po6My64SXupstxAZ5ZcIRChzjoMGRDqfbN47
	 DskMYTdJrKsjg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/2] mm/damon/core: validate damos_quota_goal->nid
Date: Fri, 27 Mar 2026 17:54:08 -0700
Message-ID: <20260328005412.7606-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

node_mem[cg]_{used,free}_bp DAMOS quota goals receive the node id.  The
node id is used for si_meminfo_node() and NODE_DATA() without proper
validation.  As a result, privileged users can trigger an out of bounds
memory access using DAMON_SYSFS.  Fix the issues.

The issue was originally reported [1] with a fix by another author.  The
original author announced [2] that they will stop working including the
fix that was still in the review stage.  Hence I'm restarting this.

[1] https://lore.kernel.org/20260325073034.140353-1-objecting@objecting.org
[2] https://lore.kernel.org/20260327040924.68553-1-sj@kernel.org

SeongJae Park (2):
  mm/damon/core: validate damos_quota_goal->nid for
    node_mem_{used,free}_bp
  mm/damon/core: validate damos_quota_goal->nid for
    node_memcg_{used,free}_bp

 mm/damon/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)


base-commit: 7da5718476562bc8136c08216a1621aac09bcb51
-- 
2.47.3
