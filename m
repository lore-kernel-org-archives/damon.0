Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493C179958;
	Tue, 18 Jun 2024 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746594; cv=none; b=Z30ekQgNyfxVAgn4fWMahUHwiuNahS4eJkIx2L4DGoOJhMkXdn6bYObv1EFo88h15NB83g5x1CYCakhrvKcOz2VSDu5OE/vmzkyZEtuR3vdtyGW4spqNayn8JP5I89NQwvy1fJnBgbK4l9qVKNksrGPLeu0CQ4tcGIL1ZSIDMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746594; c=relaxed/simple;
	bh=ucziBLbDh58RAO7bYebKVFmqwME2MQL9LkUovdjHV4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KbFhdUu/8uMFrq4+dadHJdMAqLVDVuTnL8Wzlxvw6Dn/1j6ONGBUc6o/If0MoDFnul0lSpActEtzt67G8CPsNylvCHLxG1rN7IrJqtWnOSzXb1YLbBbY1qKwPaVsQJvRlNkdk4vEZ7LMc7ZDofEp6FT0q9dcss61AKVlS58X1BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbmyY+oL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbmyY+oL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9277BC3277B;
	Tue, 18 Jun 2024 21:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718746594;
	bh=ucziBLbDh58RAO7bYebKVFmqwME2MQL9LkUovdjHV4A=;
	h=From:To:Cc:Subject:Date:From;
	b=KbmyY+oLZdnidZocLoI7d2MLZInHL4vbR2S5XJoVmwY/13YGG97Z90wSQGJ6N3/nA
	 4O9MrC50fXhnbpIQHIkCJQxa4O5b+0OF5DvxgH1eOaTfSMECWfDcyuCe5edJkbsUPf
	 7VGC7s5DGHtr37tYn7ZojwKqyXw9xSihn8HD62n7EFdL9KWRj4m5LQNdxaK/2pPR2E
	 EcMUMAjjz5Qmp2pdla8swqsOryP9XrwI6dpw69noYL+oUPrvWx+HwfhACdE0jJuYM+
	 Jxp02l0qF5BWVT6cOKIEdUvl1ZwlGE2oqCmBUACzuhaYNNmUWMP3XAHvRbiOYFCnsN
	 8XSlrrIutUdNA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] fixup DAMOS_MIGRATE_{HOT,COLD} patchset documentation
Date: Tue, 18 Jun 2024 14:36:28 -0700
Message-Id: <20240618213630.84846-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS_MIGRATE_{HOT,COLD} documentation[1], which is currently merged in
the mm-unstable tree, has two trivial problems.

Firstly, the usage document.  It missed updating some parts of the
document, and the layout of some paragraphs could be more consistent.
Secondly, DAMON sysfs ABI document is not updated.  Fix the two trivial
problems with two patches, respectively.

Andrew, could you plaese squash the first patch for usage document fixup
into the original patch[1]?  Meanwhile, I'd prefer keeping the second
patch as separate one, since I prefer having individual commit to touch
single file if possible.

[1] c100fc71858a ("Docs/damon: document damos_migrate_{hot,cold}") # mm-unstable

SeongJae Park (2):
  Docs/admin-guide/damon/usage: trivial fixups for
    DAMOS_MIGRATE_{HOT,COLD} documetnation
  Docs/ABI/damon: document target_nid file

 Documentation/ABI/testing/sysfs-kernel-mm-damon |  6 ++++++
 Documentation/admin-guide/mm/damon/usage.rst    | 12 ++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)


base-commit: 4ab13e9dfbc0134b95cfbaa2f9696b8e496dab6d
-- 
2.39.2

