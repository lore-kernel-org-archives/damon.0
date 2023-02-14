Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F37C
	for <damon@lists.linux.dev>; Tue, 14 Feb 2023 00:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FFEC433EF;
	Tue, 14 Feb 2023 00:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676334817;
	bh=/do0D6iRKp1copguw3lgY3LpRB5yMBGMUMUs4OVo/gU=;
	h=From:To:Cc:Subject:Date:From;
	b=cbOu9dqIVMv0yT0piNMsGLWl+ii4hW+oa0EUdbRKTl/ovD7nK3RA2pj4KH0BBGn9V
	 c3P7WGCOihsEy6q3oGIGwSHcvtCnXQY1uTKXXs5FVrcpwhLy1pPLcZyTLM0aw++6x4
	 ci9qELe1RfYTCcuTQZ57zb8XOcGQg4sMG961ShdsPIR8BDcBXZwB1PP/3sLvJbWfG+
	 M6Lhao6cBD93V+iwwTHHNslXzWDL7x9Ne/p051lcSZGtdDMoCiRY/vhgWDGKsklBX0
	 Yi1aYWpLLvkFzGqkHZlSM/MXuDm8HAl6BuDOc4ZQFRhUNYEU9k0kaB7XpnL5GHeEK9
	 VYQwlvmZvCchA==
From: SeongJae Park <sj@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] DAMON Updates and Future Plans
Date: Tue, 14 Feb 2023 00:33:28 +0000
Message-Id: <20230214003328.55285-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,


DAMON has merged into mainline as a data access monitoring tool that equips a
best-effort overhead-accuracy tradeoff mechanism, and then extended for data
access-aware system operations.  I'd like to briefly introduce current state of
DAMON and share/discuss about 2023 plans including below.

- Finer and easier-to-use DAMOS tuning
  - tuning aggressiveness based on user or kernel feed (e.g., QPS or PSI)
- Merging DAMON user space tool into the mainline
- Extending DAMON
  - Page-granularity monitoring
    - LRU-lists based page-granulariy monitoring
  - CPU-specific access monitoring
  - Read/Write-only access monitoring
- More DAMON-based Operation Schemes
  - Tiered memory management
  - THP memory footprint reduction
  - NUMA balancing

I hope to hear concerns/interests about the plans for prioritizing each work
items and get some suggestions of future works and collaboration with other
kernel subsystems/hackers.


Thanks,
SJ
