Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1418651
	for <damon@lists.linux.dev>; Tue, 21 Nov 2023 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6nVWtz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C87C433C7;
	Tue, 21 Nov 2023 05:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700544975;
	bh=2hTiZxsT86X0oN/PSearw+dfIAhh29V867VL4eOG5r8=;
	h=From:To:Cc:Subject:Date:From;
	b=D6nVWtz74Snj6LQsOZed22kJrcYfOOgYEzM/3i+YkHfCZmhauAJx7p3sCWPmkqUZT
	 +S9RB1X3HAlZGSQDqQkt+IoQZRP42JQxD+10JjolCfxKyMMlLFN+ki6Bu9mHIQpXWi
	 McBkhAlEdsTrUaRbTH1lyXmWGsnIz55tK7TJV/xaTgoWXb4+SgZG8vweCqDFIu+Nvz
	 tZ5dfUYZB+t+Nz/tP+1c5ttoqjr3pS0g16ro3IabH7HAEcVvhddyzfiuAuNYakoWcB
	 5CTdxJsyMsfdPoT/fbyZ+zd76mKOiq9+q76NjH/GbN+xZKAJswD5ufN9CVkvsPks8B
	 OokXxU/mf8+WQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] mm/damon: export DAMON symbols and add sample loadable modules
Date: Tue, 21 Nov 2023 05:36:01 +0000
Message-Id: <20231121053604.60798-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON cannot be used from loadable modules since it is not exporting its
symbols.  This makes use of DAMON unnecessarily tedious.  For example,
we presented basic usge of DAMON at kernel summit 2021[1] by writing
simple loadable DAMON application modules in live.  Because the time was
limited (10 minutes) and the coding was to be done step by step, we had
to make a downstream commit that exports DAMON symbols.  There were
users asking why the source code is now not working.  It was mainly due
to the absence of the symbols export patch on their tree, but also due
to the changed DAMON interfaces.  There were also multiple users
requesting support of loadable modules for easier deployment.

There's no reason to avoid exporting DAMON symbols.  However, it would
be better to have concrete use cases of the symbols in the tree
together, for better maintenance of the interface and the use cases.
The kernels summit 2021's live-coded modules could be used for the
purpose.

Expose DAMON API modules for supporting the minimum modules and and add
the kernel summit 2021's modules that updated for latest DAMON API under
the samples directory.  We will keep update of the sample modules.  For
exporting more symbols, requesters would be required to merge their
modules using it in the tree together, or updsate the sample modules to
use the newly-exporting symbols in reasonable and still simple ways.

[1] https://linuxplumbersconf.org/event/11/contributions/984/

SeongJae Park (2):
  mm/damon/core: export symbols for supporting loadable modules
  samples: add DAMON sample kernel modules

 MAINTAINERS                       |  1 +
 mm/damon/core.c                   | 10 ++++
 samples/Kconfig                   |  2 +
 samples/Makefile                  |  2 +
 samples/damon/Kconfig             | 30 ++++++++++
 samples/damon/Makefile            |  3 +
 samples/damon/damon_sample_prcl.c | 98 +++++++++++++++++++++++++++++++
 samples/damon/damon_sample_wsse.c | 80 +++++++++++++++++++++++++
 8 files changed, 226 insertions(+)
 create mode 100644 samples/damon/Kconfig
 create mode 100644 samples/damon/Makefile
 create mode 100644 samples/damon/damon_sample_prcl.c
 create mode 100644 samples/damon/damon_sample_wsse.c


base-commit: 79cc930e5e3dc73c972d9e422b5e2ab3fe56dce5
-- 
2.34.1

