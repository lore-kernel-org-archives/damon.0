Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC125D2E5;
	Mon, 26 Aug 2024 01:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724637466; cv=none; b=Ao46xb2XtWG23BmfNWdasG3ybk6pEfh2w7KzF7U8Wa/o/dkUZuFr5k4W8BIpejCX3nucmDzHjw/CbTyzxYiAeKeSKVehoa9cnxGd5EYvyqQRDcWRI5+b1yaB6zec+oty6tDM8uPHXGQkvWHQF+x3ADiQvElbPrXlTK3HVy5rOnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724637466; c=relaxed/simple;
	bh=1DWacq6Bie9HfW9DxzVr4yQ9ts9B9V5LvU0EHPMdUGw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CZPDTd6jZxmAvbfmuh0pEXmEVB5OgjFKLFs+hLhpQR5W9L6kQeLiTDG+9crzwqmJGD1ypPdWllTtIEbdxC+9AgCsfK0kYMbeXv4hPVPYx8fDCQ8qg6QstBPlez94x5WhvbB38CPMlWJzwjY2uPgrE3lmTCwKUff1nW4Nl6maFGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw1AqE3f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw1AqE3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54E0C4AF52;
	Mon, 26 Aug 2024 01:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724637465;
	bh=1DWacq6Bie9HfW9DxzVr4yQ9ts9B9V5LvU0EHPMdUGw=;
	h=From:To:Cc:Subject:Date:From;
	b=Yw1AqE3fnbVRtScAmhwhQ+RuB6Xj9tAwihT8mQ1DhcRf66iD/AnC/GX57dizJd8NO
	 hqHet9ohD47qyY+FW4SFdasYgTdDyfoToUGRdcdy6moOqc2uPluPS9UmU7pjXSmrYx
	 ssxdE761f0ejd++67XPMGmf76gN0nWh3K7R21aD8v2ZkWEpyQIeHEsSoeO+FraSwcD
	 YRiVJ9NSAPjkhD6oev24Aetu/jBH5r3dfsn0VILfCB1Sn1mad4cTy6Grdun0yvn2nl
	 QrlRJxRI3hVMUevDw+z52rDrtZa6luom246ziYI48ZG5pGCrj9ZxJNTW0i3dOZc1jd
	 TqAvPiIlUSUSQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Yanteng Si <siyanteng@loongson.cn>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Docs/damon: update GitHub repo URLs and maintainer-profile
Date: Sun, 25 Aug 2024 18:57:38 -0700
Message-Id: <20240826015741.80707-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Misc updates for DAMON documentation.

Replace GitHub URLS on DAMON documents for none-kernel parts DAMON repos
with new ones[1] via the first patch.  With following two patches,
wordsmith maitnainer-profile for better readability, and document the
Google clendsar for bi-weekly meetups, respectively.

[1] https://lore.kernel.org/20240813232158.83903-1-sj@kernel.org

SeongJae Park (3):
  Docs/damon: use damonitor GitHub organization instead of awslabs
  Docs/damon/maintainer-profile: add links in place
  Docs/damon/maintainer-profile: document Google calendar for bi-weekly
    meetups

 Documentation/admin-guide/mm/damon/start.rst  |  4 +-
 Documentation/admin-guide/mm/damon/usage.rst  |  8 +-
 Documentation/mm/damon/design.rst             |  2 +-
 Documentation/mm/damon/maintainer-profile.rst | 86 ++++++++++---------
 .../zh_CN/admin-guide/mm/damon/start.rst      |  4 +-
 .../zh_CN/admin-guide/mm/damon/usage.rst      |  8 +-
 .../zh_TW/admin-guide/mm/damon/start.rst      |  4 +-
 .../zh_TW/admin-guide/mm/damon/usage.rst      |  8 +-
 8 files changed, 65 insertions(+), 59 deletions(-)


base-commit: c7968eec021805d3259f06bd85a5d285fec4e9af
-- 
2.39.2

