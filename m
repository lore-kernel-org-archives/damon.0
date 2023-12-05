Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAA4689
	for <damon@lists.linux.dev>; Tue,  5 Dec 2023 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czDr4W1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E64EC433C8;
	Tue,  5 Dec 2023 02:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701743342;
	bh=WXN01WmS/1XYD2UM5/KTAA43TQV3rGLcmc9JJYlY+Zs=;
	h=From:To:Cc:Subject:Date:From;
	b=czDr4W1jJnUWy8kd3v9RRDgKXCXocS82Li0EGVZit+a+g8qXwzJK/05JuPU5p59uI
	 mNL2MrdBevaxzcFe9SUk0wJieUBy2sg1eSkmpmOIA0Qc2ZRfkWt35h1cPGlJ69yRzW
	 Sx9+/Cj13S5asDVBKZxroJPRmcx9LxxB2cUxHQvTPTgS3xFmZYnoGexnc7epPeac1S
	 iThTWc/g1gGXleTQnCfBmYbFlU8i2+W1zghE1o3i30AaHfFXLgAEqusK8USGTudlis
	 8/qlW4IkjWwilJQPhgrS73lm7aOE5DVGzPtJDrSMrCKjSD/X5JpHTufF3EgT47HfKN
	 V0zZDLnwstUVw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mm/damon: export DAMON symbols and add sample loadable modules
Date: Tue,  5 Dec 2023 02:28:55 +0000
Message-Id: <20231205022858.1540-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from RFC
(https://lore.kernel.org/damon/20231121053604.60798-1-sj@kernel.org/)
- Wordsmith commit message
- Use GPL v2 for Makefile
- Separate patch for each sample module

DAMON cannot be used from loadable modules since it is not exporting its
symbols.  This makes use of DAMON unnecessarily tedious.  For example,
basic usage of DAMON was presented at kernel summit 2021[1] by writing
simple loadable DAMON application modules in live.  Because the time was
limited (10 minutes) and the coding was to be done step by step, it had
to make a downstream commit that exports DAMON symbols.  There were
users asking why the source code is now not working.  It was mainly due
to the absence of the symbols export patch on their tree, but also due
to the updated DAMON programming interfaces.  There were also multiple
users requesting support of loadable modules for easier deployment.

There's no reason to avoid exporting DAMON symbols.  However, it would
be better to have concrete use cases of the symbols in the tree
together, for better maintenance of the interface and the use cases.
The kernels summit 2021's live-coded modules could be used for the
purpose.

Expose DAMON API modules for supporting the minimum modules and add the
kernel summit 2021's modules that updated for latest DAMON API under the
samples directory.  The sample modules will be keep updated.  For
exporting more symbols, requesters would be required to merge their
modules using the symbols in the tree together, or updsate the sample
modules to use the newly-exporting symbols in still simple but
reasonable ways.

[1] https://linuxplumbersconf.org/event/11/contributions/984/

Signed-off-by: SeongJae Park <sj@kernel.org>

SeongJae Park (3):
  mm/damon/core: export symbols for supporting loadable modules
  samples: add working set size estimation DAMON sample module
  samples: add proactive reclamation DAMON sample module

 MAINTAINERS                       |   1 +
 mm/damon/core.c                   |  10 +++
 samples/Kconfig                   |   2 +
 samples/Makefile                  |   2 +
 samples/damon/Kconfig             |  30 +++++++++
 samples/damon/Makefile            |   3 +
 samples/damon/damon_sample_prcl.c | 102 ++++++++++++++++++++++++++++++
 samples/damon/damon_sample_wsse.c |  85 +++++++++++++++++++++++++
 8 files changed, 235 insertions(+)
 create mode 100644 samples/damon/Kconfig
 create mode 100644 samples/damon/Makefile
 create mode 100644 samples/damon/damon_sample_prcl.c
 create mode 100644 samples/damon/damon_sample_wsse.c


base-commit: 7fcebba4a540e4508b923f00a3e9c5e4710f147f
-- 
2.34.1

