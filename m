Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E59324EA9
	for <damon@lists.linux.dev>; Thu, 25 May 2023 21:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A03BC433D2;
	Thu, 25 May 2023 21:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685051001;
	bh=3HTyPRTo0Vt0yo/NxGIYMv2y8bgYWhJIE9CMcHR1Ijg=;
	h=From:To:Cc:Subject:Date:From;
	b=mj3d6lLsnIuAjR6BCbduN15xDkEOtelzlHKHP2JSXrxufz1LV7ff3zyBXET5OAWWk
	 uGEdrxxmf0ccyf4NaoOiXs46VmWKAbj/VdmvT+HpZl/mUbKwej6rG6d3DKGKrLYTID
	 hwzLE8M/apS+SIoPXwrqySBPmT4bKzvs4GZh6+vgRuxxYhohFlGCmtfAhFW3QRpVYI
	 LG3+dcQD7QGjXgGWdqil93waHfi52/cRo3KCQU5l09aMc+TybCsCBJ88RIFwQCFLwJ
	 cJgvb/x6pDtrMD/A+0hoGS58fcrkLTblA9yiAIr7WXzXQJCHGIRIZjyrZ4N439qO09
	 zfDEmksv5UfMg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] Docs/mm/damon: Minor fixes and design doc update
Date: Thu, 25 May 2023 21:43:04 +0000
Message-Id: <20230525214314.5204-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of DAMON documents are outdated, or having minor typos or grammar
erros.  Especially, the design doc has not updated for DAMOS, which is
an important part of DAMON.  Fix the minor issues and update documents.

SeongJae Park (10):
  Docs/mm/damon/faq: remove old questions
  Docs/mm/damon/maintainer-profile: fix typos and grammar errors
  Docs/mm/damon/design: add a section for overall architecture
  Docs/mm/damon/design: update the layout based on the layers
  Docs/mm/damon/design: rewrite configurable layers
  Docs/mm/damon/design: add a section for the relation between Core and
    Modules layer
  Docs/mm/damon/design: add sections for basic parts of DAMOS
  Docs/mm/damon/design: add sections for advanced features of DAMOS
  Docs/mm/damon/design: add a section for DAMON core API
  Docs/mm/damon/design: add a section for the modules layer

 Documentation/mm/damon/design.rst             | 309 ++++++++++++++++--
 Documentation/mm/damon/faq.rst                |  23 --
 Documentation/mm/damon/maintainer-profile.rst |   4 +-
 3 files changed, 285 insertions(+), 51 deletions(-)

-- 
2.25.1

