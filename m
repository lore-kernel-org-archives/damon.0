Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9233B2FAE
	for <damon@lists.linux.dev>; Mon, 14 Nov 2022 18:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8E6C433D6;
	Mon, 14 Nov 2022 18:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668450602;
	bh=DesiBTr9/Y2bxjKJkvSh2dQ7pBkdgYYbKWbCI7mjFjE=;
	h=From:To:Cc:Subject:Date:From;
	b=HBjvbAZYHVUrRyTg8VgWolacoYa1pyz4rOK6nKuR7KJhJDYa8wxpgLfxgg9j6/KCx
	 pAQHYnLRoWf5fsqCG5KUMQs5TIcuzOE9TXGQERfKzOS/baUlJiOonoINM3hoGv6AXr
	 NyfLtm+bG+K46sg7tlymX21vcwYM9+v18xD+tSDD8Pxermc1DLVNRb0Nkd8P+1YJtL
	 viqBojQWypYg9sSqjiOmkqaIfUK1BRcez26ZQ+4Cbx2228VS2/b32Bvof0OdrH2Dda
	 B4bIWJ/E3QgrTD77kSKZnTMtrijziJ3Z93f5/s4BqzwExg3sZVB7SY4LDa9mcdrgXi
	 r0vRePOl5LpwQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable 0/2] mm/damon/sysfs-schemes: avoid updating
Date: Mon, 14 Nov 2022 18:29:52 +0000
Message-Id: <20221114182954.4745-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A DAMON sysfs interface user can start DAMON with a scheme, remove the
sysfs directory for the scheme, and then ask clears/updates of the
scheme's tried regions.  Because the schemes tried regions clear/update
logic doesn't aware of the situation, it results in an invalid memory
access.  Fix the bugs by checking if the scheme sysfs directory exists.

This patchset is fixing commits in mm-unstable.  Andrew, please meld the
first patch into "mm/damon/sysfs: implement DAMOS tried regions update
command"[1], and the second patch into "mm/damon/sysfs-schemes:
implement DAMOS-tried regions clear command"[2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-damon-sysfs-implement-damos-tried-regions-update-command.patch
[2] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-damon-sysfs-schemes-implement-damos-tried-regions-clear-command.patch

SeongJae Park (2):
  mm/damon/sysfs-schemes: skip tried regions update if the scheme
    directory has removed
  mm/damon/sysfs-schemes: skip schemes regions clearing if the scheme
    directory has removed

 mm/damon/sysfs-schemes.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.25.1

